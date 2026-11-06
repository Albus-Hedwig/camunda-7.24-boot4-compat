# Database schema upgrade

The patch set itself does not change the Camunda database schema. The 7.24.0 engine can create a new
schema or upgrade an existing 7.x schema automatically when `camunda.bpm.database.schema-update` is
enabled.

Guidance:

- Validate against PostgreSQL 17 (the version used for the compatibility smoke test).
- Back up the database before upgrading an existing environment.
- A Camunda schema upgrade is one-way; an older engine may not be able to use the upgraded schema.
- For a greenfield environment, create a new database and deploy the BPMN models again instead of
  upgrading the old database.
- Rehearse the upgrade on a database copy before running it in place.
