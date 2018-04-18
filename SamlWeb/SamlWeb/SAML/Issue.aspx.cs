using SamlWeb.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IdentityModel.Claims;
using System.IdentityModel.Tokens;
using System.IO;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Xml;

namespace SamlWeb.SAML
{
    public partial class Issue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            EnsureChildControls();

            //The email and given name values should be based on data from SQL User Store
            Dictionary<string, string> claims = new Dictionary<string, string>();
            claims[ClaimTypes.Name] = User.Identity.Name;
            claims[ClaimTypes.Email] = User.Identity.Name;
            claims[ClaimTypes.GivenName] = User.Identity.Name;

            Saml2SecurityToken token = SAMLFactory.CreateSaml2Token(
                ConfigurationManager.AppSettings["samlIssuedBy"],
                //This should be the username or user display name.  It will be modified by the relying system
                User.Identity.Name,
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
                samlresponse.Text = Convert.ToBase64String(ms.GetBuffer());
            }
            relaystate.Text = Page.Request.QueryString["RelayState"];

            HtmlGenericControl f = Page.FindControl("bodySSO") as HtmlGenericControl;
            if (f != null)
            {
                f.Attributes.Add("onload", "document.forms.form1.submit();");
            }
        }
    }
}