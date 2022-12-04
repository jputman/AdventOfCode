Clear-Host
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 4\input.txt' -Delimiter "`n"
$count = 0
foreach($input in $dataInput){
  $pairs = $input -split ","
  $set1 = $pairs[0] -split "-"
  $set2 = $pairs[1] -split "-"
  if([int]$set1[0] -le [int]$set2[0] -and [int]$set1[1] -ge [int]$set2[1])
  {
    $count++
  }
  elseif([int]$set1[0] -ge [int]$set2[0] -and [int]$set1[1] -le [int]$set2[1]){
    $count++
  }
}
$count
