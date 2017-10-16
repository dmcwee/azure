using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.IdentityModel;
//using System.IdentityModel.Claims;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClaimsWebApp
{
    public class SimpleClaimInfo
    {
        public string Type { get; set; }
        public string Value { get; set; }
        public string ValueType { get; set; }
        public string SubjectName { get; set; }
        public string Issuer { get; set; }
    }

    public partial class Claims : System.Web.UI.Page
    {
        protected List<SimpleClaimInfo> AdfsClaims { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            ClaimsPrincipal cp = Page.User as ClaimsPrincipal;
            if(cp != null)
            {
                signIn.Text = "You are signed in.";

                if (AdfsClaims == null) { AdfsClaims = new List<SimpleClaimInfo>(); }
                foreach(Claim c in cp.Claims)
                {
                    AdfsClaims.Add(new ClaimsWebApp.SimpleClaimInfo
                    {
                        Type = c.Type,
                        Value = c.Value,
                        ValueType = c.ValueType,
                        SubjectName = c.Subject.Name,
                        Issuer = c.Issuer
                    });   
                }
            }
        }
    }
}