#PS C:\WINDOWS\system32> iisreset /stop
#PS C:\WINDOWS\system32> net stop "zip103solr-8.11.2"
#PS C:\WINDOWS\system32> Get-InstalledModule -Name SitecoreInstallFramework
# The Prefix that will be used on SOLR, Website and Database instances.
$Prefix = "test103"
# The Password for the Sitecore Admin User. This will be regenerated if left on the default.
$SitecoreAdminPassword = "b"
# The root folder with the license file and WDP files.
$SCInstallRoot = "C:\ResourceFiles-test103"
# Root folder to install the site to. If left on the default [systemdrive]:\\inetpub\\wwwroot will be used
#"Custom.Site.PhysicalPath": "[joinpath(parameter('SitePhysicalRoot'),parameter('SiteName'))]", update in IdentityServer.json, sitecore-XP0.json and xconnect-xp0.json
$SitePhysicalRoot = "C:\inetpub\wwwroot"
# The name for the XConnect service.
$XConnectSiteName = "test103xconnect.dev.local"
# The Sitecore site instance name.
$SitecoreSiteName = "test103sc.dev.local"
# Identity Server site name
$IdentityServerSiteName = "test103identityserver.dev.local"
# The Path to the license file
$LicenseFile = "$SCInstallRoot\license.xml"
# The URL of the Solr Server
$SolrUrl = "https://localhost:9026/solr"
# The Folder that Solr has been installed to.
$SolrRoot = "C:\solr\solr-8.1.1\zip103solr-8.11.2"
# The Name of the Solr Service.
$SolrService = "zip103solr-8.11.2"
# The DNS name or IP of the SQL Instance.
$SqlServer = "(local)\SQLEXPRESS2022"
# A SQL user with sysadmin privileges.
$SqlAdminUser = "sa"
# The password for $SQLAdminUser.
$SqlAdminPassword = "D1g1tality!"
# The path to the XConnect Package to Deploy.
$XConnectPackage = (Get-ChildItem "$SCInstallRoot\Sitecore * rev. * (OnPrem)_xp0xconnect.*scwdp.zip").FullName
# The path to the Sitecore Package to Deploy.
$SitecorePackage = (Get-ChildItem "$SCInstallRoot\Sitecore * rev. * (OnPrem)_single.*scwdp.zip").FullName
# The path to the Identity Server Package to Deploy.
$IdentityServerPackage = (Get-ChildItem "$SCInstallRoot\Sitecore.IdentityServer * rev. * (OnPrem)_identityserver.*scwdp.zip").FullName
# The Identity Server password recovery URL, this should be the URL of the CM Instance
$PasswordRecoveryUrl = "https://$SitecoreSiteName"
# The URL of the Identity Server
$SitecoreIdentityAuthority = "https://$IdentityServerSiteName"
# The URL of the XconnectService
$XConnectCollectionService = "https://$XConnectSiteName"
# The random string key used for establishing connection with IdentityService. This will be regenerated if left on the default.
$ClientSecret = "SIF-Default"
# Pipe-separated list of instances (URIs) that are allowed to login via Sitecore Identity.
$AllowedCorsOrigins = "https://$SitecoreSiteName"
# The parameter for the installing delta WDP packages
$Update = $false
# The elastic pool name for deploy databases from the SQL Azure.
$DeployToElasticPoolName = ""

# Install XP0 via combined partials file.
$singleDeveloperParams = @{
    Path = "$SCInstallRoot\XP0-SingleDeveloper.json"
    SqlServer = $SqlServer
    SqlAdminUser = $SqlAdminUser
    SqlAdminPassword = $SqlAdminPassword
    SitecoreAdminPassword = $SitecoreAdminPassword
    SolrUrl = $SolrUrl
    SolrRoot = $SolrRoot
    SolrService = $SolrService
    Prefix = $Prefix
    XConnectCertificateName = $XConnectSiteName
    IdentityServerCertificateName = $IdentityServerSiteName
    IdentityServerSiteName = $IdentityServerSiteName
    LicenseFile = $LicenseFile
    XConnectPackage = $XConnectPackage
    SitecorePackage = $SitecorePackage
    IdentityServerPackage = $IdentityServerPackage
    XConnectSiteName = $XConnectSiteName
    SitecoreSitename = $SitecoreSiteName
    PasswordRecoveryUrl = $PasswordRecoveryUrl
    SitecoreIdentityAuthority = $SitecoreIdentityAuthority
    XConnectCollectionService = $XConnectCollectionService
    ClientSecret = $ClientSecret
    AllowedCorsOrigins = $AllowedCorsOrigins
    SitePhysicalRoot = $SitePhysicalRoot
    Update = $Update
    DeployToElasticPoolName = $DeployToElasticPoolName
}

Push-Location $SCInstallRoot

Install-SitecoreConfiguration @singleDeveloperParams *>&1 | Tee-Object XP0-SingleDeveloper.log

# Uncomment the below line and comment out the above if you want to remove the XP0 SingleDeveloper Config
#Uninstall-SitecoreConfiguration @singleDeveloperParams *>&1 | Tee-Object XP0-SingleDeveloper-Uninstall.log

Pop-Location

# SIG # Begin signature block
# MIIl4wYJKoZIhvcNAQcCoIIl1DCCJdACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCB7JHllWHpL9LOx
# 1w4GWsKHYRehBvL4d0PH5AoQducO8qCCE8kwggWQMIIDeKADAgECAhAFmxtXno4h
# MuI5B72nd3VcMA0GCSqGSIb3DQEBDAUAMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNV
# BAMTGERpZ2lDZXJ0IFRydXN0ZWQgUm9vdCBHNDAeFw0xMzA4MDExMjAwMDBaFw0z
# ODAxMTUxMjAwMDBaMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
# bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lDZXJ0
# IFRydXN0ZWQgUm9vdCBHNDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
# AL/mkHNo3rvkXUo8MCIwaTPswqclLskhPfKK2FnC4SmnPVirdprNrnsbhA3EMB/z
# G6Q4FutWxpdtHauyefLKEdLkX9YFPFIPUh/GnhWlfr6fqVcWWVVyr2iTcMKyunWZ
# anMylNEQRBAu34LzB4TmdDttceItDBvuINXJIB1jKS3O7F5OyJP4IWGbNOsFxl7s
# Wxq868nPzaw0QF+xembud8hIqGZXV59UWI4MK7dPpzDZVu7Ke13jrclPXuU15zHL
# 2pNe3I6PgNq2kZhAkHnDeMe2scS1ahg4AxCN2NQ3pC4FfYj1gj4QkXCrVYJBMtfb
# BHMqbpEBfCFM1LyuGwN1XXhm2ToxRJozQL8I11pJpMLmqaBn3aQnvKFPObURWBf3
# JFxGj2T3wWmIdph2PVldQnaHiZdpekjw4KISG2aadMreSx7nDmOu5tTvkpI6nj3c
# AORFJYm2mkQZK37AlLTSYW3rM9nF30sEAMx9HJXDj/chsrIRt7t/8tWMcCxBYKqx
# YxhElRp2Yn72gLD76GSmM9GJB+G9t+ZDpBi4pncB4Q+UDCEdslQpJYls5Q5SUUd0
# viastkF13nqsX40/ybzTQRESW+UQUOsxxcpyFiIJ33xMdT9j7CFfxCBRa2+xq4aL
# T8LWRV+dIPyhHsXAj6KxfgommfXkaS+YHS312amyHeUbAgMBAAGjQjBAMA8GA1Ud
# EwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgGGMB0GA1UdDgQWBBTs1+OC0nFdZEzf
# Lmc/57qYrhwPTzANBgkqhkiG9w0BAQwFAAOCAgEAu2HZfalsvhfEkRvDoaIAjeNk
# aA9Wz3eucPn9mkqZucl4XAwMX+TmFClWCzZJXURj4K2clhhmGyMNPXnpbWvWVPjS
# PMFDQK4dUPVS/JA7u5iZaWvHwaeoaKQn3J35J64whbn2Z006Po9ZOSJTROvIXQPK
# 7VB6fWIhCoDIc2bRoAVgX+iltKevqPdtNZx8WorWojiZ83iL9E3SIAveBO6Mm0eB
# cg3AFDLvMFkuruBx8lbkapdvklBtlo1oepqyNhR6BvIkuQkRUNcIsbiJeoQjYUIp
# 5aPNoiBB19GcZNnqJqGLFNdMGbJQQXE9P01wI4YMStyB0swylIQNCAmXHE/A7msg
# dDDS4Dk0EIUhFQEI6FUy3nFJ2SgXUE3mvk3RdazQyvtBuEOlqtPDBURPLDab4vri
# RbgjU2wGb2dVf0a1TD9uKFp5JtKkqGKX0h7i7UqLvBv9R0oN32dmfrJbQdA75PQ7
# 9ARj6e/CVABRoIoqyc54zNXqhwQYs86vSYiv85KZtrPmYQ/ShQDnUBrkG5WdGaG5
# nLGbsQAe79APT0JsyQq87kP6OnGlyE0mpTX9iV28hWIdMtKgK1TtmlfB2/oQzxm3
# i0objwG2J5VT6LaJbVu8aNQj6ItRolb58KaAoNYes7wPD1N1KarqE3fk3oyBIa0H
# EEcRrYc9B9F1vM/zZn4wggawMIIEmKADAgECAhAIrUCyYNKcTJ9ezam9k67ZMA0G
# CSqGSIb3DQEBDAUAMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
# bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lDZXJ0
# IFRydXN0ZWQgUm9vdCBHNDAeFw0yMTA0MjkwMDAwMDBaFw0zNjA0MjgyMzU5NTla
# MGkxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjFBMD8GA1UE
# AxM4RGlnaUNlcnQgVHJ1c3RlZCBHNCBDb2RlIFNpZ25pbmcgUlNBNDA5NiBTSEEz
# ODQgMjAyMSBDQTEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDVtC9C
# 0CiteLdd1TlZG7GIQvUzjOs9gZdwxbvEhSYwn6SOaNhc9es0JAfhS0/TeEP0F9ce
# 2vnS1WcaUk8OoVf8iJnBkcyBAz5NcCRks43iCH00fUyAVxJrQ5qZ8sU7H/Lvy0da
# E6ZMswEgJfMQ04uy+wjwiuCdCcBlp/qYgEk1hz1RGeiQIXhFLqGfLOEYwhrMxe6T
# SXBCMo/7xuoc82VokaJNTIIRSFJo3hC9FFdd6BgTZcV/sk+FLEikVoQ11vkunKoA
# FdE3/hoGlMJ8yOobMubKwvSnowMOdKWvObarYBLj6Na59zHh3K3kGKDYwSNHR7Oh
# D26jq22YBoMbt2pnLdK9RBqSEIGPsDsJ18ebMlrC/2pgVItJwZPt4bRc4G/rJvmM
# 1bL5OBDm6s6R9b7T+2+TYTRcvJNFKIM2KmYoX7BzzosmJQayg9Rc9hUZTO1i4F4z
# 8ujo7AqnsAMrkbI2eb73rQgedaZlzLvjSFDzd5Ea/ttQokbIYViY9XwCFjyDKK05
# huzUtw1T0PhH5nUwjewwk3YUpltLXXRhTT8SkXbev1jLchApQfDVxW0mdmgRQRNY
# mtwmKwH0iU1Z23jPgUo+QEdfyYFQc4UQIyFZYIpkVMHMIRroOBl8ZhzNeDhFMJlP
# /2NPTLuqDQhTQXxYPUez+rbsjDIJAsxsPAxWEQIDAQABo4IBWTCCAVUwEgYDVR0T
# AQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUaDfg67Y7+F8Rhvv+YXsIiGX0TkIwHwYD
# VR0jBBgwFoAU7NfjgtJxXWRM3y5nP+e6mK4cD08wDgYDVR0PAQH/BAQDAgGGMBMG
# A1UdJQQMMAoGCCsGAQUFBwMDMHcGCCsGAQUFBwEBBGswaTAkBggrBgEFBQcwAYYY
# aHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEEGCCsGAQUFBzAChjVodHRwOi8vY2Fj
# ZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVkUm9vdEc0LmNydDBDBgNV
# HR8EPDA6MDigNqA0hjJodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRU
# cnVzdGVkUm9vdEc0LmNybDAcBgNVHSAEFTATMAcGBWeBDAEDMAgGBmeBDAEEATAN
# BgkqhkiG9w0BAQwFAAOCAgEAOiNEPY0Idu6PvDqZ01bgAhql+Eg08yy25nRm95Ry
# sQDKr2wwJxMSnpBEn0v9nqN8JtU3vDpdSG2V1T9J9Ce7FoFFUP2cvbaF4HZ+N3HL
# IvdaqpDP9ZNq4+sg0dVQeYiaiorBtr2hSBh+3NiAGhEZGM1hmYFW9snjdufE5Btf
# Q/g+lP92OT2e1JnPSt0o618moZVYSNUa/tcnP/2Q0XaG3RywYFzzDaju4ImhvTnh
# OE7abrs2nfvlIVNaw8rpavGiPttDuDPITzgUkpn13c5UbdldAhQfQDN8A+KVssIh
# dXNSy0bYxDQcoqVLjc1vdjcshT8azibpGL6QB7BDf5WIIIJw8MzK7/0pNVwfiThV
# 9zeKiwmhywvpMRr/LhlcOXHhvpynCgbWJme3kuZOX956rEnPLqR0kq3bPKSchh/j
# wVYbKyP/j7XqiHtwa+aguv06P0WmxOgWkVKLQcBIhEuWTatEQOON8BUozu3xGFYH
# Ki8QxAwIZDwzj64ojDzLj4gLDb879M4ee47vtevLt/B3E+bnKD+sEq6lLyJsQfmC
# XBVmzGwOysWGw/YmMwwHS6DTBwJqakAwSEs0qFEgu60bhQjiWQ1tygVQK+pKHJ6l
# /aCnHwZ05/LWUpD9r4VIIflXO7ScA+2GRfS0YW6/aOImYIbqyK+p/pQd52MbOoZW
# eE4wggd9MIIFZaADAgECAhAEe51QLiqN2yKyU0tANZXhMA0GCSqGSIb3DQEBCwUA
# MGkxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjFBMD8GA1UE
# AxM4RGlnaUNlcnQgVHJ1c3RlZCBHNCBDb2RlIFNpZ25pbmcgUlNBNDA5NiBTSEEz
# ODQgMjAyMSBDQTEwHhcNMjExMDI2MDAwMDAwWhcNMjIxMTAyMjM1OTU5WjCBgTEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCkNhbGlmb3JuaWExFjAUBgNVBAcTDVNhbiBG
# cmFuY2lzY28xGzAZBgNVBAoTElNpdGVjb3JlIFVTQSwgSW5jLjELMAkGA1UECxMC
# SVQxGzAZBgNVBAMTElNpdGVjb3JlIFVTQSwgSW5jLjCCAiIwDQYJKoZIhvcNAQEB
# BQADggIPADCCAgoCggIBALqIAka1Ql+aPWB4e8acNTR7oGt0JAAjkKxu9dhQnuh+
# DaQePslSzOXcgPgb64FJYjpHdi4s1Kt1jTgN7FFjiT3YQqDYCxv26s0EbZKSNwmN
# KlSIQDujSriirCoA6oLd8uI6dXblbPmd5xw3frkWgTc2ILqAIuo3bgHQ80AvF3pS
# 8OtXmxPNwnJ9N+PuhjG2xCDUGorEhgAtfqxb9C/6k6hZAFoufxV2ctSKWDWLAt6x
# J4eYqnr0Vn+jmfj5xttozxEdn/J3E7Qz+Sewz/i8LqE9fa6xKwNczBlZA9UKdDj4
# cGJJs/nujfq6TUTyqH8eLzi2KG4DynpQ3yWyw0e2qqI11fbaplSpj7ZnapgOiyTb
# l4Vgayibdad5TpOxpHZvmw5OcYauNUK1gOGBh1VmG0M83Nl4Z5RflTWOjaW/j0FT
# nzCjjfX16xTelkDIXMo3oxGrj/qnFkWYucUNlhXz23HNyGj0vR/FD2kQXBU3gLxm
# JkaJ9H4vwVVWPSc7g8B4NQ8GGrGny5GGbcmL5eODGYS4+S6Zi80ecUQXczXIOo4s
# Osu2JqQRPST671Gigh7Aau7KLquW9/QwlMokNCRMKYSNQd5+JP73yZN2eRkDWrcg
# DCSdFfesBvacb3Fa4YhhnM3kcmWt8Z+e0w8eHYft2Jz7OpqUxMS/fHc4AmcMagpp
# AgMBAAGjggIGMIICAjAfBgNVHSMEGDAWgBRoN+Drtjv4XxGG+/5hewiIZfROQjAd
# BgNVHQ4EFgQUZqXdPbubXiqtLH7KbaP0G/WlYHgwDgYDVR0PAQH/BAQDAgeAMBMG
# A1UdJQQMMAoGCCsGAQUFBwMDMIG1BgNVHR8Ega0wgaowU6BRoE+GTWh0dHA6Ly9j
# cmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRHNENvZGVTaWduaW5nUlNB
# NDA5NlNIQTM4NDIwMjFDQTEuY3JsMFOgUaBPhk1odHRwOi8vY3JsNC5kaWdpY2Vy
# dC5jb20vRGlnaUNlcnRUcnVzdGVkRzRDb2RlU2lnbmluZ1JTQTQwOTZTSEEzODQy
# MDIxQ0ExLmNybDA+BgNVHSAENzA1MDMGBmeBDAEEATApMCcGCCsGAQUFBwIBFhto
# dHRwOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgZQGCCsGAQUFBwEBBIGHMIGEMCQG
# CCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wXAYIKwYBBQUHMAKG
# UGh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRHNENv
# ZGVTaWduaW5nUlNBNDA5NlNIQTM4NDIwMjFDQTEuY3J0MAwGA1UdEwEB/wQCMAAw
# DQYJKoZIhvcNAQELBQADggIBAGlm35F2ALzbmAAPmi+UUoGnLCpJX0TE3PHXMcR5
# 9mGZHxGfrDkHcWzDK9zGfqTujANHvX8CDRacdytsj87SzAHPP6kC53XNHkh5OPE6
# 1Wb58sqU1rqJVopoWX0NH7BSwk5TDFp5uM44olz+Ra0/h4uo2CD9fBYPgToA8Wkx
# lhSg7/it2osE4MzAJRUVMPwO8AmmJjtKND9FMWG3ceKTwWltDWhsYVbO/uzp7nTq
# FziS2fk0jMKP8ZhWihPotySYU7rvq9hr9qsYzhqJmDIqZrz5VX7WIckTJzA0tOyZ
# udkIEh3y/Nlh6spVVVGRy4sPKGc3v4LchuWPVQ1UGWoZd+uOubgl9diBezCKnDGd
# KvwCaWVYI/5bAzTWNkJURDO2FrpPx7iQOu/Xzds/Y0iLYehuyNAec6EOJNQyd29Q
# gsPFutersW3LwbDVtdqCjf+nk/0pnP2fZd4e7nOg63DS/WQKMFzEAqlnDWA7alAl
# BjyWjhyoiywq0sp0dNUUW6QbO56JnmVKnpA4iE095F5pIDOJkaS1pvcYYQ+RlrsN
# 99tVRjqbiIiBrB1Q0+FER6RyTDa368G19Pdg7jbms1OtZnPzXRlZ4+rNRK7nE22Q
# 5dyxtzlYy/Sv377tK05LxVKlzS3AXTos6Jm66eiiWvZN+wrsEIc7ChLiw+lwVhy0
# ExqYMYIRcDCCEWwCAQEwfTBpMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNl
# cnQsIEluYy4xQTA/BgNVBAMTOERpZ2lDZXJ0IFRydXN0ZWQgRzQgQ29kZSBTaWdu
# aW5nIFJTQTQwOTYgU0hBMzg0IDIwMjEgQ0ExAhAEe51QLiqN2yKyU0tANZXhMA0G
# CWCGSAFlAwQCAQUAoIGEMBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZI
# hvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcC
# ARUwLwYJKoZIhvcNAQkEMSIEIJ9WZFO0Sok7r1xrCc6Xi+lkfElzPZDett4Zy67p
# H0ktMA0GCSqGSIb3DQEBAQUABIICAHDH9kRJql7S1Wd7VHHefdoDINUqWWMruY7+
# GwMyE1EnLwzhnmZyqP/jWqqvKtX8vRKyUHNd260AEVepZlADyjupMXMAJbawSZ4+
# Mhc+pR2SLn2le/snzb4xYMfR+54nUlNNv4yeonNdu3XhOG/RrRBqnwE/3w1V9Qjy
# SsIRPemYjn9+RRbNGl9zJ39/m0UPboYBIz0f7uPp+wE9xTI5Fu0Xh+40danb/L25
# B4zI6e4VG0K9zDBiTcRHAYGfzFVoGGZ0TKguePQL4amz5fl2rENcb2x9pabOLoyl
# NHuwNktDcEPVecoP0TnmrWS51MjE0aGfPpPITC2hImSOC3JzbhgrcfasJX2mADPA
# A8tqCdXnQQByDIe2SABjEn+ug2rxTtcA4LGrqVAgTTZb1xJt8bmZmRiD3Kpa4J2l
# afMOi9RvDjgGr8hyi3DP9OT+h6J+VI304vy1mzpFMxJH53LDv7WQ96/PXo44dH8r
# Hiq0zPpt2avZt4izQ8PQbQIjk2lDYvTOkpDCoGrL8pKa5dUonKRr+w/gQkmEisjO
# uSr+HcylL51SvqznTX34CfKGPQruNDmXbjqyxGkkbzhUd/CLlNEonPohOpBKAMxf
# +pI/anAGRAe9s+e+rJxvcxNNk5XNkXcWGz7Yb5xEEfCQTVduATjyODAX33jMekQ0
# kEIZ76dWoYIOPTCCDjkGCisGAQQBgjcDAwExgg4pMIIOJQYJKoZIhvcNAQcCoIIO
# FjCCDhICAQMxDTALBglghkgBZQMEAgEwggEPBgsqhkiG9w0BCRABBKCB/wSB/DCB
# +QIBAQYLYIZIAYb4RQEHFwMwMTANBglghkgBZQMEAgEFAAQgSQ7wnlda7F6z/5EP
# tX6XcEKwdJit/zJGJuqQyKlCG94CFQCCYqH0UIUoKrI7AKJxqEj5+aHgyhgPMjAy
# MjA5MDcwNjQzNTFaMAMCAR6ggYakgYMwgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQK
# ExRTeW1hbnRlYyBDb3Jwb3JhdGlvbjEfMB0GA1UECxMWU3ltYW50ZWMgVHJ1c3Qg
# TmV0d29yazExMC8GA1UEAxMoU3ltYW50ZWMgU0hBMjU2IFRpbWVTdGFtcGluZyBT
# aWduZXIgLSBHM6CCCoswggU4MIIEIKADAgECAhB7BbHUSWhRRPfJidKcGZ0SMA0G
# CSqGSIb3DQEBCwUAMIG9MQswCQYDVQQGEwJVUzEXMBUGA1UEChMOVmVyaVNpZ24s
# IEluYy4xHzAdBgNVBAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxOjA4BgNVBAsT
# MShjKSAyMDA4IFZlcmlTaWduLCBJbmMuIC0gRm9yIGF1dGhvcml6ZWQgdXNlIG9u
# bHkxODA2BgNVBAMTL1ZlcmlTaWduIFVuaXZlcnNhbCBSb290IENlcnRpZmljYXRp
# b24gQXV0aG9yaXR5MB4XDTE2MDExMjAwMDAwMFoXDTMxMDExMTIzNTk1OVowdzEL
# MAkGA1UEBhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMR8wHQYD
# VQQLExZTeW1hbnRlYyBUcnVzdCBOZXR3b3JrMSgwJgYDVQQDEx9TeW1hbnRlYyBT
# SEEyNTYgVGltZVN0YW1waW5nIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
# CgKCAQEAu1mdWVVPnYxyXRqBoutV87ABrTxxrDKPBWuGmicAMpdqTclkFEspu8LZ
# Kbku7GOz4c8/C1aQ+GIbfuumB+Lef15tQDjUkQbnQXx5HMvLrRu/2JWR8/DubPit
# ljkuf8EnuHg5xYSl7e2vh47Ojcdt6tKYtTofHjmdw/SaqPSE4cTRfHHGBim0P+SD
# DSbDewg+TfkKtzNJ/8o71PWym0vhiJka9cDpMxTW38eA25Hu/rySV3J39M2ozP4J
# 9ZM3vpWIasXc9LFL1M7oCZFftYR5NYp4rBkyjyPBMkEbWQ6pPrHM+dYr77fY5NUd
# bRE6kvaTyZzjSO67Uw7UNpeGeMWhNwIDAQABo4IBdzCCAXMwDgYDVR0PAQH/BAQD
# AgEGMBIGA1UdEwEB/wQIMAYBAf8CAQAwZgYDVR0gBF8wXTBbBgtghkgBhvhFAQcX
# AzBMMCMGCCsGAQUFBwIBFhdodHRwczovL2Quc3ltY2IuY29tL2NwczAlBggrBgEF
# BQcCAjAZGhdodHRwczovL2Quc3ltY2IuY29tL3JwYTAuBggrBgEFBQcBAQQiMCAw
# HgYIKwYBBQUHMAGGEmh0dHA6Ly9zLnN5bWNkLmNvbTA2BgNVHR8ELzAtMCugKaAn
# hiVodHRwOi8vcy5zeW1jYi5jb20vdW5pdmVyc2FsLXJvb3QuY3JsMBMGA1UdJQQM
# MAoGCCsGAQUFBwMIMCgGA1UdEQQhMB+kHTAbMRkwFwYDVQQDExBUaW1lU3RhbXAt
# MjA0OC0zMB0GA1UdDgQWBBSvY9bKo06FcuCnvEHzKaI4f4B1YjAfBgNVHSMEGDAW
# gBS2d/ppSEefUxLVwuoHMnYH0ZcHGTANBgkqhkiG9w0BAQsFAAOCAQEAdeqwLdU0
# GVwyRf4O4dRPpnjBb9fq3dxP86HIgYj3p48V5kApreZd9KLZVmSEcTAq3R5hF2Yg
# VgaYGY1dcfL4l7wJ/RyRR8ni6I0D+8yQL9YKbE4z7Na0k8hMkGNIOUAhxN3WbomY
# PLWYl+ipBrcJyY9TV0GQL+EeTU7cyhB4bEJu8LbF+GFcUvVO9muN90p6vvPN/QPX
# 2fYDqA/jU/cKdezGdS6qZoUEmbf4Blfhxg726K/a7JsYH6q54zoAv86KlMsB257H
# OLsPUqvR45QDYApNoP4nbRQy/D+XQOG/mYnb5DkUvdrk08PqK1qzlVhVBH3Hmuwj
# A42FKtL/rqlhgTCCBUswggQzoAMCAQICEHvU5a+6zAc/oQEjBCJBTRIwDQYJKoZI
# hvcNAQELBQAwdzELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBv
# cmF0aW9uMR8wHQYDVQQLExZTeW1hbnRlYyBUcnVzdCBOZXR3b3JrMSgwJgYDVQQD
# Ex9TeW1hbnRlYyBTSEEyNTYgVGltZVN0YW1waW5nIENBMB4XDTE3MTIyMzAwMDAw
# MFoXDTI5MDMyMjIzNTk1OVowgYAxCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1h
# bnRlYyBDb3Jwb3JhdGlvbjEfMB0GA1UECxMWU3ltYW50ZWMgVHJ1c3QgTmV0d29y
# azExMC8GA1UEAxMoU3ltYW50ZWMgU0hBMjU2IFRpbWVTdGFtcGluZyBTaWduZXIg
# LSBHMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK8Oiqr43L9pe1QX
# cUcJvY08gfh0FXdnkJz93k4Cnkt29uU2PmXVJCBtMPndHYPpPydKM05tForkjUCN
# Iqq+pwsb0ge2PLUaJCj4G3JRPcgJiCYIOvn6QyN1R3AMs19bjwgdckhXZU2vAjxA
# 9/TdMjiTP+UspvNZI8uA3hNN+RDJqgoYbFVhV9HxAizEtavybCPSnw0PGWythWJp
# /U6FwYpSMatb2Ml0UuNXbCK/VX9vygarP0q3InZl7Ow28paVgSYs/buYqgE4068l
# QJsJU/ApV4VYXuqFSEEhh+XetNMmsntAU1h5jlIxBk2UA0XEzjwD7LcA8joixbRv
# 5e+wipsCAwEAAaOCAccwggHDMAwGA1UdEwEB/wQCMAAwZgYDVR0gBF8wXTBbBgtg
# hkgBhvhFAQcXAzBMMCMGCCsGAQUFBwIBFhdodHRwczovL2Quc3ltY2IuY29tL2Nw
# czAlBggrBgEFBQcCAjAZGhdodHRwczovL2Quc3ltY2IuY29tL3JwYTBABgNVHR8E
# OTA3MDWgM6Axhi9odHRwOi8vdHMtY3JsLndzLnN5bWFudGVjLmNvbS9zaGEyNTYt
# dHNzLWNhLmNybDAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAOBgNVHQ8BAf8EBAMC
# B4AwdwYIKwYBBQUHAQEEazBpMCoGCCsGAQUFBzABhh5odHRwOi8vdHMtb2NzcC53
# cy5zeW1hbnRlYy5jb20wOwYIKwYBBQUHMAKGL2h0dHA6Ly90cy1haWEud3Muc3lt
# YW50ZWMuY29tL3NoYTI1Ni10c3MtY2EuY2VyMCgGA1UdEQQhMB+kHTAbMRkwFwYD
# VQQDExBUaW1lU3RhbXAtMjA0OC02MB0GA1UdDgQWBBSlEwGpn4XMG24WHl87Map5
# NgB7HTAfBgNVHSMEGDAWgBSvY9bKo06FcuCnvEHzKaI4f4B1YjANBgkqhkiG9w0B
# AQsFAAOCAQEARp6v8LiiX6KZSM+oJ0shzbK5pnJwYy/jVSl7OUZO535lBliLvFeK
# kg0I2BC6NiT6Cnv7O9Niv0qUFeaC24pUbf8o/mfPcT/mMwnZolkQ9B5K/mXM3tRr
# 41IpdQBKK6XMy5voqU33tBdZkkHDtz+G5vbAf0Q8RlwXWuOkO9VpJtUhfeGAZ35i
# rLdOLhWa5Zwjr1sR6nGpQfkNeTipoQ3PtLHaPpp6xyLFdM3fRwmGxPyRJbIblumF
# COjd6nRgbmClVnoNyERY3Ob5SBSe5b/eAL13sZgUchQk38cRLB8AP8NLFMZnHMwe
# BqOQX1xUiz7jM1uCD8W3hgJOcZ/pZkU/djGCAlowggJWAgEBMIGLMHcxCzAJBgNV
# BAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3JhdGlvbjEfMB0GA1UECxMW
# U3ltYW50ZWMgVHJ1c3QgTmV0d29yazEoMCYGA1UEAxMfU3ltYW50ZWMgU0hBMjU2
# IFRpbWVTdGFtcGluZyBDQQIQe9Tlr7rMBz+hASMEIkFNEjALBglghkgBZQMEAgGg
# gaQwGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMBwGCSqGSIb3DQEJBTEPFw0y
# MjA5MDcwNjQzNTFaMC8GCSqGSIb3DQEJBDEiBCDmASu4/lvzHuOCtKFF37Rr+vHc
# 3NNNOotYycDoRUu7UjA3BgsqhkiG9w0BCRACLzEoMCYwJDAiBCDEdM52AH0COU4N
# peTefBTGgPniggE8/vZT7123H99h+DALBgkqhkiG9w0BAQEEggEAGhFKdURY5qDB
# OVPzRzVS/4818Tck0uz2PI9DE2lgS6JXpVUHDRZlSHPImTt64MtgA2dSJ50O1EDZ
# 28S3Ilio5SCkV9sLSLy8Xo/xec8GWDo+HROSJkZLjcqwMsDZqFSxul3kOg1dEMa8
# 1+KyEeVDVwNmgRjO/I6aigWupm/Wr1VjBHGT25PLjmMZQx/tFOmQxZfmdJshOX2E
# QIpIMiL3uR1Nb0n2X1jLaIOkJE5GC5Fw/WYXedZz+np/DxI+49FrAM2nCmQFxiMR
# 8GiZTQ/Y645e4LEXJ/3UdUftiVc4C0q9hWADhi9cCXwuEGTS69zq+VsD0Sjc4D+z
# NqtVYTRryQ==
# SIG # End signature block
