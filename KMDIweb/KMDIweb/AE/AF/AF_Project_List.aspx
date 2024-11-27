<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AF/AF_Master.Master" AutoEventWireup="true" CodeBehind="AF_Project_List.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AF.AF_Project_List" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AF | Project List</title>
    <style>
        .nopad{
            padding:0;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>Project List</h2>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="row nomargin">
                <div class="col-sm-2 nomargin"></div>
                <div class="col-sm-8 nomargin">
                    <div class="well">
                        <div class="row" style="padding: 0; margin: 0;">
                            <div class="col-sm-5" style="padding: 0; margin: 0;">
                                <span>Account Executive</span>
                                <asp:DropDownList runat="server" ID="ddlAE" style="border-radius:0;" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-sm-7" style="padding: 0; margin: 0;">
                                <span>Find</span>
                                <div class="input-group">
                                    <asp:TextBox runat="server" ID="tboxSearch" style="border-radius:0;" CssClass="form-control"></asp:TextBox>
                                    <div class="input-group-btn">
                                        <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-primary" OnClick="btnSearch_Click">search</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-2 nomargin"></div>
            </div>

            <div class="row nomargin">
                <div class="col-sm-2 nomargin"></div>
                <div class="col-sm-8 nomargin">
                    <div style="background-color: white; overflow-x:auto">
                        <asp:GridView runat="server" ID="gvProject" Width="100%" AutoGenerateColumns="false" BackColor="White" AllowPaging="true" GridLines="None" ShowHeader="false" CssClass=""
                            OnRowCommand="gvProject_RowCommand" OnPageIndexChanging="gvProject_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div style="margin: 2px; border: 2px solid #e0e0e0;">
                                            <div style="background-color: #e0e0e0; padding: 5px;">
                                                <span class="" style="font-size: small; color: black;"><%# Eval("Acct_Exec_Incharge") %></span>
                                            </div>
                                            <div style="padding: 5px; background-color: white">
                                                <asp:LinkButton ID="btnProject" runat="server" Font-Size="Medium" CommandName="view_request" Text='<%# Eval("Project_Label") %>'></asp:LinkButton><br />
                                                <span class="" style="font-size: smaller;"><%# Eval("FullAdd") %></span><br />
                                                <asp:Label ID="lblParentjono" Font-Size="Small" runat="server" Text='<%# Bind("Parentjono") %>'></asp:Label>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <p style="font-size: x-large" class="text-danger">0 result found!</p>
                            </EmptyDataTemplate>
                            <PagerSettings PageButtonCount="15" Position="TopAndBottom" />
                            <PagerStyle CssClass="GridPager" BackColor="transparent" ForeColor="Black" HorizontalAlign="Left" />
                        </asp:GridView>
                    </div>
                </div>
                <div class="col-sm-2 nomargin"></div>
            </div>
        </div>
    </div>
</asp:Content>
