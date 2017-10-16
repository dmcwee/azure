<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Claims.aspx.cs" Inherits="ClaimsWebApp.Claims" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h1><asp:Label ID="signIn" runat="server" /></h1>
        <asp:Repeater ID="claimsDisplay" DataMember="AdfsClaims" runat="server">
            <HeaderTemplate>
                <table>
                    <tr>
                        <td>Claim Type</td>
                        <td>Claim Value</td>
                        <td>Claim Value Type</td>
                        <td>Claim Subject Name</td>
                        <td>Claim Issuer</td>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("Type") %></td>
                    <td><%# Eval("Value") %></td>
                    <td><%# Eval("ValueType") %></td>
                    <td><%# Eval("SubjectName") %></td>
                    <td><%# Eval("Issuer") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>


    </div>
    </form>
</body>
</html>
