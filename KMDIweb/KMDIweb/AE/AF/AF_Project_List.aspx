<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AF/AF_Master.Master" AutoEventWireup="true" CodeBehind="AF_Project_List.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AF.AF_Project_List" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>Project List</h2>
                    <div class="row">
                        <div class="col-sm-6">
                            <span>Account Executive</span>
                            <asp:DropDownList runat="server" ID="ddlAE" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-sm-6">
                            <span>Find</span>
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="tboxSearch" CssClass="form-control"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-primary" OnClick="btnSearch_Click">search</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div>
            </div>
            <div>
                <asp:GridView runat="server" ID="gvProject" AutoGenerateColumns="false" AllowPaging="true" GridLines="None" ShowHeader="false" CssClass="wf_tbl"
                    OnRowCommand="gvProject_RowCommand" OnPageIndexChanging="gvProject_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div style="padding: 5px; border-left: 3px solid #0094ff; margin-left: 10px;">
                                    <span><%# Eval("Project_Label") %></span><br />
                                    <span class="text-muted" style="font-size: smaller;"><%# Eval("FullAdd") %></span><br />
                                    <span class="" style="font-size: smaller;"><%# Eval("Acct_Exec_Incharge") %></span><br />
                                    <asp:LinkButton ID="btnParentjono" runat="server" CommandName="view_request" Text='<%# Bind("Parentjono") %>'></asp:LinkButton>
                                </div>
                                <br />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <p style="font-size: x-large" class="text-danger">0 result found!</p>
                    </EmptyDataTemplate>
                    <PagerSettings PageButtonCount="15" Position="TopAndBottom" />
                    <PagerStyle CssClass="GridPager" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" />
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
