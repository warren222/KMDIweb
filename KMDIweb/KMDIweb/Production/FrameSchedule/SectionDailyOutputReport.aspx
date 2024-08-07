﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="SectionDailyOutputReport.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.SectionDailyOutputReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Section's Daily Output Summary Report</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <div class="container">
        <div class="well">
            <h2>Section's Daily Output Summary Report</h2>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" SizeToReportContent="true">
                <LocalReport ReportPath="KMDIweb\Global\Reports\SectionDailyOutputRPT.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                    </DataSources>
                </LocalReport>
      
            </rsweb:ReportViewer>
        </asp:Panel>
      
    </div>
</asp:Content>
