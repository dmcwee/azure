$multipleVerifiedDomainNames = $false
$immutableIDAlreadyIssuedforUsers = $false
$oneOfVerifiedDomainNames = 'mymildemo.us'   # Replace example.com with one of your verified domains

$rule1 = '@RuleName = "Issue account type for domain-joined computers"
c:[
    Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", 
    Value =~ "-515$", 
    Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"
]
=> issue(
    Type = "http://schemas.microsoft.com/ws/2012/01/accounttype", 
    Value = "DJ"
);'

$rule2 = '@RuleName = "Issue object GUID for domain-joined computers"
c1:[
    Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", 
    Value =~ "-515$", 
    Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"
]
&& 
c2:[
    Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/windowsaccountname", 
    Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"
]
=> issue(
    store = "Active Directory", 
    types = ("http://schemas.microsoft.com/identity/claims/onpremobjectguid"), 
    query = ";objectguid;{0}", 
    param = c2.Value
);'

$rule3 = '@RuleName = "Issue objectSID for domain-joined computers"
c1:[
    Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", 
    Value =~ "-515$", 
    Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"
]
&& 
c2:[
    Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/primarysid", 
    Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"
]
=> issue(claim = c2);'

$rule4 = ''
if ($multipleVerifiedDomainNames -eq $true) {
$rule4 = '@RuleName = "Issue account type with the value User when it is not a computer"
NOT EXISTS(
[
    Type == "http://schemas.microsoft.com/ws/2012/01/accounttype", 
    Value == "DJ"
]
)
=> add(
    Type = "http://schemas.microsoft.com/ws/2012/01/accounttype", 
    Value = "User"
);

@RuleName = "Capture UPN when AccountType is User and issue the IssuerID"
c1:[
    Type == "http://schemas.xmlsoap.org/claims/UPN"
]
&& 
c2:[
    Type == "http://schemas.microsoft.com/ws/2012/01/accounttype", 
    Value == "User"
]
=> issue(
    Type = "http://schemas.microsoft.com/ws/2008/06/identity/claims/issuerid", 
    Value = regexreplace(
    c1.Value, 
    ".+@(?<domain>.+)", 
    "http://${domain}/adfs/services/trust/"
    )
);

@RuleName = "Issue issuerID for domain-joined computers"
c:[
    Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", 
    Value =~ "-515$", 
    Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"
]
=> issue(
    Type = "http://schemas.microsoft.com/ws/2008/06/identity/claims/issuerid", 
    Value = "http://' + $oneOfVerifiedDomainNames + '/adfs/services/trust/"
);'
}

$rule5 = ''
if ($immutableIDAlreadyIssuedforUsers -eq $true) {
$rule5 = '@RuleName = "Issue ImmutableID for computers"
c1:[
    Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", 
    Value =~ "-515$", 
    Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"
] 
&& 
c2:[
    Type == "http://schemas.microsoft.com/ws/2008/06/identity/claims/windowsaccountname", 
    Issuer =~ "^(AD AUTHORITY|SELF AUTHORITY|LOCAL AUTHORITY)$"
]
=> issue(
    store = "Active Directory", 
    types = ("http://schemas.microsoft.com/LiveID/Federation/2008/05/ImmutableID"), 
    query = ";objectguid;{0}", 
    param = c2.Value
);'
}

$existingRules = (Get-ADFSRelyingPartyTrust -Identifier urn:federation:MicrosoftOnline).IssuanceTransformRules 

$updatedRules = $existingRules + $rule1 + $rule2 + $rule3 + $rule4 + $rule5

$crSet = New-ADFSClaimRuleSet -ClaimRule $updatedRules 

Set-AdfsRelyingPartyTrust -TargetIdentifier urn:federation:MicrosoftOnline -IssuanceTransformRules $crSet.ClaimRulesString