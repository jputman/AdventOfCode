Clear-Host
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 4\input.txt' -Delimiter "`n"
$count = 0
foreach($input in $dataInput){
  $pairs = $input -split ","
  $set1 = $pairs[0] -split "-"
  $set2 = $pairs[1] -split "-"
  $compare = Compare-Object -ReferenceObject ($set1[0]..$set1[1]) -DifferenceObject ($set2[0]..$set2[1]) -IncludeEqual -ExcludeDifferent
  if($compare.InputObject){
    $count++
  }
}
$count