Clear-Host
$data = Get-Content '.\SampleData.txt'
$lines = @()
$count = 0

foreach($line in $data){
  $split = $line -split ' -> '
  [int]$x1,[int]$y1 = $split[0].Split(',')
  [int]$x2,[int]$y2 = $split[1].Split(',')
  
  if($x1 -gt $x2){
    $xadd = -1
    $xchange = $x1 - $x2
  }
  elseif($x1 -eq $x2){
    $xadd = 0
    $xchange = 0
  }
  else{
    $xadd = 1
    $xchange = $x2 - $x1
  }

  if($y1 -gt $y2){
    $yadd = -1
    $ychange = $y1 - $y2
  }
  elseif($y1 -eq $y2){
    $yadd = 0
    $ychange = 0  
  }
  else{
    $yadd = 1
    $ychange = $y2 - $y1
  }

  if($xchange -gt $ychange){
    $loop = $xchange
  }
  else{
    $loop = $ychange
  }

  $pointsForLine = @()
  $xpos = $x1
  $ypos = $y1
  for($i = 0; $i -le $loop; $i++){
    $pointsForLine += "$xpos,$ypos"
    $xpos += $xadd
    $ypos += $yadd
  }
  $lines += [pscustomobject]@{x1 = $x1; x2 = $x2; y1 = $y1; y2 = $y2; Points = $pointsForLine}
}
$possibleMatches = $lines | Where-Object {$_.x1 -eq $_.x2 -or $_.y1 -eq $_.y2}
$matches = ($possibleMatches.Points | Group-Object | Where-Object {$_.Count -gt 1}).Count
Write-Host 'We have ' $matches ' matches'
