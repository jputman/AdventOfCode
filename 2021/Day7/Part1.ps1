Clear-Host
$data = Get-Content '.\Data.txt'
$crabs = $data -split ','
$submarines = @{}
$fuelCost = 0


function calculatefuel($location, $object){
  $costing = 0
  foreach($key in $object.keys)
  {
    if($key -ne $location){
      $movementCost = [Math]::Abs($location - $key)
      $costing += $movementCost * $object[$key]
    }
  }
  return $costing
}


foreach($crab in $crabs){
  if($submarines[$crab]){
    $submarines[$crab]++
  }
  else{
    $submarines.Add($crab,1)
  }
}

foreach($key in $submarines.keys)
{
  $cost = calculatefuel -location $key -object $submarines
  if($fuelcost -eq 0 -or $cost -le $fuelCost){
    $fuelcost = $cost
  }
}

Write-Host 'The best fuel cost is ' $fuelcost
