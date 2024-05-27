<%@ Page Language="C#" MasterPageFile="~/KMDIweb/PO/PO.Master" AutoEventWireup="true" CodeBehind="PO_ForApproval.aspx.cs" Inherits="KMDIweb.KMDIweb.PO.PO_ForApproval" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass Purchase Order</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <div class="container text-left">
                <h2>Glass PO Request</h2>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="row">
            <div class="col-sm-6">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvSummary" ShowHeader="false" GridLines="None" Width="100%" AutoGenerateColumns="false" runat="server" OnRowCommand="gvSummary_RowCommand" PageSize="1" OnRowDataBound="gvSummary_RowDataBound">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <table border="1" style="border-color: bisque;" class="wf_tbl">
                                            <tr>
                                                <th style="background-color: yellow" class="text-center" colspan="3">For Signature</th>
                                                <th style="background-color: green; color: white;" class="text-center">Status</th>
                                            </tr>
                                            <tr class="text-center">
                                                <td style="width: 100px;">Prepared by</td>
                                                <td style="width: 100px;">Noted by</td>
                                                <td style="width: 100px;">Approved by</td>
                                                <td style="width: 100px;">Approved</td>
                                            </tr>
                                            <tr class="text-center">
                                                <td>
                                                    <asp:LinkButton ID="btnPreparedBy" CssClass="badge" BackColor="Red" CommandName="PreparedBy" ForeColor="white" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Prepared_By") %></span></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btnNotedBy" CssClass="badge" BackColor="Red" CommandName="NotedBy" ForeColor="white" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Noted_By") %></span></asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="btnApprvoedBy" CssClass="badge" BackColor="Red" CommandName="ApprovedBy" ForeColor="white" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Approved_By") %></span></asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="btnApproved" CommandName="Done" runat="server"><span style="font-size: xx-large; color:green"><%# Eval("Notif_Approved") %></span></asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="col-sm-6">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="well">
                              <div class="row">
                                <div class="col-sm-4">
                                    <span>Date Filter</span>
                                    <asp:DropDownList runat="server" ID="ddlDateFilter" CssClass="form-control">
                                        <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                        <asp:ListItem Value="Date Prepared" Text="Date Prepared"></asp:ListItem>
                                        <asp:ListItem Value="Date Noted" Text="Date Noted"></asp:ListItem>
                                        <asp:ListItem Value="Date Approved" Text="Date Approved"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-8">
                                    <span>Date</span>
                                    <asp:TextBox runat="server" ID="tboxDate" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <asp:Label ID="lblForSignature" runat="server">For Signature</asp:Label>
                                    <asp:DropDownList ID="ddlForSignature" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="All" Text="All" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="Prepared by" Text="Prepared by"></asp:ListItem>
                                        <asp:ListItem Value="Noted by" Text="Noted by"></asp:ListItem>
                                        <asp:ListItem Value="Approved by" Text="Approved by"></asp:ListItem>
                                        <asp:ListItem Value="Approved" Text="(status)Approved"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-8">
                                    <span>Search</span>
                                    <div class="input-group">
                                        <asp:TextBox ID="tboxsearchkey" CssClass="form-control" runat="server"></asp:TextBox>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>              
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="row" style="padding: 0px; margin: 0px;">
                    <div class="col-sm-2" style="padding: 0px; margin: 0px;">
                    </div>
                    <div class="col-sm-8" style="padding: 0px; margin: 0px;">
                        <div style="overflow-x: auto; overflow-y: unset">
                            <asp:GridView ID="GridView1" AutoGenerateColumns="false" AllowPaging="true" ShowHeader="false" Width="98%" GridLines="None" runat="server"
                                OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class='<%# Eval("Web_Approved_By").ToString() == "" ? "panel panel-danger" : "panel panel-success" %>'>
                                                <div class="panel-heading">
                                                    <asp:Label runat="server" ID="lblPONO" CommandName="view_request" Text='<%# Bind("NO") %>'></asp:Label>
                                                    <asp:Label runat="server" ID="lblJONO" Visible="false" Text='<%# Bind("JONO") %>'></asp:Label>
                                                    <asp:Label runat="server" ID="lblREQUESTED" Visible="false" Text='<%# Bind("REQUESTED") %>'></asp:Label>
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
                                                    <div class="col-xs-4">
                                                        <asp:Image ID="Image1" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/PO/" + Eval("NO").ToString() + "/Signatures/Web_Prepared_By.jpg" %>' />
                                                        <br />
                                                        <span><%# Eval("Web_Prepared_By") %></span><br />
                                                        <span class="text-muted">Prepared by:</span>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <asp:Image ID="Image2" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/PO/" + Eval("NO").ToString() + "/Signatures/Web_Noted_By.jpg" %>' />
                                                        <br />
                                                        <span><%# Eval("Web_Noted_By") %></span><br />
                                                        <span class="text-muted">Noted by:</span>
                                                    </div>
                                                    <div class="col-xs-4">
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
                    <div class="col-sm-2" style="padding: 0px; margin: 0px;">
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
