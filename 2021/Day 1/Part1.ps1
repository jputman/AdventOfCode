Clear-Host
$data = Get-Content '.\Data.txt'
$larger = 0;
Write-Host $data[0] '(N/A - no previous measurement)'
for($count = 1; $count -lt $data.Count; $count++){
  if([int]$data[$count] -gt [int]$data[$count-1]){
    Write-Host $data[$count] '(increased)'
    $larger++
  }
  else{
    Write-Host $data[$count] '(decreased)'
  }
}
Write-Host 'There are ' $larger ' measurements that are larger than the previous measurement.'