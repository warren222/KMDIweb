<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fcalendarProjects.aspx.cs" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.fcalendarProjects" %>


<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title></title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <br />
        <div class="well">
            <h1>Ongoing Projects
            </h1>
        </div>
        <br />
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#Project">Projects</a></li>
            <li><a data-toggle="tab" href="#SpecialSystem">Specialized System</a></li>
        </ul>

        <div class="tab-content">
            <div id="Project" class="tab-pane fade in active">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="well">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    AE/ENGR.
                                </div>
                                <asp:DropDownList ID="ddlae" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">sort</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">

                            <asp:GridView ID="GridView3" CssClass="table" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="Both" PageSize="100" AllowPaging="True" OnPageIndexChanging="GridView3_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField HeaderText="PROJECT">
                                        <ItemTemplate>
                                            <asp:Label ID="lblproject" runat="server" Text='<%# Bind("PROJECT_LABEL") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="POINTS">
                                        <ItemTemplate>
                                            <asp:Label ID="lblpoints" runat="server" Text='<%# Bind("POINTS") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SCHEDULE">
                                        <ItemTemplate>
                                            <asp:Label ID="lblschedule" runat="server" Text='<%# Bind("SCHEDULE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                                <PagerSettings Position="TopAndBottom" />
                                <PagerStyle CssClass="GridPager" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                                <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#594B9C" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#33276A" />
                            </asp:GridView>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div id="SpecialSystem" class="tab-pane fade">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="well">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    AE/ENGR.
                                </div>
                                <asp:DropDownList ID="ddlae2" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" runat="server" OnClick="LinkButton2_Click">sort</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <asp:Panel ID="Panel2" ScrollBars="Auto" runat="server">

                            <asp:GridView ID="GridView1" CssClass="table" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="Both" PageSize="100" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField HeaderText="PROJECT">
                                        <ItemTemplate>
                                            <asp:Label ID="lblproject" runat="server" Text='<%# Bind("PROJECT_LABEL") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description">
                                        <ItemTemplate>
                                            <asp:Label ID="lblkno" Font-Bold="true" runat="server" Text='<%# Bind("KMDI_NO") %>'></asp:Label>
                                            <br />
                                            (<asp:Label ID="lblwidth" runat="server" Text='<%# Bind("WIDTH") %>'></asp:Label>&nbsp;X&nbsp;
                                              <asp:Label ID="lblheight" runat="server" Text='<%# Bind("HEIGHT") %>'></asp:Label>)
                                            <br />
                                            <asp:Label ID="lbldescription" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label><br />
                                            <span class="text-primary"><asp:Label ID="lbllocation" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="POINTS">
                                        <ItemTemplate>
                                            <asp:Label ID="lblpoints" runat="server" Text='<%# Bind("POINTS") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SCHEDULE">
                                        <ItemTemplate>
                                            <asp:Label ID="lblschedule" runat="server" Text='<%# Bind("SCHEDULE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                                <PagerSettings Position="TopAndBottom" />
                                <PagerStyle CssClass="GridPager" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                                <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#594B9C" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#33276A" />
                            </asp:GridView>

                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
