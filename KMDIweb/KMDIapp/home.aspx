<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIapp/KMDIwebMaster.Master" CodeBehind="home.aspx.cs" Inherits="KMDIweb.SCREENfab.home" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class=" jumbotron">
        <h1><strong>Screen Fabrication Monitoring<br />
            <small>Web Site!</small> </strong></h1>
    </div>
    <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
    <div class="row">
        <div class="col-sm-4">
            <blockquote>
                <h5><strong class="text-muted">Load</strong></h5>
                <asp:Label ID="LBLloadpoints" Font-Bold="true" CssClass="text-center" Font-Size="XX-Large" runat="server" Text="Time"></asp:Label>
                <br />
                <asp:Label ID="LBLloadkno" CssClass="text-center" runat="server" Text="k#(s)"></asp:Label>
            </blockquote>
        </div>
        <div class="col-sm-4">

            <blockquote>
                <h5><strong class="text-muted">Today</strong></h5>
                <asp:Label ID="LBLtodaypoints" Font-Bold="true" CssClass="text-center" Font-Size="XX-Large" runat="server" Text="Time"></asp:Label>
                <br />
                <asp:Label ID="LBLtodaykno" CssClass="text-center" runat="server" Text="k#(s)"></asp:Label>
            </blockquote>
        </div>
        <div class="col-sm-4">
            <blockquote>
                <h5><strong class="text-muted">This week</strong></h5>
                <asp:Label ID="Label5" Font-Bold="true" CssClass="text-center" Font-Size="XX-Large" runat="server" Text="Time"></asp:Label>
                <br />
                <asp:Label ID="Label6" CssClass="text-center" runat="server" Text="k#(s)"></asp:Label>
            </blockquote>
        </div>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4><span><strong>Screen Fabrication Schedule</strong> </span></h4>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    DATE BEGIN
                                </div>
                                <asp:TextBox ID="tboxBdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>

                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    DATE END
                                </div>
                                <asp:TextBox ID="tboxEdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="BTNsearch" CssClass="btn btn-default" runat="server" OnClick="BTNsearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="panel-body">
                    <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
                        <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" PageSize="25" OnDataBound="GridView1_DataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="DATE" HeaderStyle-Width="500px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLduedate" Font-Size="X-Large" Font-Bold="true" runat="server" Text='<%# Bind("DUE_DATE") %>'></asp:Label><br />
                                        <asp:Label ID="LBLyear" runat="server" Text='<%# Bind("YEAR") %>'></asp:Label><br />
                                        <asp:Label ID="LBLday" Font-Bold="true" runat="server" Text='<%# Bind("DAY") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PROJECT" HeaderStyle-Width="250px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLprojectname" runat="server" Font-Size="Small" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="K#" HeaderStyle-Width="350px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLkno" runat="server" Font-Bold="true" CssClass="text-info" Text='<%# Bind("KNO") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="COLOR">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLcolor" runat="server" Text='<%# Bind("COLOR") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="QTY">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLqty" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TYPE OF SCREEN">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLscreentype" runat="server" Text='<%# Bind("TYPE_OF_SCREEN") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="REMARKS">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLremarks" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DATE FINISHED" HeaderStyle-BackColor="Violet" HeaderStyle-ForeColor="Black">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLfinished" runat="server" Font-Size="Small" Font-Bold="true" Text='<%# Bind("FINISHED") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="TIME" HeaderStyle-BackColor="Wheat" HeaderStyle-ForeColor="Black">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLtime" Font-Bold="true" Font-Size="Medium" runat="server" Text='<%# Bind("ACTUAL_TIME") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black" />
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle Wrap="False" BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerSettings PageButtonCount="8" />

                            <RowStyle BackColor="White" />
                            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#808080" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#383838" />
                            <EmptyDataTemplate>
                                <div class="alert alert-warning">
                                    <h3><strong>Sorry, the table is empty!</strong>
                                    </h3>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>

                    </asp:Panel>
                </div>
                <div class="panel-footer">
                    <asp:Label ID="LBLrowcount" runat="server" Text="Label"></asp:Label>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" ScrollBars="Auto" Visible="false" runat="server">


                <div class="panel panel-success">
                    <div class="panel-heading">
                        <h4>Expected Daily Output Summary List</h4>
                    </div>
                    <div class="panel-body">

                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" GridLines="Both" CssClass="table" CellPadding="3" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellSpacing="1">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="Label10" runat="server" Text='<%# Bind("project_name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="Label10" runat="server" CssClass="text-info" Font-Bold="true" Text='<%# Bind("kno") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DUE DATE" HeaderStyle-BackColor="YellowGreen">
                                    <ItemTemplate>
                                        <asp:Label ID="Label10" runat="server" Font-Size="Large" Font-Bold="true" Text='<%# Bind("due_date") %>'></asp:Label>
                                    </ItemTemplate>

                                    <HeaderStyle BackColor="YellowGreen"></HeaderStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TIME" HeaderStyle-BackColor="Wheat" HeaderStyle-ForeColor="Black">
                                    <ItemTemplate>
                                        <asp:Label ID="Label10" Font-Bold="true" runat="server" Text='<%# Bind("timevalue") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="Wheat"></HeaderStyle>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="alert alert-warning">
                                    <h3><strong>Sorry, the table is empty!</strong>
                                    </h3>
                                </div>
                            </EmptyDataTemplate>
                            <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                            <HeaderStyle Wrap="False" BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                            <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                            <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#F1F1F1" />
                            <SortedAscendingHeaderStyle BackColor="#594B9C" />
                            <SortedDescendingCellStyle BackColor="#CAC9C9" />
                            <SortedDescendingHeaderStyle BackColor="#33276A" />
                        </asp:GridView>
                    </div>
                    <div class="panel-footer">
                        <asp:Label ID="Label7" runat="server" Text="row count"></asp:Label>
                    </div>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Panel ID="Panel3" runat="server" BackColor="Yellow">
    <h6><span><strong>Screen Stations</strong> </span></h6>
    <div class="row">
        <div class="col-sm-2">
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"><h4><span class="text-info"><strong>Cutting</strong></span></h4></asp:LinkButton>
        </div>
        <div class="col-sm-2">
            <asp:LinkButton ID="LinkButton5" runat="server"><h4><span class="text-info"><strong>Prepared Pleated Mesh</strong></span></h4></asp:LinkButton>
        </div>
        <div class="col-sm-2">
            <asp:LinkButton ID="LinkButton2" runat="server"><h4><span class="text-info"><strong>Putting Aluminum Shoot bolt lock</strong></span></h4></asp:LinkButton>
        </div>
        <div class="col-sm-2">
            <asp:LinkButton ID="LinkButton6" runat="server"><h4><span class="text-info"><strong>Assembling</strong></span></h4></asp:LinkButton>
        </div>
        <div class="col-sm-2">
            <asp:LinkButton ID="LinkButton3" runat="server"><h4><span class="text-info"><strong>Putting Accessories</strong></span></h4></asp:LinkButton>
        </div>
        <div class="col-sm-2">
            <asp:LinkButton ID="LinkButton7" runat="server"><h4><span class="text-info"><strong>Quality Control</strong></span></h4></asp:LinkButton>
        </div>
    </div>
        </asp:Panel>
</asp:Content>
