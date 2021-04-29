<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="NoticeForIncompleteItemsReportPaage.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.NoticeForIncompleteItemsReportPaage" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Notice For Incomplete Items Report</title>
    <script type="text/javascript">
        function confimmessage() {
            confirm('sign this notice? sign cannot be removed once its assigned.');
        }
        function savedSuccessfully() {
            alert("data saved successfully");
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <div class="container">
        <div class="well">
            <h2>Notice For Incomplete Items Report</h2>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
            <rsweb:ReportViewer ID="ReportViewer1" Width="100%" Height="800" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                <LocalReport ReportPath="KMDIweb\Global\Reports\NoticeForINCItemsReport.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>
        </asp:Panel>
        <div>
            <asp:Button ID="preparedbyBTN" runat="server" Text="Sign" CssClass="btn btn-primary" OnClick="preparedbyBTN_Click" />
        </div>
    </div>
</asp:Content>
