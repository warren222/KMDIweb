<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Delivery/ScannedDR/DRscannedReportMaster.Master" CodeBehind="DRupdatesItems.aspx.cs" Inherits="KMDIweb.KMDIweb.Delivery.ScannedDR.DRupdatesItems" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DR | Items</title>
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
                <h3>DR | Items</h3>
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
        <div class="container">
            <div style="padding: 5px;">
                <asp:Label ID="lblProject" runat="server"></asp:Label><br />
                <asp:Label ID="lblDRNo" runat="server"></asp:Label><br />
                <asp:Label ID="lblRowCount" runat="server"></asp:Label>
            </div>
            <div style="background-color: #ff006e; color: white; padding: 5px;">
                <span>DR Items</span>
            </div>
            <div style="overflow-x: auto">
                <asp:GridView ID="gvItems" runat="server" Width="100%" CssClass="tblLocal" AutoGenerateColumns="false"
                    PageSize="25" BackColor="White"
                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                    <Columns>
                        <asp:TemplateField HeaderText="K#">
                            <ItemTemplate>
                                <span><%# Eval("KMDI_NO") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Item#">
                            <ItemTemplate>
                                <span><%# Eval("ITEM_NO") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <span><%# Eval("WDW_NO") %></span><br />
                                <span><%# Eval("LOCATION") %></span><br />
                                <span><%# Eval("WIDTH") %></span>w x  <span><%# Eval("HEIGHT") %></span>h<br />
                                <span><%# Eval("DESCRIPTION") %></span>
                                <span><%# Eval("GLASS_SPECS") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
