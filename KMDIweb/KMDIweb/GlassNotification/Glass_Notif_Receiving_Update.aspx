<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" CodeBehind="Glass_Notif_Receiving_Update.aspx.cs" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_Receiving_Update" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass Notification | Updates</title>
    <style>
        .nowraptxt {
            white-space: nowrap;
        }

        .tblLocal {
            font-family: Calibri;
            white-space: nowrap;
            white-space: nowrap;
        }

            .tblLocal th, tr, td {
                padding-left: 5px;
                padding-right: 5px;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
        <div class="container">
            <h3>Glass Notification | Updates</h3>
        </div>
        <span class="pull-right">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-warning" ForeColor="Black" OnClick="btnBack_Click"><span class="glyphicon glyphicon-chevron-left"></span> back</asp:LinkButton>
        </span>
    </div>
    <div class="container">
        <div>
            <asp:GridView ID="gvSelectNotif" BorderStyle="None" GridLines="None" ShowHeader="false"
                Style="font-family: Calibri; white-space: nowrap;" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div style="font-size: medium;">
                                <span><%# Eval("Project_Name") %></span><br />
                                <span><%# Eval("Supplier") %></span><br />
                                <span><%# Eval("Date_Filed") %></span><br />
                                <span><%# Eval("Control_No") %></span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <br />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div style="background-color: #ff006e; color: white; padding: 5px;">Notification Items</div>
                <div style="overflow-x: auto;">
                    <asp:GridView ID="gvtem" runat="server" AutoGenerateColumns="False"
                        Width="100%"
                        CssClass="tblLocal" OnRowCommand="gvtem_RowCommand">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblId" Visible="false" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                                    <asp:Label ID="lblGlass_PO_Notification_Id" Visible="false" runat="server" Text='<%# Bind("Glass_PO_Notification_Id") %>'></asp:Label>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="execEdit">Edit</asp:LinkButton>
                                    <asp:LinkButton ID="btnSave" runat="server" Visible="false" CommandName="execSave">Save</asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" Visible="false" CommandName="execCancel">Cancel</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="K#">
                                <ItemTemplate>
                                    <span><%# Eval("K_No") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="G#">
                                <ItemTemplate>
                                    <asp:Label ID="lblG_No_Item" runat="server" Text='<%# Bind("G_No") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Glass Specs">
                                <ItemTemplate>
                                    <asp:Label ID="lblGlass_Specs_Item" runat="server" Text='<%# Bind("Glass_Specs") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Width">
                                <ItemTemplate>
                                    <div class="text-center">
                                        <asp:Label ID="lblWidth_Item" runat="server" Text='<%# Bind("Width") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Height">
                                <ItemTemplate>
                                    <div class="text-center">
                                        <asp:Label ID="lblHeight_Item" runat="server" Text='<%# Bind("Height") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Qty">
                                <ItemTemplate>
                                    <div class="text-center">
                                        <asp:Label ID="lblQty_Item" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Due Date">
                                <ItemTemplate>
                                    <div class="text-center">
                                        <asp:Label ID="lblDue_Date_Item" runat="server" Text='<%# Bind("Due_Date") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delivery Schedule">
                                <ItemTemplate>
                                    <div class="text-center">
                                        <asp:Label ID="lblDelivery_Schedule_Item" runat="server" Text='<%# Bind("Delivery_Schedule") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="New Received Qty">
                                <ItemTemplate>
                                    <asp:TextBox ID="tboxReceivedQtyEdit" Style="min-width: 80px;"
                                        runat="server" Visible="false" CssClass="form-control" TextMode="Number" Text='<%# Bind("Received_Qty") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Received Qty">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblReceivedQty" runat="server" Text='<%# Bind("Received_Qty") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TOT. Received">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblTotalReceived" runat="server" Text='<%# Bind("Total_Received") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Reason">
                                <ItemTemplate>
                                    <asp:Label ID="lblReason_Item" runat="server" Text='<%# Bind("Reason") %>'></asp:Label>
                                    <asp:TextBox runat="server" ID="tboxReasonEdit" Visible="false" Style="min-width: 150px;"
                                        CssClass="form-control" Text='<%# Bind("Reason") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:LinkButton runat="server" ID="btnSubmit" CssClass="btn btn-success" Style="border-radius: 0; width: 100%;"><span class="glyphicon glyphicon-send"></span>  Submit</asp:LinkButton>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
