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
                <div class="panel panel-success">
                <div class="panel-heading text-center">
                    <h2>Attendance</h2>
                </div>
                <div class="panel-body">
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:LinkButton ID="LinkButton8" Font-Size="Large" runat="server" CssClass="form-control btn btn-success" OnClick="LinkButton8_Click">Time in</asp:LinkButton>
                           <br />
                            <div class="text-center">
                                   <h3>
                                       <asp:Label ID="lblToday" runat="server" Text="Label"></asp:Label><span class="text-muted"> LOG</span></h3>
                            </div>
                             <asp:GridView ID="GridView1" ShowHeader="false" CssClass="table" AutoGenerateColumns="False" Width="100%" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:TemplateField HeaderStyle-CssClass="text-center" HeaderText="Log">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <asp:Label ID="Label1" runat="server" Font-Size="Larger" Text='<%# Bind("Time") %>'></asp:Label>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EditRowStyle BackColor="#7C6F57" />
                                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#E3EAEB" />
                                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                                <SortedAscendingHeaderStyle BackColor="#246B61" />
                                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                                <SortedDescendingHeaderStyle BackColor="#15524A" />
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="panel-footer">
                </div>
            </div>
            <br />
            <h2><strong class="text-muted">WEB applications</strong>  </h2>
            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" CssClass="alert alert-danger" runat="server" />
            <div class="row">
                <div class="col-sm-3">
                    <asp:Panel ID="Panel3" runat="server">
                        <div class="thumbnail">
                            <asp:Image ID="Image3" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/scheduling.jpg" runat="server" AlternateText="Screen Schedule" />
                            <br />
                            <strong style="font-size: large"><span class="glyphicon glyphicon-calendar"></span>
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
                            <asp:Image ID="Image1" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/scheduling.jpg" runat="server" AlternateText="Screen Schedule" />
                            <br />
                            <strong style="font-size: large"><span class="glyphicon glyphicon-calendar"></span>
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
                            <asp:Image ID="Image2" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/dr.jpg" runat="server" AlternateText="DR Reports" />
                            <br />
                            <div>
                                <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
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
                            <asp:Image ID="Image4" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/collection.jpg" runat="server" AlternateText="Collection Ledger" />
                            <br />
                            <div>
                                <strong style="font-size: large"><span class="glyphicon glyphicon-list-alt"></span>
                                    <span>Collection Ledger</span></strong><br />
                                <small>collection ledger</small>
                                <asp:LinkButton ID="LinkButton5" Font-Size="Large" runat="server" CssClass="form-control btn btn-primary" OnClick="LinkButton5_Click">ENTER</asp:LinkButton>

                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-sm-3">
                    <asp:Panel ID="Panel5" Visible="false" runat="server">
                        <div class="thumbnail">
                            <asp:Image ID="Image5" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/installation.jpg" runat="server" AlternateText="installation schedule" />
                            <br />
                            <div>
                                <strong style="font-size: x-large"><span class="glyphicon glyphicon-list-alt"></span>
                                    <span>Installation</span></strong><br />
                                <small>installation schedule</small>
                                <asp:LinkButton ID="LinkButton6" Font-Size="Large" runat="server" CssClass="form-control btn btn-primary" OnClick="LinkButton6_Click">ENTER</asp:LinkButton>

                            </div>
                        </div>
                    </asp:Panel>
                </div>
                <div class="col-sm-3">
                    <asp:Panel ID="Panel6" runat="server">
                        <div class="thumbnail">
                            <asp:Image ID="Image6" CssClass="img-thumbnail img-circle ff" Height="170" Width="170" ImageUrl="~/KMDIweb/Images/termo.jpg" runat="server" AlternateText="installation schedule" />
                            <br />
                            <div>
                                <strong style="font-size: x-large"><span class="glyphicon glyphicon-list-alt"></span>
                                    <span>DHP</span></strong><br />
                                <small>Daily Health Profile</small>
                                <asp:LinkButton ID="LinkButton7" Font-Size="Large" runat="server" CssClass="form-control btn btn-primary" PostBackUrl="http://dhp.kennethandmock.com">ENTER</asp:LinkButton>

                            </div>
                        </div>
                    </asp:Panel>
                </div>

            </div>
       
        </div>
    </form>
</body>
</html>
