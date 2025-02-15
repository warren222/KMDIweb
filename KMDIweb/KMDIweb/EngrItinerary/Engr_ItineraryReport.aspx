<%@ Page Language="C#" MasterPageFile="~/KMDIweb/EngrItinerary/EngrItineraryMaster.Master" AutoEventWireup="true" CodeBehind="Engr_ItineraryReport.aspx.cs" Inherits="KMDIweb.KMDIweb.EngrItinerary.Engr_ItineraryReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Engineers' | Itinerary Report</title>
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="">
        <div class="well" style="background-color: #303030; border-color: transparent; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>
                    <asp:Label ID="lblDate" runat="server"></asp:Label></h3>
            </div>
            <span class="pull-right">
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-warning FontLarge" ForeColor="Black" OnClick="btnBack_Click"><span class="glyphicon glyphicon-chevron-left"></span> back</asp:LinkButton>
            </span>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
                    SelectCommand="Engr_Itinerary_Calendar_Stp" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource1_Selecting">
                    <SelectParameters>
                        <asp:Parameter Name="Command" Type="String" DefaultValue="Inst_Itinerary_ByDate" />
                        <asp:QueryStringParameter Name="SelectedDate" QueryStringField="SelectedDate" Type="String" />
                        <asp:SessionParameter Name="Engr" SessionField="KMDI_nickname" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
                    SelectCommand="Engr_Itinerary_Calendar_Stp" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource2_Selecting">
                    <SelectParameters>
                        <asp:Parameter Name="Command" Type="String" DefaultValue="Daily_Report_ByDate" />
                        <asp:QueryStringParameter Name="SelectedDate" QueryStringField="SelectedDate" Type="String" />
                        <asp:SessionParameter Name="Engr" SessionField="KMDI_nickname" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" SizeToReportContent="True" OnReportRefresh="ReportViewer1_ReportRefresh"
                        BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid"
                        InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor=""
                        PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor=""
                        SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor=""
                        SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor=""
                        ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor=""
                        ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153"
                        ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226">
                        <LocalReport ReportPath="KMDIweb\Global\Reports\Engr_ItineraryReport.rdlc">
                            <DataSources>
                                <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                                <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet2" />
                            </DataSources>
                        </LocalReport>
                    </rsweb:ReportViewer>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
