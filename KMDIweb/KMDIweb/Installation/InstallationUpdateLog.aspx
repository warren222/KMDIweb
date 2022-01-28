<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Installation/InstallationMaster.Master" CodeBehind="InstallationUpdateLog.aspx.cs" Inherits="KMDIweb.KMDIweb.Installation.InstallationUpdateLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Installation Update Log</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2>Installation Update Log</h2>
        </div>
        <div class="row">
            <div class="col-sm-3">
                <span>Date of record</span>
                <asp:TextBox ID="tboxDate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
            </div>
            <div class="col-sm-6">
                <span>Project</span>
                <div class="input-group">
                    <asp:TextBox ID="tboxProject_Name" CssClass="form-control" runat="server"></asp:TextBox>
                    <div class="input-group-btn">
                        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">search</asp:LinkButton>
                    </div>
                </div>

            </div>
        </div>
        <br />

        <asp:GridView ID="GridView1" CssClass="table" runat="server" AllowPaging="True" AutoGenerateColumns="False" PageSize="100" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" GridLines="Both" OnPageIndexChanging="GridView1_PageIndexChanging" CellSpacing="1">
            <Columns>
                <asp:TemplateField HeaderText="DATE" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <asp:Label ID="lblDated" runat="server" Text='<%# Bind("DATED") %>'></asp:Label>
                    </ItemTemplate>

                    <ItemStyle Wrap="False"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PROJECT" ItemStyle-Wrap="false" ItemStyle-BackColor="White" ItemStyle-BorderColor="Silver">
                    <ItemTemplate>
                        <asp:Label ID="lblProject" runat="server" Text='<%# Bind("PROJECT_LABEL") %>'></asp:Label><br />
                        <asp:Label ID="lblFulladd" runat="server" CssClass="text-muted" Text='<%# Bind("FULLADD") %>'></asp:Label>
                    </ItemTemplate>

                    <ItemStyle Wrap="False"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="K#" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <asp:Label ID="lblKno" runat="server" Text='<%# Bind("K_No") %>'></asp:Label>
                    </ItemTemplate>

                    <ItemStyle Wrap="False"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="STATION" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <asp:Label ID="lblSatation" runat="server" Text='<%# Bind("STATION") %>'></asp:Label>
                    </ItemTemplate>

                    <ItemStyle Wrap="False"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="UPDATED BY" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <asp:Label ID="lblUpdated_by" runat="server" Text='<%# Bind("UPDATED_BY") %>'></asp:Label>
                    </ItemTemplate>

                    <ItemStyle Wrap="False"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ACTION MADE" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <asp:Label ID="lblActionmade" runat="server" Text='<%# Bind("ACTION_MADE") %>'></asp:Label>
                    </ItemTemplate>

                    <ItemStyle Wrap="False"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="VALUE" ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <asp:Label ID="lblValue" runat="server" Text='<%# Bind("VALUE") %>'></asp:Label>
                    </ItemTemplate>

                    <ItemStyle Wrap="False"></ItemStyle>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
            <PagerSettings PageButtonCount="8" Position="TopAndBottom" />

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
