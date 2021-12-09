Clear-Host
$data = Get-Content '.\Data.txt'
$screens = @{119  = '0';36  = '1';93  = '2';109  = '3';46  = '4';107  = '5';123  = '6';37  = '7';127  = '8';111  = '9'}
$letterValues = @{}
$rightBarValues = @()
$nineLetters = @()


function topBar($obj){
  $entry1 = ($entries | where { $_.length -eq 2 }).ToCharArray()
  $entry2 = ($entries | where { $_.length -eq 3 }).ToCharArray()
  $topBar = (Compare-Object -ReferenceObject $entry2 -DifferenceObject $entry1).InputObject
  $letterValues.add($topbar, 1)
}

function LeftOrMid($obj){
  $entry1 = ($entries | where-object { $_.length -eq 2 }).ToCharArray()
  $entry2 = ($entries | where-object { $_.length -eq 4 }).ToCharArray()
  return (Compare-Object -ReferenceObject $entry2 -DifferenceObject $entry1).InputObject
}

function MidBar($obj){
  $entries = ($entries | where-object { $_.length -eq 5 })
  $v = @(($letterValues.GetEnumerator() | where-object {$_.Value -eq 1}).Name)
  $v += @(($letterValues.GetEnumerator() | where-object {$_.Value -eq 64}).Name)
  $v += $rightBarValues
  foreach($entry in $entries){
    $chance = $entry.ToCharArray() | where-object {$_ -notin $v}
    if($chance.length -eq 1){
      $letterValues.add($chance, 8)
      return $chance
    }
  }
}

function findNine($obj){
  $entry1 = ($obj | where-object { $_.length -eq 4 }).ToCharArray()
  $entry2 = ($obj | where-object { $_.length -eq 6 })
  foreach($entry in $entry2){
    $validate = $entry.ToCharArray() 
    $compare = Compare-Object -ReferenceObject $validate -DifferenceObject $entry1
    if($compare.count -eq 2){
      $removeTopBar = ($letterValues.GetEnumerator() | where-object {$_.Value -eq 1}).Name
      $compare = $compare.InputObject
      $bottomBar = $compare | where-object {$_ -ne $removeTopBar}
      $letterValues.add($bottomBar, 64)
      return $validate
    }
  }
}

function findTopRight($obj){
  $entry1 = ($obj | where-object { $_.length -eq 4 }).ToCharArray()
  $entries = $obj | where-object { $_.length -eq 6 }
  $checkAgainst = @()
  foreach($entry in $entries){
    $validate = $entry.ToCharArray() 
    $compare = Compare-Object -ReferenceObject $validate -DifferenceObject $entry1
    if($compare.count -ne 2){
      $checkAgainst += $entry
    }
  }
  $obj = (Compare-Object -ReferenceObject ($checkAgainst[0].ToCharArray()) -DifferenceObject ($checkAgainst[1].ToCharArray())).InputObject
  $obj = $obj | where-object {$_ -notin $letterValues.GetEnumerator().Name}
  $letterValues.add($obj, 4)
  return $obj

}




function MidBar($obj){
  $entries = ($entries | where-object { $_.length -eq 5 })
  $v = @(($letterValues.GetEnumerator() | where-object {$_.Value -eq 1}).Name)
  $v += @(($letterValues.GetEnumerator() | where-object {$_.Value -eq 64}).Name)
  $v += $rightBarValues
  foreach($entry in $entries){
    $chance = $entry.ToCharArray() | where-object {$_ -notin $v}
    if($chance.length -eq 1){
      $letterValues.add($chance, 8)
      return $chance
    }
  }
}

$totalAnswer = 0
foreach($line in $data){
  $letterValues = @{}
  $knownLetters = @{}
  $usedLetters = @()
  $split = $line -split "\|"
  $entries = ($split[0]).Trim() -split ' '
  topBar -obj $entries
  $rightBarValues = ($entries | where { $_.length -eq 2 }).ToCharArray()
  $topLeftOrMid = LeftOrMid -obj $entries
  $nineLetters = findNine -obj $entries
  findBottomLeft -obj $entries
  $lowerLeft = @('a','b','c','d','e','f','g') | where-object {$_ -notin  $nineLetters} 
  $letterValues.add($lowerLeft, 16)
  $topLeftCheck = MidBar -obj $entries
  $topLeft = $topLeftOrMid | where-object {$_ -ne $topLeftCheck}
  $letterValues.add($topLeft, 2)
  $topRightValue = findTopRight -obj $entries
  $bottomRightValue = $rightBarValues | where-object {$_ -notin $letterValues.GetEnumerator().Name}
  $letterValues.add($bottomRightValue, 32)

  $results = ($split[1]).Trim() -split ' '
  $answer = $null
  foreach($result in $results){
    $thisAnswer = 0
    for($x = 0; $x -lt $result.length; $x++){
      $thisAnswer += ($letterValues.GetEnumerator() | where-object {$_.Name -eq $result[$x]}).value
    }
    $answer += $screens.$thisAnswer
  }
  $totalAnswer += [int]$answer
}
Write-Host 'The final total is' $totalAnswer