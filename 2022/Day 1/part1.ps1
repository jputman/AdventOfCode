Clear-Host
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day1\part1input.txt' -Raw
$nl = [System.Environment]::NewLine
$calories = $dataInput -split "$nl$nl"
$elves = [System.Collections.ArrayList]::new()
foreach($total in $calories){
  $elves.add(($total -split "$nl" | measure-object -sum).Sum) | Out-Null
}
$elves | Measure-Object -Maximum