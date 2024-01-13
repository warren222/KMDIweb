<%@ Page Language="C#" MasterPageFile="~/KMDIweb/PO/PO.Master" AutoEventWireup="true" CodeBehind="PO_ForApproval.aspx.cs" Inherits="KMDIweb.KMDIweb.PO.PO_ForApproval" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass Purchase Order</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2 class="text-center">Glass Purchase Order</h2>
        </div>
        <div class="well">
            <div class="row">
                <div class="col-sm-6">
                    For Signature
                    <asp:DropDownList ID="ddlForSignature" runat="server" CssClass="form-control">
                        <asp:ListItem Value="All" Text="All" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="Prepared by" Text="Prepared by"></asp:ListItem>
                        <asp:ListItem Value="Requested by" Text="Requested by"></asp:ListItem>
                        <asp:ListItem Value="Noted by" Text="Noted by"></asp:ListItem>
                        <asp:ListItem Value="Approved by" Text="Approved by"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-sm-6">
                    Search
                    <div class="input-group">
                        <asp:TextBox ID="tboxsearchkey" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="row">
                    <div class="col-sm-2">
                    </div>
                    <div class="col-sm-8">
                        <div style="overflow-x: auto">
                            <asp:GridView ID="GridView1" AutoGenerateColumns="false" AllowPaging="true" ShowHeader="false" Width="100%" GridLines="None" runat="server"
                                OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class='<%# Eval("Web_Approved_By").ToString() == "" ? "panel panel-danger" : "panel panel-success" %>'>
                                                <div class="panel-heading">
                                                    <asp:Label runat="server" ID="lblPONO" CommandName="view_request" Text='<%# Bind("NO") %>'></asp:Label>
                                                    <asp:Label runat="server" ID="lblJONO" Visible="false" Text='<%# Bind("JONO") %>'></asp:Label>
                                                </div>
                                                <div class=" panel-body">
                                                    <asp:LinkButton ID="btnProjectLabel" CommandName="view_request" runat="server">
                                                           <span style="font-size: large; font-weight: bold;"><%# Eval("PROJECT_LABEL") %></span>
                                                    </asp:LinkButton>
                                                    <br />
                                                    <span style="font-size: x-small" class="text-muted"><%# Eval("FULLADD") %></span><br />
                                                    <span style="font-size: x-small" class="text-muted"><%# Eval("JONO") %></span><br />

                                                    <span style="font-size: large;"><%# Eval("DATE") %></span><br />

                                                    <span class="pull-right text-center">
                                                        <span style="font-size: medium" class="text-info"><%# Eval("SUPPLIER") %></span><br />
                                                        <span style="font-size: x-small" class="text-info"><%# Eval("ADDRESS") %></span><br />
                                                    </span>

                                                </div>
                                                <div class="row">
                                                    <div class="col-xs-3">
                                                        <asp:Image ID="Image1" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/PO/" + Eval("NO").ToString() + "/Signatures/Web_Prepared_By.jpg" %>' />
                                                        <br />
                                                        <span><%# Eval("Web_Prepared_By") %></span><br />
                                                        <span class="text-muted">Prepared by:</span>
                                                    </div>
                                                    <div class="col-xs-3">
                                                        <asp:Image ID="Image4" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/PO/" + Eval("NO").ToString() + "/Signatures/Web_Requested_By.jpg" %>' />
                                                        <br />
                                                        <span><%# Eval("Web_Requested_By") %></span><br />
                                                        <span class="text-muted">Requested by:</span>
                                                    </div>
                                                    <div class="col-xs-3">
                                                        <asp:Image ID="Image2" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/PO/" + Eval("NO").ToString() + "/Signatures/Web_Noted_By.jpg" %>' />
                                                        <br />
                                                        <span><%# Eval("Web_Noted_By") %></span><br />
                                                        <span class="text-muted">Noted by:</span>
                                                    </div>
                                                    <div class="col-xs-3">
                                                        <asp:Image ID="Image3" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/PO/" + Eval("NO").ToString() + "/Signatures/Web_Approved_By.jpg" %>' />
                                                        <br />
                                                        <span><%# Eval("Web_Approved_By") %></span><br />
                                                        <span class="text-muted">Approved by:</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="alert alert-info">
                                        <h3><strong>Empty Table!</strong>
                                        </h3>
                                    </div>
                                </EmptyDataTemplate>
                                <EditRowStyle BorderStyle="None" BorderWidth="0px" />
                                <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                                <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                            </asp:GridView>
                        </div>
                    </div>
                    <div class="col-sm-2">
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
