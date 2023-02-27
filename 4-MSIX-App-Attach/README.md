# Running the MSIX App Attach sample

I'm not going to lie, the MSIX App Attach process is neither simple nor fast. Unless you plan on using it in the wild, you can probably learn enough from the video and documentation to pass the exam. That being said, you might want to try it out for yourself. Here's a quick guide to get you started.

## The Capture VM

For the course, I spun up a Windows 10 box on a D series VM in Azure that supports nested virtualization. I also chose to place it in the same subnet as my domain controller and join it to the domain to simplify file transfer. You do not have to do this. All you need is a machine running Windows 10 or 11 with Hyper-V installed. You might already have that on your workstation!

From the Hyper-V menu, you can choose to Quick Create a VM and select the [MSIX Packaging Tool Environment operating system](https://learn.microsoft.com/en-us/windows/msix/packaging-tool/quick-create-vm). You'll also need to [download the installer for VS Code](https://code.visualstudio.com/download), if that's the application you want to present. I recommend the system installer for x64, that helps to show the masking capabilities of MSIX App Attach.

You also need a certificate to sign the MSIX package. The `Create-SelfSignedCert.ps1` script can be run from your workstation and the resulting public certificate and private key will be placed in the root of the C: drive. If that doesn't work for you, just change the directory.

The rest of the capture process is in the training videos, so just follow along and you'll be fine.
