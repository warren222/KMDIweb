﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/ScreenSchedule/ScreenScheduleMaster.Master" CodeBehind="home.aspx.cs" Inherits="KMDIweb.SCREENfab.home" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>

    <style>
        .vl {
            border-left: 6px solid;
            border-color: deeppink;
        }

        .banner {
            background-color: #900fa7;
            padding-bottom: 20px;
            padding-top: 40px;
            padding-left: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="jumbotron">
        <div class="row">
            <div class="col-sm-6">
                <h1><strong>Screen Fabrication Monitoring </strong>
                    <small>WEB App</small></h1>
            </div>
            <div class="col-sm-6">

                <table class="table" border="0">
                    <tr>
                        <td style="background-color: LightBlue">Mon</td>
                        <td style="background-color: LightGreen">Tue</td>
                        <td style="background-color: Yellow">Wed</td>
                        <td style="background-color: Orange">Thu</td>
                        <td style="background-color: Pink">Fri</td>
                        <td style="background-color: Violet">Sat</td>
                        <td style="background-color: Teal">Sun</td>
                    </tr>
                    <tr>
                        <td colspan="7" style="background-color: LightSeaGreen; color: white">Fabricated</td>
                    </tr>
                </table>


            </div>
        </div>
    </div>


    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
            <div class="row" style="margin-bottom: 20px; margin-left: 20px;">
                <div class="col-sm-4 vl">

                    <h3 class="text-muted">Previous weeks <small>in progress</small> </h3>
                    <asp:LinkButton ID="BTNprevweektime" runat="server" Font-Size="XX-Large" OnClick="BTNprevweektime_Click">Time</asp:LinkButton>
                    <br />
                    <asp:Label ID="LBLprevweekitem" BackColor="Red" Font-Size="Medium" CssClass="text-center badge" runat="server"></asp:Label>&nbsp;k#(s)
             
                </div>
                <div class="col-sm-4 vl">


                    <h3 class="text-muted">Due for Today <small>in progress</small> </h3>

                    <asp:LinkButton ID="BTNtodaytime" runat="server" Font-Size="XX-Large" OnClick="BTNtodaytime_Click">Time</asp:LinkButton>
                    <br />
                    <asp:Label ID="LBLtodayitem" BackColor="Red" Font-Size="Medium" CssClass="badge" runat="server"></asp:Label>&nbsp;k#(s)
            
                </div>
                <div class="col-sm-4 vl">

                    <h3 class="text-muted">This week <small>in progress</small> </h3>
                    <asp:LinkButton ID="BTNCurrentweektime" runat="server" Font-Size="XX-Large" OnClick="BTNCurrentweektime_Click">Time</asp:LinkButton>
                    <br />
                    <asp:Label ID="LBLcurrentweekitem" BackColor="Red" Font-Size="Medium" CssClass="text-center badge" runat="server"></asp:Label>&nbsp;k#(s)
               
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4><span>Filter Option</span></h4>
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="input-group" style="width: 100%">
                                <div class="input-group-addon" style="width: 110px; background-color: cornflowerblue; color: white">
                                    DATE BEGIN
                                </div>
                                <asp:TextBox ID="tboxBdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>

                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="input-group" style="width: 100%">
                                <div class="input-group-addon" style="width: 110px; background-color: cornflowerblue; color: white">
                                    DATE END
                                </div>
                                <asp:TextBox ID="tboxEdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="input-group" style="width: 100%">
                                <div class="input-group-addon" style="width: 110px; background-color: cornflowerblue; color: white">
                                    PROJECT
                                </div>
                                <asp:TextBox ID="TBOXprojectname" placeholder="project name" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="BTNsearch" CssClass="btn btn-primary" runat="server" OnClick="BTNsearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>

                    <br />

                    <div class="container">

                        <div class="input-group">
                            <div class="input-group-addon">
                                NFC
                            </div>
                            <asp:DropDownList ID="DDLnfc" CssClass="form-control" runat="server">
                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>

                            </asp:DropDownList>


                            <div class="input-group-addon">
                                Address
                            </div>
                            <asp:DropDownList ID="DDLaddress" CssClass="form-control" runat="server">
                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                <asp:ListItem Text="Out-of-town" Value="Out-of-town"></asp:ListItem>
                                <asp:ListItem Text="Intown" Value="Intown"></asp:ListItem>
                            </asp:DropDownList>



                            <div class="input-group-addon">
                                Progress
                            </div>
                            <asp:DropDownList ID="DDLprogress" CssClass="form-control" runat="server">
                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                <asp:ListItem Text="Finished" Value="Finished"></asp:ListItem>
                                <asp:ListItem Text="In progress" Value="In progress"></asp:ListItem>
                            </asp:DropDownList>

                        </div>
                    </div>
                </div>
            </div>

            <div class="panel-body">
                <h1 class="text-center text-success"><span>
                    <asp:Label ID="LBLschedule" runat="server" CssClass="forfont" Text="Schedule"></asp:Label>
                </span></h1>
                <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">

                    <small>
                        <asp:GridView ID="GridView1" CssClass="table tbl" AutoGenerateColumns="False" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="25" OnDataBound="GridView1_DataBound" CellPadding="4" ForeColor="Black" GridLines="Vertical" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" OnRowCommand="GridView1_RowCommand">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="DUE DATE" HeaderStyle-Width="500px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLparentjono" Visible="false" runat="server" Text='<%# Bind("parentjono") %>'></asp:Label>
                                        <asp:Label ID="LBLrealduedate" Visible="false" runat="server" Text='<%# Bind("real_duedate") %>'></asp:Label>
                                        <asp:Label ID="LBLschedremarks" Visible="false" runat="server" Text='<%# Bind("sched_remarks") %>'></asp:Label>
                                        <asp:Label ID="LBLstatus" Visible="false" runat="server" Text='<%# Bind("status") %>'></asp:Label>

                                        <asp:Label ID="LBLduedate" Font-Size="Large" Font-Bold="true" runat="server" Text='<%# Bind("DUE_DATE") %>'></asp:Label><br />
                                        <asp:Label ID="LBLyear" runat="server" Text='<%# Bind("YEAR") %>'></asp:Label><br />
                                        <asp:Label ID="LBLday" Font-Bold="true" runat="server" Text='<%# Bind("DAY") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PROJECT" HeaderStyle-Width="150px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLprojectname" runat="server" Font-Size="Small" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label><br />
                                        <asp:Label ID="LBLaddress" runat="server" CssClass="text-muted" Font-Size="Small" Text='<%# Bind("FULLADD") %>'></asp:Label><br />
                                        <br />

                                        AE :<asp:Label ID="LBLae" runat="server" CssClass="text-info" Font-Size="Small" Text='<%# Bind("AE") %>'></asp:Label><br />
                                        Engineer :<asp:Label ID="LBLengr" runat="server" CssClass="text-info" Font-Size="Small" Text='<%# Bind("ENGR") %>'></asp:Label><br />
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
                                <asp:TemplateField HeaderText="CL CTRL#" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLclno" runat="server" Text='<%# Bind("CLNO") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RELEASED DATE" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLcuttinglist" runat="server" Text='<%# Bind("CUTTING_LIST") %>'></asp:Label>
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
                                <asp:TemplateField HeaderText="DATE FABRICATED" HeaderStyle-BackColor="LightSeaGreen" HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLfinished" runat="server" Font-Size="Small" Font-Bold="true" Text='<%# Bind("FINISHED") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="LightSeaGreen" ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="TIME VALUE" HeaderStyle-BackColor="Wheat" HeaderStyle-ForeColor="Black">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLtime" Font-Bold="true" Font-Size="Small" runat="server" Text='<%# Bind("ACTUAL_TIME") %>'></asp:Label>
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
                    </small>
                    <h3>Total Items:  
                        <asp:Label ID="totalQtyLBL" runat="server" Text="TOTAL QTY"></asp:Label></h3>
                </asp:Panel>

                <asp:Panel ID="Panel2" runat="server" Visible="false">
                    <h4 class="text-warning text-center"><span style="font-size: xx-large">Item Progress</span></h4>
                    <asp:LinkButton ID="LINKexit" CssClass=" form-control btn-warning text-center" runat="server" Font-Size="Larger" OnClick="LINKexit_Click">Go back to schedule</asp:LinkButton>
                    <small>
                        <asp:Panel ID="Panel10" runat="server" ScrollBars="Auto">
                            <asp:GridView ID="GridView2" CssClass="table tbl" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" OnPageIndexChanging="GridView2_PageIndexChanging" OnDataBound="GridView2_DataBound">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>
                                    <asp:TemplateField HeaderText="DUE DATE">
                                        <ItemTemplate>
                                            <asp:Label ID="g2LBLduedate" Font-Bold="true" runat="server" Text='<%# Bind("DUE_DATE") %>'></asp:Label>
                                            <asp:Label ID="g2LBLday" CssClass="text-muted" Visible="true" runat="server" Text='<%# Bind("DAY") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PROJECT">
                                        <ItemTemplate>
                                            <asp:Label ID="LBLg2projectname" runat="server" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="K#" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="LBLg2kmdino" runat="server" Text='<%# Bind("KMDI_NO") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="LOCATION / TYPE OF SCREEN" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <span>
                                                <asp:Label ID="lblItem_No" runat="server" CssClass="text-danger" Text='<%# Bind("ITEM_NO") %>'></asp:Label></span>&nbsp;&nbsp;
                                            <asp:Label ID="LBLlocation" runat="server" CssClass="text-info" Text='<%# Bind("LOCATION") %>'></asp:Label>&nbsp;
                                        <asp:Label ID="LBLg2screentype" runat="server" Text='<%# Bind("TYPE_OF_SCREEN") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SECTION" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="LBLg2currentstation" runat="server" Text='<%# Bind("CURRENTSTATION") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="REMARKS" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="LBLg2schedstatus" runat="server" Font-Bold="true" CssClass="text-danger" Text='<%# Bind("STATUS") %>'></asp:Label>&nbsp;
                                           <asp:Label ID="LBLg2sched_remarks" runat="server" Text='<%# Bind("SCHED_REMARKS") %>'></asp:Label>
                                            <%--    <asp:Label ID="LBLgremarks" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>--%>
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
                                <EmptyDataTemplate>
                                    <div>
                                        <h3><strong>Sorry, No Result Found!</strong>
                                        </h3>
                                    </div>
                                </EmptyDataTemplate>
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
                    </small>
                </asp:Panel>
            </div>
            <div class="panel-footer" style="background-color: white">
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
