<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="FrameOverDue.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.FrameOverDue" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Frame Over Due</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="well text-center">
        <h2>Frame's Overdue Monitoring</h2>
    </div>
    <div class="container">
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
                        Schedule
                    </div>
                    <asp:DropDownList ID="ddlSection" CssClass="form-control" runat="server">
                        <asp:ListItem Text="Due Date" Value="Due Date"></asp:ListItem>
                        <asp:ListItem Text="New Due Date" Value="New Due Date"></asp:ListItem>
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
        <h4>Overdue</h4>
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

            <asp:GridView ID="GridView1" CssClass="tbl" AllowPaging="True" AutoGenerateColumns="False" runat="server" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="100" CellPadding="4" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" ForeColor="Black">
                <Columns>
                    <asp:TemplateField HeaderText="Project">
                        <ItemTemplate>
                            <asp:Label ID="lblProject" runat="server" Text='<%# Bind("Project_Label") %>'></asp:Label><br />
                            <asp:Label ID="lblParentjono" runat="server" CssClass="text-info" Text='<%# Bind("parentjono") %>'></asp:Label><br />
                            <asp:Label ID="lblFulladd" runat="server" CssClass="text-muted" Font-Size="Small" Text='<%# Bind("Fulladd") %>'></asp:Label><br />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="K#/Location">
                        <ItemTemplate>
                            <asp:Label ID="lblKno" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                            <asp:Label ID="lblLocation" CssClass="text-info" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Right" HeaderText="Points">
                        <ItemTemplate>
                            <asp:Label ID="lblpoints" runat="server" Text='<%# Bind("points") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Schedule">
                        <ItemTemplate>
                            <asp:Label ID="lbldate" runat="server" Text='<%# Bind("d") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Remarks">
                        <ItemTemplate>
                            <asp:Label ID="lblremaks" runat="server" Text='<%# Bind("Sched_Remarks") %>'></asp:Label>
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
                <PagerStyle CssClass="GridPager" HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black" />

                <FooterStyle BackColor="#CCCCCC" />

                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerSettings PageButtonCount="8" Position="Bottom" />
                <EmptyDataTemplate>
                    <div>
                        <h3><strong>Sorry, No Result Found!</strong>
                        </h3>
                    </div>
                </EmptyDataTemplate>
                <RowStyle BackColor="White" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>

        </asp:Panel>


    </div>
</asp:Content>
