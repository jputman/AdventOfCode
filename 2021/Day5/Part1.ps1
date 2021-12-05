Clear-Host
$data = Get-Content '.\Data.txt'
$lines = @()
$count = 0

function getChange($int1, $int2){
  if($int1 -gt $int2){
    $intadd = -1
    $intchange = $int1 - $int2
  }
  elseif($int1 -eq $int2){
    $intadd = 0
    $intchange = 0
  }
  else{
    $intadd = 1
    $intchange = $int2 - $int1
  }
  return $intadd, $intchange
}

foreach($line in $data){
  $split = $line -split ' -> '
  [int]$x1,[int]$y1 = $split[0].Split(',')
  [int]$x2,[int]$y2 = $split[1].Split(',')
  
  $xadd, $xchange = getChange -int1 $x1 -int2 $x2
  $yadd, $ychange = getChange -int1 $y1 -int2 $y2

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
