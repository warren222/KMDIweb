<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/AE/ProjectImages/Project_ImageMaster.Master" CodeBehind="Project_ImageUploader.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.ProjectImages.Project_ImageUploader" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Project | File Manager</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>For Checking</h2>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-6">
                    <asp:Panel ID="pnlUpload" runat="server">
                        <div class="FontSpacing FontLarge text-center">UPLOAD FORM</div>
                        <label class="form-control">
                            <asp:FileUpload ID="FileUpload1" CssClass="" runat="server" AllowMultiple="True"></asp:FileUpload>
                        </label>
                        <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CssClass=" wf_control_btn btn btn-success" Width="100%">upload selected file(s)</asp:LinkButton>
                    </asp:Panel>
                </div>
                <div class="col-sm-3"></div>
            </div>
        </div>

    </div>
</asp:Content>
