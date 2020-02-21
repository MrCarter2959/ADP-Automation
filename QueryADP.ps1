#####################################################################################################
#                                        XML Path                                                   #
#####################################################################################################
$xmlPath = "\\UNC\File\Path\ADP\Tokens\API_Token.xml"
#####################################################################################################
#                                   Import Bearer Token                                             #
#####################################################################################################
$bearerToken = Import-Clixml -LiteralPath $xmlPath
#####################################################################################################
#                                      API Options                                                  #
#####################################################################################################
# URI API Path
$queryADP = "api.adp.com/core/v1/operations"
# Protocol To Use
$queryProtocol = "https"
# API Auth
$queryAuth = 'Bearer '
# Obtain Authentication String
$queryToken = ($bearerToken.access_token)
# Custom Build URL String
$queryAPIString = 'workerInformationManagement/hr.v2.workers/1111111111111111%1Z1?$select=processingStatus' # Removed Sensitive Info left special characters'
#queryString Returns Results from Google Postman but not Invoke-WebRequest
#$queryURL = "${queryProtocol}://${queryADP}/${queryAPIString}"
$queryURL = 'https://api.adp.com/hr/v2/workers?$top=10' # working small query
# API Headers
$queryHeaders = @{Authorization = $queryAuth + $queryToken}
# Find Certificate Thumbprint
$queryThumbprint = Get-ChildItem Cert:\CurrentUser\My -Recurse | where {$_.Subject -like '*serverName} | select -ExpandProperty Thumbprint
# Invoke API Call
$queryResponse = Invoke-WebRequest $queryURL -Headers $queryHeaders -CertificateThumbprint $queryThumbprint
# API Query Response
$queryCallBack = $queryResponse.Content
