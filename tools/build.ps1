#Requires -Modules psake
[cmdletbinding()]
param(
    [ValidateSet('Build','Test','BuildHelp','BuildTests','Install','Clean','Analyze','Publish','Sign','ExportFunctionsToSrc')]
    [string[]]$Task = 'Build'
)

Import-Module psake;Import-Module Pester;Import-Module PSScriptAnalyzer
Invoke-psake -buildFile "$PSScriptRoot\_build.psake.ps1" -taskList $Task -Verbose:$VerbosePreference