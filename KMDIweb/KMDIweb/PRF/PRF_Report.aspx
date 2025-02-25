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

        .cssSign {
            border: 1px solid #808080;
            border-radius: 5px;
            padding: 10px;
            margin: 4px;
            background-color: whitesmoke;
            width: 250px;
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
        <br />
    </div>
    <asp:UpdatePanel runat="server" ID="upnl1">
        <ContentTemplate>
            <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            <div style="height: auto; display: flex; flex-flow: row wrap; width: auto; padding: 2px; border-top: solid 5px #ff006e;">
                <asp:Panel runat="server" Visible="false" ID="pnlRecipient" Style="border: 1px solid #dddddd; border-radius: 5px; padding: 10px; margin: 4px; background-color: #dfe5f0; width: 300px;">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="errorval" Font-Size="Medium" ForeColor="Red"
                        ControlToValidate="ddlAddressed" ErrorMessage="Unable to sign the form. Recipient is required.">*</asp:RequiredFieldValidator><span>RECIPIENT:</span>
                    <asp:DropDownList runat="server" ID="ddlAddressed" ValidationGroup="errorval" CssClass="form-control"></asp:DropDownList>
                </asp:Panel>
                <asp:Panel ID="pnlRequested" runat="server" CssClass="cssSign">
                    <div>
                        <span>REQUESTED BY</span>
                    </div>
                    <asp:LinkButton ID="btnRequestedByDefault" Width="100%" ValidationGroup="errorval" CssClass="btn btn-success" runat="server" OnClick="btnRequestedByDefault_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Sign</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="pnlNoted" runat="server" CssClass="cssSign">
                    <div>
                        <span>NOTED BY</span>
                    </div>
                    <asp:LinkButton ID="btnNotedByDefault" Width="100%" ValidationGroup="addressVal" CssClass="btn btn-success" runat="server" OnClick="btnNotedByDefault_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Sign</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="pnlReceived" runat="server" CssClass="cssSign">
                    <div>
                        <span>RECEIVED BY</span>
                    </div>
                    <asp:LinkButton ID="btnReceivedByDefault" Width="100%" CssClass="btn btn-success" runat="server" OnClick="btnReceivedByDefault_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Sign</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="pnlApproved" runat="server" CssClass="cssSign">
                    <div>
                        <span>APPROVED BY</span>
                    </div>
                    <asp:LinkButton ID="btnApprovedByDefault" Width="100%" CssClass="btn btn-success" runat="server" OnClick="btnApprovedByDefault_Click"><span class="glyphicon glyphicon-pencil"></span> &nbsp;Sign</asp:LinkButton>
                </asp:Panel>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
