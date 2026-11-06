# Contributing

Thanks for helping improve Camunda 7.24 + Spring Boot 4.1 compatibility.

## Before you start

- Open an issue for non-trivial changes so the approach can be discussed first.
- Search existing issues before opening a new one.
- Do not include credentials, internal hostnames, customer data, or unsanitized logs.
- Do not submit Camunda Enterprise Edition code or `-ee` artifacts.

## Pull requests

- Keep changes small and focused.
- Add or update a smoke test where possible.
- Explain the Spring Boot 4.1 incompatibility being fixed and the affected module.
- Sign off your commits:

  ```bash
  git commit -s -m "Describe the change"
  ```

  The sign-off certifies that you have the right to submit the contribution under the Apache
  License 2.0 (Developer Certificate of Origin).
- By submitting a pull request you agree that the contribution is licensed under Apache 2.0.

## Reporting bugs

Use the bug report issue template. Include:

- Camunda version and patch-set version;
- Spring Boot, Java, and database versions;
- a minimal reproduction, ideally using `smoke-app`;
- expected and actual behavior;
- sanitized stack traces and logs.

## Support

This is a best-effort community project. There is no SLA, and maintainers may take time to
respond. For production use, test against your own BPMN models, delegates, listeners, and plugins.
