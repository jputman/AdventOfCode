Clear-Host
$data = Get-Content '.\Data.txt'
$gamma = ''
$epsilon = ''
$length = $data[0].length
for($i = 0; $i -lt $data[0].length; $i++){
  $bit0 = 0;
  $bit1 = 0;
  for($j = 0; $j -lt $data.count; $j++){
    switch(($data[$j][$i])){
      '0'{
        $bit0++
      }
      '1'{
        $bit1++
      }
    }
  }
  if($bit0 -gt $bit1){
    $gamma += '0'
    $epsilon += '1'
  }
  else{
    $gamma += '1'
    $epsilon += '0'
  }
}
$gamma = [convert]::ToInt32($gamma,2)
$epsilon = [convert]::ToInt32($epsilon,2)
Write-Host 'Gamma: ' $gamma
Write-Host 'Epsilon: ' $epsilon 
Write-Host 'Answer: ' ($gamma * $epsilon )
