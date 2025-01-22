<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/PRF/PRF_Master.Master" CodeBehind="PRF_List.aspx.cs" Inherits="KMDIweb.KMDIweb.PRF.PRF_List" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PRF | List</title>
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
                <h3>Purchase Request Form | List</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="row nopm">
            <div class="col-sm-6 nopm">
            </div>
            <div class="col-sm-6 nopm">
                <div class="well">
                    <span>Search</span>
                    <div class="input-group">
                        <asp:TextBox runat="server" ID="tboxFind" CssClass="form-control"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-danger" Style="background-color: #ff006e; border-color: #ff006e" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <asp:LinkButton ID="btnCreate" runat="server" CssClass="btn btn-default"
                OnClick="btnCreate_Click">Create New PRF</asp:LinkButton>
        </div>
        <div>
            <asp:GridView ID="gvList" runat="server">
            </asp:GridView>
        </div>
    </div>

</asp:Content>
