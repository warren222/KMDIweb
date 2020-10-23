<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIapp/KMDIwebMaster.Master" CodeBehind="sccutting.aspx.cs" Inherits="KMDIweb.KMDIapp.sccutting" %>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class=" jumbotron">
        <div class="row">
            <div class="col-sm-6">
                <h1><strong>For Cutting<br />
                    <small>Station's expected output</small> </strong></h1>
                <asp:LinkButton ID="BTNback" runat="server" PostBackUrl="~/KMDIapp/home.aspx" CssClass="btn btn-primary">back to home page</asp:LinkButton>
            </div>
            <div class="col-sm-6">
                <table class="table">
                    <tr>
                        <td style="background-color: LightBlue">Mon</td>
                        <td style="background-color: LightGreen">Tue</td>
                        <td style="background-color: Yellow">Wed</td>
                        <td style="background-color: Orange">Thu</td>
                        <td style="background-color: Pink">Fri</td>
                        <td style="background-color: Violet">Sat</td>
                        <td style="background-color: Teal">Sun</td>
                    </tr>
                  
                </table>
                <table class="table">
                      <tr>
                        <td style="background-color: indigo; color: white">Cutting</td>
                        <td style="background-color: brown; color: white">Fabricated</td>
                    </tr>
                </table>
            </div>
        </div>

    </div>
    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />

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
                                    <asp:LinkButton ID="BTNsearch" CssClass="btn btn-primary" runat="server" OnClick="BTNsearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="panel-body">
                    <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
                        <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" PageSize="25" OnDataBound="GridView1_DataBound" OnRowCommand="GridView1_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="DUE DATE" HeaderStyle-Width="500px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLduedate" Font-Size="X-Large" Font-Bold="true" runat="server" Text='<%# Bind("DUE_DATE") %>'></asp:Label><br />
                                        <asp:Label ID="LBLyear" runat="server" Text='<%# Bind("YEAR") %>'></asp:Label><br />
                                        <asp:Label ID="LBLday" Font-Bold="true" runat="server" Text='<%# Bind("DAY") %>'></asp:Label>

                                        <asp:Label ID="LBLparentjono" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("parentjono") %>'></asp:Label>
                                        <asp:Label ID="LBLddate" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("ddate") %>'></asp:Label>
                                        <asp:Label ID="LBLschedremarks" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("sched_remarks") %>'></asp:Label>

                                        <asp:Label ID="LBLstatus" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("status") %>'></asp:Label>
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
                                        <asp:LinkButton ID="LINKkno" runat="server" CommandName="forcutting" Font-Bold="true" Text='<%# Bind("KNO") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CL ctrl no.">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLclno" runat="server" Text='<%# Bind("CLNO") %>'></asp:Label>
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
                                <asp:TemplateField HeaderText="CUTTING DATE" HeaderStyle-BackColor="Indigo" HeaderStyle-ForeColor="White">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLcutting" Font-Size="Small" runat="server" Font-Bold="true" Text='<%# Bind("CUTTING") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="Violet" ForeColor="Black" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FABRICATED" HeaderStyle-BackColor="Brown" HeaderStyle-ForeColor="white">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLfinished" Font-Bold="true" runat="server" Text='<%# Bind("finished") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black" />
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle Wrap="False" BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerSettings PageButtonCount="8" Position="TopAndBottom" />

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

                    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" Visible="false">
                        <div class="navbar-right">
                              <asp:LinkButton ID="LINKexit" CssClass="btn btn-danger" runat="server" OnClick="LINKexit_Click">Exit</asp:LinkButton>
                        </div>

                        <asp:GridView ID="GridView2" CssClass="table" runat="server" CellPadding="4" ForeColor="Black" AllowPaging="True" AutoGenerateColumns="False" OnDataBound="GridView2_DataBound" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2" OnPageIndexChanging="GridView2_PageIndexChanging" OnRowCommand="GridView2_RowCommand" PageSize="25">
                            <Columns>
                                <asp:TemplateField HeaderText="DUE DATE">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLduedate" Font-Size="Medium" Font-Bold="true" runat="server" Text='<%# Bind("DUE_DATE") %>'></asp:Label><br />
                                        <asp:Label ID="g2LBLday" Font-Bold="true" Visible="false" runat="server" Text='<%# Bind("DAY") %>'></asp:Label><br />
                                        <asp:Label ID="g2LBLjoborderno" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("job_order_no") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PROJECT" HeaderStyle-Width="250px">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLprojectname" runat="server" Font-Size="Small" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="K#">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLkno" runat="server" Font-Bold="true" Text='<%# Bind("kmdi_no") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CL ctrl no.">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLclno" runat="server" Text='<%# Bind("CLNO") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="COLOR">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLcolor" runat="server" Text='<%# Bind("COLOR") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TYPE OF SCREEN">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLscreentype" runat="server" Text='<%# Bind("TYPE_OF_SCREEN") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="REMARKS">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLremarks" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CUTTING DATE" HeaderStyle-BackColor="Indigo" HeaderStyle-ForeColor="White">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLcutting" Font-Size="Small" runat="server" Font-Bold="true" Text='<%# Bind("CUTTING") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="Violet" ForeColor="Black" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="BTNcheck"  CommandName="check" Visible='<%# Eval("CUTTING").ToString() == "" ? true : false %>' runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-ok"></span>&nbsp; Check</asp:LinkButton>
                                         <asp:LinkButton ID="BTNuncheck"  CommandName="uncheck" Visible='<%# Eval("uncheck").ToString() == "true" ? true : false %>' runat="server" CssClass="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp; Uncheck</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCCCC" />
                            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                            <PagerSettings Position="TopAndBottom" PageButtonCount="8" />
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Left" BackColor="#CCCCCC" ForeColor="Black" />
                            <RowStyle BackColor="White" Wrap="False" />
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
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
