<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIapp/KMDIwebMaster.Master" CodeBehind="cutting.aspx.cs" Inherits="KMDIweb.KMDIapp.cutting" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class=" jumbotron">
        <h1><strong>For Cutting<br />
            <small>Station's expected output</small> </strong></h1>
    </div>

    <div class="">
        <asp:GridView ID="GridView1" runat="server">
               <EmptyDataTemplate>
                        <div class="alert alert-warning">
                            <h3><strong>Sorry, no result!</strong>
                            </h3>
                        </div>
                    </EmptyDataTemplate>
        </asp:GridView>
    </div>
</asp:Content>
