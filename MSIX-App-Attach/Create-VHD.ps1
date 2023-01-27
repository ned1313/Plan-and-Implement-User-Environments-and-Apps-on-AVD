# Prepare a VHD
$file = Get-Item -Path ~\Desktop\*.msix
$vhdName = $file.BaseName + ".vhd"
New-VHD -SizeBytes 1024MB -Path c:\temp\$vhdName -Dynamic -Confirm:$false
$vhdObject = Mount-VHD c:\temp\$vhdName -Passthru
$disk = Initialize-Disk -Passthru -Number $vhdObject.Number
$partition = New-Partition -AssignDriveLetter -UseMaximumSize -DiskNumber $disk.Number
Format-Volume -FileSystem NTFS -Confirm:$false -DriveLetter $partition.DriveLetter -Force

# Get the msixmgr tool
Invoke-WebRequest -Uri https://aka.ms/msixmgr -OutFile C:\temp\msixmgr.zip
Expand-Archive -Path C:\temp\msixmgr.zip -DestinationPath C:\desktop\

# Move the MSIX file into the x64 directory
Copy-Item -Path $file.PSPath -Destination ~\Desktop\x64\

# Run the msixmgr.exe program
mkdir -Path "$($partition.DriveLetter):\msix"
cd ~\Desktop\x64
.\msixmgr.exe -Unpack -packagePath $file.Name -destination "$($partition.DriveLetter):\msix" -applyacls

# Unmount VHD when complete
Dismount-VHD -DiskNumber $vhdObject.DiskNumber