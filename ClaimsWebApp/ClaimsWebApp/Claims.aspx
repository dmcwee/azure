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

        <table>
            <tr>
                <td>Type</td>
                <td>Value</td>
                <td>Value Type</td>
                <td>Subject Name</td>
                <td>Issuer</td>
            </tr>
        <% foreach (var c in this.AdfsClaims) { %>
            <tr>
                <td><%= c.Type %></td>
                <td><%= c.Value %></td>
                <td><%= c.ValueType %></td>
                <td><%= c.SubjectName %></td>
                <td><%= c.Issuer %></td>
            </tr>
        <% } %>
        </table>

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
