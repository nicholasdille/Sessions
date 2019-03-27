. ..\03_modules\ConvertTo-Base64.ps1

Describe 'ConvertTo-Base64' {
    It 'Converts to Base64 using the parameter' {
        ConvertTo-Base64 'abc' | Should Be 'YWJj'
    }
    It 'Converts to Base64 using the pipeline' {
        'abc' | ConvertTo-Base64 | Should Be 'YWJj'
    }
    It 'Converts multiple strings using the parameter' {
        $Base64 = @(ConvertTo-Base64 'abc', 'def')
        $Base64.Length | Should Be 2
    }
    It 'Converts multiple strings using the pipeline' {
        $Base64 = @('abc', 'def' | ConvertTo-Base64)
        $Base64.Length | Should Be 2
    }
}