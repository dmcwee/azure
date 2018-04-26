<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Saml2Replay.aspx.cs" Inherits="SamlReplay.Saml2Replay" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    
    <script src="Scripts/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap.min.js" type="text/javascript"></script>

    <title></title>
</head>
<body>
    <div class="collapse bg-dark" id="navbarHeader">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-md-7 py-4">
                    <h4 class="text-white">About</h4>
                    <p class="text-muted">This solution allows you to replay a SAML authentication to any service you desire.  Simply generate a SAML token to a service and then copy the XML sent and add it to the replay screen.</p>
                </div>
                <div class="col-sm-4 offset-md-1 py-4">
                    <h4 class="text-white">Contact</h4>
                    <ul class="list-unstyled">
                        <li><a class="text-white" href="mailto:dmcwee@microsoft.com">Email me</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <nav class="navbar navbar-dark bg-dark">
        <div class="container d-flex justify-content-between">
            <a class="navbar-brand d-flex align-items-center" href="~/">
                <strong>SAML Replay</strong>
            </a>
            <button class="navbar-toggler" aria-expanded="false" aria-controls="navbarHeader" aria-label="Toggle Navigation" type="button" data-toggle="collapse" data-target="#navbarHeader">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </nav>
    <div class="container">
        <form id="form1" runat="server" method="post">
            <div class="row">
                <div class="col-md-12">
                    <label for="replacestate">SAML State</label>
                    <asp:TextBox ID="relaystate" runat="server" CssClass="form-control" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <label for="samlresponse">SAML Response</label>
                    <asp:TextBox ID="samlresponse" runat="server" TextMode="MultiLine" Width="800" Height="800" CssClass="form-control" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <input type="submit" value="Replay SAML" class="btn btn-primary btn-lg" />
                </div>
            </div>
        </form>
        
        <script type="text/javascript">
            $(document).ready(function () {
                $("#form1").attr("action", "<%= Request.QueryString["url"] %>");
            });
        </script>
    </div>

</body>
</html>
