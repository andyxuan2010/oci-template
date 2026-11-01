# Contributing

Preserve deployed resource addresses and input names where practical, and document intentional behavior changes in [CHANGELOG.md](CHANGELOG.md) and [migration notes](docs/MIGRATION.md). Follow the [module standard](docs/REPO_MODULES_GUIDE.md), [security standard](SECURITY.md), and repository `.editorconfig`/`.gitattributes` conventions.

Use Terraform 1.15.8 for the same CLI baseline as CI, PowerShell 7, OCI provider >= 8.23.0 and < 9.0.0, and terraform-docs 0.16.0. Credentials and local environment files must remain outside commits.

## Checks

```powershell
terraform fmt -check -recursive
terraform init -backend=false -input=false
terraform validate
terraform test
.\test.ps1
.\scripts\Test-TerraformModules.ps1 -SkipInit -NoColor
.\scripts\Update-ModuleDocs.ps1
.\scripts\Update-ModuleDocs.ps1 -Check
.\scripts\Test-DocsSecurity.ps1
.\scripts\Build-DocsSite.ps1
.\scripts\Test-DocsSite.ps1
git diff --check
```

Run `test.ps1` before using `-SkipInit` in the module test runner. Optional TFLint checks provide additional Terraform linting. Mock tests require no OCI credentials; live deployment acceptance remains a separate reviewed plan with target-tenancy permissions and network prerequisites.

Human-authored README/EXAMPLES content must describe purpose, composition, security choices, and limits. Only edit generated reference sections by regenerating them. Module references use the canonical repository URL; production callers pin reviewed commits or releases. Refresh `docs-manifest.json` through the docs build or `scripts/New-DocsManifest.ps1` after adding/removing Markdown files.
