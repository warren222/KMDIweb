<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Installation/InstallationMaster.Master" CodeBehind="InstallationUpdateLogRange.aspx.cs" Inherits="KMDIweb.KMDIweb.Installation.InstallationUpdateLogRange" %>

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
        <asp:LinkButton ID="btn1" runat="server" CssClass="btn btn-warning" Text="<< go back" PostBackUrl="~/KMDIweb/Installation/InstallationUpdateLog.aspx"></asp:LinkButton>
        <br />
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="row">
                    <div class="col-sm-3">
                        <span>Start Date</span>
                        <asp:TextBox ID="tboxSdate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-sm-3">
                        <span>End Date</span>
                        <asp:TextBox ID="tboxEdate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-sm-6">
                        <span>Installer</span>
                        <div class="input-group">
                            <asp:DropDownList ID="ddlInstl" CssClass="form-control" runat="server"></asp:DropDownList>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">search</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                    <asp:GridView ID="GridView1" CssClass="table" Font-Size="X-Small" AutoGenerateColumns="false" runat="server" AllowPaging="True" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="Both" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="100">
                        <Columns>
                            <asp:TemplateField HeaderText="INSTALLATION SCHEDULE" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblSchedule" runat="server" Text='<%# Bind("Schedule") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="UPDATED BY" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblUpdated_by" runat="server" Text='<%# Bind("UPDATED_BY") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DATE INPUTTED" ItemStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblDated" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Wrap="False"></ItemStyle>
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
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
