Configuration LCM {
    Node 'localhost' {
        LocalConfigurationManager {
            DownloadManagerCustomData = @{
                ServerUrl = "https://$PullServer/PSDSCPullServer.svc";
                AllowUnsecureConnection = 'false';

                # Thumbprint of certificate for client authentication
                CertificateID = (Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object {$_.FriendlyName -eq 'DSCPullServerAuthentication'}).Thumbprint;
            }

            # Thumbprint of certificate for credential encryption
            CertificateID = (Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object {$_.FriendlyName -eq 'DSCEncryption'}).Thumbprint;
        }
    }
}
