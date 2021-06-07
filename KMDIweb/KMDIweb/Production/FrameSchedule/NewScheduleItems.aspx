<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="NewScheduleItems.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.NewScheduleItems" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>List of rescheduled items</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well text-center">
            <h2 class="text-muted">List of rescheduled items
            <asp:Label ID="lblDate" runat="server" CssClass="text-primary" Text=""></asp:Label></h2>
           
                <div class=" input-group">
                    <div class="input-group-addon">
                        Project
                    </div>
                    <asp:TextBox ID="tboxproject" CssClass="form-control" runat="server"></asp:TextBox>
                    <div class="input-group-btn">
                        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                    </div>
                </div>
           
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
                <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                    <asp:GridView ID="GridView1" CssClass="table tbl" AllowPaging="True" AutoGenerateColumns="False" runat="server" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="100" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                        <Columns>
                            <asp:TemplateField HeaderText="Project">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Project_label") %>'></asp:Label><br />
                                    <asp:Label ID="Label3" Font-Size="Small" CssClass="text-muted" runat="server" Text='<%# Bind("fulladd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="K#/Location">
                                <ItemTemplate>
                                    <asp:Label ID="LBLg2kmdino" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                    <asp:Label ID="LBLlocation" runat="server" CssClass="text-muted" Text='<%# Bind("location") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="From">
                                <ItemTemplate>
                                    <asp:Label ID="lblduedate" runat="server" Text='<%# Bind("due_date") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="To">
                                <ItemTemplate>
                                    <asp:Label ID="lblnewduedate" runat="server" Text='<%# Bind("new_due_date") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <asp:Label ID="LBLschedstatus" runat="server" Font-Bold="true" CssClass="text-danger" Text='<%# Bind("STATUS") %>'></asp:Label>&nbsp;
                                    <asp:Label ID="LBLg2sched_remarks" runat="server" Text='<%# Bind("SCHED_REMARKS") %>'></asp:Label>
                                    <asp:Label ID="lblrescheduleremarks" Visible="false" runat="server" Text='<%# Bind("reschedule_remarks") %>'></asp:Label>
                                    <asp:Label ID="lblincompletematerials" Visible="false" runat="server" Text='<%# Bind("inc_materials_remarks") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="OpenPopUpBTN" runat="server" CommandName="OpenPopUp">more details</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="GridPager" ForeColor="Black" HorizontalAlign="Left" BackColor="#CCCCCC" />
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

                <div id="myModal" class="modal fade" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <asp:Label ID="lblmodalKno" Font-Bold="true" CssClass="text-info" runat="server" Text=""></asp:Label></h5>
                                <asp:Label ID="lblmodalLocation" CssClass="text-muted" runat="server" Text=""></asp:Label>
                                <%--   <button type="button" class="close btn btn-default" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>--%>
                            </div>
                            <div class="modal-body">
                                <h5><strong>Reason</strong></h5>
                                <blockquote>
                                    <p>
                                        <asp:Label ID="lblModalReschedRemarks" runat="server" Text=""></asp:Label>
                                    </p>
                                </blockquote>
                                <h5><strong>Incomplete Materials Remarks</strong></h5>
                                <blockquote>
                                    <p>
                                        <asp:Label ID="lblModalIncompleteMaterials" runat="server" Text=""></asp:Label>
                                    </p>
                                </blockquote>
                                <h5><strong>Schedule Remarks</strong></h5>
                                <blockquote>
                                    <p>
                                        <asp:Label ID="lblModalRemarks" runat="server" Text=""></asp:Label>
                                    </p>
                                </blockquote>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</asp:Content>

