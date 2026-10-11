# Active Directory Lab		

* Scenario Based:				
	- tasked by IT department to close some tickets in the queue after an audit such as:		
		- Adding new hires	
		- Removing inactive user and computer objects	
		- Unlocking a user account		
		- Creating a new security group, and a new OU for the group and their corresponding PCs			
		- Add New-Hires computers to the domain(validate their objects are in the correct OU)		
		- Create and apply a new Group Policy duplicated 	
		- Validate the DNS records for a host	


## AD Basics Recap:		

* Objects			
	1. Users(SID,GUID) + attributes		
	2. Computers(SID,GUID)		
	3. Groups
		- SID,GUID		
		- manage permissions	
		- attributes	
		- can contain users,computers
	4. Shared Folders(GUID)
	5. OUs		
		- container to store similar objects 	
		- useful for managing Group Policy		
		- attributes	
	6. Domain		
		- contains objects(users and computers which are organized into Groups and OUs)		
	7. Domain Controllers	
		- handle authentication req, verify users, enforces sec policy, holds info about every other object in domain		
	8. Foreign Security Principals	
		- object created to represent security princpal belonging to a trusted external forest		
		- using an SID to resolve the object's name via the trust relationship	


* Trusts	
	1. Parent-Child	
	2. Cross-Link		
	3. External	
	4. Tree-Root	
	5. Forest		

* Transitive trusts	
	- extended to object that the child domain trusts		
	
* Non-Transitive trusts					
	- only the child domain itself is trusted		

* Bidirectional trusts:		
	- trusts between two forests/domains	
	- users from both trusting domains can access resources		
	- e.g. domain with multiple child domains, doesnt mean child domains in forest A can trust child domains in forest B			

* One Way trusts	
	- only users in trusted domain can access resources in a trusting domain	



(root domain)		
INLANEFREIGHT.LOCAL/		
├── ADMIN.INLANEFREIGHT.LOCAL	(subdomain)		
│   ├── GPOs
│   └── OU
│       └── EMPLOYEES
│           ├── COMPUTERS
│           │   └── FILE01
│           ├── GROUPS
│           │   └── HQ Staff
│           └── USERS
│               └── barbara.jones
├── CORP.INLANEFREIGHT.LOCAL	(subdomain)		
└── DEV.INLANEFREIGHT.LOCAL	(subdomain)	


* AD Protocols			
	1. Kerberos	
	2. DNS	
	3. LDAP		
	4. MSRPC	

* NTLM Auth		


## General Commands		

`Get-Module`		

`Get-Command -Module ActiveDirectory`		

`Get-Help <cmd-let>`	
	
`Import-Module ActiveDirectory`			



## Scenario 1: Managing Users	

`Get-ADUser -Identity <user>`		
	- user naming attributes		


`New-ADUser -Name "First Last" -Accountpassword (Read-Host -AsSecureString "Password123") -Enabled $true -OtherAttributes@{'title'="Analyst";'mail'="f.last@domain.com"}`		


`Remove-ADUser -Identity <name>`		

`Unlock-ADAccount -Identity <name>`

`Set-ADAccountPassword -Identity <'name'> -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "NewPass123" -Force)`

`Set-ADUser -Identity amasters -ChangePasswordAtLogon $true`		





## Scenario 2: Managing Groups	


1. Type
	- group's purpose	
	- Security: ease of assigning permissions & rights to a collection of users
	- Distribution:	used by email apps(MS Exchange) to distribute messages to group members		
2. Scope		
	- how group can be used within domain	
	- Domain Local:	used to manage permissions to domain resources in domain where it was created, can contain users from other domains
	- Global: grant access to resources in another domain, can be added to other global and local groups	
	- Universal: manage resources distributed across multiple domains


`Get-ADGroup  -Filter * |select samaccountname,groupscope`		
	- group scopes		


`New-ADOrganizationalUnit -Name "name" -Path "OU=folder,DC=domain,DC=local"`	
	- create a new AD OU named "name" in path specified	
	
`NewAD-Group -Name "name" -SamAccountName analysts -GroupCategory Security -GroupScope Global -DisplayName "Security Analysts" -Path "CN=Users,DC=Domain,DC=local" -Description "Members of this group are Security Analysts under IT OU"`		

`Add-ADGroupMember -Identity "group name" -Members 'F.Last,F.Last,F.Last'`	





## Scenario 3: Managing GPOs		

* GPO Precedence Order	
	1. Local 
	2. Site	
	3. Domain	
	4. Parent	
	5. Child	


`Copy-GPO -SourceName "GPO to copy" -TargetName "name"`	
	
`New-GPLink -Name "Security Analysts Control" -Target "ou=Security Analysts,ou=IT,OU=HQ-NYC,OU=Employees,OU=Corp,dc=INLANEFREIGHT,dc=LOCAL" -LinkEnabled Yes`	
	- links existing GPO to specified OU path	
	- linkenabled ensures once link has been established, the policies are actually enabled		

`Set-GPLink -Name "Security Analysts Control" -Target "ou=Security Analysts,ou=IT,OU=HQ-NYC,OU=Employees,OU=Corp,dc=INLANEFREIGHT,dc=LOCAL" -LinkEnabled Yes`	
	- Link existing GPO for use to specific OU or security group	



## Scenario 4: Add/Remove Computers to the Domain		

`Add-Computer -DomainName 'INLANEFREIGHT.LOCAL' -Credential 'INLANEFREIGHT\HTB-student_adm' -Restart`		

`Add-Computer -ComputerName 'name' -LocalCredential '.\localuser' -DomainName 'INLANEFREIGHT.LOCAL' -Credential 'INLANEFREIGHT\htb-student_adm' -Restart`		
	- remotely add computer to domain		

`Get-ADComputer -Identity "name" -Properties * | select CN,CanonicalName,IPv4Address`
	- check for a computer and view its properties		





