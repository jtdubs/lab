Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Set-PSDebug -Trace 1

$adDomain = Get-ADDomain
$domain = $adDomain.DNSRoot
$domainDn = $adDomain.DistinguishedName

# OU Structure
$OUs = @(
    @{ Name="Accounts";                     Path="$domainDn" },
        @{ Name="Default";                  Path="OU=Accounts,$domainDn" },
        @{ Name="People";                   Path="OU=Accounts,$domainDn" },
        @{ Name="Privileged";               Path="OU=Accounts,$domainDn" },
            @{ Name="Domain";               Path="OU=Privileged,OU=Accounts,$domainDn" },
            @{ Name="Server";               Path="OU=Privileged,OU=Accounts,$domainDn" },
            @{ Name="Workstation";          Path="OU=Privileged,OU=Accounts,$domainDn" },
            @{ Name="Middleware";           Path="OU=Privileged,OU=Accounts,$domainDn" },
            @{ Name="Application";          Path="OU=Privileged,OU=Accounts,$domainDn" },
        @{ Name="Services";                 Path="OU=Accounts,$domainDn" },
            @{ Name="Managed";              Path="OU=Services,OU=Accounts,$domainDn" },
    @{ Name="Devices";                      Path="$domainDn" },
        @{ Name="Servers";                  Path="OU=Devices,$domainDn" },
            @{ Name="Development";          Path="OU=Servers,OU=Devices,$domainDn" },
                @{ Name="Windows";          Path="OU=Development,OU=Servers,OU=Devices,$domainDn" },
                @{ Name="Linux";            Path="OU=Development,OU=Servers,OU=Devices,$domainDn" },
            @{ Name="Test";                 Path="OU=Servers,OU=Devices,$domainDn" },
                @{ Name="Windows";          Path="OU=Test,OU=Servers,OU=Devices,$domainDn" },
                @{ Name="Linux";            Path="OU=Test,OU=Servers,OU=Devices,$domainDn" },
            @{ Name="Staging";              Path="OU=Servers,OU=Devices,$domainDn" },
                @{ Name="Windows";          Path="OU=Test,OU=Servers,OU=Devices,$domainDn" },
                @{ Name="Linux";            Path="OU=Test,OU=Servers,OU=Devices,$domainDn" },
            @{ Name="Production";           Path="OU=Servers,OU=Devices,$domainDn" },
                @{ Name="Windows";          Path="OU=Production,OU=Servers,OU=Devices,$domainDn" },
                @{ Name="Linux";            Path="OU=Production,OU=Servers,OU=Devices,$domainDn" },
        @{ Name="Workstations";             Path="OU=Devices,$domainDn" },
            @{ Name="Linux";                Path="OU=Workstations,OU=Devices,$domainDn" },
            @{ Name="Windows";              Path="OU=Workstations,OU=Devices,$domainDn" },
    @{ Name="Groups";                       Path="$domainDn" },
        @{ Name="Roles";                    Path="OU=Groups,$domainDn" },
        @{ Name="Access";                   Path="OU=Groups,$domainDn" },
            @{ Name="Domain";               Path="OU=Access,OU=Groups,$domainDn" },
            @{ Name="Servers";              Path="OU=Access,OU=Groups,$domainDn" },
            @{ Name="Workstations";         Path="OU=Access,OU=Groups,$domainDn" },
            @{ Name="Middleware";           Path="OU=Access,OU=Groups,$domainDn" },
            @{ Name="Applications";         Path="OU=Access,OU=Groups,$domainDn" },
            @{ Name="Privileged";           Path="OU=Access,OU=Groups,$domainDn" }
                @{ Name="Domain";           Path="OU=Privileged,OU=Access,OU=Groups,$domainDn" },
                @{ Name="Servers";          Path="OU=Privileged,OU=Access,OU=Groups,$domainDn" },
                @{ Name="Workstations";     Path="OU=Privileged,OU=Access,OU=Groups,$domainDn" },
                @{ Name="Middleware";       Path="OU=Privileged,OU=Access,OU=Groups,$domainDn" }
                @{ Name="Applications";     Path="OU=Privileged,OU=Access,OU=Groups,$domainDn" }
)

$Groups = @(
    # Domain Access Groups
    @{ Name="Domain Read";                               Path="OU=Domain,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Domain Administrator";                      Path="OU=Domain,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Domain Account Administrator";              Path="OU=Domain,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Domain Group Administrator";                Path="OU=Domain,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },

    # Server Access Groups
    @{ Name="Domain Controller WMI Read";                Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Domain Controller WMI Modify";              Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Domain Controller Login";                   Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Domain Controller Admin";                   Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Read - Development";     Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Read - Test";            Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Read - Staging";         Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Read - Production";      Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Modify - Development";   Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Modify - Test";          Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Modify - Staging";       Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Modify - Production";    Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Login - Development";        Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Login - Test";               Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Login - Staging";            Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Login - Production";         Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Admin - Development";        Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Admin - Test";               Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Admin - Staging";            Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Admin - Production";         Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Login - Development";          Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Login - Test";                 Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Login - Staging";              Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Login - Production";           Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Admin - Development";          Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Admin - Test";                 Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Admin - Staging";              Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Admin - Production";           Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },

    # Server Access Groups
    @{ Name="Domain Controller WMI Read";                Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Domain Controller WMI Modify";              Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Domain Controller Login";                   Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Domain Controller Admin";                   Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Read - Development";     Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Read - Test";            Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Read - Staging";         Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Read - Production";      Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Modify - Development";   Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Modify - Test";          Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Modify - Staging";       Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server WMI Modify - Production";    Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Login - Development";        Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Login - Test";               Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Login - Staging";            Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Login - Production";         Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Admin - Development";        Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Admin - Test";               Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Admin - Staging";            Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Server Admin - Production";         Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Login - Development";          Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Login - Test";                 Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Login - Staging";              Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Login - Production";           Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Admin - Development";          Path="OU=Servers,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Admin - Test";                 Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Admin - Staging";              Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Linux Server Admin - Production";           Path="OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },

    # Workstation Access Groups
    @{ Name="Windows Workstation WMI Read";              Path="OU=Workstations,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Workstation WMI Modify";            Path="OU=Workstations,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Workstation Login";                 Path="OU=Workstations,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Windows Workstation Admin";                 Path="OU=Workstations,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },

    # Middleware Access Groups
    @{ Name="IIS Administrator - Development";           Path="OU=Middleware,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="IIS Administrator - Test";                  Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="IIS Administrator - Staging";               Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="IIS Administrator - Production";            Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="SQL Administrator - Development";           Path="OU=Middleware,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="SQL Administrator - Test";                  Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="SQL Administrator - Staging";               Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="SQL Administrator - Production";            Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Tomcat Administrator - Development";        Path="OU=Middleware,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Tomcat Administrator - Test";               Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Tomcat Administrator - Staging";            Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Tomcat Administrator - Production";         Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Postgres Administrator - Development";      Path="OU=Middleware,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Postgres Administrator - Test";             Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Postgres Administrator - Staging";          Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Postgres Administrator - Production";       Path="OU=Middleware,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },

    # Application Access Groups
    @{ Name="Corobe User - Development";                 Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Corobe User - Test";                        Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Corobe User - Staging";                     Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Corobe User - Production";                  Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Corobe Administrator - Development";        Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Corobe Administrator - Test";               Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Corobe Administrator - Staging";            Path="OU=Applications,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Corobe Administrator - Production";         Path="OU=Applications,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Bertal User - Development";                 Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Bertal User - Test";                        Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Bertal User - Staging";                     Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Bertal User - Production";                  Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Bertal Administrator - Development";        Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Bertal Administrator - Test";               Path="OU=Applications,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Bertal Administrator - Staging";            Path="OU=Applications,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },
    @{ Name="Bertal Administrator - Production";         Path="OU=Applications,OU=Privileged,OU=Access,OU=Groups,$domainDn"; Category="Security" },

    # Infrastructure Team Groups
    @{ Name="Domain Administrators"; Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Windows Engineers";     Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Windows Operators";     Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Linux Engineers";       Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Linux Operators";       Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },

    # Middleware Team Groups
    @{ Name="Web Engineers";         Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Web Operators";         Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Database Engineers";    Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Database Operators";    Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },

    # Support Team Groups
    @{ Name="Workstation Support";   Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Access Administrators"; Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },

    # Application Team Groups
    @{ Name="Corobe Developers";     Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Corobe Testers";        Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Corobe Users";          Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Bertal Developers";     Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Bertal Testers";        Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" },
    @{ Name="Bertal Users";          Path="OU=Distribution,OU=Groups,$domainDn"; Category="Distribution" }
)

# Role to Account & Access Rights mapping
$Roles = @(
    @{
        Role="Domain Administrators";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn",
                    "CN=Domain Administrator,OU=Domain,OU=Privileged,OU=Access,OU=Groups,$domainDn",
                    "CN=Domain Controller WMI Read,OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn",
                    "CN=Domain Controller WMI Modify,OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn",
                    "CN=Domain Controller Login,OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn",
                    "CN=Domain Controller Admin,OU=Servers,OU=Privileged,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Windows Engineers";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server WMI Read - Development,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server WMI Read - Test,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server WMI Read - Staging,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server WMI Read - Production,OU=Servers,OU=Access,OU=Groups,$domainDn"
                    "CN=Windows Server WMI Modify - Development,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server Login - Development,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server Login - Test,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server Admin - Development,OU=Servers,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Server";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server WMI Modify - Test,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server WMI Modify - Staging,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server WMI Modify - Production,OU=Servers,OU=Access,OU=Groups,$domainDn"
                    "CN=Windows Server Login - Staging,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server Login - Production,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server Admin - Test,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server Admin - Staging,OU=Servers,OU=Access,OU=Groups,$domainDn",
                    "CN=Windows Server Admin - Production,OU=Servers,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Windows Operators";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Linux Engineers";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Linux Operators";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Web Engineers";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Web Operators";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Database Engineers";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Database Operators";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Workstation Support";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Access Administrators";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Corobe Developers";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Corobe Testers";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Corobe Users";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Bertal Developers";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Bertal Testers";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    },
    {
        Role="Bertal Users";
        Accounts=@(
            @{
                Type="Primary";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            },
            @{
                Type="Domain";
                Rights=@(
                    "CN=Domain Read,OU=Domain,OU=Access,OU=Groups,$domainDn"
                )
            }
        )
    }
)

# Write-Host "Creating OU Structure..."
# 
# $OUs | ForEach-Object {
#     $ou = $_
#     New-ADOrganizationalUnit -Name $ou.Name -Path $ou.Path
# }
# redirusr "OU=Accounts,$domainDn"
# redircmp "OU=Devices,$domainDn"
# 
# Remove-ADObject -Identity "CN=Computers,$domainDn" -Confirm:$False
# 
# 
# Write-Host "Creating AD Groups..."
# $Groups | ForEach-Object {
#     $group = $_
#     New-ADGroup -Name $group.Name -Path $group.Path -GroupScope DomainLocal -GroupCategory $group.Category
# }
# 
# 
# Write-Host "Creating AD Accounts..."
# 
# $Accounts | ForEach-Object {
#     $user = $_
#     $first = $user.First
#     $firstLower = $first.ToLower()
#     $last = $user.Last
#     $lastLower = $last.ToLower()
#     $id = "$firstLower.$lastLower"
#     $password = ConvertTo-SecureString -AsPlainText $user.Password -Force
# 
#     New-ADUser `
#         -Path "OU=People,OU=Accounts,$domainDn" `
#         -Name $id `
#         -UserPrincipalName "$id@$domain" `
#         -EmailAddress "$id@$domain" `
#         -GivenName $first `
#         -Surname $last `
#         -DisplayName "$first $last" `
#         -AccountPassword $password `
#         -Enabled $true `
#         -PasswordNeverExpires $false
# 
#     $user.Roles | ForEach-Object {
#         $role = $_
#         Add-ADGroupMember `
#             -Identity "CN=$role,OU=Groups,$domainDn" `
#             -Members "CN=$id,OU=People,OU=Accounts,$domainDn"
#     }
# 
#     $user.AdditionalGroups | ForEach-Object {
#         $group = $_
#         Add-ADGroupMember `
#             -Identity $group `
#             -Members "CN=$id,OU=People,OU=Accounts,$domainDn"
#     }
# 
#     $_.AdminAccounts | ForEach-Object {
#         $type = $_
#         $suffix = $type.Substring(0, 1).ToLower()
#         $admin_id = "$id.$suffix"
# 
#         New-ADUser `
#             -Path "OU=$type,OU=Admins,OU=Accounts,$domainDn" `
#             -Name $admin_id `
#             -UserPrincipalName "$admin_id@$domain" `
#             -EmailAddress "$admin_id@$domain" `
#             -GivenName $first `
#             -Surname $last `
#             -DisplayName "$first $last" `
#             -AccountPassword $password `
#             -Enabled $true `
#             -PasswordNeverExpires $false
#     }
# }
# 
# Move-ADObject -Identity "CN=Administrator,CN=Users,$domainDn" -TargetPath "OU=Default,OU=Accounts,$domainDn"
# Move-ADObject -Identity "CN=Guest,CN=Users,$domainDn" -TargetPath "OU=Default,OU=Accounts,$domainDn"
# Move-ADObject -Identity "CN=Vagrant,CN=Users,$domainDn" -TargetPath "OU=Default,OU=Accounts,$domainDn"