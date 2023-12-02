$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day2\input.txt"
$sum = 0
foreach($line in $data){
  $cubes = @{
    "red" = 0
    "green" = 0
    "blue" = 0
  }
  $game = $line -split ":"
  $lookup = [Regex]::Matches($game[1],"(red|green|blue|[0-9]{1,})")
  for($i = 0; $i -lt $lookup.count - 1; $i = $i + 2){
    if($cubes.$($lookup[$i + 1].value) -lt [int]$lookup[$i].value){
      $cubes.$($lookup[$i + 1].value) = [int]$lookup[$i].value
    }
  }
  $power = $cubes.red * $cubes.green * $cubes.blue
  $sum = $sum + $power
}
$sum