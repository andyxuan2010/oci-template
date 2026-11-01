[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$tokens = $null
$parseErrors = $null
$ast = [Management.Automation.Language.Parser]::ParseFile((Join-Path $PSScriptRoot 'Build-DocsSite.ps1'), [ref]$tokens, [ref]$parseErrors)
if ($parseErrors.Count -gt 0) { throw 'Documentation builder has PowerShell parse errors.' }
$repoRoot = $repositoryRoot
$names = @('Resolve-SiteOutput', 'Html', 'Safe-MarkdownUrl', 'Source-LinkHref', 'Inline-Markdown')
foreach ($definition in $ast.FindAll({ param($node) $node -is [Management.Automation.Language.FunctionDefinitionAst] }, $true)) {
    if ($definition.Name -in $names) { . ([scriptblock]::Create($definition.Extent.Text)) }
}

foreach ($url in @('javascript:alert(1)', 'data:text/html,unsafe', 'vbscript:unsafe', '//example.com', "java`nscript:unsafe")) {
    if ((Safe-MarkdownUrl $url) -ne '#') { throw "Unsafe URL was accepted: $url" }
}
if ((Safe-MarkdownUrl 'mailto:team@example.com' -Image) -ne '#') { throw 'Images must reject mailto URLs.' }
if ((Inline-Markdown '[guide](guide.md#usage)') -notmatch 'href="guide.html#usage"') { throw 'Safe Markdown links must still work.' }
if ((Inline-Markdown '[unsafe](javascript:alert)') -match 'href="javascript:') { throw 'Markdown renderer accepted an executable URL.' }
if ((Inline-Markdown '<script>alert(1)</script>') -match '<script>') { throw 'Raw HTML must be escaped.' }
$script:CurrentSourcePath = 'modules/compute_instance/README.md'
if ((Source-LinkHref 'tests/basic.tftest.hcl') -ne 'https://github.com/CCOE-Azure/oci-template/blob/main/modules/compute_instance/tests/basic.tftest.hcl') { throw 'Code links must resolve to the canonical source repository.' }
if ((Source-LinkHref '../../../../outside.tf') -ne '#') { throw 'Code links cannot escape the repository.' }

foreach ($directory in @('.', '..', '../outside', 'modules', 'docs')) {
    $rejected = $false
    try { Resolve-SiteOutput -RepositoryRoot $repositoryRoot -Directory $directory | Out-Null }
    catch { $rejected = $true }
    if (-not $rejected) { throw "Unsafe site output was accepted: $directory" }
}
if ((Resolve-SiteOutput -RepositoryRoot $repositoryRoot -Directory '_site') -ne (Join-Path $repositoryRoot '_site')) { throw 'Default site output must remain supported.' }
Write-Host 'Documentation URL and output-directory security checks passed.'
