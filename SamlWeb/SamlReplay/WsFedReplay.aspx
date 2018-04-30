<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WsFedReplay.aspx.cs" Inherits="SamlReplay.WSFedReplay" MasterPageFile="~/SamlReplay.Master" %>

<asp:Content ContentPlaceHolderID="head" ID="headPlaceHolder" runat="server">
    <title>WS-FED Replay</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="AboutText" ID="aboutTextPlaceHolder" runat="server">
    This solution allows you to replay a SAML authentication to any service you desire.  Simply generate a SAML token to a service and then copy the XML sent and add it to the replay screen.
</asp:Content>

<asp:Content ContentPlaceHolderID="mainContainer" ID="mainContentPlaceHolder" runat="server">
    <form id="form1" runat="server" method="post">
        <div class="row mb-3">
            <div class="col-md-12">
                <label for="wa">WS-Fed WA</label>
                <asp:TextBox ID="wa" runat="server" CssClass="form-control" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <label for="wctx">WS-Fed Ctx</label>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-md-12 input-group">
                <input type="text" id="wctx" class="form-control" />
                <div class="input-group-append">
                    <input type="button" value="URL Decode" onclick="decodeContent('wctx');" class="form-control btn btn-outline-info" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <label for="wresult">WS-Fed Result</label>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-md-12">
                <textarea id="wresult" class="form-control" cols="2" rows="20"></textarea>
                <input type="button" value="URL Decode" onclick="decodeContent('wresult');" class="btn btn-outline-info" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <input type="submit" value="Replay SAML" class="btn btn-primary btn-lg" />
            </div>
        </div>
    </form>
</asp:Content>

<asp:Content ContentPlaceHolderID="scripts" runat="server" ID="scriptsPlaceHolder">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#form1").attr("action", "<%= Request.QueryString["url"] %>");
        });
    </script>
</asp:Content>
