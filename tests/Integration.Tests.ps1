[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope = '*', Target = 'SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot\Shared.ps1
Describe 'Integration tests' {

    Context "Get-UrlScanioScan" {
        It "Validate pattern and position for uuid" {
            { Get-UrlScanioScan "garbage" } | Should Throw
        }

        It "Returns results" {
            $call = Get-UrlScanioScan -uuid "a6a66576-69be-4a2a-9153-0ab0046bff60"
            $call.data | Should -Not -Be $null
        }
    }

    Context "Search-UrlScanio" {
        It "Error handling for no params" {
            { Search-UrlScanio } | Should Throw
        }

        It "Domain search" {
            $call = Search-UrlScanio -Domain "google.com" -Limit 1
            $call | Should -Not -Be $null
        }

        It "IP search" {
            $call = Search-UrlScanio -IP 148.251.45.170 -Limit 1
            $call | Should -Not -Be $null
        }

        It "ASN search" {
            $call = Search-UrlScanio -ASN AS24940 -Limit 1
            $call | Should -Not -Be $null
        }

        It "ASN name search" {
            $call = Search-UrlScanio -ASNName hetzner -Limit 1
            $call | Should -Not -Be $null
        }

        It "Filename search" {
            $call = Search-UrlScanio -Filename "jquery.min.js" -Limit 1
            $call | Should -Not -Be $null
        }

        It "Hash search" {
            $call = Search-UrlScanio -Hash "d699f303990ce9bd7d7c97e9bd3cad6a46ecf2532f475cf22ae58213237821b9" -Limit 1
            $call | Should -Not -Be $null
        }

        It "Server search" {
            $call = Search-UrlScanio -Server "nginx" -Limit 1
            $call | Should -Not -Be $null
        }

        It "Filter string search" {
            $call = Search-UrlScanio -Filter "page.domain:ch AND !page.country:ch" -Limit 1
            $call | Should -Not -Be $null
        }

        It "Raw results" {
            $call = Search-UrlScanio -Domain "google.com" -Limit 1 -Raw
            $call | Should -BeLike "*`"task`":  {*"
        }
    }

    Context "Start-UrlScanioScan" {
        It "Successful submission" {
            $call = Start-UrlScanioScan -Url "www.google.com" -ShowResults:$false
            $call.message | Should -BeExactly 'Submission successful'
        }
    }
}
