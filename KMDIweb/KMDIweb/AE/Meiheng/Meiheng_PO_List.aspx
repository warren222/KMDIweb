<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/AE/Meiheng/MeiihengMaster.Master" CodeBehind="Meiheng_PO_List.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.Meiheng.Meiheng_PO_List" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Meiheng Glass | P.O</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }
    </style>
</asp:Content>


<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <h2>Meiheng Glass P.O <small>to be received</small></h2>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <div>
                <div class="row nopm">
                    <div class="col-sm-4">
                        <span>Account Executive / Engineer</span>
                        <div class="input-group">
                            <asp:DropDownList runat="server" ID="ddlAE" Style="border-radius: 0;" CssClass="form-control"></asp:DropDownList>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary" OnClick="LinkButton1_Click">GO</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-8"></div>
                </div>
            </div>
            <div>
                <asp:GridView ID="gv" AutoGenerateColumns="False" AllowPaging="True" PageSize="25" OnPageIndexChanging="gv_PageIndexChanging"
                    CssClass="table" runat="server" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" GridLines="None" CellSpacing="1">
                    <Columns>
                        <asp:TemplateField HeaderText="P.O">
                            <ItemTemplate>
                                <span><%# Eval("po") %></span><br />
                                <span><%# Eval("date") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Specificaton">
                            <ItemTemplate>
                                <span><%# Eval("kmdi_no") %></span><br />
                                <span><%# Eval("G_No") %></span><br />
                                <span><%# Eval("width").ToString() +"w x "+ Eval("height").ToString()+"h" %></span><br />
                                <span><%# Eval("GLASS_SPECS") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Project">
                            <ItemTemplate>
                                <span><%# Eval("Project_Name") %></span><br />
                                <span><%# Eval("Sub_JO") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />

                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#594B9C" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#33276A" />
                    <PagerSettings PageButtonCount="10" Position="TopAndBottom" />
                    <PagerStyle CssClass="GridPager" BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                    <EmptyDataTemplate>
                        <p style="font-size: x-large" class="text-danger">0 result found!</p>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
