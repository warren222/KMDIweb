<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fclnoout.aspx.cs" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.fclnoout" %>


<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>For cutting</title>

</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <div class="container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="well">
            <h1>Cutting list schedule</h1>
            <div class="row">
            <div class="col-sm-6"></div>
            <div class="col-sm-6">
                <div class="input-group">
                    <div class="input-group-addon">
                        PROJECT NAME
                    </div>
                    <asp:TextBox ID="tboxSearch" CssClass="form-control" runat="server"></asp:TextBox>
                    <div class="input-group-btn">
                        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click1">
                            <span class="glyphicon glyphicon-search"></span>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
                </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">

                    <small>
                        <asp:GridView ID="GridView1" CssClass="table tbl" AutoGenerateColumns="False" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" CellPadding="2" ForeColor="Black" PageSize="25" OnDataBound="GridView1_DataBound" OnRowCommand="GridView1_RowCommand" GridLines="None" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px">
                            <AlternatingRowStyle BackColor="PaleGoldenrod" />
                            <Columns>
                                <asp:TemplateField HeaderText="DUE DATE" HeaderStyle-Width="500px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLduedate" Font-Size="Large" Font-Bold="true" runat="server" Text='<%# Bind("DUE_DATE") %>'></asp:Label><br />
                                        <asp:Label ID="LBLyear" runat="server" Text='<%# Bind("YEAR") %>'></asp:Label><br />
                                        <asp:Label ID="LBLday" Font-Bold="true" runat="server" Text='<%# Bind("DAY") %>'></asp:Label>

                                        <asp:Label ID="LBLparentjono" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("parentjono") %>'></asp:Label>

                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PROJECT" HeaderStyle-Width="250px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLprojectname" runat="server" Font-Size="Small" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="K#" HeaderStyle-Width="350px" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LINKkno" runat="server" CommandName="forcutting" Font-Bold="true" Text='<%# Bind("KNO") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CL CTRL#" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLclno" runat="server" Text='<%# Bind("CLNO") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton CommandName="outme" ID="LinkButton2" OnClientClick="return confirm('remove this list?');" CssClass="btn btn-warning" runat="server">Out</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Center" BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" />
                            <FooterStyle BackColor="Tan" />
                            <HeaderStyle Wrap="False" BackColor="Tan" Font-Bold="True" />
                            <PagerSettings PageButtonCount="8" Position="TopAndBottom" />

                            <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                            <SortedAscendingCellStyle BackColor="#FAFAE7" />
                            <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                            <SortedDescendingCellStyle BackColor="#E1DB9C" />
                            <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                            <EmptyDataTemplate>
                                <div>
                                    <h3><strong>Sorry, No Result Found!</strong>
                                    </h3>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </small>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
