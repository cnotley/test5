.PHONY: circleci tflint fmt docs validate

all: circleci tflint fmt docs validate

tflint:
	tflint --disable-rule=terraform_module_pinned_source

fmt:
	terraform fmt -check -diff -recursive

docs:
	terraform-docs . > README.md

validate: export TF_DATA_DIR = .terraform_validate
validate:
	rm -rf $(TF_DATA_DIR)
	terraform init -backend=false
	terraform validate
	rm -rf $(TF_DATA_DIR)
