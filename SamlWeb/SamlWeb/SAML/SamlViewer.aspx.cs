using System;
using System.Collections.Generic;
using System.Web.UI;
using SamlWeb.Models;
using System.IdentityModel.Tokens;
using System.Xml;
using System.Text;
using System.Security.Claims;
using System.IO;
using System.Configuration;

namespace SamlWeb.Account
{
    public partial class SamlViewer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            EnsureChildControls();

            Dictionary<string, string> claims = new Dictionary<string, string>();

            claims[ClaimTypes.Name] = User.Identity.Name;
            claims[ClaimTypes.Email] = User.Identity.Name;
            claims[ClaimTypes.GivenName] = User.Identity.Name;
            //claims[ClaimTypes.Surname] = "McWee";

            Saml2SecurityToken token = SAMLFactory.CreateSaml2Token(
                ConfigurationManager.AppSettings["samlIssuedBy"],
                "McWee, David",
                claims,
                ConfigurationManager.AppSettings["x509CertThumbPrint"]);

            Saml2SecurityTokenHandler tokenHandler = new Saml2SecurityTokenHandler();

            XmlWriterSettings xmlSettings = new XmlWriterSettings();
            xmlSettings.Encoding = System.Text.Encoding.UTF8;

            using (MemoryStream ms = new MemoryStream())
            {
                using (XmlWriter w = XmlWriter.Create(ms, xmlSettings))
                {
                    tokenHandler.WriteToken(w, token);
                    w.Flush();
                    w.Close();
                }
                ms.Position = 0;
                string tokenString = string.Empty;
                using (StreamReader sr = new StreamReader(ms))
                {
                    tokenString = sr.ReadToEnd();
                }

                samlresponse.Text = Convert.ToBase64String(Encoding.UTF8.GetBytes(tokenString));
                rawSamlToken.Text = tokenString;
            }
            relaystate.Text = Page.Request.QueryString["RelayState"];
        }
    }
}