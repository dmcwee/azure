<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SamlViewer.aspx.cs" Inherits="SamlWeb.Account.SamlViewer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body runat="server">
    <form id="form1" runat="server">
        <div>
            <div>SamlToken (Plain Text): <asp:TextBox ID="rawSamlToken" runat="server" TextMode="MultiLine" Width="800" Height="400" /></div>
            <hr />
            <div>SamlToken (Encoded for Post): <asp:TextBox ID="samlresponse" runat="server" TextMode="MultiLine" Width="800" Height="400" /></div>
            <div>SamlState: <asp:TextBox ID="relaystate" runat="server" /></div>
        </div>
    </form>
</body>
</html>
