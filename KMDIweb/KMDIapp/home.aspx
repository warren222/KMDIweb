<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIapp/KMDIwebMaster.Master" CodeBehind="home.aspx.cs" Inherits="KMDIweb.SCREENfab.home" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Screen Monitoring</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class=" jumbotron">
        <h1><strong>Screen Fabrication Monitoring<br />
            <small>Web Site!</small> </strong></h1>
    </div>

  

    <div class="panel panel-default">
        <div class="panel-heading">
            <h4><span class="text-muted"><strong>Screen Fabrication Schedule</strong> </span></h4>
        </div>
        <div class="panel-body">
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="well">
                            <div>
                                <h4 class="text-primary">Date filter option</h4>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            Date begin
                                        </div>
                                        <asp:TextBox ID="tboxSdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            Date end
                                        </div>
                                        <asp:TextBox ID="tboxEdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="BTNsearch" CssClass="btn btn-default" runat="server" OnClick="BTNsearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div>
                            <h4 class="text-primary">Selected Schedule</h4>
                        </div>
                        <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
                            <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                                <AlternatingRowStyle BackColor="#DCDCDC" />
                                <Columns>
                                    <asp:TemplateField HeaderText="PROJECT">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Font-Size="Large" Text='<%# Bind("PROJECT_LABEL") %>'></asp:Label>
                                            <br />
                                            <strong>
                                            <asp:Label ID="Label2" runat="server" CssClass="text-info" Text='<%# Bind("COLOR") %>'></asp:Label>
                                            <br />
                                            <asp:Label ID="Label3" runat="server" CssClass="text-muted" Text='<%# Bind("CLNO") %>'></asp:Label>
                                            </strong>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="D. RELEASED">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("CUTTING_LIST") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SCREEN TYPE">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("SCREENTYPE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="K NO.">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("KMDINO") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderStyle-Width="100px" HeaderText="DUE DATE">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("DUE_DATE") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px" />
                                    </asp:TemplateField>
                                       <asp:TemplateField HeaderStyle-Width="100px" HeaderText="FINISHED">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("DATE_FABRICATED") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="100px" />
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="GridPager" HorizontalAlign="Center" BackColor="#999999" ForeColor="Black" />
                                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                <HeaderStyle Wrap="False" BackColor="#000084" Font-Bold="True" ForeColor="White" />
                                <PagerSettings PageButtonCount="8" />
                      
                                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#000065" />
                      
                            </asp:GridView>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
        <div class="panel-footer">
        </div>
    </div>
      <h4><span><strong>Screen Stations</strong> </span></h4>
    <blockquote>
        <asp:LinkButton ID="LinkButton1" runat="server"><h3><span class="text-info"><strong>Cutting</strong></span></h3></asp:LinkButton>
        <asp:LinkButton ID="LinkButton5" runat="server"><h3><span class="text-info"><strong>Prepared Pleated Mesh</strong></span></h3></asp:LinkButton>
        <asp:LinkButton ID="LinkButton6" runat="server"><h3><span class="text-info"><strong>Assembling</strong></span></h3></asp:LinkButton>
        <asp:LinkButton ID="LinkButton7" runat="server"><h3><span class="text-info"><strong>Quality Control</strong></span></h3></asp:LinkButton>
    </blockquote>
</asp:Content>
