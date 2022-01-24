<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Installation/InstallationMaster.Master" CodeBehind="InstallationSummaryReport.aspx.cs" Inherits="KMDIweb.KMDIweb.Installation.InstallationSummaryReport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2 class="text-center">Project Summary
            </h2>

            <div class="row">
                <div class="col-sm-3">
                    START<br />
                    <asp:TextBox ID="tboxSdate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                </div>
                <div class="col-sm-3">
                    END<br />
                    <asp:TextBox ID="tboxEdate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                </div>
                <div class="col-sm-2">
                    DATA<br />
                    <asp:DropDownList ID="ddlDataStatus" CssClass="form-control" runat="server">
                        <asp:ListItem Value="Updated" Text="with report"></asp:ListItem>
                        <asp:ListItem Value="Outdated" Text="no report"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-sm-4">
                    PROJECT<br />
                    <div class="input-group">
                        <asp:TextBox ID="tboxSearch" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" runat="server" OnClick="LinkButton2_Click">search</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>

            <br />
            <br />
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-danger" runat="server" OnClick="LinkButton1_Click">Report</asp:LinkButton>
        </div>



        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
            <asp:Panel ID="PNLschedule" runat="server">
                <asp:GridView ID="GridView1" CssClass="table" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="White" BorderColor="White"
                    BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" GridLines="Both" CellSpacing="1" PageSize="50">
                    <Columns>
                        <asp:TemplateField HeaderText="PROJECT" ItemStyle-BackColor="White" ItemStyle-BorderColor="Silver" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblproject" Font-Size="Large" CssClass="text-info" runat="server" Text='<%# Bind("PIR2_PROJECTNAME") %>'></asp:Label><br />
                                <asp:Label ID="lblAddress" Font-Size="Small" CssClass="text-muted" runat="server" Text='<%# Bind("Fulladd") %>'></asp:Label><br />
                                <asp:Label ID="lblparentjono" Font-Size="Smaller" runat="server" Text='<%# Bind("PIR2_PARENTJONO") %>'></asp:Label><br />
                                <asp:Label ID="lblEngr" Font-Size="Smaller" CssClass="text-warning" runat="server" Text='<%# Bind("ENGR") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle BackColor="White" BorderColor="Silver" Wrap="False" />
                        </asp:TemplateField>
                           <asp:TemplateField HeaderStyle-Width="200px" HeaderText="INSTALLERS" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblinstallershidden" runat="server" Visible="false" Text='<%# Bind("Installers") %>'></asp:Label>
                                <asp:Label ID="lblInstallers" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Installers").ToString(), "\r\n|\r|\n", "<br>"))  %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SCHEDULE" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblStart" runat="server" Text='<%# Bind("PIR2_START_DATE") %>'></asp:Label><br />
                                <asp:Label ID="lblEnd" runat="server" Text='<%# Bind("PIR2_END_DATE") %>'></asp:Label>
                                <itemstyle wrap="False" />
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                    </Columns>

                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />

                    <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                    <PagerStyle CssClass="GridPager" ForeColor="Black" HorizontalAlign="Left" />
                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#594B9C" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#33276A" />
                </asp:GridView>
            </asp:Panel>
        </asp:Panel>
    </div>

</asp:Content>
