<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Glass_Notif_Rpt.aspx.cs" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_Rpt" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass Notification</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2 class="text-center">Glass Notification</h2>
            <span class="pull-right">
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-warning" OnClick="btnBack_Click"><span class="glyphicon glyphicon-chevron-left"></span> back</asp:LinkButton>
            </span>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>" SelectCommand="Glass_PO_Notification_Stp" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource1_Selecting">
            <SelectParameters>
                <asp:Parameter Name="Command" Type="String" DefaultValue="Select" />
                <asp:QueryStringParameter Name="Id" QueryStringField="Glass_PO_Notification_Id" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>" SelectCommand="Glass_PO_Notification_Item_Stp" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource2_Selecting">
            <SelectParameters>
                <asp:Parameter Name="Command" Type="String" DefaultValue="Select" />
                <asp:QueryStringParameter Name="Glass_PO_Notification_Id" QueryStringField="Glass_PO_Notification_Id" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" SizeToReportContent="true" OnReportRefresh="ReportViewer1_ReportRefresh">
                <LocalReport ReportPath="KMDIweb\Global\Reports\Glass_NotificationReport.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet2" />
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>
        </asp:Panel>
    </div>

</asp:Content>
