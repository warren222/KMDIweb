﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" CodeBehind="Glass_Notif_Edit.aspx.cs" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_Edit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass Notification | Edit</title>
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
            <h3>Glass Notification | Edit</h3>
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
        <asp:LinkButton ID="btnGet_PO_Items" runat="server" CssClass="btn btn-default" OnClick="btnGet_PO_Items_Click" Text="Show P.O."></asp:LinkButton>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Panel runat="server" ID="pnlPO_Items" Visible="false">
                    <div style="background-color: aqua; padding: 5px;">
                        <asp:Label ID="lblPO" runat="server"></asp:Label>
                    </div>
                    <div style="overflow-x: auto">
                        <asp:GridView ID="gvPO_Items" runat="server" Width="100%" CssClass="tblLocal" AutoGenerateColumns="False">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="text-center">
                                            <asp:CheckBox runat="server" ID="cboxSelect" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="K No.">
                                    <ItemTemplate>
                                        <asp:Label ID="lblK_No" runat="server" Text='<%# Bind("KMDI_NO") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="G No.">
                                    <ItemTemplate>
                                        <asp:Label ID="lblG_No" runat="server" Text='<%# Bind("G_NO") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Glass Specs">
                                    <ItemTemplate>
                                        <div style="white-space: normal; min-width: 150px;">
                                            <asp:Label ID="lblGlass_Specs" runat="server" Text='<%# Bind("Glass_Specs") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Width">
                                    <ItemTemplate>
                                        <div class="text-center">
                                            <asp:Label ID="lblWidth" runat="server" Text='<%# Bind("Width") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Height">
                                    <ItemTemplate>
                                        <div class="text-center">
                                            <asp:Label ID="lblHeight" runat="server" Text='<%# Bind("Height") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Qty">
                                    <ItemTemplate>
                                        <div class="text-center">
                                            <asp:Label ID="lblQty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Due Date">
                                    <ItemTemplate>
                                        <div class="text-center">
                                            <asp:Label ID="lblDue_Date" runat="server" Text='<%# Bind("Due_Date") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delivery Schedule">
                                    <ItemTemplate>
                                        <div class="text-center">
                                            <asp:Label ID="lblDelivery_Schedule" runat="server" Text='<%# Bind("GREQUEST") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:TextBox runat="server" ID="tboxReceivedQty" CssClass="form-control" Style="min-width: 80px;" TextMode="Number"></asp:TextBox>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Reason">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="tboxReason" CssClass="form-control" Style="min-width: 150px;"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <asp:LinkButton runat="server" ID="btnProceed" CssClass="btn btn-success" Style="border-radius: 0; width: 100%;" OnClick="btnProceed_Click1"><span class="glyphicon glyphicon-arrow-down"></span> Insert Selected Items</asp:LinkButton>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
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
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="execDelete" OnClientClick="return confirm('Delete this item?')">Delete</asp:LinkButton>
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
                            <asp:TemplateField HeaderText="Received Qty">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblReceivedQty" runat="server" Text='<%# Bind("Received_Qty") %>'></asp:Label>
                                        <asp:TextBox ID="tboxReceivedQtyEdit" Style="min-width: 80px;"
                                            runat="server" Visible="false" CssClass="form-control" TextMode="Number" Text='<%# Bind("Received_Qty") %>'></asp:TextBox>
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
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
