<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Glass_Notif_Updates.aspx.cs" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_Updates" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass | Notification Update</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }

        .bcRed {
            background-color: red;
            color: white;
        }

        .bcOrange {
            background-color: orange;
            color: white;
        }

        .bcBlue {
            background-color: aqua;
            color: black;
        }

        .bcYellow {
            background-color: yellow;
            color: black;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>Glass Notification Updates</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="container">

            <div class="row nopm">
                <div class="col-sm-2 nopm">
                    <div style="padding: 9px; background-color: whitesmoke; font-size: medium; border: 1px solid bisque;" class="text-center">
                        <span>New Updates</span>
                    </div>
                    <div class="text-center" style="padding: 10px; border: 1px solid bisque; background-color: white;">
                        <asp:LinkButton ID="btnBadge" CssClass="badge bcRed" Font-Bold="true" runat="server" Font-Size="X-Large" OnClick="btnBadge_Click"></asp:LinkButton>
                    </div>
                </div>
                <div class="col-sm-5 nopm">
                    <div class="well" style="border-radius: 0;">
                        <span>Search</span>
                        <div class="input-group">
                            <asp:TextBox runat="server" ID="tboxFind" CssClass="form-control"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-danger" Style="background-color: #ff006e; border-color: #ff006e" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <div style="overflow-x: auto" class="nopm">
                <asp:GridView runat="server" ID="gvUpdates" Width="100%"
                    AutoGenerateColumns="false"
                    GridLines="None"
                    AllowPaging="True"
                    Style="min-width: 700px;" OnRowCommand="gvUpdates_RowCommand" OnPageIndexChanging="gvUpdates_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="panel panel-default" style='border-color: <%# Eval("Notify").ToString() == "1" ? "#ff8080" : "#80ffa2" %>'>
                                    <div class="panel-heading" style='background-color: <%# Eval("Notify").ToString() == "1" ? "#ff8080" : "#80ffa2" %>'>
                                        <asp:Label runat="server" ID="lblId" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                        <asp:Label runat="server" ID="lblPO" Visible="false" Text='<%# Bind("PO") %>'></asp:Label>
                                        <asp:Label runat="server" ID="lblJO" Visible="false" Text='<%# Bind("JO") %>'></asp:Label>
                                        <asp:Label runat="server" ID="lblControl_No" Text='<%# Bind("Control_No") %>'></asp:Label>
                                        <span class="pull-right">
                                            <span><%# Eval("Glass_Update") %></span>
                                        </span>
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
                                    <div class="panel-footer">
                                        <div class="row nopm text-center" style="font-size: small">
                                            <div class="col-sm-4">
                                                <span><%# Eval("View_PM").ToString().Replace("/","<br/>") %></span>
                                            </div>
                                            <div class="col-sm-4">
                                                <span><%# Eval("View_Received").ToString().Replace("/","<br/>") %></span>
                                            </div>
                                            <div class="col-sm-4">
                                                <span><%# Eval("View_IM").ToString().Replace("/","<br/>") %></span>
                                            </div>
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
