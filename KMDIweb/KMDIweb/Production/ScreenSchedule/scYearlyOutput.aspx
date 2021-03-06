﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/ScreenSchedule/ScreenScheduleMaster.Master" CodeBehind="scYearlyOutput.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.ScreenSchedule.scYearlyOutput" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Yearly output insight</title>
</asp:Content>
<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="content">
    <div class="well">
        <h2>Screen Fabrication Load/Output Summary</h2>
    </div>
    <div class="container">
        <div class="well">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <h2>Chart</h2>

                    <div class="row">
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon" style="background-color: cornflowerblue">
                                    <span style="color: white"><b>year</b></span>
                                </div>
                                <asp:TextBox ID="tboxy1" CssClass="form-control" TextMode="Number" MaxLength="9999" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon" style="background-color: orange">
                                    <span style="color: white"><b>year</b></span>
                                </div>
                                <asp:TextBox ID="tboxy2" CssClass="form-control" TextMode="Number" MaxLength="9999" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon">
                                </div>
                                <asp:DropDownList ID="ddlSearchby" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="Output" Text="Output"></asp:ListItem>
                                    <asp:ListItem Value="Load" Text="Load"></asp:ListItem>
                                </asp:DropDownList>

                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon">
                                </div>
                                <asp:DropDownList ID="ddlChartType" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChartType_SelectedIndexChanged"></asp:DropDownList>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnsubmit" CssClass="btn btn-default" runat="server" OnClick="btnsubmit_Click">submit</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
                        <asp:Chart ID="Chart1" runat="server" Width="1049px" Height="506px">

                            <Titles>
                                <asp:Title Text="Monthly Screen Fabrication Chart"></asp:Title>
                            </Titles>
                            <Series>
                                <asp:Series Name="Year_1" IsValueShownAsLabel="true" IsVisibleInLegend="true" XValueMember="MM" YValueMembers="qty1" ChartArea="ChartArea1" ChartType="Column" Legend="Legend1">
                                </asp:Series>
                                <asp:Series Name="Year_2" IsValueShownAsLabel="true" IsVisibleInLegend="true" XValueMember="MM" YValueMembers="qty2" ChartArea="ChartArea1" ChartType="Column" Legend="Legend1">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisX Title="Month"></AxisX>
                                    <AxisY Title="Screen Quantity"></AxisY>
                                    <%--    <Area3DStyle Enable3D="true" />--%>
                                </asp:ChartArea>
                            </ChartAreas>

                        </asp:Chart>
                    </asp:Panel>
                    <%--   <div class="row">
                <div class="col-sm-6">
                    <asp:DropDownList ID="ddlSortDirection" AutoPostBack="true"  CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlSortDirection_SelectedIndexChanged">
                        <asp:ListItem Text="Ascending" Value="ASC"></asp:ListItem>
                        <asp:ListItem Text="Descending" Value="DESC"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-sm-6">
                        <asp:DropDownList ID="ddlSortBy"  AutoPostBack="true" CssClass="form-control" runat="server" OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged">
                        <asp:ListItem Text="Month" Value="AxisLabel"></asp:ListItem>
                        <asp:ListItem Text="Quantity" Value="Y"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>--%>

                    <br />
                    <h2>Table</h2>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    Sort Order
                                </div>
                                <asp:DropDownList ID="ddlOrderBy" CssClass="form-control" runat="server">
                                    <asp:ListItem Text="Ascending" Value="ASC"></asp:ListItem>
                                    <asp:ListItem Text="Descending" Value="DESC"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                        </div>
                        <div class="col-sm-6">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    Sort By<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="mm" ControlToValidate="ddlSortBy" ForeColor="Red" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>
                                <asp:DropDownList ID="ddlSortBy" CssClass="form-control" runat="server">
                                </asp:DropDownList>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSort" ValidationGroup="mm" CssClass="btn btn-default" runat="server" OnClick="btnSort_Click">SORT</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" OnRowDataBound="GridView1_RowDataBound" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
                        <AlternatingRowStyle BackColor="PaleGoldenrod" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <%# Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Month">

                                <ItemTemplate>
                                    <asp:Label ID="lblMM" runat="server" Text='<%# Bind("MM") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblheadery1" runat="server" Text="Label"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbly1" runat="server" Text='<%# Bind("qty1Formated") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblheadery2" runat="server" Text="Label"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbly2" runat="server" Text='<%# Bind("qty2Formated") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>

                        <FooterStyle BackColor="Tan" />
                        <HeaderStyle BackColor="Tan" Font-Bold="True" />
                        <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                        <SortedAscendingCellStyle BackColor="#FAFAE7" />
                        <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                        <SortedDescendingCellStyle BackColor="#E1DB9C" />
                        <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
