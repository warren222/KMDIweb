<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" CodeBehind="Glass_Notif_Create.aspx.cs" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_Create" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Imported Glass | P.O</title>
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
                <h3>Glass Notification Create</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div>
            <div class="container">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="form-group">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon" id="basic-addon1">FIND PO</span>
                                        <asp:TextBox ID="tboxFind" runat="server" CssClass="form-control"></asp:TextBox>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" Style="background-color: #ff006e; border-color: #ff006e" OnClick="btnFind_Click">GO</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="panel-body">
                        <asp:GridView runat="server" ID="gvFind" Width="100%" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSelect" runat="server">select</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="lblPO" runat="server" Text='<%# Bind("PO") %>'></asp:Label>
                                        <asp:Label ID="lblJO" runat="server" Visible="false" Text='<%# Bind("JOB_ORDER_NO") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="lblProject_Name" runat="server" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                        <asp:Label ID="lblPO_Date" runat="server" Text='<%# Bind("PO_DATE") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
