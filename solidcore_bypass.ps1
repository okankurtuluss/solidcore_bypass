$testExePath = "EXECUTABLE_PATH"

if (Test-Path $testExePath) {
    try {
        
        $exeBytes = [System.IO.File]::ReadAllBytes($testExePath)
        

        $assembly = [System.Reflection.Assembly]::Load($exeBytes)
        $entryPoint = $assembly.EntryPoint
        
        if ($entryPoint -ne $null) {
            Write-Host "EntryPoint found: " $entryPoint.Name -ForegroundColor Green
            
            $parameters = $entryPoint.GetParameters()
            
            if ($parameters.Length -eq 0) {
                $entryPoint.Invoke($null, $null)
            } else {
                $emptyArgs = [string[]]::new($parameters.Length)
                $entryPoint.Invoke($null, @($emptyArgs))
            }
            
            Write-Host "Memory Execution Successful" -ForegroundColor Green
        } else {
            Write-Host "EntryPoint not found" -ForegroundColor Red
        }
    } catch {
        Write-Host "ERROR: " $_.Exception.Message -ForegroundColor Red
        Write-Host "Details: " $_.Exception.StackTrace -ForegroundColor Red
    }
} else {
    Write-Host "EXE not found" -ForegroundColor Red
}