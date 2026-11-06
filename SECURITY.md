# Security policy

## Reporting a vulnerability

Do **not** open a public issue for a security vulnerability.

Use GitHub's private vulnerability reporting:

1. Open the **Security** tab of this repository.
2. Choose **Report a vulnerability**.
3. Include the affected version, a minimal reproduction, impact, and any suggested fix.

We aim to acknowledge reports within 7 days, but this is a best-effort community project with no
SLA. Please allow time for a fix before public disclosure.

## Scope

This repository contains compatibility patches and a smoke application for Camunda 7.24.0.
Security issues in the Camunda engine itself should also be reported to the Camunda maintainers if
they are not caused by these patches.

## Supported versions

Security fixes are applied to the latest patch release on `main`. Older patch releases may not
receive backports.
