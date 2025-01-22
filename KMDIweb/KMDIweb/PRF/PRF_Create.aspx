<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/PRF/PRF_Master.Master" CodeBehind="PRF_Create.aspx.cs" Inherits="KMDIweb.KMDIweb.PRF.PRF_Create" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PRF | Create</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }

        .bcRed {
            background-color: red;
            color: white;
        }

        .bcOrange {
            background-color: orange;
            color: black;
        }

        .bcBlue {
            background-color: aqua;
            color: black;
        }

        .bcYellow {
            background-color: yellow;
            color: black;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>Create | PRF</h3>
            </div>
            <span class="pull-right">
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-warning" ForeColor="Black" OnClick="btnBack_Click"><span class="glyphicon glyphicon-chevron-left"></span> back</asp:LinkButton>
            </span>
        </div>

        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="container">
            <div class="panel panel-info">
                <div class="panel-heading">
                </div>
                <asp:Panel ID="pnlCtrlNumberCreate" runat="server">
                    <div class="row">
                        <div class="col-sm-4">
                        </div>
                        <div class="col-sm-4">
                            <span>Select Due Date</span>
                            <div class=" input-group">
                                <asp:TextBox ID="tboxDueDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                <div class=" input-group-btn">
                                    <asp:LinkButton ID="btnCreate" runat="server" CssClass="btn btn-danger"
                                        Style="background-color: #ff006e; border-color: #ff006e" OnClick="btnCreate_Click"><span class="glyphicon glyphicon-search"></span> Create Control Number</asp:LinkButton>
                                </div>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvDueDate" runat="server" ControlToValidate="tboxDueDate" ForeColor="Red" ErrorMessage="Sorry! Please select due date."></asp:RequiredFieldValidator>
                        </div>
                       <div class="col-sm-4">
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlControlNumber" runat="server">
                   <asp:DataGrid ID="gvControlNumber" runat="server"></asp:DataGrid>
                </asp:Panel>
            </div>





            <div class="well">
                <h3>Purchase Request Form</h3>
                <span>Item Description</span>
                <asp:TextBox ID="tboxItemDescription" runat="server" CssClass="form-control"></asp:TextBox>
                <span>Quantity</span>
                <asp:TextBox ID="tboxQuantity" runat="server" CssClass="form-control"></asp:TextBox>
                <span>Account</span>
                <asp:TextBox ID="tboxAccount" runat="server" CssClass="form-control"></asp:TextBox>
                <span>Remarks</span>
                <asp:TextBox ID="tboxRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:LinkButton runat="server" ID="btnProceed" Width="100%" CssClass="btn btn-success" Style="border-radius: 0px;" OnClick="btnProceed_Click">
                <span class="glyphicon glyphicon-floppy-disk"></span> Add</asp:LinkButton>
            </div>
        </div>
    </div>

</asp:Content>
