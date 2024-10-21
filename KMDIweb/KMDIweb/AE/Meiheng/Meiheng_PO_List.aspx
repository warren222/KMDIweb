<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/AE/Meiheng/MeiihengMaster.Master" CodeBehind="Meiheng_PO_List.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.Meiheng.Meiheng_PO_List" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Imported Glass | P.O</title>
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
        <div class="">
            <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
                <div class="container">
                    <h3>Imported Glass P.O</h3>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="well">
                <div class="row">
                    <div class="col-sm-1"></div>
                    <div class="col-sm-3">
                        <span>Glass Supplier</span>
                        <asp:DropDownList runat="server" ID="ddlSupplier" Style="border-radius: 0;" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="col-sm-3">
                        <span>AE / Engr.</span>
                        <asp:DropDownList runat="server" ID="ddlAE" Style="border-radius: 0;" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="col-sm-4">
                        <span>Find</span>
                        <div class="input-group">
                            <asp:TextBox runat="server" ID="tboxFind" CssClass="form-control"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-danger" Style="background-color:#ff006e;border-color:#ff006e" OnClick="LinkButton1_Click">GO</asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-1"></div>
                </div>
            </div>
            <div style="overflow-x: auto">
                <asp:GridView ID="gv" AutoGenerateColumns="False" AllowPaging="True" PageSize="25" OnPageIndexChanging="gv_PageIndexChanging"
                    CssClass="table" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" GridLines="Horizontal" ForeColor="Black">
                    <Columns>
                        <asp:TemplateField HeaderText="P.O">
                            <ItemTemplate>
                                <div style="white-space: nowrap">
                                    <span><%# Eval("po") %></span><br />
                                    <span><%# Eval("date") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Specificaton">
                            <ItemTemplate>
                                <div style="min-width: 300px;">
                                    <span><%# Eval("kmdi_no") %></span><br />
                                    <span><%# Eval("G_No") %></span><br />
                                    <span><%# Eval("width").ToString() +"w x "+ Eval("height").ToString()+"h" %></span><br />
                                    <span><%# Eval("GLASS_SPECS") %></span><br />
                                    <span class="text-info"><%# Eval("Supplier") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Project">
                            <ItemTemplate>
                                <div style="min-width: 300px;">
                                    <span><%# Eval("Project_Name") %></span><br />
                                    <span style="font-size: small;"><%# Eval("Sub_JO") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="AE/Engr.">
                            <ItemTemplate>
                                <div style="min-width: 300px; white-space: nowrap">
                                    <span style="font-size: small"><%# Eval("ACCT_EXEC_INCHARGE") %></span><br />
                                    <span style="font-size: small"><%# Eval("PROJECT_ENGR_INCHARGE") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />

                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#242121" />
                    <PagerSettings PageButtonCount="10" Position="TopAndBottom" />
                    <PagerStyle CssClass="GridPager" BackColor="White" ForeColor="Black" HorizontalAlign="Left" />
                    <EmptyDataTemplate>
                        <p style="font-size: x-large" class="text-danger">Empty Table</p>
                    </EmptyDataTemplate>
                </asp:GridView>
              
                <div class="container">
                    Results found:
                <asp:Label runat="server" ID="lblResult"></asp:Label>
                </div>
                <br />
            </div>
        </div>
    </div>
</asp:Content>
