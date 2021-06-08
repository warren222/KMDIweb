<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="FrameLag.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.FrameLag" %>


<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Frame Lag</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well text-center">
            <h2>Frame Sections' Lag Monitoring</h2>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="input-group">
                    <div class="input-group-addon">
                        AE/ENGR.
                    </div>
                    <asp:DropDownList ID="ddlae" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="input-group">
                    <div class="input-group-addon" style="width: 110px;">
                        Section
                    </div>
                    <asp:DropDownList ID="ddlSection" CssClass="form-control" runat="server">
                        <asp:ListItem Text="Cutting" Value="Cutting"></asp:ListItem>
                        <asp:ListItem Text="Drainage" Value="Drainage"></asp:ListItem>
                        <asp:ListItem Text="Handle" Value="Handle"></asp:ListItem>
                        <asp:ListItem Text="Fixing" Value="Fixing"></asp:ListItem>
                        <asp:ListItem Text="Welding" Value="Welding"></asp:ListItem>
                        <asp:ListItem Text="Corner Cleaning" Value="Corner Cleaning"></asp:ListItem>
                        <asp:ListItem Text="Mullion / Transom" Value="Mullion / Transom"></asp:ListItem>
                        <asp:ListItem Text="Glazing Bead" Value="Glazing Bead"></asp:ListItem>
                        <asp:ListItem Text="Hardware" Value="Hardware"></asp:ListItem>
                        <asp:ListItem Text="Finishing" Value="Finishing"></asp:ListItem>
                    </asp:DropDownList>
                    <div class="input-group-btn">
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <br />
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
        <h2>
            <asp:Label ID="lblSection" runat="server" Text=""></asp:Label></h2>
        <h4>Lags</h4>
        <table border="1" style="border-width: 4px;" class="table">
            <tr style="background-color: whitesmoke;">
                <td colspan="2">Summary</td>
            </tr>
            <tr>
                <th>No. of Items</th>
                <th>Total Points</th>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblNoItems" CssClass="text-info" Font-Size="XX-Large" Text="Number of Items" runat="server"></asp:Label></td>
                <td>
                    <asp:Label ID="lblTotalpoints" CssClass="text-info" Font-Size="XX-Large" Text="TotalPoints" runat="server"></asp:Label></td>
            </tr>
        </table>
        <asp:Panel runat="server" ID="Panel1" ScrollBars="Auto">

            <asp:GridView ID="GridView1" CssClass="table tbl" AllowPaging="True" AutoGenerateColumns="False" runat="server" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="100" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                <Columns>
                    <asp:TemplateField HeaderText="Project">
                        <ItemTemplate>
                            <asp:Label ID="lblProject" runat="server" Text='<%# Bind("Project_Label") %>'></asp:Label><br />
                            <asp:Label ID="lblParentjono" runat="server" CssClass="text-info" Text='<%# Bind("parentjono") %>'></asp:Label><br />
                            <asp:Label ID="lblFulladd" runat="server" CssClass="text-muted" Text='<%# Bind("Fulladd") %>'></asp:Label><br />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="K#/Location">
                        <ItemTemplate>
                            <asp:Label ID="lblKno" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                            <asp:Label ID="lblLocation" CssClass="text-muted" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Points">
                        <ItemTemplate>
                            <asp:Label ID="lblpoints" runat="server" Text='<%# Bind("points") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="lbldate" runat="server" Text='<%# Bind("d") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Days">
                        <ItemTemplate>
                            <asp:Label ID="lbldays" Font-Size="XX-Large" CssClass="text-danger" Font-Bold="true" runat="server" Text='<%# Bind("days") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="GridPager" HorizontalAlign="Right" BackColor="White" ForeColor="Black" />
                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                <PagerSettings PageButtonCount="8" Position="Bottom" />
                <EmptyDataTemplate>
                    <div>
                        <h3><strong>Sorry, No Result Found!</strong>
                        </h3>
                    </div>
                </EmptyDataTemplate>
                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#242121" />
            </asp:GridView>

        </asp:Panel>
    </div>
</asp:Content>
