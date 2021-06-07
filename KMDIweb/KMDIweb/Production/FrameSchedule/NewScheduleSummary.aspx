<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="NewScheduleSummary.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.NewScheduleSummary" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Summary of rescheduled items</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2 class="text-center">Summary of rescheduled items</h2>
               <div class="row">
                    <div class="col-sm-6">
                        <div class=" input-group">
                            <div class="input-group-addon">
                                Project
                            </div>
                            <asp:TextBox ID="tboxproject" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="input-group">
                            <div class="input-group-addon">
                                Search
                            </div>
                            <asp:TextBox ID="tboxdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
             
                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
                <asp:GridView ID="GridView1" GridLines="None" AllowPaging="true" AutoGenerateColumns="false" runat="server" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="panel panel-default">
                                    <div class="panel-heading text-center">
                                        <span class="label label-success">Date updated
                                        </span>
                                    </div>
                                    <div class="panel-body">
                                        <h2>
                                            <asp:Label ID="lblDate" runat="server" CssClass="" Text='<%# Bind("new_due_date_updated") %>'></asp:Label></h2>
                                        <asp:Label ID="lbldd" Visible="false" runat="server" CssClass="text-primary" Text='<%# Bind("dd") %>'></asp:Label>

                                        <asp:Label ID="lblproject" Font-Size="Larger" runat="server" Text='<%# Regex.Replace(Eval("project").ToString(), "\r\n|\r|\n", "<br>") %>'></asp:Label>
                                    </div>
                                    <div class="panel-footer text-center">
                                        <asp:LinkButton ID="LinkButton3" CssClass="btn btn-primary" CommandName="viewlist" runat="server">View List</asp:LinkButton>
                                    </div>
                                </div>
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
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</asp:Content>
