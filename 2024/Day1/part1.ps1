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
}
$list1.sort()
$list2.sort()
$total = 0
for($i = 0; $i -lt $list1.count; $i++){
  $total += [math]::Abs($list2[$i] - $list1[$i])
}
$total

# Original
Measure-Command {
$data = Get-Content "D:\DevOps\AdventOfCode\2024\Day1\input.txt"
$list1 = [List[int]]@()
$list2 = [List[int]]@()
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
}
$total

#>