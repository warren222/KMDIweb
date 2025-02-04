<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Glass_Notif_Rpt.aspx.cs" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_Rpt" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass Notification</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
        <div class="container">
            <h3>Glass Notification | Report</h3>
        </div>
        <span class="pull-right">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-warning" ForeColor="Black" OnClick="btnBack_Click"><span class="glyphicon glyphicon-chevron-left"></span> back</asp:LinkButton>
        </span>
    </div>
    <div class="container">
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
        <div>
            <asp:LinkButton ID="btnPreparedBy" CssClass="btn btn-primary" runat="server" OnClick="btnPreparedBy_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;PREPARED BY</asp:LinkButton>
            <asp:LinkButton ID="btnNotedByPM" CssClass="btn btn-primary" runat="server" OnClick="btnNotedByPM_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;NOTED BY</asp:LinkButton>
            <asp:LinkButton ID="btnReceivedBy" CssClass="btn btn-primary" runat="server" OnClick="btnReceivedBy_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;RECEIVED BY</asp:LinkButton>
            <asp:LinkButton ID="btnNotedByIM" CssClass="btn btn-primary" runat="server" OnClick="btnNotedByIM_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;NOTED BY</asp:LinkButton>
        </div>
    </div>

</asp:Content>
