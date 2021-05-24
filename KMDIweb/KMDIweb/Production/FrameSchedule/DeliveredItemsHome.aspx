<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="DeliveredItemsHome.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.DeliveredItemsHome" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>List of delivered items per project</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2>List of delivered Items</h2>
            <div class="input-group">
                <div class="input-group-addon">
                    Search
                </div>
                <asp:TextBox ID="tboxSearch" CssClass="form-control" runat="server"></asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
                <asp:Panel ID="Panel1" runat="server">
                    <asp:GridView ID="GridView1" AllowPaging="true" GridLines="None" runat="server" AutoGenerateColumns="false" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" PageSize="100">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label ID="lblProject" runat="server" Font-Size="Large" Text='<%# Bind("Project_Label") %>'></asp:Label><br />
                                    <asp:Label ID="lblParentjono" runat="server" CssClass="text-muted" Text='<%# Bind("parentjono") %>'></asp:Label><br />
                                    <asp:Label ID="lblFulladd" runat="server" CssClass="text-info" Text='<%# Bind("Fulladd") %>'></asp:Label><br />
                                    <asp:LinkButton ID="LinkButton2" CommandName="viewdel" CssClass="btn btn-default" runat="server">delivered frames</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton3" CommandName="viewdelscreen" CssClass="btn btn-default" runat="server">delivered screens</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton4" CommandName="viewdelglass" CssClass="btn btn-default" runat="server">delivered glasses</asp:LinkButton>
                                    <hr />
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
                <div id="myModal" class="modal fade" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <asp:Label ID="lblmodalProjectname" Font-Bold="true" CssClass="text-info" runat="server" Text=""></asp:Label></h5>
                                <asp:Label ID="lblHeader" runat="server" Text="Header"></asp:Label>
                                <%--      <button type="button" class="close btn btn-default" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>--%>
                            </div>
                            <div class="modal-body">
                                <asp:GridView ID="GridView2" CssClass="table" GridLines="None" AutoGenerateColumns="false" runat="server">
                                    <Columns>
                                        <asp:TemplateField HeaderText="K#/Location">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmodalKno" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label>
                                                <asp:Label ID="lblgno" runat="server" Text='<%# Bind("g_no") %>'></asp:Label><br />
                                                <asp:Label ID="lblmodalLocation" CssClass="text-muted" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Date Delivered">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDateDelivered" runat="server" Text='<%# Bind("date_delivered") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
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
