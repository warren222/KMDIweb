<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/PRF/PRF_Master.Master" CodeBehind="PRF_Report.aspx.cs" Inherits="KMDIweb.KMDIweb.PRF.PRF_Report" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PRF | Report</title>
    <style>
        .nopm {
            padding: 5px;
            margin: 0;
            border: 1px solid black;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
        <div class="container">
            <h3>PRF | Report</h3>
        </div>
        <span class="pull-right">
            <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-warning" ForeColor="Black" OnClick="btnBack_Click"><span class="glyphicon glyphicon-chevron-left"></span> back</asp:LinkButton>
        </span>
    </div>
    <div class="container">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
            SelectCommand="PRF_Stp" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource1_Selecting">
            <SelectParameters>
                <asp:Parameter Name="Command" Type="String" DefaultValue="Select" />
                <asp:QueryStringParameter Name="Id" QueryStringField="Id" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>"
            SelectCommand="PRF_Item_Stp" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource2_Selecting">
            <SelectParameters>
                <asp:Parameter Name="Command" Type="String" DefaultValue="Select" />
                <asp:QueryStringParameter Name="PRF_Id" QueryStringField="Id" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" SizeToReportContent="True" OnReportRefresh="ReportViewer1_ReportRefresh" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226">
                <LocalReport ReportPath="KMDIweb\Global\Reports\PRF_Report.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                        <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet2" />
                    </DataSources>
                </LocalReport>
            </rsweb:ReportViewer>
        </asp:Panel>
        <br />
        <div>
            <span></span>
            <div class="row nopm" style="border: 1px solid black; padding: 0; margin: 0;">
                <div class="col-sm-3 nopm">
                    <div>
                        <span>REQUESTED BY</span>
                    </div>
                    <asp:LinkButton ID="btnRequestedBy" Width="100%" CssClass="btn btn-default" runat="server" OnClick="btnRequestedBy_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Capture Sign</asp:LinkButton><br />
                    <asp:LinkButton ID="btnRequestedByDefault" Width="100%" CssClass="btn btn-success" runat="server" OnClick="btnRequestedByDefault_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Default Signature</asp:LinkButton>
                </div>
                <div class="col-sm-3 nopm">
                    <div>
                        <span>NOTED BY</span>
                    </div>
                    <asp:LinkButton ID="btnNotedBy" Width="100%" CssClass="btn btn-default" runat="server" OnClick="btnNotedBy_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Capture Signature</asp:LinkButton><br />
                    <asp:LinkButton ID="btnNotedByDefault" Width="100%" CssClass="btn btn-success" runat="server" OnClick="btnNotedByDefault_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Default Signature</asp:LinkButton>
                </div>
                <div class="col-sm-3 nopm">
                    <div>
                        <span>RECEIVED BY</span>
                    </div>
                    <asp:LinkButton ID="btnReceivedBy" Width="100%" CssClass="btn btn-default" runat="server" OnClick="btnReceivedBy_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Capture Signature</asp:LinkButton><br />
                    <asp:LinkButton ID="btnReceivedByDefault" Width="100%" CssClass="btn btn-success" runat="server" OnClick="btnReceivedByDefault_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Default Signature</asp:LinkButton>
                </div>
                <div class="col-sm-3 nopm">
                    <div>
                        <span>APPROVED BY</span>
                    </div>
                    <asp:LinkButton ID="btnApprovedBy" Width="100%" CssClass="btn btn-default" runat="server" OnClick="btnApprovedBy_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Capture Signature</asp:LinkButton><br />
                    <asp:LinkButton ID="btnApprovedByDefault" Width="100%" CssClass="btn btn-success" runat="server" OnClick="btnApprovedByDefault_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Default Signature</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
