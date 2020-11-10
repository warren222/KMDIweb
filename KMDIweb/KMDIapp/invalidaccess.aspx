<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIapp/KMDIwebMaster.Master" CodeBehind="invalidaccess.aspx.cs" Inherits="KMDIweb.KMDIapp.invalidaccess" %>

<asp:Content ID ="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Invalid Access</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <div class="container">
        <div class="jumbotron">
            <h1>
                <strong>Invalid Access!</strong><small>unable to access this page</small>
            </h1>
        </div>
    </div>
</asp:Content>