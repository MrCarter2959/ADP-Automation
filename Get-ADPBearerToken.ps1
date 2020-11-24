#####################################################################################################
#                                        XML Path                                                   #
#####################################################################################################
$xmlPath = "path\to\save\token.xml"
#####################################################################################################
#                                       API Options                                                 #
#####################################################################################################
# URI API Path
$bearerAPIPath = "accounts.adp.com/auth/oauth/v2"
# Protocol To Use
$bearerProtocol = "https"
# ADP Username
$bearerUsername = "your bearer username"
# ADP Password
$bearerPassword = "your bearer password"
# ADP API Query String
$bearerQuery = "token?grant_type=client_credentials"
# Custom Build URL String
$bearerURL = "${bearerProtocol}://${bearerAPIPath}/${bearerQuery}"
# API Type
$bearerType = "POST"
# API Auth
$bearerAuth = 'Basic '
# Obtain base64 Authentication String
$bearerAuthString = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${bearerUsername}:${bearerPassword}"))
# Find Certificate Thumbprint
$bearerThumbprint = Get-ChildItem Cert:\CurrentUser\My -Recurse | where {$_.Subject -like '*serverFQDNOfCertificate'} | select -ExpandProperty Thumbprint
# API Headers
$bearerHeaders = @{Authorization = $bearerAuth + $bearerAuthString}
# Invoke API Call
$bearerResponse = Invoke-WebRequest -Uri $bearerURL -Headers $bearerHeaders -Method $bearerType -CertificateThumbprint $bearerThumbprint
# Assign Bearer Token to varable
$bearerToken = $bearerResponse.content
#####################################################################################################
#                                  Export Authentication Token                                      #
#####################################################################################################
# Convert JSON
$exportBearer = ConvertFrom-Json -InputObject $bearerToken
#Convert JSON to XML Export
$exportBearer | Export-Clixml -LiteralPath $xmlPath

#
