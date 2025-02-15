<%@ Page Language="C#" MasterPageFile="~/KMDIweb/EngrItinerary/EngrItineraryMaster.Master" AutoEventWireup="true" CodeBehind="Engr_ItineraryReportGenerator.aspx.cs" Inherits="KMDIweb.KMDIweb.EngrItinerary.Engr_ItineraryReportGenerator" %>

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
    </div>
</asp:Content>
