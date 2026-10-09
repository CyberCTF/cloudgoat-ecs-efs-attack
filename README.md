# CloudGoat: ECS EFS attack

[CloudGoat](https://github.com/RhinoSecurityLabs/cloudgoat) by Rhino Security Labs: "vulnerable by
design" AWS deployment scenarios. This repository runs its `ecs_efs_attack` scenario with
[Isoloom](https://www.isoloom.com) in your own AWS account: [`isoloom.yml`](isoloom.yml) describes
the cloud services, the scenario sits unchanged in
[`app/`](app), and [`terraform/`](terraform) is a small wrapper that
feeds the scenario what CloudGoat's Python CLI would.

| Cloud services | What |
| --- | --- |
| EC2 | The ruse box and an admin box |
| ECS | A cluster with a web task |
| EFS | A file system |
| Lambda | A scheduled function |
| IAM | Instance and task roles |

Cost while it runs: two t3.micro EC2 instances, an ECS cluster on them, an EFS file system, a Lambda function on a schedule, and public IPv4 addresses (about $0.05 an hour).

## Run it

Use an AWS account with nothing else in it, signed in with the AWS CLI (`aws login`, the
`default` profile, or set another with `-s cloud.vars.profile=<name>`), and Terraform installed.

```bash
isoloom run cloud-services -s cloud.vars.whitelist=$(curl -s https://checkip.amazonaws.com)/32
isoloom test cloud-services
isoloom down cloud-services
```

The scenario's instances accept only your public IP: pass it on `run` (the spec holds a
placeholder that refuses to deploy). `down` works without it.

`run` prints where to start (your starting credentials, if the scenario gives you some). Guide:
the scenario's [README](app/cloudgoat/scenarios/aws/ecs_efs_attack/README.md) and cheat sheets in [`app/cloudgoat/scenarios/aws/ecs_efs_attack/`](app/cloudgoat/scenarios/aws/ecs_efs_attack).
Anything you create yourself while playing isn't Terraform's: delete it before `down`.

Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

BSD-3-Clause, as CloudGoat ([LICENSE](LICENSE)). This lab is deliberately vulnerable: deploy it
only in an account you use for nothing else, and destroy it when you are done.
