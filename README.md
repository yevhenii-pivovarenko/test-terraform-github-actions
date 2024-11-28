Small experiment to try out a combination of Terraform + GitHub Actions


3 steps are necessary to facilitate deployment (*over*simplified):

1. Create a function that you want to deploy, test it locally. (`main.py`)
2. Create Terraform config to deploy the necessary infrastructure. (`config.tf` with supplementary files of `terraform.tfvars` for env)
3. Create GitHub Actions config that will utilize Terraform to deploy code to prod in CI/CD. (`.github/workflows/` with supplementary `.json` file for authentication in this particular case)


> Getting the correct minimal permissions necessary for deployment is a **PAIN**, he-he.