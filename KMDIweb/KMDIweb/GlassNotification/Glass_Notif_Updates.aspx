<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Glass_Notif_Updates.aspx.cs" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_Updates" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass | Notification</title>
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
            color: white;
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
                <h3>Glass Update Notification</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <contenttemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </contenttemplate>
        </asp:UpdatePanel>

        <div class="container">
            <asp:GridView runat="server"></asp:GridView>
        </div>
    </div>
</asp:Content>
