<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIapp/KMDIwebMaster.Master" CodeBehind="sccutting.aspx.cs" Inherits="KMDIweb.KMDIapp.sccutting" %>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class=" jumbotron">
        <h1><strong>For Cutting<br />
            <small>Station's expected output</small> </strong></h1>

        <asp:LinkButton ID="BTNback" runat="server" PostBackUrl="~/KMDIapp/home.aspx" CssClass="btn btn-default">back to home page</asp:LinkButton>

    </div>
    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
          

            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <asp:GridView ID="GridView1" runat="server" CssClass="table" AutoGenerateColumns="False" AllowPaging="True" PageSize="25" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="PROJECT">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Visible="false" Text='<%# Bind("JOB_ORDER_NO") %>'></asp:Label>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("PROJECT_LABEL") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ITEM#">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("ITEM_NO") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="KMDI#">
                            <ItemTemplate>
                                <div class="text-primary">
                                    <strong>
                                        <asp:Label ID="Label1" Font-Bold="true" Font-Size="Large" runat="server" Text='<%# Bind("KMDI_NO") %>'></asp:Label></strong>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="CUTTING">
                            <ItemTemplate>
                                <asp:LinkButton ID="BTNupdate" CssClass="btn btn-primary" runat="server">Done Cutting</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <EmptyDataTemplate>
                        <div class="alert alert-warning">
                            <h3><strong>Sorry, no result!</strong>
                            </h3>
                        </div>
                    </EmptyDataTemplate>
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>



</asp:Content>
