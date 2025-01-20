<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" CodeBehind="Glass_Notif_Create.aspx.cs" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_Create" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Imported Glass | P.O</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
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

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>Glass Notification | Create</h3>
            </div>
            <span class="pull-right">
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-warning" ForeColor="Black" OnClick="btnBack_Click"><span class="glyphicon glyphicon-chevron-left"></span> back</asp:LinkButton>
            </span>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div>
            <div class="container">

                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>


                        <div class="row">
                            <div class="col-md-6">
                                <span>Find P.O.</span>
                                <div class="input-group">

                                    <asp:TextBox ID="tboxFind" runat="server" CssClass="form-control"></asp:TextBox>
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" Style="background-color: #ff006e; border-color: #ff006e" OnClick="btnFind_Click">GO</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <br />




                        <div style="background-color: #303030; padding: 5px; color: white; border: 1px #7b7b7b solid; border-bottom: 0px;">
                            <span>P.O. Source Table</span>
                        </div>
                        <div style="overflow-x: auto">
                            <asp:GridView runat="server" ID="gvFind" Width="100%" AutoGenerateColumns="False" AllowPaging="True" CssClass="tblLocal"
                                OnPageIndexChanging="gvFind_PageIndexChanging" PageSize="5" OnRowCommand="gvFind_RowCommand" BackColor="White"
                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnSelect" CommandName="view_po" runat="server">select</asp:LinkButton>
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
                                            <asp:Label ID="lblAddress" runat="server" Visible="false" Text='<%# Bind("Full_Address") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PO DATE">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPO_Date" runat="server" Text='<%# Bind("PO_DATE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SUPPLIER">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSupplier" runat="server" Text='<%# Bind("Supplier") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                <EmptyDataTemplate>
                                    <div class="alert alert-info">
                                        <h3><strong>Empty Table!</strong>
                                        </h3>
                                    </div>
                                </EmptyDataTemplate>
                                <PagerSettings PageButtonCount="8" Position="Bottom" />
                                <PagerStyle CssClass="GridPager" BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                <RowStyle ForeColor="#000066" />
                                <SelectedRowStyle BackColor="#303030" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#00547E" />
                            </asp:GridView>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <br />
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="pnl" Visible="false" runat="server">


                            <div style="background-color: #ff006e; color: white; padding: 5px;">
                                <span>P.O. Items - Select items for notifcation</span>
                            </div>
                            <div style="overflow-x: auto">
                                <asp:GridView ID="gvPO_Items" runat="server" Width="100%" AutoGenerateColumns="False"
                                    CssClass="tblLocal">
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
                                        <asp:TemplateField HeaderText="Received Qty">
                                            <ItemTemplate>
                                                <div style="min-width: 80px;">
                                                    <asp:TextBox ID="tboxReceivedQty" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Reason">
                                            <ItemTemplate>
                                                <div style="min-width: 150px;">
                                                    <asp:TextBox runat="server" ID="tboxReason" CssClass="form-control"></asp:TextBox>
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
                                </asp:GridView>
                            </div>
                            <asp:LinkButton runat="server" ID="btnProceed" Width="100%" CssClass="btn btn-success" style="border-radius:0px;"
                                OnClick="btnProceed_Click1"><span class="glyphicon glyphicon-floppy-disk"></span> Create notification</asp:LinkButton>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>

        </div>
    </div>
</asp:Content>
