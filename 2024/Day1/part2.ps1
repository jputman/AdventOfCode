Clear-Host
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
$total
}