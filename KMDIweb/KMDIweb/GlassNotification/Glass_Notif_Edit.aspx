<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" CodeBehind="Glass_Notif_Edit.aspx.cs" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_Edit" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass Notification | Edit</title>
    <style>
        .nowraptxt {
            white-space: nowrap;
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

        <asp:GridView ID="gvPO_Items" runat="server" Width="100%" CssClass="tb" AutoGenerateColumns="False" BackColor="White" 
            BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="cboxSelect" />
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
                        <div style="white-space: normal">
                            <asp:Label ID="lblGlass_Specs" runat="server" Text='<%# Bind("Glass_Specs") %>'></asp:Label>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Width">
                    <ItemTemplate>
                        <asp:Label ID="lblWidth" runat="server" Text='<%# Bind("Width") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Height">
                    <ItemTemplate>
                        <asp:Label ID="lblHeight" runat="server" Text='<%# Bind("Height") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Qty">
                    <ItemTemplate>
                        <asp:Label ID="lblQty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Due Date">
                    <ItemTemplate>
                        <asp:Label ID="lblDue_Date" runat="server" Text='<%# Bind("Due_Date") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Delivery Schedule">
                    <ItemTemplate>
                        <asp:Label ID="lblDelivery_Schedule" runat="server" Text='<%# Bind("GREQUEST") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Reason">
                    <ItemTemplate>
                        <asp:TextBox runat="server" ID="tboxReason" CssClass="form-control"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <RowStyle BackColor="White" ForeColor="#330099" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <SortedAscendingCellStyle BackColor="#FEFCEB" />
            <SortedAscendingHeaderStyle BackColor="#AF0101" />
            <SortedDescendingCellStyle BackColor="#F6F0C0" />
            <SortedDescendingHeaderStyle BackColor="#7E0000" />
        </asp:GridView>


        <asp:GridView ID="gvtem" runat="server" BackColor="White" AutoGenerateColumns="false" Width="100%"
            CssClass="nowraptxt" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="None" OnRowCommand="gvtem_RowCommand">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="lblId" Visible="false" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                        <asp:Label ID="lblGlass_PO_Notification_Id" Visible="false" runat="server" Text='<%# Bind("Glass_PO_Notification_Id") %>'></asp:Label>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="execDelete">Delete</asp:LinkButton>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="execEdit">Edit</asp:LinkButton>
                        <asp:LinkButton ID="btnSave" runat="server" Visible="false" CommandName="execSave">Save</asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" Visible="false" CommandName="execCancel">Cancel</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="K#">
                    <ItemTemplate>
                        <asp:Label ID="lblK_No_Item" runat="server" Text='<%# Bind("K_No") %>'></asp:Label>
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
                        <asp:Label ID="lblWidth_Item" runat="server" Text='<%# Bind("Width") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Height">
                    <ItemTemplate>
                        <asp:Label ID="lblHeight_Item" runat="server" Text='<%# Bind("Height") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Qty">
                    <ItemTemplate>
                        <asp:Label ID="lblQty_Item" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Due Date">
                    <ItemTemplate>
                        <asp:Label ID="lblDue_Date_Item" runat="server" Text='<%# Bind("Due_Date") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Delivery Schedule">
                    <ItemTemplate>
                        <asp:Label ID="lblDelivery_Schedule_Item" runat="server" Text='<%# Bind("Delivery_Schedule") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Reason">
                    <ItemTemplate>
                        <asp:Label ID="lblReason_Item" runat="server" Text='<%# Bind("Reason") %>'></asp:Label>
                        <asp:TextBox runat="server" ID="tboxReasonEdit" Visible="false" CssClass="form-control" Text='<%# Bind("Reason") %>'></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#594B9C" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#33276A" />
        </asp:GridView>
    </div>
</asp:Content>
