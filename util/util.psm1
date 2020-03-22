#Requires -Version 5.1

Add-Type -AssemblyName System.Net.Http
$httpClient = [System.Net.Http.HttpClient]::new()

# Downloads the content from a URL to a specified path.
function Receive-FileFromUrl([string] $SourceUrl, [string] $DestinationPath) {
    $sw = [Diagnostics.Stopwatch]::StartNew()
    Write-Output "Downloading file..."
    Write-Output "Source: $SourceUrl"
    Write-Output "Destination: $DestinationPath"

    try {
        $webStream = $httpClient.GetStreamAsync($SourceUrl).GetAwaiter().GetResult()
        $fileStream = [System.IO.File]::Create($DestinationPath)
        $webStream.CopyTo($fileStream)
        $fileStream.Close()
        $webStream.Close()
    } catch {
        $sw.Stop()
        Write-Error "Download failed in " $sw.Elapsed.ToString()
        try { $webStream.Close() } catch {}
        try { $fileStream.Close() } catch {}
        Remove-Item $DestinationPath
        Exit
    }

    $sw.Stop()
    Write-Output "Download completed in " $sw.Elapsed.ToString()
}

Export-ModuleMember -Function Receive-FileFromUrl

# Fully resolves a path without requiring the path to actually exist.
function Resolve-PathSafe([string] $Path) {
    return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($path)
}

Export-ModuleMember -Function Resolve-PathSafe
