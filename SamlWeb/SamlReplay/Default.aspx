<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SamlReplay.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Enter the URL you wish to send the SAML claim to: <asp:TextBox type="text" id="samlSubmitUrl" runat="server" />
        </div>
        <div>
            <asp:Button OnClick="Unnamed_Click" ID="submitButton" runat="server" />
        </div>
    </form>
</body>
</html>
