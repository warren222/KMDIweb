<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Installation/InstallationMaster.Master" CodeBehind="InstallationSummaryReportViewer.aspx.cs" Inherits="KMDIweb.KMDIweb.Installation.InstallationSummaryReportViewer" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <div class="container">
        <div class="well">
            <h2 class="text-center">Report</h2>
        </div>
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>" SelectCommand="installation_schedule_report_summary_stp" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource1_Selecting">
                <SelectParameters>
                    <asp:SessionParameter Name="Command" SessionField="PSCommand" Type="String" />
                    <asp:SessionParameter Name="Search" SessionField="PSSearch" Type="String" DefaultValue="" />
                    <asp:SessionParameter Name="Sdate" SessionField="PSSdate" Type="String" />
                    <asp:SessionParameter Name="Edate" SessionField="PSEdate" Type="String" />
                    <asp:SessionParameter Name="DataStatus" SessionField="PSDataStatus" Type="String" />
                    <asp:SessionParameter Name="user_code" SessionField="PSuser_code" Type="String" />
                    <asp:SessionParameter Name="fullname" SessionField="PSfullname" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <rsweb:ReportViewer ID="ReportViewer1" Width="100%" Height="800px" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                    <LocalReport ReportPath="KMDIweb\Global\Reports\ProjectSummaryRPT.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
