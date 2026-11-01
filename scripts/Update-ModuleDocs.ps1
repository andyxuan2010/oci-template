[CmdletBinding()]
param([switch]$Check)

$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path -Parent $PSScriptRoot
if (-not (Get-Command terraform-docs -ErrorAction SilentlyContinue)) { throw 'Install terraform-docs 0.16.0 to update or check generated module reference tables.' }
$version = terraform-docs --version
if ($LASTEXITCODE -ne 0 -or $version -notmatch '\bv0\.16\.0\b') { throw 'Use terraform-docs 0.16.0 for reproducible documentation output.' }
$failed = @()
$modules = @(Get-ChildItem -LiteralPath (Join-Path $repositoryRoot 'modules') -Directory | Sort-Object Name)
foreach ($module in $modules) {
    $arguments = @('markdown', 'table', '--config', (Join-Path $repositoryRoot '.terraform-docs.yml'))
    if ($Check) { $arguments += '--output-check' }
    $arguments += $module.FullName
    & terraform-docs @arguments
    if ($LASTEXITCODE -ne 0) { $failed += $module.Name }
}
if ($failed.Count -gt 0) { throw "Module documentation check failed: $($failed -join ', ')" }
Write-Host "Module documentation $(if ($Check) { 'check' } else { 'generation' }) passed for $($modules.Count) modules."
