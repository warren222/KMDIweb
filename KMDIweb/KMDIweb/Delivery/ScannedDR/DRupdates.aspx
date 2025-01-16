<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Delivery/ScannedDR/DRscannedReportMaster.Master" CodeBehind="DRupdates.aspx.cs" Inherits="KMDIweb.KMDIweb.Delivery.ScannedDR.DRupdates" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DR | Updates</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }

        .tblLocal {
            font-family: Calibri;
            white-space: nowrap;
            white-space: nowrap;
        }

            .tblLocal th, tr, td {
                padding-left: 5px;
                padding-right: 5px;
            }
    </style>
</asp:Content>


<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>DR | Updates</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="container">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="well">
                        <div class="row">
                            <div class="col-sm-6">
                                <span>Specfication</span>
                                <asp:DropDownList ID="ddlSpecification" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                    <asp:ListItem Value="Frame" Text="Frame"></asp:ListItem>
                                    <asp:ListItem Value="Screen" Text="Screen"></asp:ListItem>
                                    <asp:ListItem Value="Glass" Text="Glass"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-6">
                                <span>Search</span>
                                <div class="input-group">
                                    <asp:TextBox ID="tboxFind" runat="server" CssClass="form-control"></asp:TextBox>
                                    <div class="input-group-btn">
                                        <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" Style="background-color: #ff006e; border-color: #ff006e">GO</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
