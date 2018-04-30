<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Saml2Replay.aspx.cs" Inherits="SamlReplay.Saml2Replay" MasterPageFile="~/SamlReplay.Master" %>

<asp:Content ContentPlaceHolderID="head" ID="titlePlaceHolder" runat="server">
    <title>Saml 2 Replay</title>
</asp:Content>

<asp:Content ContentPlaceHolderID="AboutText" ID="headPlaceHolder" runat="server">
    This solution allows you to replay a SAML authentication to any service you desire.  Simply generate a SAML token to a service and then copy the XML sent and add it to the replay screen.
</asp:Content>

<asp:Content ContentPlaceHolderID="mainContainer" ID="containerPlaceHolder" runat="server">
    <form id="form1" method="post" runat="server">
        <div class="row">
            <div class="col-md-12">
                <label for="replacestate">SAML State</label>
                <input type="text" id="relaystate" class="form-control" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <label for="samlresponse">SAML Response</label>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-md-12">
                <textarea id="samlresponse" class="form-control" cols="2" rows="20" ></textarea>
                <input type="button" value="URL Decode" onclick="decodeContent('samlresponse');" class="btn btn-outline-info" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <input type="submit" value="Replay SAML" class="btn btn-primary btn-lg" />
            </div>
        </div>
    </form>
</asp:Content>

<asp:Content ContentPlaceHolderID="scripts" ID="scriptsPlaceHolder" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#form1").attr("action", "<%= Request.QueryString["url"] %>");
        });
    </script>
</asp:Content>
