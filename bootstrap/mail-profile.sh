#!/usr/bin/env bash

set -euo pipefail

umask 077

PROFILE="/private/tmp/mac-config-mail.mobileconfig"
SECRETS_ROOT="/run/secrets/mail"

ACCOUNTS=(
  "account1"
  "account2"
  "account3"
  "account4"
  "account5"
  "account6"
  "account7"
  "account8"
)

cleanup() {
  rm -f "$PROFILE"
}

trap cleanup EXIT

require_secret() {
  local path="$1"

  if [[ ! -r "$path" ]]; then
    echo "Missing or unreadable secret:"
    echo "  $path"
    exit 1
  fi
}

xml_escape() {
  printf '%s' "$1" \
    | sed \
      -e 's/&/\&amp;/g' \
      -e 's/</\&lt;/g' \
      -e 's/>/\&gt;/g' \
      -e 's/"/\&quot;/g' \
      -e "s/'/\&apos;/g"
}

read_secret() {
  local path="$1"
  require_secret "$path"

  cat "$path"
}

PROFILE_UUID="$(uuidgen)"

cat > "$PROFILE" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>PayloadContent</key>
  <array>
EOF

for account in "${ACCOUNTS[@]}"; do
  ACCOUNT_ROOT="${SECRETS_ROOT}/${account}"

  ADDRESS="$(read_secret "${ACCOUNT_ROOT}/address")"
  USERNAME="$(read_secret "${ACCOUNT_ROOT}/username")"
  PASSWORD="$(read_secret "${ACCOUNT_ROOT}/password")"
  IMAP_HOST="$(read_secret "${ACCOUNT_ROOT}/imap_host")"
  IMAP_PORT="$(read_secret "${ACCOUNT_ROOT}/imap_port")"
  SMTP_HOST="$(read_secret "${ACCOUNT_ROOT}/smtp_host")"
  SMTP_PORT="$(read_secret "${ACCOUNT_ROOT}/smtp_port")"

  ADDRESS_XML="$(xml_escape "$ADDRESS")"
  USERNAME_XML="$(xml_escape "$USERNAME")"
  PASSWORD_XML="$(xml_escape "$PASSWORD")"
  IMAP_HOST_XML="$(xml_escape "$IMAP_HOST")"
  SMTP_HOST_XML="$(xml_escape "$SMTP_HOST")"

  PAYLOAD_UUID="$(uuidgen)"

  cat >> "$PROFILE" <<EOF
    <dict>
      <key>PayloadType</key>
      <string>com.apple.mail.managed</string>

      <key>PayloadVersion</key>
      <integer>1</integer>

      <key>PayloadIdentifier</key>
      <string>de.jayzone91.mac-config.mail.${account}</string>

      <key>PayloadUUID</key>
      <string>${PAYLOAD_UUID}</string>

      <key>PayloadDisplayName</key>
      <string>${ADDRESS_XML}</string>

      <key>EmailAccountDescription</key>
      <string>${ADDRESS_XML}</string>

      <key>EmailAccountName</key>
      <string>${ADDRESS_XML}</string>

      <key>EmailAccountType</key>
      <string>EmailTypeIMAP</string>

      <key>EmailAddress</key>
      <string>${ADDRESS_XML}</string>

      <key>IncomingMailServerAuthentication</key>
      <string>EmailAuthPassword</string>

      <key>IncomingMailServerHostName</key>
      <string>${IMAP_HOST_XML}</string>

      <key>IncomingMailServerPortNumber</key>
      <integer>${IMAP_PORT}</integer>

      <key>IncomingMailServerUseSSL</key>
      <true/>

      <key>IncomingMailServerUsername</key>
      <string>${USERNAME_XML}</string>

      <key>IncomingPassword</key>
      <string>${PASSWORD_XML}</string>

      <key>OutgoingMailServerAuthentication</key>
      <string>EmailAuthPassword</string>

      <key>OutgoingMailServerHostName</key>
      <string>${SMTP_HOST_XML}</string>

      <key>OutgoingMailServerPortNumber</key>
      <integer>${SMTP_PORT}</integer>

      <key>OutgoingMailServerUseSSL</key>
      <true/>

      <key>OutgoingMailServerUsername</key>
      <string>${USERNAME_XML}</string>

      <key>OutgoingPassword</key>
      <string>${PASSWORD_XML}</string>

      <key>OutgoingPasswordSameAsIncomingPassword</key>
      <false/>
    </dict>
EOF
done

cat >> "$PROFILE" <<EOF
  </array>

  <key>PayloadDisplayName</key>
  <string>mac-config Mail Accounts</string>

  <key>PayloadIdentifier</key>
  <string>de.jayzone91.mac-config.mail</string>

  <key>PayloadOrganization</key>
  <string>mac-config</string>

  <key>PayloadType</key>
  <string>Configuration</string>

  <key>PayloadUUID</key>
  <string>${PROFILE_UUID}</string>

  <key>PayloadVersion</key>
  <integer>1</integer>
</dict>
</plist>
EOF

chmod 600 "$PROFILE"

if ! plutil -lint "$PROFILE"; then
  echo "Generated configuration profile is invalid."
  exit 1
fi

echo
echo "Mail configuration profile created:"
echo "  $PROFILE"
echo
echo "Opening profile..."
echo

open "$PROFILE"

echo
echo "Install the profile in:"
echo
echo "  System Settings"
echo "  -> General"
echo "  -> Device Management"
echo
echo "Press Enter only after the profile has been installed."
read -r

rm -f "$PROFILE"
trap - EXIT

echo
echo "Temporary mail profile removed."
echo
echo "Mail accounts should now be available in Mail.app."