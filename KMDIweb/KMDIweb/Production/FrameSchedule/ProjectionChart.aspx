<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="ProjectionChart.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.ProjectionChart" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PROJECTED DELIVERY DATE</title>
</asp:Content>
<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="content">

    <div class="container">
        <div class="well text-center">
            <h3><strong>ESTIMATED DELIVERY POINTS</strong> </h3>
            <div class="input-group">
                <div class="input-group-addon">
                    YEAR
                </div>
                <asp:TextBox ID="tboxYear" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">submit</asp:LinkButton>
                </div>
            </div>

        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">

                    <asp:GridView ID="GridView1" HeaderStyle-BackColor="DimGray" ForeColor="White" runat="server" AutoGenerateColumns="false" CssClass="table text-center">
                        <Columns>
                            <asp:TemplateField HeaderText="TOTAL" ItemStyle-BackColor="DimGray">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("TOTAL") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Engineers' Projection" ItemStyle-BackColor="Green">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("a") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account Executives' Estimation" ItemStyle-BackColor="#0101C0">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("b") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delivered Points" ItemStyle-BackColor="#FF8001">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("c") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="text-center">
                                ONGOING PROJECTS ONLY
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-4"></div>
                                <div class="col-sm-4">
                                    <asp:Panel ID="Panel2" Visible="false" runat="server">
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                Year
                                            </div>
                                            <asp:TextBox ID="tboxYear2" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>

                                        </div>
                                    </asp:Panel>

                                </div>
                                <div class="col-sm-4">
                                    <div class="input-group">
                                        <div class="input-group-addon">
                                            search by
                                        </div>
                                        <asp:DropDownList ID="ddlsearchby" CssClass="form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlsearchby_SelectedIndexChanged">
                                            <asp:ListItem Text="All Year" Value="All"></asp:ListItem>
                                            <asp:ListItem Text="Selected Year" Value="Selected"></asp:ListItem>
                                        </asp:DropDownList>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" runat="server" OnClick="LinkButton2_Click">search</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <br />
                            <br />
                            <asp:GridView ID="GridView7" Width="100%" AutoGenerateColumns="False" runat="server" ShowHeader="False" GridLines="None">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div style="font-size: x-large">
                                                <span>Total Current Contract Points</span>
                                                <span class="text-right pull-right">
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Total_Current_Contract_Points") %>'></asp:Label><br />
                                                    <asp:Label ID="Label7" CssClass="text-muted" runat="server" Text='<%# Bind("TotalProjects") %>'></asp:Label><br />
                                                    (<asp:Label ID="Label2" runat="server" Text='<%# Bind("Total_Points_Delivered_based_on_Current_Contracts") %>'></asp:Label>)<br />
                                                    (<asp:Label ID="Label3" runat="server" Text='<%# Bind("Ongoing_Fab_scheduled") %>'></asp:Label>)<br />
                                                    (<asp:Label ID="Label4" runat="server" Text='<%# Bind("SD_at_hand") %>'></asp:Label>)<br />
                                                    <span>
                                                        <asp:Label ID="Label5" Font-Bold="true" CssClass="text-primary" Font-Size="X-Large" runat="server" Text='<%# Bind("Points_to_receive") %>'></asp:Label></span><br />
                                                    <br />
                                                    <asp:Label ID="Label6" Font-Bold="true" CssClass="text-primary" Font-Size="X-Large" runat="server" Text='<%# Bind("Ongoing_Fab_scheduled") %>'></asp:Label>
                                                </span>
                                                <br />
                                                <span>Total number of Projects</span><br />
                                                <span>Total Points Delivered</span><br />
                                                <span>Ongoing Fab</span><br />
                                                <span>SD at Hand</span><br />
                                                <span style="font-size: x-large;font-weight:bold">Points yet to receive</span>
                                                <br />
                                                <br />
                                                <span style="font-size: x-large;font-weight:bold">Current Production Load</span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                        </div>
                        <div class="panel-footer">
                        </div>
                    </div>
                            </ContentTemplate>
                    </asp:UpdatePanel>



                    <asp:Chart ID="Chart1" runat="server" Width="1049px" Height="1500px" Palette="None" PaletteCustomColors="Green; 0, 0, 192; 255, 128, 0">

                        <%--   <Legends>
                            <asp:Legend Name="Legend1">
                            </asp:Legend>
                        </Legends>--%>

                        <Titles>
                            <asp:Title Text="Projected Delivery Date Points"></asp:Title>
                        </Titles>
                        <Series>
                            <asp:Series Name="Engineers' Projection" IsValueShownAsLabel="true" IsVisibleInLegend="true" XValueMember="MM" YValueMembers="engr_projection" ChartArea="ChartArea1" ChartType="Bar" Legend="Legend1">
                            </asp:Series>
                            <asp:Series Name="AEs' Estimation" IsValueShownAsLabel="true" IsVisibleInLegend="true" XValueMember="MM" YValueMembers="ae_estimation" ChartArea="ChartArea1" ChartType="Bar" Legend="Legend1">
                            </asp:Series>
                            <asp:Series Name="Fabricated Points" IsValueShownAsLabel="true" IsVisibleInLegend="true" XValueMember="MM" YValueMembers="delivered_points" ChartArea="ChartArea1" ChartType="Bar" Legend="Legend1">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisX Title="Month">
                                    <MajorGrid Enabled="false" />
                                </AxisX>
                                <AxisY Title="Frame Points">
                                    <MajorGrid Enabled="false" />
                                </AxisY>
                                <%--   <Area3DStyle Enable3D="true" />--%>
                            </asp:ChartArea>
                        </ChartAreas>

                    </asp:Chart>


                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
