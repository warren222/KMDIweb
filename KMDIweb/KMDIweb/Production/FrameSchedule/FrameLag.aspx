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
        <div class="input-group" style="width: 100%">
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
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
        <h2>
            <asp:Label ID="lblSection" runat="server" Text=""></asp:Label></h2>
        <h4>Lags</h4>
        <asp:Panel runat="server" ID="Panel1" ScrollBars="Auto">

            <asp:GridView ID="GridView1" CssClass="table tbl" GridLines="None" AllowPaging="true" AutoGenerateColumns="false" runat="server" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="25">
                <Columns>
                    <asp:TemplateField HeaderText="Project">
                        <ItemTemplate>
                            <asp:Label ID="lblProject" runat="server" Text='<%# Bind("Project_Label") %>'></asp:Label><br />
                            <asp:Label ID="lblParentjono" runat="server" CssClass="text-info" Text='<%# Bind("parentjono") %>'></asp:Label><br />
                            <asp:Label ID="lblFulladd" runat="server" CssClass="text-muted" Text='<%# Bind("Fulladd") %>'></asp:Label><br />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="K#/Location">
                        <ItemTemplate>
                            <asp:Label ID="lblKno" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                            <asp:Label ID="lblLocation" CssClass="text-muted" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="lbldate" runat="server" Text='<%# Bind("d") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Days">
                        <ItemTemplate>
                            <asp:Label ID="lbldays" runat="server" Text='<%# Bind("days") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="GridPager" ForeColor="Black" HorizontalAlign="Left" />
                <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                <EmptyDataTemplate>
                    <div>
                        <h3><strong>Sorry, No Result Found!</strong>
                        </h3>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>

        </asp:Panel>
    </div>
</asp:Content>
