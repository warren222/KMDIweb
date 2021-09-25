<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CollectionLedgerInput.aspx.cs" MasterPageFile="~/KMDIweb/AE/CollectionLedger/AEMaster.Master" Inherits="KMDIweb.KMDIweb.AE.CollectionLedger.CollectionLedgerInput" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Collection Ledger</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <div class="container">
                <h2><strong class="text-center">Input</strong></h2>
            </div>
        </div>
            <div style="padding: 10px; background-color: whitesmoke;">
            <div class="row">
                <div class="col-sm-6">
                    <span>AMOUNT</span><br />
                    <asp:TextBox ID="tboxAmount" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" ControlToValidate="tboxAmount" ValidationGroup="inputVal" runat="server"
                        ErrorMessage="Amount is a required field!">*</asp:RequiredFieldValidator>
                    <br />
                    <span>CHECK DETAILS</span><br />
                    <asp:TextBox ID="tboxCheckDetails" CssClass="form-control" runat="server"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" ControlToValidate="tboxCheckDetails" ValidationGroup="inputVal" runat="server"
                        ErrorMessage="Check details is a required field!">*</asp:RequiredFieldValidator>
                    <br />
                    <span>PROJECT</span><br />
                    <asp:TextBox ID="tboxProject" CssClass="form-control" runat="server"></asp:TextBox><br />
                </div>
                <div class="col-sm-6">
                    <span>PAYMENT OR CHECK DATE</span><br />
                    <asp:TextBox ID="tboxPaymentDate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" ControlToValidate="tboxPaymentDate" ValidationGroup="inputVal" runat="server"
                        ErrorMessage="Payment or check date is a required field!">*</asp:RequiredFieldValidator>
                    <br />
                    <span>DATE COLLECTED</span><br />
                    <asp:TextBox ID="tboxDateColledted" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ForeColor="Red" ControlToValidate="tboxDateColledted" ValidationGroup="inputVal" runat="server"
                        ErrorMessage="Date collected is a required field!">*</asp:RequiredFieldValidator>
                </div>
            </div>
            <asp:LinkButton ID="LinkButton1" ValidationGroup="inputVal" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">ADD</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" CssClass="btn btn-default" runat="server" OnClick="LinkButton2_Click">CANCEL</asp:LinkButton>
            <asp:ValidationSummary CssClass="alert alert-danger" ID="ValidationSummary1" ValidationGroup="inputVal" ForeColor="Red" runat="server" />
            <asp:ValidationSummary CssClass="alert alert-danger" ID="ValidationSummary2" ValidationGroup="errorVal" ForeColor="Red" runat="server" />
        </div>
    </div>
</asp:Content>
