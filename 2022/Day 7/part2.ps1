Clear-Host
$dataInput = Get-Content 'D:\Git Repos\Personal\AdventOfCode\2022\Day 7\input.txt'
$dirTree = @{}
$curDir = $null
$dispace = 70000000
$needed = 30000000
foreach($item in $dataInput){
  $line = $item.split();
  switch -wildcard ($item) {
    "$ cd /" {
      $curDir = "/"
      break
    }
    "dir*" {break}    
    "$ ls" {break}
    "$ cd .." {
      $curDir = $curDir.Substring(0,$curDir.length -1)
      $curDir = $curDir.Substring(0,$curDir.LastIndexOf('/')) + "/"
      break
    }
    "$ cd*" {
      $curDir = "$($curDir)$($line[2])/"
      break
    }
    default {
      if(!($dirTree.$curDir)){
        $dirTree.Add($curDir,[int]$line[0]);
      }
      else{
        $dirTree.$curDir += [int]$line[0]
      }
      $parentPath = $curDir.Substring(0,$curDir.length -1)
      while($parentPath -ne ""){
        $parentPath = $parentPath.Substring(0,$parentPath.LastIndexOf('/'))
        $dirTree.($parentPath + "/") += [int]$line[0]
      }
      break
    }
  }
}

$find = $needed - (70000000 - $dirTree."/")
((($dirTree.GetEnumerator() | Where-Object {$_.Value -ge $find})).Value) | Measure-object -Minimum