<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIapp/KMDIwebMaster.Master" CodeBehind="home.aspx.cs" Inherits="KMDIweb.SCREENfab.home" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>

    <script type="text/javascript">

        $(function () {
            $(".progress").each(function () {
                var $this = $(this),
                    value = parseInt($this.find('.progress-bar').text());
                $this.progressbar({
                    value: value
                });
                // Here, "value" gives the used space value.
            });
        });

    </script>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class=" jumbotron">
        <div class="row">
            <div class="col-sm-6">
                <h1><strong>Screen Fabrication Monitoring<br />
                    <small>Web Site!</small> </strong></h1>
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
                        <td style="background-color: brown; color: white">Fabricated</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>



    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
            <div class="row">
                <div class="col-sm-4">
                    <blockquote>
                        <h5><strong class="text-muted">Previous Week Unfinished</strong></h5>
                        <asp:LinkButton ID="BTNprevweektime" runat="server" Font-Size="XX-Large" OnClick="BTNprevweektime_Click">Time</asp:LinkButton>
                        <br />
                        <asp:Label ID="LBLprevweekitem" CssClass="text-center" runat="server" Text="k#(s)"></asp:Label>
                    </blockquote>
                </div>
                <div class="col-sm-4">

                    <blockquote>
                        <h5><strong class="text-muted">Today Unfinished</strong></h5>

                        <asp:LinkButton ID="BTNtodaytime" runat="server" Font-Size="XX-Large" OnClick="BTNtodaytime_Click">Time</asp:LinkButton>
                        <br />
                        <asp:Label ID="LBLtodayitem" CssClass="text-center" runat="server" Text="k#(s)"></asp:Label>
                    </blockquote>
                </div>
                <div class="col-sm-4">
                    <blockquote>
                        <h5><strong class="text-muted">Current week Unfinished</strong></h5>
                        <asp:LinkButton ID="BTNCurrentweektime" runat="server" Font-Size="XX-Large" OnClick="BTNCurrentweektime_Click">Time</asp:LinkButton>
                        <br />
                        <asp:Label ID="LBLcurrentweekitem" CssClass="text-center" runat="server" Text="k#(s)"></asp:Label>
                    </blockquote>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4><span>Filter Option</span></h4>
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    DATE BEGIN
                                </div>
                                <asp:TextBox ID="tboxBdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>

                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    DATE END
                                </div>
                                <asp:TextBox ID="tboxEdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    PROJECT
                                </div>
                                <asp:TextBox ID="TBOXprojectname" placeholder="project name" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-addon">
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked="true" />&nbsp;Finished
                                </div>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="BTNsearch" CssClass="btn btn-default" runat="server" OnClick="BTNsearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="panel-body">
                    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                        <h3 class="text-center text-success"><span><strong>
                            <asp:Label ID="LBLschedule" runat="server" CssClass="forfont" Text="Schedule"></asp:Label></strong> </span></h3>
                        <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="25" OnDataBound="GridView1_DataBound" CellPadding="4" ForeColor="Black" GridLines="Vertical" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" OnRowCommand="GridView1_RowCommand">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="DATE" HeaderStyle-Width="500px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLparentjono" Visible="false" runat="server" Text='<%# Bind("parentjono") %>'></asp:Label>
                                        <asp:Label ID="LBLrealduedate" Visible="false" runat="server" Text='<%# Bind("real_duedate") %>'></asp:Label>
                                        <asp:Label ID="LBLschedremarks" Visible="false" runat="server" Text='<%# Bind("sched_remarks") %>'></asp:Label>
                                        <asp:Label ID="LBLstatus" Visible="false" runat="server" Text='<%# Bind("status") %>'></asp:Label>

                                        <asp:Label ID="LBLduedate" Font-Size="X-Large" Font-Bold="true" runat="server" Text='<%# Bind("DUE_DATE") %>'></asp:Label><br />
                                        <asp:Label ID="LBLyear" runat="server" Text='<%# Bind("YEAR") %>'></asp:Label><br />
                                        <asp:Label ID="LBLday" Font-Bold="true" runat="server" Text='<%# Bind("DAY") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PROJECT" HeaderStyle-Width="150px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLprojectname" runat="server" Font-Size="Small" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="K#" HeaderStyle-Width="350px" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="BTNkno" runat="server" CommandName="loadkno" Font-Bold="true" Text='<%# Bind("KNO") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="COLOR" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLcolor" runat="server" Text='<%# Bind("COLOR") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="QTY" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLqty" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TYPE OF SCREEN" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLscreentype" runat="server" Text='<%# Bind("TYPE_OF_SCREEN") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="REMARKS" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLremarks" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DATE FINISHED" HeaderStyle-BackColor="Brown" HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLfinished" runat="server" Font-Size="Small" Font-Bold="true" Text='<%# Bind("FINISHED") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="Brown" ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="TIME" HeaderStyle-BackColor="Wheat" HeaderStyle-ForeColor="Black">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLtime" Font-Bold="true" Font-Size="Medium" runat="server" Text='<%# Bind("ACTUAL_TIME") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="Wheat" ForeColor="Black" />
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="GridPager" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle Wrap="False" BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerSettings PageButtonCount="8" Position="TopAndBottom" />

                            <EmptyDataTemplate>
                                <div>
                                    <h3><strong>Sorry, No Result Found!</strong>
                                    </h3>
                                </div>
                            </EmptyDataTemplate>
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>

                    </asp:Panel>

                    <asp:Panel ID="Panel2" runat="server" Visible="false">
                        <h4 class="text-warning text-center"><span style="font-size: xx-large">Item Progress</span></h4>
                        <asp:LinkButton ID="LINKexit" CssClass=" form-control btn-warning text-center" runat="server" Font-Size="Larger" OnClick="LINKexit_Click">Go back to schedule</asp:LinkButton>
                        <asp:GridView ID="GridView2" CssClass="table" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" OnPageIndexChanging="GridView2_PageIndexChanging">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="PROJECT">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="K#">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("KMDI_NO") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TYPE OF SCREEN">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("TYPE_OF_SCREEN") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="STATION">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("CURRENTSTATION") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="35%">
                                    <ItemTemplate>

                                        <asp:Panel ID="Panel3" Visible='<%# Eval("PROGRESSVALUE").ToString() == "35" ? true : false %>' runat="server">
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-danger" role="progressbar"
                                                    aria-valuenow="35" aria-valuemin="0" aria-valuemax="100" style="width: 35%">
                                                    <span style="font-size: small">35% Complete </span>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel4" Visible='<%# Eval("PROGRESSVALUE").ToString() == "45" ? true : false %>' runat="server">
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-danger" role="progressbar"
                                                    aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">
                                                    <span style="font-size: small">45% Complete</span>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel5" Visible='<%# Eval("PROGRESSVALUE").ToString() == "60" ? true : false %>' runat="server">
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-warning" role="progressbar"
                                                    aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                                    <span style="font-size: small">60% Complete</span>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel6" Visible='<%# Eval("PROGRESSVALUE").ToString() == "70" ? true : false %>' runat="server">
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-warning" role="progressbar"
                                                    aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%">
                                                    <span style="font-size: small">70% Complete </span>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel7" Visible='<%# Eval("PROGRESSVALUE").ToString() == "80" ? true : false %>' runat="server">
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-warning" role="progressbar"
                                                    aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                                    <span style="font-size: small">80% Complete </span>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel8" Visible='<%# Eval("PROGRESSVALUE").ToString() == "90" ? true : false %>' runat="server">
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-info" role="progressbar"
                                                    aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width: 90%">
                                                    <span style="font-size: small">90% Complete</span>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel9" Visible='<%# Eval("PROGRESSVALUE").ToString() == "100" ? true : false %>' runat="server">
                                            <div class="progress">
                                                <div class="progress-bar progress-bar-success" role="progressbar"
                                                    aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                                                    <span style="font-size: small">100% Complete </span>
                                                </div>
                                            </div>
                                        </asp:Panel>

                                    </ItemTemplate>
                                    <HeaderStyle Width="500px" />
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                        </asp:GridView>
                    </asp:Panel>
                </div>
                <div class="panel-footer">
                    <asp:Label ID="LBLrowcount" runat="server" Text="Label"></asp:Label>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
