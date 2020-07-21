# File Generator (filegen.ps1)
# Written by Kirk Ryan - NetApp / Microsoft
# Version 1.0 - 21/07/2020 - Initial Build - Generate several large and small files as per a given ratio

# Configure boundaries of file types
# Small Files
$smallFileMinSize = 1000
# TODO $smallFileMaxSize = 1000000

# Large Files
$largeFileMinSize = 100000000
# TODO $largeFileMaxSize = 500000000

# Total Capacity to generate
# Total Dataset Size
$totalDatasetSize = 1000000000000 #Size In Bytes
# Small Files Ratio
$smallFilesRatio = 0.5
# Large Files Ration
$largeFilesRatio = 1.0 - $smallFilesRatio

$numberOfSmallFilesToGenerate = $totalDatasetSize * $smallFilesRatio / $smallFileMinSize
$numberOfLargeFilesToGenerate = $totalDatasetSize * $largeFilesRatio / $largeFileMinSize

# Manual Override Section - Useful for small tests
#$numberOfSmallFilesToGenerate = 10
#$numberOfLargeFilesToGenerate = 2

# Generate small files
Write-Output "Starting File Generation..."

$msg = "Creating $numberOfSmallFilesToGenerate small files"
Write-Output $msg 
$fileCounter = $numberOfSmallFilesToGenerate
do {
    #Write a small file
    $out = new-object byte[] $smallFileMinSize; (new-object Random).NextBytes($out);
    $filename = "$pwd/filegen-sm-$fileCounter.txt"
    #may need filepath?
    [IO.File]::WriteAllBytes($filename, $out)
    #fsutil file createnew filegen-$numberOfSmallFilesToGenerate.txt $smallFileMinSize
    #File has been written, reduce the remaining count by one
    $fileCounter--;
    #Show Progress
    Write-Progress -Activity "Task 1: Small File Generation" -Status "$fileCounter files remaining" -PercentComplete ($fileCounter / $numberOfSmallFilesToGenerate * 100)
} until ($fileCounter -eq 0)

$msg = "Creating $numberOfLargeFilesToGenerate large files"
Write-Output $msg 

# Generate large files
$fileCounter = $numberOfLargeFilesToGenerate
do {
    #Write a small file
    $out = new-object byte[] $largeFileMinSize; (new-object Random).NextBytes($out);
    $filename = "$pwd/filegen-lg-$fileCounter.txt"
    #may need filepath?
    [IO.File]::WriteAllBytes($filename, $out)
    #fsutil file createnew filegen-$numberOfSmallFilesToGenerate.txt $smallFileMinSize
    #File has been written, reduce the remaining count by one
    $fileCounter--;
    #Show Progress
    Write-Progress -Activity "Task 2: Large File Generation" -Status "$fileCounter files remaining" -PercentComplete ($fileCounter / $numberOfLargeFilesToGenerate * 100)
} until ($fileCounter -eq 0)

Write-Output "File Generation Complete, Have a NICE day!"