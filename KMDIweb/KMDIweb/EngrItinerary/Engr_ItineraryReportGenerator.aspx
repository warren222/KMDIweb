<%@ Page Language="C#" MasterPageFile="~/KMDIweb/EngrItinerary/EngrItineraryMaster.Master" AutoEventWireup="true" CodeBehind="Engr_ItineraryReportGenerator.aspx.cs" Inherits="KMDIweb.KMDIweb.EngrItinerary.Engr_ItineraryReportGenerator" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Engineers' | Itinerary Report</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }

        .wf_body {
            /*background-color: #323232;*/
            background-image: url('../Images/446.jpg');
            background-size: 350px;
            background-position: center top;
            background-repeat: repeat;
            /*background-size: 100%;*/
            /*color: rgba(226, 238, 239, 0.5);*/
            color: white;
            border-top: solid 5px #ff006e;
            border-bottom: solid 5px #ff006e;
            /*font-family: Bahnschrift;*/
        }
    </style>
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="">
        <div class="well" style="background-color: #303030; border-color: transparent; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>
                    <asp:Label ID="lblDate" runat="server">Engineering's Itinerary</asp:Label></h3>
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
                <div class="well" style="border-color: transparent;">
                    <div class="row nopm">
                        <div class="col-sm-6 nopm">
                        </div>
                        <div class="col-sm-6 nopm">
                            <div class="row nopm">
                                <div class="col-sm-4 nopm">
                                    <span>Engineer</span>
                                    <asp:DropDownList ID="ddlEngr" Style="border-radius: 0" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                                <div class="col-sm-4 nopm">
                                    <span>Start Date</span>
                                    <asp:TextBox ID="tboxSdate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                </div>
                                <div class="col-sm-4 nopm">
                                    <span>End Date</span>
                                    <div class="input-group">
                                        <asp:TextBox ID="tboxEdate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-danger" Style="background-color: #ff006e; border-color: #ff006e"
                                                OnClick="btnSearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
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
                    </rsweb:ReportViewer>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <div style="height: auto; display: flex; flex-flow: row wrap; width: auto; padding: 2px; border-top: solid 5px #ff006e;">
        </div>
    </div>
</asp:Content>
