using namespace System.Collections.Generic
Clear-Host
# Inspired by Mamue.  
Measure-Command {
  $list1 = [List[int]]::new()
  $list2 = [List[int]]::new()
  switch -Regex -File "D:\DevOps\AdventOfCode\2024\Day1\input.txt"  {
    '^\s*(?<left>\d+)\s+(?<right>\d+)\s*$' {
        $list1.Add([int]$matches['left'])
        $list2.Add([int]$matches['right'])
    }
    Default {}
  } 
  $total = 0
  foreach($item in $list1){
    if($list2.contains($item)){
      $total += $item * ($list2 | Where-Object {$_ -eq $item}).count 
    }
  }  
}
$total

# Original
Measure-Command {
$data = Get-Content "D:\DevOps\AdventOfCode\2024\Day1\input.txt"
$list1 = [System.Collections.Generic.List[int]]@()
$list2 = [System.Collections.Generic.List[int]]@()
foreach($item in $data){
  $temp = $item -split '\s+'
  $list1.add($temp[0]) | Out-Null
  $list2.add($temp[1]) | Out-Null
}
$total = 0
foreach($item in $list1){
  $total += ($list2 | Where-Object {$_ -eq $item}).count * $item
}
}
$total

