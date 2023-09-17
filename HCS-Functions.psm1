#######
# GET #
#######

Function Get-HCSAADIdentityProviderUrl {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/auth/v1/admin/azure-ad-setup"
        }

    $Header = @{
	    "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
	    "org_id" = "$OrganizationId"
    }

    try
        {
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing).authUrl
        }
    catch
        {
            Throw $_
        }
}

Function Get-HCSADConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/active-directories"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            try
                {
                    Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
                }
            catch
                {
                    Throw $_
                }
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.name -eq "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
}

Function Get-HCSAVApplication {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/av-appies/v1/applications"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            try
                {
                    Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
                }
            catch
                {
                    Throw $_
                }
        }
    Else {
        ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
        {
            If ($_.name -eq "$Name")
                {
                    Write-Output $_
                    $NameFound = $True
                }
        }
    
        If ($NameFound -ne $True)
        {
            Write-Warning "Name not found."
        }
    }
}

Function Get-HCSAVApplicationEntitlement {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$ApplicationId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/av-entitlements/v1/app-entitlements"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($ApplicationId))
        {
            try
                {
                    Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
                }
            catch
                {
                    Throw $_
                }
        }
    Else {
        ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
        {
            If ($_.applicationId -eq "$ApplicationId")
                {
                    Write-Output $_
                    $ApplicationIdFound = $True
                }
        }
    
        If ($ApplicationIdFound -ne $True)
        {
            Write-Warning "Application ID not found."
        }
    }
}

Function Get-HCSAVApplicationVersion {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/av-appies/v1/app-versions"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            try
                {
                    Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
                }
            catch
                {
                    Throw $_
                }
        }
    Else {
        ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
        {
            If ($_.name -eq "$Name")
                {
                    Write-Output $_
                    $NameFound = $True
                }
        }
    
        If ($NameFound -ne $True)
        {
            Write-Warning "Name not found."
        }
    }
}

Function Get-HCSAVFileShare {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Search
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/av-fileshare/v1/fileshares"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Search))
        {
            try
                {
                    Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
                }
            catch
                {
                    Throw $_
                }
        }
    Else {
            $Url = "$Url" + "?search=" + $Search
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
    }
}

Function Get-HCSAzureADSetup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/auth/v1/admin/azure-ad-setup?orgId=" + $OrganizationId
        }

    $Header = @{
	    "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header
        }
    catch
        {
            Throw $_
        }
}

Function Get-HCSAzureDiskSkus {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/providers/azure/instances/" + $ProviderInstanceId + "/disk-skus"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    try
        {
            Write-Output ((Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content).data
        }
    catch
        {
            Throw $_
        }
}

Function Get-HCSAzureNetwork {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Id,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/providers/azure/instances/" + $Id + "/networks"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.id -match "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}

Function Get-HCSAzureSubnet {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId,
        [Parameter(Mandatory=$True)] [string]$NetworkId,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/providers/azure/instances/" + $ProviderInstanceId + "/networks/subnets?network_id=$NetworkId"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.data.name -like "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}

Function Get-HCSAzureVMSkus {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/providers/azure/v3/instances/" + $ProviderInstanceId + "/vm-skus"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Write-Output ((Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content).data
}

Function Get-HCSAzureVMSkusSeries {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/providers/azure/instances/" + $ProviderInstanceId + "/vm-skus-series"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing    
}

Function Get-HCSSSOCABundle {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$SSOId,
        [Parameter(Mandatory=$True)] [string]$FileName
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v1/sso-configurations/" + $SSOId + "/ca-bundle"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing -OutFile $FileName
}

Function Get-HCSDEMConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v1/dem-settings"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
        }
    Else {
            ForEach ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.name -eq "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}

Function Get-HCSEdgeDeployment {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/edge-deployments"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.name -eq "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}

Function Get-HCSEntitlement {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$PoolGroupId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/entitlements"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($PoolGroupId))
        {
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.PoolIds -eq "$PoolGroupId")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}

Function Get-HCSHomeSiteMapping {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/homesitemappings"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.entityName -eq "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}

Function Get-HCSIAMGroup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/auth/v1/admin/groups"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
    {
        Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).groups
    }
    Else {
        ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).groups)
            {
                If ($_.displayName -eq "$Name")
                    {
                        Write-Output $_
                        $NameFound = $True
                    }
            }
        
        If ($NameFound -ne $True)
            {
                Write-Warning "Name not found."
            }
    }
}

Function Get-HCSImage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/imagemgmt/v1/images"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
    {
        Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
    }
    Else {
        ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
            {
                If ($_.name -eq "$Name")
                    {
                        Write-Output $_
                        $NameFound = $True
                    }
            }
        
        If ($NameFound -ne $True)
            {
                Write-Warning "Name not found."
            }
    }
}

Function Get-HCSImageMarker {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ImageId,
        [Parameter(Mandatory=$True)] [string]$ImageVersionId,
        [Parameter(Mandatory=$False)] [string]$Name        
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/imagemgmt/v1/images/" + $ImageId + "/markers?search=versionId `$eq " + $ImageVersionId
        }

    $Header = @{
	    "Content-Type" = "application/json";
	    "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
    {
        (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
    }
    Else {
        ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
            {
                If ($_.name -eq "$Name")
                    {
                        Write-Output $_
                        $NameFound = $True
                    }
            }
        
        If ($NameFound -ne $True)
            {
                Write-Warning "Name not found."
            }
    }
}

Function Get-HCSImageSources {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId,
        [Parameter(Mandatory=$True)] [string]$ProviderType, #AZURE
        [Parameter(Mandatory=$True)] [string]$Source, #AZURE_MARKET_PLACE
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/imagemgmt/v1/image-sources?provider_instance_id=" + "$ProviderInstanceId" + "&provider_type=" + "$ProviderType" + "&source_stream=" + "$Source"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
    {
        (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
    }
    Else {
        ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
            {
                If ($_.displayName -match "$Name")
                    {
                        Write-Output $_
                        $NameFound = $True
                    }
            }
        
        If ($NameFound -ne $True)
            {
                Write-Warning "Name not found."
            }
    }
}

Function Get-HCSImageVersion {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ImageId,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/imagemgmt/v1/images/" + "$ImageId" + "/versions"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
            {
                If ($_.streamId -eq "$ImageId")
                    {
                        If (!($Name))
                            {
                                Write-Output $_
                                $ImageIdFound = $True
                            }
                        Else
                            {
                                $_ | Where-Object {$_.name -eq "$Name"}
                                $ImageIdFound = $True
                            }   
                    }
            }
        
        If ($ImageIdFound -ne $True)
            {
                Write-Warning "Image ID not found."
            }
}

Function Get-HCSOrganizationId {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$Token,
        [Parameter(Mandatory=$False)] [string]$Url
    )

    If (!($Url))
        {
            $Url = "https://console.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/details"
        }

    $Header = @{
    	"Content-Type" = "application/json";
    }

    $Body = @{
	    "tokenValue" = "$Token"
    }

    Write-Output (Invoke-RestMethod -Uri $Url -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing).orgId
}

Function Get-HCSPool {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/templates"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
    {
        (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
    }
    Else {
        ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
            {
                If ($_.name -eq "$Name")
                    {
                        Write-Output $_
                        $NameFound = $True
                    }
            }
        
        If ($NameFound -ne $True)
            {
                Write-Warning "Name not found."
            }
    }
}

Function Get-HCSPoolGroup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$PoolGroupName
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/pools"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($PoolGroupName))
    {
        (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
    }
    Else {
        ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
            {
                If ($_.name -eq "$PoolGroupName")
                    {
                        Write-Output $_
                        $NameFound = $True
                    }
            }
        
        If ($NameFound -ne $True)
            {
                Write-Warning "Name not found."
            }
    }
}

Function Get-HCSPoolTemplate {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/templates"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
    {
        Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
    }
    Else {
        ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
            {
                If ($_.name -eq "$Name")
                    {
                        Write-Output $_
                        $NameFound = $True
                    }
            }
        
        If ($NameFound -ne $True)
            {
                Write-Warning "Name not found."
            }
    }
}

Function Get-HCSProvider {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v1/providers"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing
}

Function Get-HCSProviderInstanceConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/providers/azure/instances"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.name -eq "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
    
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }      
    }
}

Function Get-HCSSiteConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/sites"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing))
                {
                    If ($_.name -eq "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
    
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }      
    }
}

Function Get-HCSSSOConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v1/sso-configurations"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.name -eq "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}

Function Get-HCSTest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud-sg.horizon.vmware.com/synthetic-testing/v1/probes/"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.testConfig.name -eq "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}

Function Get-HCSTestingClient {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud-sg.horizon.vmware.com/synthetic-testing/v1/outposts"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.name -eq "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}

Function Get-HCSUAGDeployment {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$Name
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/uag-deployments"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If (!($Name))
        {
            Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.name -eq "$Name")
                        {
                            Write-Output $_
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}

Function Get-ObjectMember {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [PSCustomObject]$obj
    )
    $obj | Get-Member -MemberType NoteProperty | ForEach-Object {
        $key = $_.Name
        [PSCustomObject]@{Leaf = $key; Properties = $obj."$key"}
    }
}


##########
# IMPORT #
##########

Function Import-HCSAVPackages {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/av-appies/v1/import/app-packages"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
        "data" = @{
			    "providerInstanceId" = $ProviderInstanceId
		    };
    }

    Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
}


##########
# INVOKE #
##########

Function Invoke-URLInDefaultBrowser {
    <#
        .SYNOPSIS
            Cmdlet to open a URL in the User's default browser.
        .DESCRIPTION
            Cmdlet to open a URL in the User's default browser.
        .PARAMETER URL
            Specify the URL to be Opened.
        .EXAMPLE
            PS> Invoke-URLInDefaultBrowser -URL 'http://jkdba.com'
            
            This will open the website "jkdba.com" in the user's default browser.
        .NOTES
            This cmdlet has only been test on Windows 10, using edge, chrome, and firefox as default browsers.
    #>
    [CmdletBinding()]
    param
    (
        [Parameter(
            Position = 0,
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String] $URL
    )
    #Verify Format. Do not want to assume http or https so throw warning.
    if( $URL -notmatch "http://*" -and $URL -notmatch "https://*")
    {
        Write-Warning -Message "The URL Specified is formatted incorrectly: ($URL)" 
        Write-Warning -Message "Please make sure to include the URL Protocol (http:// or https://)"
        break;
    }
    #Replace spaces with encoded space
    $URL = $URL -replace ' ','%20'
    
    #Get Default browser
    $DefaultSettingPath = 'HKCU:\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice'
    $DefaultBrowserName = (Get-Item $DefaultSettingPath | Get-ItemProperty).ProgId
    
    #Handle for Edge
    ##edge will no open with the specified shell open command in the HKCR.
    if($DefaultBrowserName -eq 'AppXq0fevzme2pys62n3e0fbqa7peapykr8v')
    {
        #Open url in edge
        start Microsoft-edge:$URL 
    }
    else
    {
        try
        {
            #Create PSDrive to HKEY_CLASSES_ROOT
            $null = New-PSDrive -PSProvider registry -Root 'HKEY_CLASSES_ROOT' -Name 'HKCR'
            #Get the default browser executable command/path
            $DefaultBrowserOpenCommand = (Get-Item "HKCR:\$DefaultBrowserName\shell\open\command" | Get-ItemProperty).'(default)'
            $DefaultBrowserPath = [regex]::Match($DefaultBrowserOpenCommand,'\".+?\"')
            #Open URL in browser
            Start-Process -FilePath $DefaultBrowserPath -ArgumentList $URL   
        }
        catch
        {
            Throw $_.Exception
        }
        finally
        {
            #Clean up PSDrive for 'HKEY_CLASSES_ROOT
            Remove-PSDrive -Name 'HKCR'
        }
    }
}


#######
# NEW #
#######

Function New-HCSAccessToken {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$Token, #OMZETTEN NAAR APIToken
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [bool]$JSONOnly
    )

    If (!($Url))
        {
            $Url = "https://console.cloud.vmware.com/csp/gateway/am/api/auth/api-tokens/authorize"
        }

    $Header = @{
	    "Content-Type" = "application/x-www-form-urlencoded"
    }

    $Body = @{
	    "refresh_token" = "$Token"
    }

    If ($JSONOnly -eq $True)
        {
            Write-Output ""
            Write-Output "--- JSON ---"
            Write-Output ""
            Write-Output "POST $Url"
            Write-Output "content-type: application/x-www-form-urlencoded"
            Write-Output ""
            Write-Output ($Body | ConvertTo-Json -Depth 6)
            Write-Output ""
            Write-Output "------------"
            Write-Output ""
        }
    Else
        {
            try
                {
                    Write-Output (Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body $Body -UseBasicParsing).access_token    
                }
            catch
                {
                    Throw $_                    
                }
        }
}

Function New-HCSADConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$False)] [string]$Description,
        [Parameter(Mandatory=$True)] [string]$DNSDomainName,
        [Parameter(Mandatory=$True)] [string]$BindAccountUsername,
        [Parameter(Mandatory=$True)] [string]$BindAccountPassword,
        [Parameter(Mandatory=$True)] [string]$AuxBindAccountUsername,
        [Parameter(Mandatory=$True)] [string]$AuxBindAccountPassword,
        [Parameter(Mandatory=$True)] [string]$DomainJoinAccountUsername,
        [Parameter(Mandatory=$True)] [string]$DomainJoinAccountPassword,
        [Parameter(Mandatory=$True)] [string]$AuxDomainJoinAccountUsername,
        [Parameter(Mandatory=$True)] [string]$AuxDomainJoinAccountPassword,
        [Parameter(Mandatory=$True)] [string]$DefaultOU
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/active-directories"
        }

    $Header = @{
	    "Content-Type" = "application/json";
	    "Authorization" = "Bearer " + $AccessToken
    }

    If ($Description -eq $null)
        {
            $Description = ""
        }

    $Body = @{
	    "bindAccounts" = @{
    		"auxiliary" = @{
			    "password" = $AuxBindAccountPassword;
			    "username" = $AuxBindAccountUsername
		    };
		    "primary" = @{
    			"password" = $BindAccountPassword;
			    "username" = $BindAccountUsername
		    };
	    };
	    "defaultOU" = "$DefaultOU";
	    "description" = "$Description";
	    "dnsDomainName" = "$DNSDomainName";
	    "joinAccounts" = @{
    		"auxiliary" = @{
			    "password" = $AuxDomainJoinAccountPassword;
			    "username" = $AuxDomainJoinAccountUsername
		    };
		    "primary" = @{
    			"password" = $DomainJoinAccountPassword;
			    "username" = $DomainJoinAccountUsername
		    };
	    };
	    "name" = "$Name";
	    "orgId" = "$OrganizationId"
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }
}

Function New-HCSAVApplicationEntitlement {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$AppVersionId,
        [Parameter(Mandatory=$True)] [string]$ApplicationId,
        [Parameter(Mandatory=$True)] [string]$MarkerId, # CURRENT or LATEST
        [Parameter(Mandatory=$True)] [string]$DeliveryMode, # CLASSIC or ONDEMAND
        [Parameter(Mandatory=$True)] [string]$EntityId,
        [Parameter(Mandatory=$True)] [string]$EntityType, # user or group
        [Parameter(Mandatory=$True)] [string]$Overwrite # true or false

    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/av-entitlements/v1/app-entitlements/create-bulk"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
        "data" = @{
            "apps" = @(
                @{
                    "appVersionId" = "$AppVersionId";
                    "applicationId" = "$ApplicationId";
                    "markerId" = "$MarkerId";
                }
            );
            "deliveryMode" = "$DeliveryMode";
            "entities" = @(
                @{
                    "entityId" = "$EntityId";
                    "entityType" = "$EntityType"
                }
            );
            "overwrite" = "$Overwrite"
        }      
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json -Depth 6) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }

    # New-HCSAVApplicationEntitlement -AccessToken $AccessToken -AppVersionId 6451744dbae5605b6699e911 -ApplicationId 6451744dbae5605b6699e910 -MarkerId CURRENT -DeliveryMode CLASSIC -EntityId (Get-HCSIAMGroup -AccessToken $AccessToken -Name UNSYNCED-Testgroep-Ivan).id -EntityType group -Overwrite true
}

Function New-HCSAzMarketPlaceImage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$False)] [string]$Description,
        [Parameter(Mandatory=$True)] [string]$VersionSource, #0.0
        [Parameter(Mandatory=$True)] [string]$VersionType, #MAJOR
        [Parameter(Mandatory=$True)] [string]$GPUType, #NONE
        [Parameter(Mandatory=$True)] [string]$MultiSession, #false
        [Parameter(Mandatory=$True)] [string]$OS, #Windows 10 Enterprise, 21H2
        [Parameter(Mandatory=$True)] [string]$OSType, #WINDOWS
        [Parameter(Mandatory=$True)] [string]$LicenseType, #Windows_Client
        [Parameter(Mandatory=$True)] [string]$Offer, #windows-10
        [Parameter(Mandatory=$True)] [string]$Publisher, #microsoftwindowsdesktop
        [Parameter(Mandatory=$True)] [string]$SKU, #win10-21h2-ent
        [Parameter(Mandatory=$True)] [string]$Version, #19044.2251.221105
        [Parameter(Mandatory=$True)] [string]$VNet,
        [Parameter(Mandatory=$True)] [string]$Subnet,
        [Parameter(Mandatory=$True)] [string]$VMSize, #Standard_DS2_v2
        [Parameter(Mandatory=$True)] [string]$PublicIP, #false
        [Parameter(Mandatory=$True)] [string]$UserName,
        [Parameter(Mandatory=$True)] [string]$Password
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/imagemgmt/v1/images?action=import"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    [Array]$ConvertedPassword = $Password.ToCharArray()
    [Array]$BodyPassword = $null

    ForEach ($_ in $ConvertedPassword) {
            $BodyPassword += "$($_)"                    
    }

    $JsonBodyPassword = $BodyPassword | ConvertTo-Json

    $Body = @{
        "assetDetails" = @{
            "data" = @{
                "licenseType" = "$LicenseType";
                "offer" = "$Offer";
                "publisher" = "$Publisher";
                "sku" = "$SKU";
                "subNet" = "$Subnet";
                "version" = "$Version";
                "vNet" = "$VNet";
                "vmSize" = "$VMSize";
            };
            "options" = @{
                "createPublicIp" = "$PublicIP"
            };
            "type" = "AZURE_VM_IN_RG";
            "vmInfo" = @{
                "password" = @(
                    $($JsonBodyPassword | ConvertFrom-Json)
                )
                "username" = "$UserName"
            }
        };
        "streamName" = "$Name";
        "streamDescription" = "$Description";
        "orgId" = "$OrganizationId";
        "providerInstanceId" = "$ProviderInstanceId";
        "providerLabel" = "AZURE";
        "sourceStreamType" = "AZURE_MARKET_PLACE";
        "gpuType" = "$GPUType";
        "isMultiSession" = "$MultiSession";
        "markers" = @();
        "os" = "$OS";
        "osType" = "$OSType";
        "versionSource" = "$VersionSource";
        "versionType" = "$VersionType";        
    }

    Try {
        Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json -Depth 6) -UseBasicParsing
    } Catch {
        $outError = [System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream()).ReadToEnd() | ConvertFrom-Json
        Write-Error $OutError.errors.message
    }
}

Function New-HCSCloudHostedTestingClient {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$TestingClientName,
        [Parameter(Mandatory=$True)] [ValidateSet("westus2","eastus2","northeurope","germanywestcentral","uksouth","japaneast","australiaeast")] [string]$Region
    )

    If (!($Url))
        {
            $Url = "https://cloud-sg.horizon.vmware.com/synthetic-testing/v1/outposts"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
	    "name" = "$TestingClientName";
        "region" = "$Region";
        "type" = "CLOUD_HOSTED"
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }
}

Function New-HCSConnectivityTest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Uri,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$True)] [string]$TestingClientId,
        [Parameter(Mandatory=$True)] [ValidateSet("5m","10m","15m","30m","1h","2h","4h","6h","12h")] [string]$Interval,
        [Parameter(Mandatory=$True)] [string]$Url,
        [Parameter(Mandatory=$False)] [bool]$JSONOnly
    )

    If (!($Uri))
        {
            $Uri = "https://cloud-sg.horizon.vmware.com/synthetic-testing/v1/probes"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $NewInterval = switch ($Interval)
    {
        5m {"PT5M"}
        10m {"PT10M"}
        15m {"PT15M"}
        30m {"PT30M"}
        1h {"PT1H"}
        2h {"PT2H"}
        4h {"PT4H"}
        6h {"PT6H"}
        12h {"PT12H"}
    }

    $Body = @{
	    "outpostIds" = @(
            "$TestingClientId"
        );
        "testConfig" = @{
            "data" = @{
                "repeat" = "$NewInterval";
                "target" = "$Url"
            };
            "name" = "$Name";
            "type" = "TEST_HZN_CONNECT"
        }
    }

    If ($JSONOnly -eq $True)
        {
            Write-Output ""
            Write-Output "--- JSON ---"
            Write-Output ""
            Write-Output ($Body | ConvertTo-Json -Depth 6)
            Write-Output ""
            Write-Output "------------"
            Write-Output ""
        }
        Else
        {
            try
                {
                    Invoke-RestMethod -Uri "$Uri" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
                }
            catch
                {
                    Throw $_
                }
        }
}

Function New-HCSDEMConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$True)] [string]$ConfigFilePath
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v1/dem-settings"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
	    "name" = "$Name";
        "configFilePath" = "$ConfigFilePath";
        "orgId" = "$OrganizationId";
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }
}

Function New-HCSEdgeDeployment {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$False)] [string]$Description,
        [Parameter(Mandatory=$True)] [string]$FQDN,
        [Parameter(Mandatory=$True)] [string]$EnablePrivateEndpoint,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetId,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetParent,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetName,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetAvailableIPAddresses,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetCIDR,
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId,
        [Parameter(Mandatory=$True)] [string]$SSOConfigId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/edge-deployments"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
	    "description" = "$Description";
        "enablePrivateEndpoint" = $EnablePrivateEndpoint;
        "fqdn" = "$FQDN";
        "name" = "$Name";
        "orgId" = "$OrganizationId";
        "providerInstanceId" = "$ProviderInstanceId";
        "infrastructure" = @{
            "managementNetwork" = @{
                "kind" = "subnets";
                "id" = $ManagementSubnetId;
                "data" = @{
                    "parent" = $ManagementSubnetParent;
                    "name" = $ManagementSubnetName;
                    "availableIpAddresses" = $ManagementSubnetAvailableIPAddresses;
                    "cidr" = $ManagementSubnetCIDR
                }
            }
        }
        "ssoConfigurations" = @(@{
            "ssoConfigurationId" = "$SSOConfigId";
        })
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json -Depth 4) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }
}

Function New-HCSEdgeDeploymentV2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$False)] [string]$Description,
        [Parameter(Mandatory=$True)] [string]$FQDN,
        [Parameter(Mandatory=$True)] [string]$EnablePrivateEndpoint,
        [Parameter(Mandatory=$True)] [string]$HAEnabled,
        [Parameter(Mandatory=$True)] [string]$K8sDNSNamePrefix,
        [Parameter(Mandatory=$True)] [string]$K8sDockerBridgeCidr,
        [Parameter(Mandatory=$True)] [string]$K8sIdentityId,
        [Parameter(Mandatory=$True)] [string]$K8sOutboundType,
        [Parameter(Mandatory=$True)] [string]$K8sPodCidr,
        [Parameter(Mandatory=$True)] [string]$K8sServiceCidr,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetId,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetParent,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetName,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetAvailableIPAddresses,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetCIDR,
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId,
        [Parameter(Mandatory=$True)] [string]$SSOConfigId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/edge-deployments"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    If ($HAEnabled -eq "true")
            {
                $K8sNumNodes = "4"
            }
    Else    {
                $K8sNumNodes = "1"
            }

    $Body = @{
	    "description" = "$Description";
        "enablePrivateEndpoint" = $EnablePrivateEndpoint;
        "fqdn" = "$FQDN";
        "name" = "$Name";
        "orgId" = "$OrganizationId";
        "providerInstanceId" = "$ProviderInstanceId";
        "deploymentModeDetails" = @{
            "attributes" = @{
                "dnsNamePrefix" = $K8sDNSNamePrefix;
                "dockerBridgeCidr" = $K8sDockerBridgeCidr;
                "identityId" = $K8sIdentityId;
                "numNodes" = $K8sNumNodes;
                "outboundType" = $K8sOutboundType;
                "podCidr" = $K8sPodCidr;
                "serviceCidr" = $K8sServiceCidr;
            }
            "type" = "CLUSTER"
        }
        "infrastructure" = @{
            "managementNetwork" = @{
                "kind" = "subnets";
                "id" = $ManagementSubnetId;
                "data" = @{
                    "parent" = $ManagementSubnetParent;
                    "name" = $ManagementSubnetName;
                    "availableIpAddresses" = $ManagementSubnetAvailableIPAddresses;
                    "cidr" = $ManagementSubnetCIDR
                }
            }
        }
        "ssoConfigurations" = @(@{
            "ssoConfigurationId" = "$SSOConfigId";
        })
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json -Depth 4) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }
}

Function New-HCSGroupEntitlement {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$GroupId,
        [Parameter(Mandatory=$True)] [string]$PoolGroupId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/entitlements"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
        "groupIds" = @(
            "$GroupId"
        );
        "orgId" = "$OrganizationId";
        "poolIds" = @(
            "$PoolGroupId"
        );
        "resourceDetails" = @(@{
                "poolId" = "$PoolGroupId"
            })
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }
}

Function New-HCSHomeSiteMapping {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$SiteId,
        [Parameter(Mandatory=$True)] [string]$SiteName,
        [Parameter(Mandatory=$True)] [string]$GroupId,
        [Parameter(Mandatory=$True)] [string]$GroupName

    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/homesitemappings"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
        "orgId" = "$OrganizationId";
        "homeSiteId" = "$SiteId";
        "homeSiteName" = "$SiteName";
        "groups" = @(
                        @{
                            "entityId" = "$GroupId";
                            "entityName" = "$GroupName"
                        }
                    ) 
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }
}

Function New-HCSPool {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$PoolName,
        [Parameter(Mandatory=$True)] [string]$Description,
        [Parameter(Mandatory=$True)] [string]$PoolType, #FLOATING
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId,
        [Parameter(Mandatory=$True)] [string]$UAGDeploymentId,
        [Parameter(Mandatory=$True)] [string]$ImageId,
        [Parameter(Mandatory=$True)] [string]$MarkerId,
        [Parameter(Mandatory=$True)] [string]$EligableLicense, #true or false
        [Parameter(Mandatory=$True)] [string]$VMModel, #Standard_DS2_v2
        [Parameter(Mandatory=$True)] [string]$VMLicenseType, #WINDOWS_CLIENT
        [Parameter(Mandatory=$True)] [string]$VMDiskType, #Premium_LRS
        [Parameter(Mandatory=$True)] [string]$VMDiskSize, #in GB
        [Parameter(Mandatory=$True)] [string]$VMDiskEncryptionEnabled, #true or false
        [Parameter(Mandatory=$True)] [string]$ActiveDirectoryId,
        [Parameter(Mandatory=$True)] [string]$ComputerOU, #CN=Computers
        [Parameter(Mandatory=$True)] [string]$MinSpareVMs,
        [Parameter(Mandatory=$True)] [string]$MaxSpareVMs,
        [Parameter(Mandatory=$True)] [string]$MaxVMs,
        [Parameter(Mandatory=$True)] [string]$SessionsPerVM, #1
        [Parameter(Mandatory=$True)] [string]$VMNamePrefix, #win10-
        [Parameter(Mandatory=$True)] [string]$DesktopAdminUsername,
        [Parameter(Mandatory=$True)] [string]$DesktopAdminPassword,
        [Parameter(Mandatory=$True)] [string]$VNetId, #/...
        [Parameter(Mandatory=$True)] [string]$SubnetId, #/...
        [Parameter(Mandatory=$True)] [string]$DEMConfigId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/templates"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    [Array]$ConvertedPassword = $DesktopAdminPassword.ToCharArray()
    [Array]$BodyPassword = $null

    ForEach ($_ in $ConvertedPassword) {
            $BodyPassword += "$($_)"                    
    }

    $JsonBodyPassword = $BodyPassword | ConvertTo-Json

    $Body = @{
        "orgId" = "$OrganizationId";
        "name" = "$PoolName";
        "description" = "$Description";
        "templateType" = "$PoolType";
        "providerInstanceId" = "$ProviderInstanceId";
        "uagDeploymentId" = "$UAGDeploymentId";
        "imageReference" = @{
            "streamId" = "$ImageId";
            "markerId" = "$MarkerId"
        };
        "licenseProvided" = "$EligableLicense";
        "infrastructure" = @{
            "vmSkus" = @(@{
                "kind" = "vmSkus";
                "id" = "$VMModel"
            });
            "diskSkus" = @(@{
                "kind" = "diskSkus";
                "id" = "$VMDiskType"
            })
        };
        "diskSizeInGB" = "$VMDiskSize";
        "diskEncryption" = @{
            "enabled" = "$VMDiskEncryptionEnabled"
        };
        "activeDirectoryId" = "$ActiveDirectoryId";
        "computerAccountOU" = "$ComputerOU";
        "sparePolicy" = @{
            "description" = "";
            "limit" = "$MaxVMs";
            "min" = "$MinSpareVMs";
            "max" = "$MaxSpareVMs"
        };
        "vmNamePattern" = "$VMNamePrefix";
        "desktopAdminUsername" = "$DesktopAdminUsername";
        "desktopAdminPassword" = @(
            $($JsonBodyPassword | ConvertFrom-Json)
        );
        "networks" = @(@{
            "kind" = "subnets";
            "id" = "$SubnetId";
            "data" = @{
                "parent" = "$VNetId"
            }
        });
        "agentCustomization" = @{
            "demSettingId" = "$getDEMConfigId"
        };
        "sessionsPerVm" = "$SessionsPerVM";
        "vmLicenseType" = "$VMLicenseType"
    }    

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json -Depth 5) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }    
    
}

Function New-HCSPoolGroup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$PoolGroupName,
        [Parameter(Mandatory=$True)] [string]$DisplayName,
        [Parameter(Mandatory=$True)] [string]$EdgeDeploymentName, #Edge-CWS
        [Parameter(Mandatory=$True)] [string]$EdgeDeploymentId,
        [Parameter(Mandatory=$True)] [string]$PoolId,
        [Parameter(Mandatory=$True)] [string]$Protocol, #BLAST
        [Parameter(Mandatory=$True)] [string]$TemplateType, #FLOATING
        [Parameter(Mandatory=$True)] [string]$Type, #DESKTOP
        [Parameter(Mandatory=$True)] [string]$EnableSSO #true or false
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/pools"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
        "displayName" = "$DisplayName";
        "enableSSO" = "$EnableSSO";
        "name" = "$PoolGroupName";
        "orgId" = "$OrganizationId";
        "protocols" = @(@{
                "defaultProtocol" = "true";
                "name" = "$Protocol"
        });
        "templates" = @(@{
                "edgeDeployment" = @{
                    "name" = "$EdgeDeploymentName"
                };
                "edgeDeploymentId" = "$EdgeDeploymentId";
                "id" = "$PoolId"
        });
        "templateType" = "$TemplateType";
        "type" = "$Type"
    }    

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json -Depth 5) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }     

}

Function New-HCSProviderInstanceConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$True)] [string]$DirectoryId,
        [Parameter(Mandatory=$True)] [string]$SubscriptionId,
        [Parameter(Mandatory=$True)] [string]$ApplicationId,
        [Parameter(Mandatory=$True)] [string]$ApplicationKey,
        [Parameter(Mandatory=$True)] [string]$Region,
        [Parameter(Mandatory=$False)] [bool]$JSONOnly
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/providers/azure/instances"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
        "name" = "$Name";
        "orgId" = "$OrganizationId";
        "providerDetails" = @{
            "method" = "ByAppRegistration";
            "data" = @{
                "subscriptionId" = "$SubscriptionId";
                "directoryId" = "$DirectoryId";
                "applicationId" = "$ApplicationId";
                "applicationKey" = "$ApplicationKey";
                "region" = "$Region";
            }
        }
    }

    If ($JSONOnly -eq $True)
        {
            Write-Output ""
            Write-Output "--- JSON ---"
            Write-Output ""
            Write-Output ($Body | ConvertTo-Json -Depth 6)
            Write-Output ""
            Write-Output "------------"
            Write-Output ""
        }
        Else
        {
            try
                {
                    Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
                }
            catch
                {
                    Throw $_
                }  
        }
}

Function New-HCSSiteConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$False)] [string]$Description
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/sites"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
	    "name" = "$Name";
        "description" = "$Description";
        "orgId" = "$OrganizationId"
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
        }
    catch
        {
            Throw $_
        } 

}

Function New-HCSSiteEdgeMapping {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$SiteId,
        [Parameter(Mandatory=$True)] [string]$EdgeId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/sites/" + "$SiteId" + "/edge/" + "$EdgeId"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Put -Headers $Header -UseBasicParsing
        }
    catch
        {
            Throw $_
        } 
}

Function New-HCSSSOConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$False)] [string]$Description,
        [Parameter(Mandatory=$True)] [string]$ActiveDirectoryId,
        [Parameter(Mandatory=$True)] [string]$ConfigurationDomainName,
        [Parameter(Mandatory=$True)] [string]$CAMode #root or sub
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v1/sso-configurations"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
        "activeDirectoryIds" = @("$ActiveDirectoryId");        
	    "name" = "$Name";
        "description" = "$Description";
        "orgId" = "$OrganizationId";
        "caConfigDn" = "$ConfigurationDomainName";
        "caMode" = "$CAMode";
    }

    try
        {
            Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
        }
    catch
        {
            Throw $_
        }
}

Function New-HCSUAGDeployment {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$False)] [string]$Description,
        [Parameter(Mandatory=$True)] [string]$FQDN,
        [Parameter(Mandatory=$True)] [int]$NumberOfGateways,
        [Parameter(Mandatory=$True)] [string]$SSLCertificate, #must be PEM format (no PFX), including key and root/intermediates
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetId,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetParent,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetName,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetAvailableIPAddresses,
        [Parameter(Mandatory=$True)] [string]$ManagementSubnetCIDR,
        [Parameter(Mandatory=$True)] [string]$DMZSubnetId,
        [Parameter(Mandatory=$True)] [string]$DMZSubnetParent,
        [Parameter(Mandatory=$True)] [string]$DMZSubnetName,
        [Parameter(Mandatory=$True)] [string]$DMZSubnetAvailableIPAddresses,
        [Parameter(Mandatory=$True)] [string]$DMZSubnetCIDR,
        [Parameter(Mandatory=$True)] [string]$WorkloadSubnetId,
        [Parameter(Mandatory=$True)] [string]$WorkloadSubnetParent,
        [Parameter(Mandatory=$True)] [string]$WorkloadSubnetName,
        [Parameter(Mandatory=$True)] [string]$WorkloadSubnetAvailableIPAddresses,
        [Parameter(Mandatory=$True)] [string]$WorkloadSubnetCIDR,
        [Parameter(Mandatory=$True)] [string]$ProviderInstanceId,
        [Parameter(Mandatory=$False)] [bool]$JSONOnly


    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/uag-deployments"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    #Convert SSL certificate string to allowed format

    $output = $SSLCertificate.replace("- ","-`n")
    $output = $output.replace(" -","`n-")
    $array = $output.split("`n")
    $newarray = @()
    foreach ($line in $array)
    	{
		    if ($line.subString(0,5) -ne "-----")
    			{
				    $newarray += $line.replace(" ","`n")
			    }
		    else
			    {
    				$newarray += $line
			    }
	    }

    $string = [string]$newarray
    $string = $string.replace(" -","`n-")
    $string = $string.replace("- ","-`n")
    $SSLCertificate = $string


    $Body = @{
	    "cluster" = @{
            "max" = $NumberOfGateways;
            "min" = $NumberOfGateways
        }
        "description" = "$Description";
        "fqdn" = "$FQDN";
        "infrastructure" = @{
            "dmzNetwork" = @{
                "kind" = "subnets";
                "id" = $DMZSubnetId;
                "data" = @{
                    "parent" = $DMZSubnetParent;
                    "name" = $DMZSubnetName;
                    "availableIpAddresses" = $DMZSubnetAvailableIPAddresses;
                    "cidr" = $DMZSubnetCIDR
                }
            };
            "managementNetwork" = @{
                "kind" = "subnets";
                "id" = $ManagementSubnetId;
                "data" = @{
                    "parent" = $ManagementSubnetParent;
                    "name" = $ManagementSubnetName;
                    "availableIpAddresses" = $ManagementSubnetAvailableIPAddresses;
                    "cidr" = $ManagementSubnetCIDR
                }
            };
            "desktopNetwork" = @{
                "kind" = "subnets";
                "id" = $WorkloadSubnetId;
                "data" = @{
                    "parent" = $WorkloadSubnetParent;
                    "name" = $WorkloadSubnetName;
                    "availableIpAddresses" = $WorkloadSubnetAvailableIPAddresses;
                    "cidr" = $WorkloadSubnetCIDR
                }
            };
        }
        "name" = "$Name";
        "orgId" = "$OrganizationId";
        "providerInstanceId" = "$ProviderInstanceId";
        "numberOfGateways" = $NumberOfGateways;
        "sslCertificate" = @{
            "data" = @{
                "certificate" = "$SSLCertificate";
                "certificatePassword" = ""
            };
            "type" = "PEM"
        }
        "type" = "EXTERNAL"
    }

    If ($JSONOnly -eq $True)
        {
            Write-Output ""
            Write-Output "--- JSON ---"
            Write-Output ""
            Write-Output "POST $Url"
            Write-Output "content-type: application/json"
            Write-Output "Authorization: Bearer $AccessToken"
            Write-Output ""
            Write-Output ($Body | ConvertTo-Json -Depth 6)
            Write-Output ""
            Write-Output "------------"
            Write-Output ""
        }
        Else
        {
            try
                {
                    Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json -Depth 6) -UseBasicParsing
                }
            catch
                {
                    Throw $_
                }
        }
}


###########
# PUBLISH #
###########

Function Publish-HCSImage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Description,
        [Parameter(Mandatory=$True)] [string]$ImageId,
        [Parameter(Mandatory=$True)] [string]$ImageVersionId,
        [Parameter(Mandatory=$True)] [string]$ImageVersionName, #1.0.0
        [Parameter(Mandatory=$True)] [string]$Provider, #AZURE
        [Parameter(Mandatory=$True)] [string]$InstallFeatures, #DEM, AvAgentInstall, ClientDriveRedirection, PerfTracker, HelpDesk, RTAV, PrintRedir, V4V, GEOREDIR, VMWMediaProviderProxy, SmartCard, USB, URLRedirection, SerialPortRedirection, ScannerRedirection, SDOSensor
        [Parameter(Mandatory=$True)] [string]$InstallHorizonAgent,
        [Parameter(Mandatory=$True)] [string]$DisableWindowsUpdate,
        [Parameter(Mandatory=$True)] [string]$RemoveAppXPackages
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/imagemgmt/v1/images/" + $ImageId + "/versions/" + $ImageVersionId + "?action=publish"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    [array]$JsonInstallFeatures = $null
    
    ForEach ($_ in $InstallFeatures.Split(",")) {
        $JsonInstallFeatures += $_
    }

    $JsonInstallFeatures = $JsonInstallFeatures | ConvertTo-Json
    
    [array]$OSCustomizations = $null

    If ($DisableWindowsUpdate -eq "true") {
        $OSCustomizations += "DisableWindowsUpdate"
    }

    If ($RemoveAppXPackages -eq "true") {
        $OSCustomizations += "RemoveAppXPackages"
    }

    $JsonOSCustomizations = $OSCustomizations | ConvertTo-Json

    $Body = @{
        "description" = "$Description";
        "options" = @{
            "applicationScan" = @{
                "appScanDetails" = @{
                    "infrastructureResourceList" = @()
                };
                "enableAppScan" = "false"
            };
            "horizonAgent" = @{
                "features" = @($($JsonInstallFeatures | ConvertFrom-Json));
                "installHorizonAgent" = "$InstallHorizonAgent"
            };
            "osCustomizations" = @($($JsonOSCustomizations | ConvertFrom-Json));
            "publishWithResiliency" = "false";
            "validateImage" = "false";
            "validationInfraResourceDetails" = @{
                "infrastructureResourceList" = @()
            }
        };
        "orgId" = "$OrganizationId";
        "providerLabel" = "$Provider";
        "replicas" = @();
        "versionName" = "$ImageVersionName"
    }

    Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json -Depth 6) -UseBasicParsing
}


############
# REGISTER #
############

Function Register-HCSEdgeDefaultModules {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$EdgeId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/edge-deployments/" + $EdgeId + "/edge-modules?action=refresh&org_id=" + $OrganizationId
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -UseBasicParsing
}


##########
# REMOVE #
##########

Function Remove-HCSADConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$Id
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/active-directories/" + $Id
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSAVApplication {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ApplicationId,
        [Parameter(Mandatory=$False)] [bool]$Force
    )

    If (!($Url))
        {
            If ($Force -eq $True)
                {
                    $Url = "https://cloud.vmwarehorizon.com/av-appies/v1/applications/" + $ApplicationId + "?forceDelete=true"
                }
            Else
                {
                    $Url = "https://cloud.vmwarehorizon.com/av-appies/v1/applications/" + $ApplicationId
                }
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSAVApplicationEntitlement {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ApplicationEntitlementId
    )

    If (!($Url))
    {
        $Url = "https://cloud.vmwarehorizon.com/av-entitlements/v1/app-entitlements/delete-bulk"
    }    

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
        "data" = @{
            "appEntitlementIds" = @(
                "$ApplicationEntitlementId"
            );
        }      
    }

    Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json -Depth 6) -UseBasicParsing
}

Function Remove-HCSDEMConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$Id
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v1/dem-settings"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    $Url = $Url + "/" + $Id
    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSEdgeDeployment {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$Id,
        [Parameter(Mandatory=$False)] [bool]$Force
    )

    If (!($Url))
        {
            If ($Force -eq $True)
            {
                $Url = "https://cloud.vmwarehorizon.com/admin/v2/edge-deployments/" + "$Id" + "?force=true"
            } Else {
                $Url = "https://cloud.vmwarehorizon.com/admin/v2/edge-deployments/" + "$Id"
            }          
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSEntitlement {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$EntitlementId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/entitlements/" + "$EntitlementId"          
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSHomeSiteMapping {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$Id
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/homesitemappings/" + "$Id"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSIAMMapping {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url
    )

    If (!($Url))
        {    
            $Url = "https://cloud.vmwarehorizon.com/auth/v1/admin/org-idp-map"
        }          

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSImage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ImageId,
        [Parameter(Mandatory=$True)] [string]$ImageVersionId,
        [Parameter(Mandatory=$False)] [bool]$Force
    )

    If (!($Url))
        {
            If ($Force -eq $True)
            {
                $Url = "https://cloud.vmwarehorizon.com/imagemgmt/v1/images/" + "$ImageId" + "/versions/" + "$ImageVersionId"  + "?force=true"
            } Else {
                $Url = "https://cloud.vmwarehorizon.com/imagemgmt/v1/images/" + "$ImageId" + "/versions/" + "$ImageVersionId"
            }          
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSPool {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$PoolId,
        [Parameter(Mandatory=$False)] [bool]$Force
    )

    If (!($Url))
        {
            If ($Force -eq $True)
            {
                $Url = "https://cloud.vmwarehorizon.com/admin/v2/templates/" + "$PoolId" + "?force=true"
            } Else {
                $Url = "https://cloud.vmwarehorizon.com/admin/v2/templates/" + "$PoolId"
            }          
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSPoolGroup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$PoolGroupId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/pools/" + "$PoolGroupId"          
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSProviderInstanceConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$Id
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/providers/azure/instances/" + $Id
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSSiteConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$Id
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/sites/" + $Id
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSSiteEdgeMapping {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$SiteId,
        [Parameter(Mandatory=$True)] [string]$EdgeId
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/sites/" + "$SiteId" + "/edge/" + "$EdgeId"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSSSOConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$Id
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v1/sso-configurations/" + $Id
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSTest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$TestId
    )

    If (!($Url))
        {
            $Url = "https://cloud-sg.horizon.vmware.com/synthetic-testing/v1/probes/" + $TestId
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSTestingClient {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$TestingClientId
    )

    If (!($Url))
        {
            $Url = "https://cloud-sg.horizon.vmware.com/synthetic-testing/v1/outposts/" + $TestingClientId
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}

Function Remove-HCSUAGDeployment {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$Id,
        [Parameter(Mandatory=$False)] [bool]$Force
    )

    If (!($Url))
        {
            If ($Force -eq $True)
            {
                $Url = "https://cloud.vmwarehorizon.com/admin/v2/uag-deployments/" + "$Id" + "?force=true"
            } Else {
                $Url = "https://cloud.vmwarehorizon.com/admin/v2/uag-deployments/" + "$Id"
            }          
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Delete -Headers $Header -UseBasicParsing
}


#######
# SET #
#######

Function Set-HCSADConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Id,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$True)] [string]$BindAccountUsername,
        [Parameter(Mandatory=$True)] [string]$BindAccountPassword,
        [Parameter(Mandatory=$True)] [string]$AuxBindAccountUsername,
        [Parameter(Mandatory=$True)] [string]$AuxBindAccountPassword,
        [Parameter(Mandatory=$True)] [string]$DomainJoinAccountUsername,
        [Parameter(Mandatory=$True)] [string]$DomainJoinAccountPassword,
        [Parameter(Mandatory=$True)] [string]$AuxDomainJoinAccountUsername,
        [Parameter(Mandatory=$True)] [string]$AuxDomainJoinAccountPassword,
        [Parameter(Mandatory=$True)] [string]$DefaultOU
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/active-directories/" + "$Id"
        }

    $Header = @{
	    "Content-Type" = "application/json";
	    "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
	    "bindAccounts" = @{
    		"auxiliary" = @{
			    "password" = $AuxBindAccountPassword;
			    "username" = $AuxBindAccountUsername
		    };
		    "primary" = @{
    			"password" = $BindAccountPassword;
			    "username" = $BindAccountUsername
		    };
	    };
	    "defaultOU" = "$DefaultOU";
	    "joinAccounts" = @{
    		"auxiliary" = @{
			    "password" = $AuxDomainJoinAccountPassword;
			    "username" = $AuxDomainJoinAccountUsername
		    };
		    "primary" = @{
    			"password" = $DomainJoinAccountPassword;
			    "username" = $DomainJoinAccountUsername
		    };
	    };
	    "name" = "$Name"
    }

    Invoke-RestMethod -Uri "$Url" -Method Patch -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
}

Function Set-HCSAVApplicationDeliveryMethod {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ApplicationVersionId,
        [Parameter(Mandatory=$True)] [string]$DeliveryMode # CLASSIC or ONDEMAND

    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/av-appies/v1/app-versions/" + $ApplicationVersionId
        }

    $Header = @{
	    "Content-Type" = "application/json";
	    "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
	    "data" = @{
    	            "deliveryMode" = "$DeliveryMode";
        }
    }

    Invoke-RestMethod -Uri "$Url" -Method Patch -Headers $Header -Body ($Body | ConvertTo-Json -Depth 6) -UseBasicParsing
}

Function Set-HCSAVPackageMarker {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$AppVersionId,
        [Parameter(Mandatory=$True)] [string]$MarkerId # CURRENT or LATEST
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/av-appies/v1/app-versions/" + $AppVersionId + "/markers/" + $MarkerId
        }

    $Header = @{
	    "Content-Type" = "application/json";
	    "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Put -Headers $Header -UseBasicParsing

    # Set-HCSAVPackageMarker -AccessToken $AccessToken -AppVersionId (Get-HCSAVApplicationVersion -AccessToken $AccessToken -Name "Notepad++ 8 5 2").packages.appVersionIds -MarkerId "CURRENT"
}

Function Set-HCSClientSettings {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [bool]$EnablePreLoginMessage,
        [Parameter(Mandatory=$False)] [string]$PreLoginMessage     
    )

    If (!($Url))
        {
            $Url = "https://cloud-sg.horizon.vmware.com/rx-service/v1/tenant/client-setting"
        }

    $Header = @{
	    "Content-Type" = "application/json";
	    "Authorization" = "Bearer " + $AccessToken
    }

    If ($EnablePreLoginMessage -eq $True)
        {
            $EnablePreLoginMessage = "true"
        }
    Else {
            $EnablePreLoginMessage = "false"
        }

    $Body = @{
	    "enablePreLoginMessage" = "$EnablePreLoginMessage";
        "preLoginMessage" = "$PreLoginMessage"
    }

    Invoke-RestMethod -Uri "$Url" -Method Put -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
}

Function Set-HCSImageMarker {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ImageId,
        [Parameter(Mandatory=$True)] [string]$ImageVersionId,
        [Parameter(Mandatory=$True)] [string]$Name        
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/imagemgmt/v1/images/" + $ImageId + "/versions/" + $ImageVersionId
        }

    $Header = @{
	    "Content-Type" = "application/json";
	    "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
	    "markers" = @(
    	                @{
		                    "label" = "$Name";
                            "name" = "$Name";
                            "value" = "$Name"
		                }
	                )
    }

    Invoke-RestMethod -Uri "$Url" -Method Patch -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
}

Function Set-HCSPoolImage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$False)] [string]$PoolId,
        [Parameter(Mandatory=$True)] [string]$ImageId,
        [Parameter(Mandatory=$True)] [string]$MarkerId      
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/templates/" + $PoolId
        }

    $Header = @{
	    "Content-Type" = "application/json";
	    "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
	    "imageReference" = @{
		                    "streamId" = "$ImageId";
                            "markerId" = "$MarkerId"
		                }
    }

    Invoke-RestMethod -Uri "$Url" -Method Patch -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
}

Function Set-HCSProviderSubnets { #WORK IN PROGRESS
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$ProviderId,
        [Parameter(Mandatory=$True)] [string]$VNetId,
        [Parameter(Mandatory=$True)] [string]$SubnetId,
        [Parameter(Mandatory=$True)] [string]$SubnetName
        
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/providers/azure/instances/" + "$ProviderId" + "/preferences/networks"
        }

    $Header = @{
	    "Content-Type" = "application/json";
	    "Authorization" = "Bearer " + $AccessToken
    }

    $Body = @{
	    "desktop" = @(
    	                @{
		                    "kind" = "subnets";
		                    "id" = $SubnetId;
		                    "data" = @{
    			                "name" = $SubnetName;
			                    "parent" = $VNetId
		                    }
		                }
	                )
    }

    Invoke-RestMethod -Uri "$Url" -Method Patch -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
}