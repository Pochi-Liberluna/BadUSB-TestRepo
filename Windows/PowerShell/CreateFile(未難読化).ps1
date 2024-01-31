param(
  [string]$DirectoryPath = "C:\Windows\System32\",
  [string]$FileName = "backdoor.c"
  [string]$Code = @"
  #include<stdio.h>
  #include<stdlib.h>
  #include<string.h>

  main(void){
    printf("\n");
  }
  "@
  )

  $CodeFilePath = Join-Path -Path $DirectoryPath -ChildPath $FileName

  Set-Content -Path $CodeFilePath -Value $Code

  Start-Job -ScriptBlock{
    $exeFilePath = Join-Path -Path $using:DirectoryPath -ChildPath "backdoor.exe"
    Invoke-Expression -Command "gcc `"$using:CodeFilePath`" -o `"$exeFilePath`""
  } | Wait-Job | Receive-Job

