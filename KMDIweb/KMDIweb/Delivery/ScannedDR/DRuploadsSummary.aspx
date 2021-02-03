<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DRuploadsSummary.aspx.cs" MasterPageFile="~/KMDIweb/Delivery/ScannedDR/DRscannedReportMaster.Master" Inherits="KMDIweb.KMDIweb.Delivery.ScannedDR.DRuploadsSummary" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>For cutting</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <div class="container">
            <h2><strong>DR Uploaded File Summary</strong></h2>
        </div>
    </div>
    <div class="container">
        <div class="well">
            <div class="row">
                <div class="col-sm-4">
                    <div class="input-group">
                        <div class="input-group-addon">
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                            DATE
                        </div>
                        <asp:TextBox ID="TBOXdate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="input-group">
                        <div class="input-group-addon">
                            FOLDER
                        </div>
                        <asp:DropDownList ID="DDLfolder" CssClass="form-control" runat="server">
                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                            <asp:ListItem Value="Frame" Text="Frame"></asp:ListItem>
                            <asp:ListItem Value="Screen" Text="Screen"></asp:ListItem>
                            <asp:ListItem Value="Glass" Text="Glass"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="input-group">
                        <div class="input-group-addon">
                            SEARCH KEY
                        </div>
                        <asp:TextBox ID="TBOXsearchkey" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="BTNsearch" CssClass="btn btn-primary" runat="server" OnClick="BTNsearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />


        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
                    <h3>Uploaded files</h3>
                    <asp:GridView ID="GridView1" runat="server" CssClass="table" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="25">
                        <Columns>
                            <asp:TemplateField HeaderText="DATE">
                                <ItemTemplate>
                                    <asp:Label ID="lbldate" runat="server" Text='<%# Bind("udate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PROJECT NAME">
                                <ItemTemplate>
                                    <asp:Label ID="lblprojectname" runat="server" Text='<%# Bind("projectname") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="MOTHER JO">
                                <ItemTemplate>
                                    <asp:Label ID="lbljo" runat="server" Text='<%# Bind("parentjono") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FOLDER">
                                <ItemTemplate>
                                    <asp:Label ID="lblspecification" runat="server" Text='<%# Bind("specification") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TYPE">
                                <ItemTemplate>
                                    <asp:Label ID="lbltype" runat="server" Text='<%# Bind("filetype") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="File Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblid" runat="server" Text='<%# Bind("ID") %>' Visible="false"></asp:Label>
                                    <asp:LinkButton ID="lbtnfilename" CssClass="text-info" runat="server" CommandName="viewfile" Text='<%# Bind("FILENAME") %>'></asp:LinkButton>
                                    <asp:Label ID="lblfilepath" runat="server" Text='<%# Bind("path") %>' Visible="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                        <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                        <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" ForeColor="#8C4510"/>
                        <RowStyle Wrap="False" BackColor="#FFF7E7" ForeColor="#8C4510" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#FFF1D4" />
                        <SortedAscendingHeaderStyle BackColor="#B95C30" />
                        <SortedDescendingCellStyle BackColor="#F1E5CE" />
                        <SortedDescendingHeaderStyle BackColor="#93451F" />
                    </asp:GridView>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
