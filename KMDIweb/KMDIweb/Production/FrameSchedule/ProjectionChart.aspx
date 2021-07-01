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
