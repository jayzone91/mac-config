#!/usr/bin/env python3

import imaplib
import smtplib
from pathlib import Path

SECRETS_ROOT = Path("/run/secrets/mail")

ACCOUNTS = [
    "account1",
    "account2",
    "account3",
    "account4",
    "account5",
    "account6",
    "account7",
    "account8",
]


def read_secret(account: str, name: str) -> str:
    return (SECRETS_ROOT / account / name).read_text().strip()


def check_imap(account: str):
    address = read_secret(account, "address")
    username = read_secret(account, "username")
    password = read_secret(account, "password")
    host = read_secret(account, "imap_host")
    port = int(read_secret(account, "imap_port"))

    try:
        connection = imaplib.IMAP4_SSL(host, port, timeout=10)
        connection.login(username, password)
        connection.logout()

        print(f"[OK]   {account}: {address} -> IMAP")
        return True

    except Exception as exc:
        print(f"[FAIL] {account}: {address} -> IMAP: {exc}")
        return False


def check_smtp(account: str):
    address = read_secret(account, "address")
    username = read_secret(account, "username")
    password = read_secret(account, "password")
    host = read_secret(account, "smtp_host")
    port = int(read_secret(account, "smtp_port"))

    try:
        if port == 465:
            connection = smtplib.SMTP_SSL(host, port, timeout=10)
        else:
            connection = smtplib.SMTP(host, port, timeout=10)
            connection.ehlo()
            connection.starttls()
            connection.ehlo()

        connection.login(username, password)
        connection.quit()

        print(f"[OK]   {account}: {address} -> SMTP")
        return True

    except Exception as exc:
        print(f"[FAIL] {account}: {address} -> SMTP: {exc}")
        return False


def main():
    failed = False

    for account in ACCOUNTS:
        print()
        print(f"Checking {account}")

        if not check_imap(account):
            failed = True

        if not check_smtp(account):
            failed = True

    print()

    if failed:
        print("One or more mail accounts failed.")
        raise SystemExit(1)

    print("All mail accounts passed.")


if __name__ == "__main__":
    main()