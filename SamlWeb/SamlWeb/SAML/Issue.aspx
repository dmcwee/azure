<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Issue.aspx.cs" Inherits="SamlWeb.SAML.Issue" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body id="bodySSO" runat="server">
    <form id="form1" runat="server" action="https://eaglei-sandbox.maps.arcgis.com/sharing/rest/oauth2/saml/signin" method="post" enableviewstate="false">
        <div style="display: none;">
            <div>SamlToken: <asp:TextBox ID="samlresponse" runat="server" TextMode="MultiLine" Width="800" Height="800" /></div>
            <div>SamlState: <asp:TextBox ID="relaystate" runat="server" /></div>
        </div>
    </form>
</body>
</html>
