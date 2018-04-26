<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SamlReplay.WebForm1" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <title></title>

    <link href="Content/bootstrap.css" rel="stylesheet" />

    <script src="Scripts/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="Scripts/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="collapse bg-dark" id="navbarHeader">
            <div class="container">
                <div class="row">
                    <div class="col-sm-8 col-md-7 py-4">
                        <h4 class="text-white">About</h4>
                        <p class="text-muted">This solution allows you to replay a SAML authentication to any service you desire.  Provide the URL where the SAML token will be submitted to.</p>
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
            <div class="row">
                <div class="col-md-6">
                    <div class="card mb-6">
                        <h4 class="card-header">Replay a SAML 2.0 Token</h4>
                        <div class="card-body">
                            <p class="card-text">
                                Enter the URL you wish to send the SAML claim to:
                                <input type="url" runat="server" id="samlSubmitUrl" class="form-control" />
                                <asp:Button Text="Go" runat="server" OnClick="SubmitClicked" CssClass="btn-primary btn-lg" />
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card mb-6">
                        <h4 class="card-header">Replay a WS-FED Token</h4>
                        <div class="card-body">
                            <p class="card-text">
                                Enter the URL you wish to send the WS-FED claim to:
                            <input type="url" runat="server" id="wsFedSubmitUrl" class="form-control" />
                            <asp:Button Text="Go" runat="server" OnClick="WsFedSubmitClicked" CssClass="btn-primary btn-lg" />
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
    <script type="text/javascript">
        function forward
    </script>
</body>
</html>
