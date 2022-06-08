Function New-HCAccessToken {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$Token,
        [Parameter(Mandatory=$False)] [string]$Url
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

    Write-Output (Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body $Body -UseBasicParsing).access_token
}

Function Add-HCActiveDirectory {
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

    Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
}

Function Get-HCOrganizationId {
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

Function Get-HCAADIdentityProviderUrl {
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

    Write-Output (Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing).authUrl
}


Function New-HCSite {
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

    Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
}


Function Get-HCSites {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/portal/v2/sites"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing
}


Function Get-HCProvider {
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


Function New-HCProviderInstance {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$OrganizationId,
        [Parameter(Mandatory=$True)] [string]$Name,
        [Parameter(Mandatory=$True)] [string]$Environment,
        [Parameter(Mandatory=$True)] [string]$DirectoryId,
        [Parameter(Mandatory=$True)] [string]$SubscriptionId,
        [Parameter(Mandatory=$True)] [string]$ApplicationId,
        [Parameter(Mandatory=$True)] [string]$ApplicationKey,
        [Parameter(Mandatory=$True)] [string]$Region
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
        "denyOperations" = @("EDGE_DEPLOYMENT");        
	    "name" = "$Name";
        "orgId" = "$OrganizationId";
        "providerDetails" = @()
    }

    Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
}


Function Get-HCProviderInstance {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True)] [string]$AccessToken,
        [Parameter(Mandatory=$False)] [string]$Url,
        [Parameter(Mandatory=$True)] [string]$Label
    )

    If (!($Url))
        {
            $Url = "https://cloud.vmwarehorizon.com/admin/v2/providers/" + $Label + "/instances"
        }

    $Header = @{
        "Content-Type" = "application/json";
        "Authorization" = "Bearer " + $AccessToken
    }

    Write-Output (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content
    #Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing
}


Function New-HCDEMConfig {
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

    Invoke-RestMethod -Uri "$Url" -Method Post -Headers $Header -Body ($Body | ConvertTo-Json) -UseBasicParsing
}

Function Get-HCDEMConfig {
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
            Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing
        }
    Else {
            ForEach  ($_ in (Invoke-RestMethod -Uri "$Url" -Method Get -Headers $Header -UseBasicParsing).content)
                {
                    If ($_.name -eq "$Name")
                        {
                            Write-Output $_.id
                            $NameFound = $True
                        }
                }
            
            If ($NameFound -ne $True)
                {
                    Write-Warning "Name not found."
                }
    }
    
}


Function Remove-HCDEMConfig {
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

Function Invoke-URLInDefaultBrowser
{
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