<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="FYearlyOutput.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.FYearlyOutput" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>POINTS INSIGHT</title>
</asp:Content>
<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="content">

    <div class="container">
        <div class="well text-center">
            <h3><strong>MONTHLY POINT'S SUMMARY</strong> </h3>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


        <div class="well">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <h3 class="text-center text-muted">Chart</h3>
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
                                    <asp:ListItem Value="SD_Received" Text="SD Received"></asp:ListItem>
                                    <asp:ListItem Value="Output" Text="Fabricated"></asp:ListItem>
                                    <asp:ListItem Value="Load" Text="Not Fabricated"></asp:ListItem>
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
                    <div style="overflow-x: auto;">
                        <table border="1" style="width: 100%; font-family: Calibri;font-size:x-large" >
                            <tr>
                                <th></th>
                                <th>
                                    <asp:Label ID="lblYear1Th" Font-Size="Larger" runat="server" ForeColor="Highlight" Text="Label"></asp:Label>
                                </th>
                                <th>
                                    <asp:Label ID="lblYear2Th" Font-Size="Larger" runat="server" ForeColor="Orange" Text="Label"></asp:Label>
                                </th>
                            </tr>
                            <tr>
                                <td>Total</td>
                                <td class="text-right">
                                    <asp:Label ID="lblYear1Total" runat="server" Text="Label"></asp:Label>
                                </td>
                                <td class="text-right">
                                    <asp:Label ID="lblYear2Total" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>Average</td>
                                <td class="text-right">
                                    <asp:Label ID="lblYear1Ave" runat="server" Text="Label"></asp:Label>
                                </td>
                                <td class="text-right">
                                    <asp:Label ID="lblYear2Ave" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
                        <asp:Chart ID="Chart1" runat="server" Width="1049px" Height="506px">

                            <Titles>
                                <asp:Title Text="Monthly Frame Points Chart"></asp:Title>
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
                                    <AxisY Title="Frame Points"></AxisY>
                                    <%--     <Area3DStyle Enable3D="true" />--%>
                                </asp:ChartArea>
                            </ChartAreas>

                        </asp:Chart>
                    </asp:Panel>

                    <br />
                    <%--   <h2>Table</h2>
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
                    </asp:GridView>--%>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>


    </div>
</asp:Content>
