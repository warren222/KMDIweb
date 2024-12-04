<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Glass_Notif_List.aspx.cs" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_List" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass | Notification</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>Glass Notification</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="container">
            <asp:LinkButton ID="btnCreate" runat="server" CssClass="btn btn-danger" Style="background-color: #ff006e; border-color: #ff006e" OnClick="btnCreate_Click">Create New Notification</asp:LinkButton>
        </div>
        <br />
        <div class="well">
            <div class="row">
                <div class="col-sm-6"></div>
                <div class="col-sm-4">
                    <span>Find</span>
                    <div class="input-group">
                        <asp:TextBox runat="server" ID="tboxFind" CssClass="form-control"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-danger" Style="background-color: #ff006e; border-color: #ff006e" OnClick="LinkButton1_Click">GO</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="col-sm-1">
                </div>
                <div class="col-sm-1"></div>
            </div>
        </div>
        <div class="">
        </div>
        <div class="container">
            <div style="overflow-x: auto">
                <asp:GridView ID="gvGlassNotifList" runat="server" Width="100%"
                    OnPageIndexChanging="gvGlassNotifList_PageIndexChanging"
                    AutoGenerateColumns="false" GridLines="None" AllowPaging="True"
                    OnRowCommand="gvGlassNotifList_RowCommand" PageSize="2">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="panel panel-danger">
                                    <div class="panel-heading">
                                        <asp:Label runat="server" ID="lblId" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                        <asp:Label runat="server" ID="lblControl_No" CommandName="view_notification" Text='<%# Bind("Control_No") %>'></asp:Label>
                                    </div>
                                    <div class="panel-body">
                                        <asp:LinkButton ID="btnProject_Name" CommandName="view_notification" runat="server">
                                        <span style="font-size: large; font-weight: bold;"><%# Eval("Project_Name") %></span>
                                        </asp:LinkButton>
                                        <br />
                                        <span style="font-size: small"><%# Eval("Supplier") %></span><br />
                                        <span style="font-size: small"><%# Eval("PO") %></span><br />
                                        <span style="font-size: small;" class="text-muted"><%# Eval("Date_Filed") %></span><br />
                                    </div>
                                    <div class="row nopm">
                                        <div class="col-xs-3 nopm">
                                            <asp:Image ID="Image1" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/Glass_Notification/" + Eval("Control_No").ToString() + "/Signatures/Prepared_By.jpg" %>' />
                                            <br />
                                            <span><%# Eval("Prepared_By") %></span><br />
                                            <span style="font-size: smaller"><%# Eval("Prepared_By_Date") %></span><br />
                                            <span class="text-muted">Prepared by:</span>
                                        </div>
                                        <div class="col-xs-3 nopm">
                                            <asp:Image ID="Image2" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/Glass_Notification/" + Eval("Control_No").ToString() + "/Signatures/Noted_By_PM.jpg" %>' />
                                            <br />
                                            <span><%# Eval("Noted_By_PM") %></span><br />
                                            <span style="font-size: smaller"><%# Eval("Noted_By_PM_Date") %></span><br />
                                            <span class="text-muted">Noted by:</span>
                                        </div>
                                        <div class="col-xs-3 nopm">
                                            <asp:Image ID="Image3" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/Glass_Notification/" + Eval("Control_No").ToString() + "/Signatures/Received_By.jpg" %>' />
                                            <br />
                                            <span><%# Eval("Received_By") %></span><br />
                                            <span style="font-size: smaller"><%# Eval("Received_By_Date") %></span><br />
                                            <span class="text-muted">Received by:</span>
                                        </div>
                                        <div class="col-xs-3 nopm">
                                            <asp:Image ID="Image4" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/Glass_Notification/" + Eval("Control_No").ToString() + "/Signatures/Noted_By_IM.jpg" %>' />
                                            <br />
                                            <span><%# Eval("Noted_By_IM") %></span><br />
                                            <span style="font-size: smaller"><%# Eval("Noted_By_IM_Date") %></span><br />
                                            <span class="text-muted">Noted by:</span>
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
    </div>
</asp:Content>
