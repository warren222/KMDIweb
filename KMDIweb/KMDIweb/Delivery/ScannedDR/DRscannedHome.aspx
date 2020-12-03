<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Delivery/sCANNEDdr/DRscannedReportMaster.Master" CodeBehind="DRscannedHome.aspx.cs" Inherits="KMDIweb.DRscannedReports.DelHome" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
    <style>
        .leftbotBorder {
            border-left: 6px solid green;
            padding-left: 20px;
            margin-bottom: 20PX;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well banner">
        <div class="container">
            <h1><strong style="color:#9baec8"><span  class="glyphicon glyphicon-home"></span>&nbsp;&nbsp; Scanned DR Reports</strong><br />
                <small style="color:#edeef0">store and access DR scanned copies</small> </h1>
        </div>
    </div>
    <div class="container">
        <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="valerror" runat="server" />
        <div class="well">
            <div class="input-group">
                <div class="input-group-addon">
                    search key
                </div>
                <asp:TextBox ID="TBOXsearchkey" CssClass="form-control" runat="server"></asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton ID="BTNsearch" runat="server" CssClass="btn btn-primary" OnClick="BTNsearch_Click"> <span class="glyphicon glyphicon-search"></span> </asp:LinkButton>
                </div>
            </div>
        </div>
        <asp:Panel ID="Panel1" runat="server">
            <h2>PROJECTS </h2>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" GridLines="Vertical" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" ShowHeader="False">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="leftbotBorder">
                                        <asp:Label ID="LBLprojectlabel" Font-Size="X-Large" CssClass="text-info" runat="server" Text='<%# Bind("project_label") %>'></asp:Label><br />
                                        <asp:Label ID="LBLfulladd" Font-Size="Medium" CssClass="text-muted" runat="server" Text='<%# Bind("fulladd") %>'></asp:Label><br />
                                        <asp:Label ID="LBLparentjono" Font-Size="Small" runat="server" Text='<%# Bind("parentjono") %>'></asp:Label>
                                        <br />
                                        <br />
                                        <asp:LinkButton ID="BTNframe" CommandName="btnframe" CssClass="btn btn-primary" runat="server">Frame</asp:LinkButton>
                                        <asp:LinkButton ID="BTNscreen" CommandName="btnscreen" CssClass="btn  btn-primary" runat="server">Screen</asp:LinkButton>
                                        <asp:LinkButton ID="BTNglass" CommandName="btnglass" CssClass="btn  btn-primary" runat="server">Glass</asp:LinkButton>
                                        <br />
                                        <br />
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                        <PagerStyle CssClass="GridPager" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>

        </asp:Panel>
    </div>


</asp:Content>
