Clear-Host
$data = Get-Content '.\Data.txt'
$larger = 0;
for($count = 0; $count -lt $data.count -2; $count++){
  $sum = [int]$data[$count] + [int]$data[$count + 1] + [int]$data[$count + 2]
  if($count -eq 0){
    Write-Host $sum '(N/A - no previous sum)'
  }
  else{
    if($sum -gt $previous){
      $larger++
      Write-Host $sum '(increased)'
    }
    elseif($sum -eq $previous){
      Write-Host $sum '(no change)'
    }
    else{
      Write-Host $sum '(decreased)'
    }
  }
  $previous = $sum
}
Write-Host 'There are ' $larger ' sums that are larger than the previous sum.'
