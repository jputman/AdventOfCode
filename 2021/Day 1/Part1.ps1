Clear-Host
$data = Get-Content '.\Data.txt'
$larger = 0;
for($count = 1; $count -lt $data.Count; $count++){
  if([int]$data[$count] -gt [int]$data[$count-1]){
    $larger++
  }
}
Write-Host 'There are ' $larger ' sums that are larger than the previous sum.'