<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="ChartComparison.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.ChartComparison" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>POINTS INSIGHT</title>
</asp:Content>
<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="content">
    <div class="container">
        <div class="well text-center">
            <h3><strong>SD/Schedule points chart</strong> </h3>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="row">
                    <div class="col-sm-3">
                        <div class="input-group">
                            <div class="input-group-addon">
                                <span><b>select a year</b></span>
                            </div>
                            <asp:TextBox ID="tboxy1" CssClass="form-control" TextMode="Number" MaxLength="9999" runat="server"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="btnsubmit" CssClass="btn btn-default" runat="server" OnClick="btnsubmit_Click">submit</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>

                <br />
                <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
                    <h3 class="pull-right">
                    <span class="label label-primary">sd received</span>
                    <span class="label label-warning">due date</span></h3>
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
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>

</asp:Content>
