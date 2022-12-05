Clear-Host
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day1\part1input.txt' -Raw
$nl = [System.Environment]::NewLine
$calories = $dataInput -split "$nl$nl"
$elves = [System.Collections.ArrayList]::new()
foreach($total in $calories){
  $elves.add(($total -split "$nl" | measure-object -sum).Sum) | Out-Null
}
$elves | Sort-Object -Descending | Select-Object -first 3 | Measure-Object -Sum