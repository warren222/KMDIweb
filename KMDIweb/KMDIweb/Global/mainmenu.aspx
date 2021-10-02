<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mainmenu.aspx.cs" Inherits="KMDIweb.KMDIapp.mainmenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="../../Scripts/bootstrap.js"></script>
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>
    <link href="css/gridcss.css" rel="stylesheet" />
    <title>Main Menu</title>
    <style>
        .vl {
            border-left: 1px solid white;
            color: white;
        }

            .vl:hover {
                color: white;
                font-style: normal;
            }

        body, html {
            background-color: #e4e5e7;
        }

        .headerbanner {
            background-color: #336699;
            border-color: #336699;
            color: white;
        }

        .myopacity {
            opacity: 0.5;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="well headerbanner">
            <div class="container">

                <div class="row">
                    <div class="col-sm-6">
                        <h1><strong>Kenneth <span class="text-muted">and</span> Mock</strong> </h1>
                    </div>
                    <div class="col-sm-6">
                        <div class="navbar-right">
                            <asp:LinkButton ID="LinkButton3" CssClass="vl" runat="server" OnClick="LinkButton3_Click">&nbsp;&nbsp;Log out</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <h2><strong class="text-muted">WEB applications</strong>  </h2>
            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" CssClass="alert alert-danger" runat="server" />
            <div class="row">
                <div class="col-sm-3">
                    <asp:Panel ID="Panel3" runat="server">
                        <div class="thumbnail">
                            <asp:Image ID="Image3" CssClass="img-thumbnail" Height="170" ImageUrl="~/KMDIweb/Images/scheduling.jpg" runat="server" AlternateText="Screen Schedule" />
                            <br />
                            <strong style="font-size: x-large"><span class="glyphicon glyphicon-calendar"></span>
                                <span>Frame Schedule</span></strong>
                            <br />
                            <small>Frame fabrication monitoring</small>
                            <asp:LinkButton ID="LinkButton4" Font-Size="Large" runat="server" CssClass="form-control btn btn-primary" OnClick="LinkButton4_Click">ENTER</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
                <div class="col-sm-3">
                    <asp:Panel ID="Panel4" runat="server">
                        <div class="thumbnail">
                            <asp:Image ID="Image1" CssClass="img-thumbnail" Height="170" ImageUrl="~/KMDIweb/Images/scheduling.jpg" runat="server" AlternateText="Screen Schedule" />
                            <br />
                            <strong style="font-size: x-large"><span class="glyphicon glyphicon-calendar"></span>
                                <span>Screen Schedule</span></strong>
                            <br />
                            <small>screen fabrication monitoring</small>
                            <asp:LinkButton ID="LinkButton2" Font-Size="Large" runat="server" CssClass="form-control btn btn-primary" OnClick="LinkButton2_Click">ENTER</asp:LinkButton>
                        </div>
                    </asp:Panel>
                </div>
                <div class="col-sm-3">
                    <asp:Panel ID="Panel1" runat="server">
                        <div class="thumbnail">
                            <asp:Image ID="Image2" CssClass="img-thumbnail" Height="170" ImageUrl="~/KMDIweb/Images/dr.jpg" runat="server" AlternateText="DR Reports" />
                            <br />
                            <div>
                                <strong style="font-size: x-large"><span class="glyphicon glyphicon-list-alt"></span>
                                    <span>DR Reports</span></strong><br />
                                <small>Uploaded DR Scanned fileS</small>
                                <asp:LinkButton ID="LinkButton1" Font-Size="Large" runat="server" CssClass="form-control btn btn-primary" OnClick="LinkButton1_Click">ENTER</asp:LinkButton>

                            </div>
                        </div>
                    </asp:Panel>
                </div>
                <div class="col-sm-3">
                    <asp:Panel ID="Panel2" Visible="false" runat="server">
                        <div class="thumbnail">
                            <asp:Image ID="Image4" CssClass="img-thumbnail" Height="170" ImageUrl="~/KMDIweb/Images/dr.jpg" runat="server" AlternateText="Collection Ledger" />
                            <br />
                            <div>
                                <strong style="font-size: x-large"><span class="glyphicon glyphicon-list-alt"></span>
                                    <span>Collection Ledger</span></strong><br />
                                <small>collection ledger</small>
                                <asp:LinkButton ID="LinkButton5" Font-Size="Large" runat="server" CssClass="form-control btn btn-primary" OnClick="LinkButton5_Click">ENTER</asp:LinkButton>

                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
