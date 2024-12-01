Clear-Host
$data = Get-Content "D:\DevOps\AdventOfCode\2024\Day1\input.txt"
$list1 = [System.Collections.Generic.List[int]]@()
$list2 = [System.Collections.Generic.List[int]]@()
foreach($item in $data){
  $temp = $item -split '\s+'
  $list1.add($temp[0]) | Out-Null
  $list2.add($temp[1]) | Out-Null
}
$list1 = $list1 | Sort-Object
$list2 = $list2 | Sort-Object
$total = 0
for($i = 0; $i -lt $list1.count; $i++){
  $total += [math]::Abs($list2[$i] - $list1[$i])
}
$total