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
                <h1>File Manager</h1>
                <asp:LinkButton ID="btnBack" CssClass="btn btn-default" OnClick="btnBack_Click" runat="server">b a c k</asp:LinkButton>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <div style="border: 1px solid #b72162; margin-bottom: 15px;">
                <div style="padding: 10px; background-color: white;">
                    <asp:Label runat="server" ID="lblProject_Name" ForeColor="#b72162" Font-Bold="true" Font-Size="Large"></asp:Label><br />
                    <asp:Label runat="server" ID="lblJO"></asp:Label> | <asp:Label runat="server" ID="lblAddress"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-sm-5">
                        <asp:Panel ID="pnlUpload" runat="server" Style="padding: 10px;">
                            <div class="FontSpacing FontLarge text-center">UPLOAD FORM</div>
                            <label class="form-control">
                                <asp:FileUpload ID="FileUpload1" CssClass="" runat="server" AllowMultiple="True"></asp:FileUpload>
                            </label>
                            <asp:LinkButton ID="LinkButton2" runat="server" BackColor="#b72162" BorderColor="#b72162" OnClick="LinkButton2_Click" CssClass=" wf_control_btn btn btn-success" Width="100%">upload selected file(s)</asp:LinkButton>
                        </asp:Panel>
                    </div>
                    <div class="col-sm-7"></div>
                </div>
                <asp:Label ID="lblError" CssClass="text-danger" runat="server" Text=""></asp:Label>
                <br />
                <br />
                <div style="overflow-x: auto">
                    <asp:DataList ID="DataList1" Width="100%" GridLines="None" BackColor="White" CellPadding="5" RepeatDirection="Horizontal" RepeatColumns="4" runat="server" OnItemCommand="DataList1_ItemCommand">
                        <ItemTemplate>
                            <table border="0" style="max-width: 300px;">
                                <tr>
                                    <td class="text-center">
                                        <asp:HyperLink ID="HyperLink1"
                                            CssClass='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-image-link"%>'
                                            NavigateUrl='<%# Eval("File_Path").ToString() %>'
                                            data-lightbox='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-set"%>' data-title='<%# Eval("FileName").ToString() %>' runat="server">
                                            <asp:Image ID="Image2" CssClass='<%# Eval("FileExtension").ToString() == ".pdf"? "wf_img img-thumbnail" : "wf_img img-thumbnail example-image"%>'
                                                ImageUrl='<%# Eval("FileExtension").ToString() == ".pdf" ? "~/Images/pdflogo.png" : Eval("File_Path") %>' runat="server" />
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblFile_Path" Visible="false" runat="server" Text='<%# Bind("File_Path") %>'></asp:Label>
                                        <asp:LinkButton ID="btnView" ForeColor="White" runat="server" CommandName="myView" Text='<%# Bind("FileName") %>'></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDate_Modified" CssClass="text-muted" runat="server" Text='<%# Bind("Date_Modified") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="myDelete" ForeColor="Maroon" OnClientClick="return confirm('delete this image?')">DELETE</asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
