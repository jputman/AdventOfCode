Clear-Host
$data = Get-Content '.\Data.txt'
$crabs = $data -split ','
$submarines = @{}
$fuelCost = 0

function getFuelCost($n){
  $total = 0
  for($i = 1; $i -le $n; $i++){
    $total += $i
  }
  return $total
}

function calculatefuel($location, $object){
  $costing = 0
  foreach($key in $object.keys){
    if($key -ne $location){
      $movementCost = [Math]::Abs($location - $key)
      #$thisCost = getFuelCost $movementCost
      $costing += ($movementCost/2)*(1 + $movementCost)*$object[$key]
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

for($x = 0; $x -le ($crabs | Measure-Object -Maximum).Maximum; $x++)
{
  $cost = calculatefuel -location $x -object $submarines
  if($fuelcost -eq 0 -or $cost -le $fuelCost){
    $fuelcost = $cost
  }
}
Write-Host 'The best fuel cost is ' $fuelcost