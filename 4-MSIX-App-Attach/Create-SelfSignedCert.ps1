# Run this script from your Windows 10 capture machine to generate a self-signed certificate
# and export the pfx and cer signing and trust on session hosts

$cert = New-SelfSignedCertificate -Type Custom -Subject "CN=Contoso HQ, O=Contoso Corporation, C=US" -KeyUsage DigitalSignature -FriendlyName "Contoso HQ MSIX" -CertStoreLocation "Cert:\CurrentUser\My" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.3", "2.5.29.19={text}")

$password = ConvertTo-SecureString -String 'ContosoHQ!' -Force -AsPlainText 

$path = 'Cert:\CurrentUser\My\' + $cert.Thumbprint

Export-PfxCertificate -cert $path -FilePath C:\msix.pfx -Password $password

Export-Certificate -Cert $path -FilePath C:\msix.cer -Type CERT
