Clear-Host
Write-Host '----------------------------------------- Start Script -----------------------------------------' -ForegroundColor Blue
$data = Get-Content '.\Data.txt'
$lines = @()


foreach($line in $data){
  $split = $line -split "\|"
  $results = ($split[1]).Trim() -split ' '
  
  foreach($result in $results){
    $length = $result.Length
    $lines += [pscustomobject]@{Name = $result; Lit = $length;}
  }
}

$uniqueOptions = @(2,4,3,7)
(($lines.Lit | Group-Object | Where-Object {$_.Name -in $uniqueOptions}).Group).Count


Write-Host '------------------------------------------ End Script ------------------------------------------' -ForegroundColor Blue