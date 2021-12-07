Clear-Host
#Write-Host '------------------------------- Script Starting -------------------------------' -ForegroundColor Blue
$data = Get-Content '.\Data.txt'
$fishes = $data -split ','
$days = 256


$SchoolofFish = [PSCustomObject]@{
  '0' = 0
  '1' = 0
  '2' = 0
  '3' = 0
  '4' = 0
  '5' = 0
  '6' = 0
  '7' = 0
  '8' = 0
}

foreach($fish in $fishes){
  $SchoolofFish.$fish++
}


#$SchoolofFish
for($day = 1; $day -le $days; $day++){
  $numberOfNewFish = $SchoolofFish.'0'
  for($i = 1; $i -le 8; $i++){
    $numFish = $SchoolofFish.$i
    $SchoolofFish.($i-1) = $numFish
  }
  $SchoolofFish.'8' = $numberOfNewFish
  $SchoolofFish.'6' += $numberOfNewFish
  #Write-Host '--------------------------------- Day ' $day ' ---------------------------------------------------' -ForegroundColor Red
  #$SchoolofFish  
}

$count = 0
for($i = 0; $i -le 8; $i++){
  $count += $SchoolofFish.$i
}
Write-Host 'There are ' $count ' fish'













#Write-Host '------------------------------- Script Ending -------------------------------' -ForegroundColor Blue