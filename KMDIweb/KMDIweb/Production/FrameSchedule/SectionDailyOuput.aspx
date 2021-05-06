<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="SectionDailyOuput.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.SectionDailyOuput" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>List of delivered items per project</title>
    <style type="text/css">
        span.gridLabel {
            display: block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well text-center">
            <h2>Section's daily output</h2>
        </div>
        <div class="row">
            <div class="col-sm-4">
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
                        <asp:ListItem Text="QC" Value="QC"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="input-group" style="width: 100%">
                    <div class="input-group-addon" style="width: 110px;">
                        Month
                    </div>
                    <asp:TextBox ID="tboxMonth" TextMode="Number" ValidationGroup="errorval" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="input-group" style="width: 100%">
                    <div class="input-group-addon" style="width: 110px;">
                        Year
                    </div>
                    <asp:TextBox ID="tboxYear" TextMode="Number" ValidationGroup="errorval" CssClass="form-control" runat="server"></asp:TextBox>
                    <div class="input-group-btn">
                        <asp:LinkButton ID="btnSearch" runat="server" ValidationGroup="errorval" CssClass="btn btn-primary" OnClick="btnSearch_Click">submit</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
        <asp:RangeValidator ID="RangeValidator2" ValidationGroup="errorval" MaximumValue="12" MinimumValue="1" ControlToValidate="tboxMonth" runat="server" CssClass="text-danger" ErrorMessage="month must be between 1 and 12">*</asp:RangeValidator>
        <asp:RangeValidator ID="RangeValidator1" ValidationGroup="errorval" MaximumValue="9999" MinimumValue="1900" ControlToValidate="tboxYear" runat="server" CssClass="text-danger" ErrorMessage="year must be between 1900 and 9999">*</asp:RangeValidator>
        <h2>
            <asp:Label ID="lblSection" runat="server" Text=""></asp:Label></h2>
        <h4>Output</h4>
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
            <asp:GridView ID="GridView1" CssClass="table tbl" GridLines="None" runat="server" AutoGenerateColumns="false" AllowSorting="True" OnSorting="GridView1_Sorting">
                <Columns>
                    <asp:TemplateField HeaderText="Month" SortExpression="dd">
                        <ItemTemplate>
                            <asp:Label ID="lblMonth" runat="server" Text='<%# Bind("ddFormatted") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Points" SortExpression="points">
                        <ItemTemplate>
                            <span class="gridLabel" style='width: <%# Eval("per").ToString()  %>px; background: #6699ff'>&nbsp;</span>
                            <%# Eval("pointsFormatted").ToString()  %>
                            <%--<asp:Panel ID="Panel2" CssClass="pnl" runat="server" Width='<%# Eval("per").ToString() %>' Height="20" BackColor="red"></asp:Panel>--%>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
    </div>
</asp:Content>
