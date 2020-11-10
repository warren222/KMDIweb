<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIapp/KMDIwebMaster.Master" CodeBehind="manageaccount.aspx.cs" Inherits="KMDIweb.KMDIapp.manageaccount" %>


<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Accounts</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <div class="container">
        <div class="well">
            <h1>
                <strong>Manage accounts</strong><small></small>
            </h1>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <div class="row">
                    <div class="col-sm-4">
                        Full name
                        <asp:TextBox ID="TBOXfullname" placeholder="Full name" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-sm-4">
                        Nickname
                        <asp:TextBox ID="TBOXnickname" placeholder="Nickname" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-sm-4">
                        Account type
                        <div class="input-group">

                            <asp:DropDownList ID="DDLaccounttype" CssClass="form-control" runat="server">
                                <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                                <asp:ListItem Text="User" Value="User"></asp:ListItem>
                                <asp:ListItem Text="Guest" Value="Guest"></asp:ListItem>
                            </asp:DropDownList>

                            <div class="input-group-btn">
                                <asp:LinkButton ID="BTNadd" CssClass="btn btn-primary" runat="server" OnClick="BTNadd_Click">add</asp:LinkButton>
                            </div>
                        </div>

                    </div>

                </div>

                <br />
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                    <h3 class="text-center text-success"><span><strong>
                        <asp:Label ID="LBLtitle" runat="server" CssClass="forfont" Text="Accounts Table"></asp:Label></strong> </span></h3>
                    <asp:GridView ID="GridView1" runat="server" CssClass="table" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:TemplateField HeaderText="ID">
                                <ItemTemplate>
                                    <asp:Label ID="LBLid" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FULL NAME">
                                <ItemTemplate>
                                    <asp:Label ID="LBLfullname" runat="server" Text='<%# Bind("FULLNAME") %>'></asp:Label>
                                    <asp:TextBox  Visible="false" ID="TBOXeditfullname" CssClass="form-control" runat="server" Text='<%# Bind("FULLNAME") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="NICKNAME">
                                <ItemTemplate>
                                    <asp:Label ID="LBLnickname" runat="server" Text='<%# Bind("NICKNAME") %>'></asp:Label>
                                    <asp:TextBox  Visible="false" ID="TBOXeditnickname" CssClass="form-control" runat="server" Text='<%# Bind("NICKNAME") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ACCOUNT TYPE">
                                <ItemTemplate>
                                    <asp:Label ID="LBLaccttype" runat="server" Text='<%# Bind("ACCTTYPE") %>'></asp:Label>
                                    <asp:DropDownList Visible="false" ID="DDLeditaccounttype" CssClass="form-control" runat="server" DataValueField='<%# Bind("ACCTTYPE") %>' DataTextField='<%# Bind("ACCTTYPE") %>'>
                                        <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                                        <asp:ListItem Text="User" Value="User"></asp:ListItem>
                                        <asp:ListItem Text="Guest" Value="Guest"></asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ACTION">
                                <ItemTemplate>
                                    <asp:LinkButton ID="BTNedit" CommandName="myedit" CssClass="btn btn-primary" runat="server">Edit</asp:LinkButton>
                                    <asp:LinkButton ID="BTNdelete" CommandName="mydelete" OnClientClick="return confirm('delete this record?');" CssClass="btn btn-danger" runat="server">Delete</asp:LinkButton>
                                    <asp:LinkButton ID="BTNsave" Visible="false" CommandName="mysave" CssClass="btn btn-success" runat="server">Save</asp:LinkButton>
                                    <asp:LinkButton ID="BTNcancel" Visible="false" CommandName="mycancel" CssClass="btn btn-warning" runat="server">Cancel</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <EmptyDataTemplate>
                            <div>
                                <h3><strong>Sorry, No Result Found!</strong>
                                </h3>
                            </div>
                        </EmptyDataTemplate>
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>
                </asp:Panel>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
