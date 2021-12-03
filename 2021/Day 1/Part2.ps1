Clear-Host
$data = Get-Content '.\Data.txt'
$larger = 0;
for($count = 0; $count -lt $data.count -2; $count++){
  $sum = [int]$data[$count] + [int]$data[$count + 1] + [int]$data[$count + 2]
  if($count -eq 0){
  }
  else{
    if($sum -gt $previous){
      $larger++
    }
  }
  $previous = $sum
}
Write-Host 'There are ' $larger ' sums that are larger than the previous sum.'
