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
            <h2>Sections' daily output</h2>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
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
                            <asp:DropDownList ID="ddlMonth" CssClass="form-control" runat="server">
                                <asp:ListItem Text="January" Value="1"></asp:ListItem>
                                <asp:ListItem Text="February" Value="2"></asp:ListItem>
                                <asp:ListItem Text="March" Value="3"></asp:ListItem>
                                <asp:ListItem Text="April" Value="4"></asp:ListItem>
                                <asp:ListItem Text="May" Value="5"></asp:ListItem>
                                <asp:ListItem Text="June" Value="6"></asp:ListItem>
                                <asp:ListItem Text="July" Value="7"></asp:ListItem>
                                <asp:ListItem Text="August" Value="8"></asp:ListItem>
                                <asp:ListItem Text="September" Value="9"></asp:ListItem>
                                <asp:ListItem Text="October" Value="10"></asp:ListItem>
                                <asp:ListItem Text="Novermber" Value="11"></asp:ListItem>
                                <asp:ListItem Text="December" Value="12"></asp:ListItem>
                            </asp:DropDownList>
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
                <asp:RangeValidator ID="RangeValidator1" ValidationGroup="errorval" MaximumValue="9999" MinimumValue="1900" ControlToValidate="tboxYear" runat="server" CssClass="text-danger" ErrorMessage="year must be between 1900 and 9999">*</asp:RangeValidator>
                <h2>
                    <asp:Label ID="lblSection" ForeColor="Red" runat="server" Text=""></asp:Label></h2>
                <h4>Output</h4>

                <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                    <asp:GridView ID="GridView1" CssClass="table tbl" GridLines="None" runat="server" AutoGenerateColumns="false" AllowSorting="True" OnSorting="GridView1_Sorting" OnRowCommand="GridView1_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Month" SortExpression="dd">
                                <ItemTemplate>
                                    <asp:Label ID="lblDateFormatted" runat="server" Text='<%# Bind("ddFormatted") %>'></asp:Label>
                                    <asp:Label ID="lblDate" runat="server" Visible="false" Text='<%# Bind("dd") %>'></asp:Label>
                                    <asp:Label ID="lblSection" runat="server" Visible="false" Text='<%# Bind("section") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Points" SortExpression="points">
                                <ItemTemplate>
                                    <span class="gridLabel" style='width: <%# Eval("per").ToString()  %>px; background: #6699ff'>&nbsp;</span>
                                    <asp:LinkButton ID="LinkButton1" CommandName="viewlist" runat="server" ForeColor="Black" Text='<%# Bind("pointsFormatted") %>'></asp:LinkButton>
                                    <%--<asp:Panel ID="Panel2" CssClass="pnl" runat="server" Width='<%# Eval("per").ToString() %>' Height="20" BackColor="red"></asp:Panel>--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
                <div id="myModal" class="modal fade" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <asp:Label ID="lblmodalSection" Font-Bold="true" CssClass="text-info" runat="server" Text=""></asp:Label></h5>
                                <asp:Label ID="lblmodalDate" runat="server" Text="Header"></asp:Label>
                                <%--      <button type="button" class="close btn btn-default" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>--%>
                            </div>
                            <div class="modal-body">
                                <small>
                                    <asp:GridView ID="GridView2" CssClass="table" GridLines="None" AutoGenerateColumns="false" runat="server">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Project">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblmodalProject" runat="server" Text='<%# Bind("project_label") %>'></asp:Label><br />
                                                    <asp:Label ID="lblmodaladdress" Font-Size="Small" CssClass="text-muted" runat="server" Text='<%# Bind("fulladd") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="K#/Location">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblmodalKno" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                    <asp:Label ID="lblmodalLocation" CssClass="text-muted" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Points">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblmodalPoints" runat="server" Text='<%# Bind("points") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </small>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:LinkButton ID="viewReportBtn" runat="server" CssClass="btn btn-primary" OnClick="viewReportBtn_Click"><span class="glyphicon glyphicon-print"></span></asp:LinkButton>
    </div>
</asp:Content>
