Clear-Host
Measure-Command {
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 6\input.txt'
#$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 6\example.txt'
for($i = 0;$i -lt $dataInput.length - 13; $i++){
  $out = ($dataInput.substring($i,14)).ToCharArray() | Group-Object
  $isMarker = $true
  foreach($obj in $out){
    if($obj.count -gt 1){$isMarker = $false;break}
  }
  if($isMarker){break}
}
$i + 14
}