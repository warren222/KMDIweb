<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AF/AF_Master.Master" AutoEventWireup="true" CodeBehind="AF_Project_Request.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AF.AF_Project_Request" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>AF Request</h2>
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-primary" Text="back" OnClick="btnBack_Click"></asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
