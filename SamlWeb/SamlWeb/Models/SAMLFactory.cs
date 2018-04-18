using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens;
using System.Security.Cryptography.X509Certificates;
using System.Diagnostics;
using System.Security.Cryptography;

namespace SamlWeb.Models
{
    public static class SAMLFactory
    {
        public static Saml2SecurityToken CreateSaml2Token(string issuedBy, string subject, Dictionary<string, string> claimValues, string certThumbPrint)
        {
            Trace.TraceInformation("Entering CreateSaml2Token with issuedBy '{0}', subject '{1}', and thumbprint '{2}'", issuedBy, subject, certThumbPrint);

            Saml2Assertion assertion = new Saml2Assertion(new Saml2NameIdentifier(issuedBy));
            assertion.Id = new Saml2Id(string.Format("icfi_{0}", Guid.NewGuid().ToString()));
            //assertion.Issuer = new Saml2NameIdentifier(issuedBy);

            Saml2Subject subj = new Saml2Subject();
            subj.NameId = new Saml2NameIdentifier(subject);
            assertion.Subject = subj;

            Saml2AttributeStatement samlAttrStatement = new Saml2AttributeStatement();
            foreach (string claimKey in claimValues.Keys)
            {
                samlAttrStatement.Attributes.Add(new Saml2Attribute(claimKey, claimValues[claimKey]));
            }
            assertion.Statements.Add(samlAttrStatement);

            X509Certificate2 cert = GetCertificate(certThumbPrint);

            X509AsymmetricSecurityKey signingKey = new X509AsymmetricSecurityKey(cert);

            assertion.SigningCredentials = new SigningCredentials(
                signingKey,
                cert.PublicKey.Key.SignatureAlgorithm,
                SecurityAlgorithms.Sha1Digest,
                    new SecurityKeyIdentifier(new X509ThumbprintKeyIdentifierClause(cert)));

            Saml2SecurityToken samlToken = new Saml2SecurityToken(assertion);
            return samlToken;
        }

        public static SamlSecurityToken CreateSamlToken(string issuedBy, string subject, string attrNamespace, Dictionary<string, string> claims, string certThumbPrint)
        {
            SamlAssertion assertion = new SamlAssertion();
            assertion.AssertionId = string.Format("icfi_{0}", Guid.NewGuid().ToString());
            assertion.Issuer = issuedBy;

            SamlSubject subj = new SamlSubject();
            subj.Name = subject;

            SamlAttributeStatement samlAttrStatement = new SamlAttributeStatement();
            foreach (string claimKey in claims.Keys)
            {
                SamlAttribute attr = new SamlAttribute();
                attr.Namespace = attrNamespace;
                attr.AttributeValues.Add(claims[claimKey]);
                samlAttrStatement.Attributes.Add(attr);
            }
            samlAttrStatement.SamlSubject = subj;

            assertion.Statements.Add(samlAttrStatement);

            X509Certificate2 cert = GetCertificate(certThumbPrint);

            X509AsymmetricSecurityKey signingKey = new X509AsymmetricSecurityKey(cert);

            assertion.SigningCredentials = new SigningCredentials(
                signingKey,
                cert.PublicKey.Key.SignatureAlgorithm,
                SecurityAlgorithms.Sha1Digest,
                    new SecurityKeyIdentifier(new X509ThumbprintKeyIdentifierClause(cert)));

            SamlSecurityToken samlToken = new SamlSecurityToken(assertion);
            return samlToken;
        }

        private static X509Certificate2 GetCertificate(string thumbprint)
        {
            Trace.TraceInformation("GetCertificate With Thumbprint {0}", thumbprint);

            X509Store store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
            store.Open(OpenFlags.ReadOnly);
            foreach (X509Certificate2 cert in store.Certificates)
            {
                if (cert.Thumbprint.ToUpper() == thumbprint.ToUpper())
                {
                    Trace.TraceInformation("Found Certificate {0} with matching Thumbprint {1}.", cert.Subject, cert.Thumbprint);
                    Trace.TraceInformation("Checking if Certificate's Private Key is Available.");

                    if (cert.HasPrivateKey)
                    {
                        try
                        {
                            AsymmetricAlgorithm pKey = cert.PrivateKey;
                            Trace.TraceInformation("Certificate has an accessible private key and is OK for SAML");
                        }
                        catch (Exception ex)
                        {
                            Trace.TraceError("Attempting to access the Certificate's Private Key raised an exception: {0}", ex.Message);
                            throw;
                        }
                    }
                    else
                    {
                        Trace.TraceError("Cert.HasPrivateKey check returned false.  SAML Certificates must have a private key for signing purposes.");
                        throw new NullReferenceException("The Certificate does not include a private key.");
                    }

                    return cert;
                }
            }
            return null;
        }
    }
}