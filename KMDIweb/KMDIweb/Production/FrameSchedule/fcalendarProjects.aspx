<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fcalendarProjects.aspx.cs" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.fcalendarProjects" %>


<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title></title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
        <div class="container">
            <h3>Ongoing Projects</h3>
        </div>
    </div>
    <div class="container">

        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#Project">Projects</a></li>
            <li><a data-toggle="tab" href="#SpecialSystem">Specialized System</a></li>
        </ul>

        <div class="tab-content">
            <div id="Project" class="tab-pane fade in active">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>

                        <div class="row nopm">
                            <div class="col-sm-6 nopm">
                                <div class="well well-sm">
                                    <div class="input-group">
                                        <div class="input-group-addon">AE/Engr:</div>
                                        <asp:DropDownList ID="ddlae" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="LinkButton1" Style="background-color: #ff006e; border-color: #ff006e"
                                                CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 nopm">
                                <div class="alert alert-danger alert-dismissible" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <strong>Selected Filter:</strong>
                                    <asp:Label ID="lblSelectedAE" runat="server"></asp:Label>
                                </div>
                            </div>

                        </div>


                        <div style="background-color: #ff006e; width: 100%; padding: 5px; font-size: larger; color: white; font-family: Calibri;">
                            <span>Production Load Points
                            </span>
                            <span class="pull-right">
                                <asp:Label ID="lblTotalPoints" runat="server"></asp:Label>
                            </span>
                        </div>
                        <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
                            <asp:GridView ID="GridView3" Width="100%" Style="font-family: Calibri; white-space: nowrap;" runat="server" AutoGenerateColumns="False"
                                PageSize="100" AllowPaging="True" CellPadding="3" OnPageIndexChanging="GridView3_PageIndexChanging" OnRowDataBound="GridView3_RowDataBound">
                                <Columns>

                                    <asp:TemplateField HeaderText="PROJECT">
                                        <ItemTemplate>
                                            <asp:Label ID="lblproject" runat="server" Text='<%# Bind("PROJECT_LABEL") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SCHEDULE">
                                        <ItemTemplate>
                                            <div class="text-right">
                                                <asp:Label ID="lblschedule" runat="server" Text='<%# Bind("SCHEDULE") %>'></asp:Label>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="">
                                        <ItemTemplate>
                                            <div class="text-right">
                                                <asp:Label ID="lblProdStatus" runat="server" ForeColor="Red" CssClass='<%# Eval("Prod_Status").ToString() == "Delay" ? "glyphicon glyphicon-warning-sign" : "" %>'></asp:Label>

                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="LOAD POINTS">
                                        <ItemTemplate>
                                            <div class="text-right">
                                                <span><%# Convert.ToInt32(Eval("points")).ToString("n0") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="LOAD %POINTS">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <span style="color: blue"><%# Eval("points_per") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FAB. POINTS">
                                        <ItemTemplate>
                                            <div class="text-right text-muted">
                                                <span><%# Eval("fab_points") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FAB. %POINTS">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <span style="color: green"><%# Eval("fab_points_per") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="J.O. POINTS">
                                        <ItemTemplate>
                                            <div class="text-right text-muted">
                                                <span><%# Eval("contract_points") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="J.O.">
                                        <ItemTemplate>
                                            <div>
                                                <asp:Label ID="lblPoints" runat="server" Text='<%# Bind("Points") %>' Visible="false"></asp:Label>
                                                <span class="text-muted" style=""><%# Eval("sub_jo") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerSettings Position="TopAndBottom" />
                                <PagerStyle CssClass="GridPager" />
                                <EmptyDataTemplate>
                                    <p style="font-size: x-large" class="text-danger">Empty Table</p>
                                </EmptyDataTemplate>
                            </asp:GridView>
                            </span>
                        </asp:Panel>
                        <div style="background-color: #ffd800; width: 100%; padding: 5px; font-size: larger; color: black; font-family: Calibri;">
                            <span><span style="color: red" class="glyphicon glyphicon-warning-sign"></span>Overdue Points
                            </span>
                            <span class="pull-right">
                                <asp:Label ID="lblDelayPoints" runat="server"></asp:Label>
                            </span>
                        </div>

                        </span>


                        </span>


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
                                            <span class="text-primary">
                                                <asp:Label ID="lbllocation" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label></span>
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
