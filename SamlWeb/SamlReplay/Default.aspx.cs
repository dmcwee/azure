using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SamlReplay
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitClicked(object sender, EventArgs e)
        {
            Response.Redirect("./Saml2Replay.aspx?url=" + this.samlSubmitUrl.Value);
        }

        protected void WsFedSubmitClicked(object sender, EventArgs e)
        {
            Response.Redirect("./WSFedReplay.aspx?url=" + this.wsFedSubmitUrl.Value);
        }
    }
}