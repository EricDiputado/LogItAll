Write-Host "Getting weather forecast..."
try {
    # Disable certificate validation for development
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }

    $webClient = New-Object System.Net.WebClient
    $webClient.Headers.Add("Accept", "application/json")
    $response = $webClient.DownloadString("https://localhost:7034/weatherforecast")
    $forecast = $response | ConvertFrom-Json
    
    Write-Host "`nReceived weather forecast:"
    $forecast | ForEach-Object {
        Write-Host ("- Date: $($_.date), Temperature: " + 
            "$($_.temperatureC)C / " +
            "$($_.temperatureF)F, " +
            "Summary: $($_.summary)")
    }
}
catch {
    Write-Host "Error calling the API: $($_.Exception.Message)"
    Write-Host "Stack trace: $($_.Exception.StackTrace)"
}
Write-Host "`nExecution Ended.`n"

# Write-Host "Getting weather forecast..."
# $forecast = Invoke-RestMethod -Uri "http://localhost:5080/weatherforecast" -Method Get
# Write-Host "`nReceived weather forecast:"
# $forecast | ForEach-Object {
#     Write-Host "- Date: $($_.date), Temperature: $($_.temperatureC) °C, Summary: $($_.summary)"
# }