<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIapp/KMDIwebMaster.Master" CodeBehind="home.aspx.cs" Inherits="KMDIweb.SCREENfab.home" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Screen Monitoring</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">

    <div class=" jumbotron">
        <h1><strong>Screen Fabrication Monitoring<br /><small>Web Site!</small> </strong></h1>
    </div>
 
            <h4><span><strong>Screen Stations</strong> </span></h4>
            <blockquote>
                <asp:LinkButton ID="LinkButton1" runat="server"><h3><span class="text-info"><strong>Cutting</strong></span></h3></asp:LinkButton>
                <asp:LinkButton ID="LinkButton5" runat="server"><h3><span class="text-info"><strong>Prepared Pleated Mesh</strong></span></h3></asp:LinkButton>
                <asp:LinkButton ID="LinkButton6" runat="server"><h3><span class="text-info"><strong>Assembling</strong></span></h3></asp:LinkButton>
                <asp:LinkButton ID="LinkButton7" runat="server"><h3><span class="text-info"><strong>Quality Control</strong></span></h3></asp:LinkButton>
            </blockquote>
      

</asp:Content>
