# Telemetry

Right now we have none.

For privacy reasons we need to be able to run it ourselves.

So we use the exact same approach that we use for Deployment Modes, and have a single binary that can run the Telemetry.

## Modes

**[OnPremise mode](#single-mode)**

- Used on Premise.
- When you have low load, and do not need any HA.
- No admin skills required.

**[Cloud mode](#ha-mode)**

- Running on a cloud provider using k3d like we do for Deployment.
