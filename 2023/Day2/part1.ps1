$data = Get-Content "D:\DevOps\AdventOfCode\2023\Day2\input.txt"
$cubes = @{
  "red" = 12
  "green" = 13
  "blue" = 14
}
$sum = 0
foreach($line in $data){
  $game = $line -split ":"
  $gameNumber = $game[0] -replace "\D*",""
  $lookup = [Regex]::Matches($game[1],"(red|green|blue|[0-9]{1,})")
  $valid = $true
  for($i = 0; $i -lt $lookup.count - 1; $i = $i + 2){
    if($cubes.$($lookup[$i + 1].value) -lt [int]$lookup[$i].value){
      $valid = $false
      break
    }
  }
  if($valid){
    $sum = $sum + [convert]::ToInt32($gameNumber, 10)
  }
}
$sum