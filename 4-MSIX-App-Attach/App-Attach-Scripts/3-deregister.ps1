#MSIX app attach deregistration sample

#region variables
$packageName = "PACKAGE_NAME"
#endregion

#region deregister
Remove-AppxPackage -PreserveRoamableApplicationData $packageName
#endregion