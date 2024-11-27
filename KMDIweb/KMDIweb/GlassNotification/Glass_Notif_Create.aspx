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
                <h3>Glass Notification | Create</h3>
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
                        <asp:GridView runat="server" ID="gvFind" Width="100%" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="gvFind_PageIndexChanging" PageSize="5" OnRowCommand="gvFind_RowCommand" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSelect" CommandName="view_po" ForeColor="#CC3333" runat="server">select</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PO">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPO" runat="server" Text='<%# Bind("PO") %>'></asp:Label>
                                        <asp:Label ID="lblJO" runat="server" Visible="false" Text='<%# Bind("JOB_ORDER_NO") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PROJECT">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProject_Name" runat="server" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PO DATE">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPO_Date" runat="server" Text='<%# Bind("PO_DATE") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                            <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F7F7F7" />
                            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                            <SortedDescendingCellStyle BackColor="#E5E5E5" />
                            <SortedDescendingHeaderStyle BackColor="#242121" />
                        </asp:GridView>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel panel-heading">
                        PO Items
                    </div>
                    <div class="panel-body">
                        <asp:GridView ID="gvPO_Items" runat="server" AutoGenerateColumns="false">
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
                                        <asp:Label ID="lblGlass_Specs" runat="server" Text='<%# Bind("Glass_Specs") %>'></asp:Label>
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
                        </asp:GridView>
                    </div>
                    <div class="panel panel-footer">
                        <asp:LinkButton runat="server" ID="btnProceed" CssClass="btn btn-success">Proceed</asp:LinkButton>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
