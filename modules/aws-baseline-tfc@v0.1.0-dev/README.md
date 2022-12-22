# AWS-BASELINE-TFC

## Overview

Baseline adapter-module for `gamma-platform/tfc-lp-aws-baseline`.

The purpose of this module is to propagate necessary resources data (LP deployment's VPC Id, Route Tables etc.)
provisioned during the `tfc-lp-aws-baseline` module deployment to the consumer LP modules, maintaining the
Falcon /Launchpad Protocol standard, i.e. TF input /output naming convention.

Since the baseline is applied as a separate step, being an independent Terraform Cloud Workspace,
above-mentioned data is obtained via the `tfe` Provider by referencing the baseline module outputs,
given the TFC Workspace Id.
