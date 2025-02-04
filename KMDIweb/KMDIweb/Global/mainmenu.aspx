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
        .ff {
            object-fit: cover;
        }

        .vl {
            border-left: 1px solid white;
            color: white;
        }

            .vl:hover {
                color: white;
                font-style: normal;
            }

        body, html {
            background-color: #bfbfbf;
        }

        .headerbanner {
            background-color: #303030;
            border-bottom: solid 5px #ff006e;
            color: white;
            padding: 10px;
        }

        .myopacity {
            opacity: 0.5;
        }

        .btnstyle {
            background-color: #ff006e;
            border-color: #ff006e
        }
    </style>
</head>
<body style="font-family: Bahnschrift">
    <form id="form1" runat="server">

        <div class="headerbanner">
            <div class="container">

                <div class="row">
                    <div class="col-sm-6">
                        <span><span style="font-size: 20px;">Kenneth & Mock Web Application</span> </span>
                    </div>
                    <div class="col-sm-6">
                        <div class="navbar-right">
                            <asp:LinkButton ID="LinkButton3" CssClass="vl" runat="server" OnClick="LinkButton3_Click">&nbsp;&nbsp;Log out</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="">
            <div class="row">
                <div class="col-xs-1">
                </div>
                <div class="col-xs-10">
                    <h2><strong class="">Main Menu</strong>  </h2>
                    <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" CssClass="alert alert-danger" runat="server" />
                    <div style="height: auto; display: flex; flex-flow: row wrap; width: auto; padding: 2px;">

                        <asp:Panel ID="Panel3" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image3" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/scheduling.jpg" runat="server" AlternateText="Screen Schedule" />
                                <br />
                                <strong style="font-size: large"><span class="glyphicon glyphicon-calendar"></span>
                                    <span>Frame Schedule</span></strong>
                                <br />
                                <small>Frame fabrication monitoring</small>
                                <asp:LinkButton ID="LinkButton4" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton4_Click">ENTER</asp:LinkButton>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel4" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image1" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/scheduling.jpg" runat="server" AlternateText="Screen Schedule" />
                                <br />
                                <strong style="font-size: large"><span class="glyphicon glyphicon-calendar"></span>
                                    <span>Screen Schedule</span></strong>
                                <br />
                                <small>screen fabrication monitoring</small>
                                <asp:LinkButton ID="LinkButton2" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton2_Click">ENTER</asp:LinkButton>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel1" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image2" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/dr.jpg" runat="server" AlternateText="DR Reports" />
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>DR Reports</span></strong><br />
                                    <small>Uploaded DR Scanned fileS</small>
                                    <asp:LinkButton ID="LinkButton1" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton1_Click">ENTER</asp:LinkButton>

                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel2" Visible="false" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image4" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/collection.jpg" runat="server" AlternateText="Collection Ledger" />
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>Collection Ledger</span></strong><br />
                                    <small>collection ledger</small>
                                    <asp:LinkButton ID="LinkButton5" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton5_Click">ENTER</asp:LinkButton>

                                </div>
                            </div>
                        </asp:Panel>


                        <asp:Panel ID="Panel5" Visible="false" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image5" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/installation.jpg" runat="server" AlternateText="installation schedule" />
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>Installation</span></strong><br />
                                    <small>installation schedule</small>
                                    <asp:LinkButton ID="LinkButton6" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton6_Click">ENTER</asp:LinkButton>

                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel6" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image6" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/termo.jpg" runat="server" AlternateText="installation schedule" />
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>DHP</span></strong><br />
                                    <small>Daily Health Profile</small>
                                    <asp:LinkButton ID="LinkButton7" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" PostBackUrl="http://dhp.kennethandmock.com">ENTER</asp:LinkButton>

                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel7" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image7" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/scheduling.jpg" runat="server" AlternateText="installation schedule" />
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>Foiling</span></strong><br />
                                    <small>Foiling Calendar</small>
                                    <asp:LinkButton ID="LinkButton8" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" PostBackUrl="~/KMDIweb/FoilingSchedule/FoilingCalendar.aspx">ENTER</asp:LinkButton>

                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlAF" Visible="false" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image8" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/collection.jpg" runat="server" AlternateText="AF" />
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>AF</span></strong><br />
                                    <small>AF Request</small>
                                    <asp:LinkButton ID="LinkButton9" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton9_Click">ENTER</asp:LinkButton>

                                </div>
                            </div>
                        </asp:Panel>


                        <asp:Panel ID="pnlAC" Visible="false" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image9" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/dr.jpg" runat="server" AlternateText="Accounting Clearance" />
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>Accg Clearance</span></strong><br />
                                    <small>Requisition</small>
                                    <asp:LinkButton ID="LinkButton10" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton10_Click">ENTER</asp:LinkButton>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlPO" Visible="false" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image10" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/dr.jpg" runat="server" AlternateText="Glass PO" />
                                <span class="pull-right">
                                    <asp:Label ID="lblGlassPOCounter" runat="server" Font-Size="XX-Large" CssClass="badge"></asp:Label>
                                </span>
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>Glass P.O.</span></strong><br />
                                    <small>Purchase Order</small>
                                    <asp:LinkButton ID="LinkButton11" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton11_Click">ENTER</asp:LinkButton>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlPI" Visible="true" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image11" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/house.jpg" runat="server" AlternateText="Project Photos" />
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>Photos</span></strong><br />
                                    <small>Poject Photos</small>
                                    <asp:LinkButton ID="LinkButton12" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton12_Click">ENTER</asp:LinkButton>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlMeiheng" Visible="true" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image12" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/Clear-Glass.jpg" runat="server" AlternateText="Project Photos" />
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>Imported Glass Order</span></strong><br />
                                    <small>P.O</small>
                                    <asp:LinkButton ID="LinkButton13" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton13_Click">ENTER</asp:LinkButton>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlGlassPONotif" Visible="false" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image13" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/G03.jpg" runat="server" AlternateText="Project Photos" />
                                <span class="pull-right">
                                    <asp:Label ID="lblGlassNotifCounter" runat="server" Font-Size="XX-Large" CssClass="badge"></asp:Label>
                                </span>
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>Glass Notification</span></strong><br />
                                    <small>P.O Notification</small>
                                    <asp:LinkButton ID="LinkButton14" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton14_Click">ENTER</asp:LinkButton>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="Panel8" Visible="false" runat="server" Width="250px">
                            <div class="thumbnail">
                                <asp:Image ID="Image14" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/G03.jpg" runat="server" AlternateText="Project Photos" />
                                <span class="pull-right">
                                    <asp:Label ID="Label1" runat="server" Font-Size="XX-Large" CssClass="badge"></asp:Label>
                                </span>
                                <br />
                                <div>
                                    <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                        <span>PRF</span></strong><br />
                                    <small>Online PRF</small>
                                    <asp:LinkButton ID="LinkButton15" Font-Size="Large" runat="server" CssClass="form-control btn btn-danger btnstyle" OnClick="LinkButton15_Click">ENTER</asp:LinkButton>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
                <div class="col-xs-1">
                </div>
            </div>
        </div>
    </form>
</body>
</html>
