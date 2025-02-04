<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="Alu_Sys_Project_Summary.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.Alu_Sys_Project_Summary" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Alu & uPVC | Project Summary</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }

        .tblLocal {
            font-family: Calibri;
            font-size: 16px;
            white-space: nowrap;
            white-space: nowrap;
        }

            .tblLocal th, tr, td {
                padding-left: 5px;
                padding-right: 5px;
            }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>Alu & uPVC | Project Summary</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="container">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="row nopm">
                        <div class="col-sm-6 nopm">
                            <div class="alert alert-info alert-dismissible" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <strong>Selected Date Range:</strong>
                                <asp:Label ID="lblDateRange" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="col-sm-6 nopm">
                            <div class="well">
                                <div class="row nopm">
                                    <div class="col-sm-6 nopm">
                                        <span>START DATE</span>
                                        <asp:TextBox ID="tboxSdate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-6 nopm">
                                        <span>END DATE</span>
                                        <div class="input-group">
                                            <asp:TextBox ID="tboxEdate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                            <div class="input-group-btn">
                                                <asp:LinkButton ID="btnSearch" runat="server" Style="background-color: #ff006e; border-color: #ff006e" CssClass="btn btn-default" OnClick="btnSearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div style="background-color: #ff006e; width: 100%; padding: 5px; font-size: larger; color: white; font-family: Calibri;">
                        <span>System Used Summary </span>
                    </div>
                    <div style="overflow-x: auto">
                        <asp:GridView ID="gvAluSummary" CssClass="tblLocal" AutoGenerateColumns="false" Width="100%" OnRowCommand="gvAluSummary_RowCommand" runat="server">
                            <Columns>
                                <asp:TemplateField HeaderText="SYS">
                                    <ItemTemplate>
                                        <div class="text-left">
                                            <asp:LinkButton ID="btnSys_Tag" CommandName="execSelect" ForeColor="Black" runat="server" Text='<%# Bind("Sys_Tag") %>'></asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PROJECTS">
                                    <ItemTemplate>
                                        <div class="text-right">
                                            <asp:Label ID="lblUnit" runat="server" Text='<%# Bind("unit") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <SelectedRowStyle BackColor="#aed4f5" Font-Bold="True" ForeColor="Black" />
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />

            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <div style="background-color: #303030; width: 100%; padding: 5px; font-size: x-large; color: white; font-family: Calibri;">
                        <asp:Label ID="lblSysTag" runat="server"></asp:Label>
                        <span class="pull-right">
                            <asp:Label ID="lblTotalUnits" runat="server"></asp:Label>
                        </span>
                    </div>
                    <div style="overflow-x: auto">
                        <asp:GridView ID="gvItems" CssClass="tblLocal" Width="100%" runat="server" AllowPaging="True" OnPageIndexChanging="gvItems_PageIndexChanging" PageSize="25">
                            <EmptyDataTemplate>
                                <div class="">
                                    <h3><strong>Sorry! No result found :(</strong>
                                    </h3>
                                </div>
                            </EmptyDataTemplate>
                            <EditRowStyle BorderStyle="None" BorderWidth="0px" />
                            <PagerSettings PageButtonCount="8" Position="Bottom" />
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
