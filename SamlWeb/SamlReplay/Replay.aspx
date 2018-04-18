<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Replay.aspx.cs" Inherits="SamlReplay.Replay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" action="<%= Request.QueryString("url") %>">
        <div>
            <div>SamlToken: <asp:TextBox ID="samlresponse" runat="server" TextMode="MultiLine" Width="800" Height="800" /></div>
            <div>SamlState: <asp:TextBox ID="relaystate" runat="server" /></div>
            <div><input type="submit" value="Replay SAML" /></div>
        </div>
    </form>
</body>
</html>
