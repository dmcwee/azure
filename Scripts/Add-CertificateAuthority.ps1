add-windowsfeature ADCS-Cert-Authority,ADCS-Enroll-Web-Pol -IncludeManagementTools

Install-AdcsCertificationAuthority -CAType EnterpriseRootCa -CryptoProviderName "RSA#Microsoft Software Key Storage Provider" -KeyLength 2048 -HashAlgorithmName SHA256 -ValidityPeriod Years -ValidityPeriodUnits 3 -Force
Install-adcsEnrollmentPolicyWebService -Force