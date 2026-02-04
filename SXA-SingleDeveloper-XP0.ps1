# The Prefix used on SOLR, Website and Database instances.  | ALSO you need to hardcode line no 67 in sxa-XP0.json
#PS C:\ResourceFiles> Get-ExecutionPolicy -List
#PS C:\ResourceFiles> .\SXA-SingleDeveloper-XP0.ps1
#Get-ExecutionPolicy
# PS C:\ResourceFiles> powershell.exe -ExecutionPolicy Bypass -File .\SXA-SingleDeveloper-XP0.ps1
$prefix = "test103"
# The Password for the Sitecore Admin User
$SitecoreAdminPassword = "b"
# The root folder with the license file and WDP files.
$SCInstallRoot = "C:\ResourceFiles-test103"
# Root folder to install the site to. If left on the default [systemdrive]:\\inetpub\\wwwroot will be used
#"Custom.Site.PhysicalPath": "[joinpath(parameter('SitePhysicalRoot'),parameter('SiteName'))]", update in IdentityServer.json, sitecore-XP0.json and xconnect-xp0.json
#line 67 in default sxa-XP0.json update "Site.PhysicalPath": "[joinpath(environment('SystemDrive'), 'inetpub', 'wwwroot', parameter('SiteName'))]",
$SitePhysicalRoot = "C:\inetpub\wwwroot"
# The URL of the Solr Server
$SolrUrl = "https://localhost:9026/solr"
# The Folder that Solr has been installed in.
$SolrRoot = "C:\solr\solr-8.1.1\zip103solr-8.11.2"
# The Name of the Solr Service.
$SolrService = "zip103solr-8.11.2"
# The DNS name or IP of the SQL Instance.
$SqlServer = "(local)\SQLEXPRESS2022"
# A SQL user with sysadmin privileges.
$SqlAdminUser = "sa"
# The password for $SQLAdminUser.
$SqlAdminPassword = "D1g1tality!"
# The name for the Sitecore Content Delivery server.
$Sitename = "test103sc.dev.local"

$SPEPackage = (Get-ChildItem "$SCInstallRoot\Sitecore.PowerShell.Extensions*.scwdp.zip").FullName
$SXAPackage = (Get-ChildItem "$SCInstallRoot\Sitecore Experience Accelerator*.scwdp.zip").FullName

# Install Sitecore Powershell and Experience Accelerator packages
$sitecoreParams = @{
    Path                      = "$SCInstallRoot\SXA-SingleDeveloper-XP0.json"
    SPEPackage                = $SPEPackage
    SXAPackage                = $SXAPackage
    Prefix                    = $prefix
    SitecoreAdminPassword     = $SitecoreAdminPassword
    SqlServer                 = $SqlServer
    SqlAdminUser              = $SqlAdminUser
    SqlAdminPassword          = $SqlAdminPassword
    SolrUrl                   = $SolrUrl
    SolrRoot                  = $SolrRoot
    SolrService               = $SolrService
    Sitename                  = $Sitename
}

Push-Location $SCInstallRoot

Install-SitecoreConfiguration @sitecoreParams -verbose *>&1 | Tee-Object SXA-SingleDeveloper.log

Pop-Location