[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $true
. $PSScriptRoot\Shared.ps1

Describe 'Module Manifest Tests' {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath
        $? | Should Be $true
    }
}

$result = Invoke-Pester -Script "$PSScriptRoot\Integration.Tests.ps1" -PassThru

if ($result.FailedCount -gt 0) {
    throw "$($result.FailedCount) tests failed."
}