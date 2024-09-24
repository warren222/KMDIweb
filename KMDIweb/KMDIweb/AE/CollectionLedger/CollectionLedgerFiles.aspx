<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/AE/CollectionLedger/AEMaster.Master" CodeBehind="CollectionLedgerFiles.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.CollectionLedger.CollectionLedgerFiles" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }
    </style>
</asp:Content>


<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div>
        <div style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px">
            <div style="padding: 10px; color: antiquewhite; font-family: Calibri">
                <asp:Label runat="server" ID="lblProject_Name" ForeColor="White" Font-Size="XX-Large"></asp:Label><br />
                <asp:Label runat="server" Font-Size="Medium" ID="lblAmount" ForeColor="LimeGreen"></asp:Label><br />
            </div>
        </div>
    </div>
    <div class="">
        <div class="well">
            <div class="container">
                <h3><strong>PDF/Image Files</strong> </h3>
                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" PostBackUrl="~/KMDIweb/AE/CollectionLedger/CollectionLedgerFrm.aspx" runat="server">back to home</asp:LinkButton>
            </div>
        </div>
        <div class="container">
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <div style="background-color: antiquewhite; padding: 10px;border-top-left-radius:15px;border-top-right-radius:15px">
                <asp:Panel ID="pnlUpload" Visble="true" runat="server">
                    <div class="row nopm">
                        <div class="col-sm-4 nopm">
                            <div class="FontSpacing FontLarge text-center text-muted">UPLOAD FORM</div>
                            <div class="input-group">
                                <label class=" form-control" style="width: 75%">
                                    <asp:FileUpload ID="FileUpload1" CssClass="" runat="server" AllowMultiple="True"></asp:FileUpload>
                                </label>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="LinkButton2" runat="server" BackColor="#b72162" BorderColor="#b72162" OnClick="LinkButton2_Click" CssClass=" btn btn-success">upload</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-8 nopm"></div>
                    </div>

                </asp:Panel>
                <asp:Label ID="lblError" CssClass="text-danger" runat="server" Text=""></asp:Label>
            </div>
            <div style="background-color: aliceblue;border:solid 5px antiquewhite;">
                <div style="overflow-x: auto">
                    <asp:DataList ID="DataList1" CellSpacing="20" Width="100%" CellPadding="5" RepeatDirection="Horizontal" RepeatColumns="4" runat="server" OnItemCommand="DataList1_ItemCommand">
                        <ItemTemplate>
                            <table border="0">
                                <tr>
                                    <td class="text-center">
                                        <asp:HyperLink ID="HyperLink2"
                                            CssClass='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-image-link"%>'
                                            NavigateUrl='<%# Eval("File_Path").ToString() %>'
                                            data-lightbox='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-set"%>'
                                            data-title='<%# Eval("FileName").ToString() %>' runat="server">
                                            <asp:Image ID="Image2" Style="object-fit: contain; max-height: 300px;" CssClass='<%# Eval("File_Path").ToString() == ".pdf"? "imgcs img-thumbnail" : " imgcs img-thumbnail example-image"%>'
                                                ImageUrl='<%# Eval("FileExtension").ToString() == ".pdf" ? "~/Images/pdflogo.png" : Eval("File_Path") %>' runat="server" />
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblFile_Path" Visible="false" runat="server" Text='<%# Bind("File_Path") %>'></asp:Label>
                                        <span><%# Eval("FileName") %></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDate_Modified" ForeColor="#666666" runat="server" Text='<%# Bind("Date_Modified") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="LinkButton3" runat="server" CssClass="text-danger" CommandName="myDelete" OnClientClick="return confirm('delete this image?')">DELETE</asp:LinkButton>
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
