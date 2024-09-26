<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CollectionLedgerFileViewer.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.CollectionLedger.CollectionLedgerFileViewer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="../../../Scripts/bootstrap.js"></script>
    <script type="text/javascript" src='<%= Page.ResolveClientUrl("~/Scripts/lightbox-plus-jquery.min.js") %>'></script>
    <link href="../../../Content/bootstrap.css" rel="stylesheet" />
    <link href="../../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../../../Scripts/bootstrap.min.js"></script>
    <link href="../../Global/css/gridcss.css" rel="stylesheet" />
    <link href="../../Global/css/lightbox.min.css" rel="stylesheet" />
    <title>Collection | File Viewer</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<body style="background-color: white;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px">
            <div style="padding: 10px; color: antiquewhite; font-family: Calibri">
                <asp:Label runat="server" ID="lblProject_Name" ForeColor="White" Font-Size="XX-Large"></asp:Label><br />
                <asp:Label runat="server" Font-Size="Medium" ID="lblAmount" ForeColor="LimeGreen"></asp:Label><br />
            </div>
        </div>
        <div class="well">
            <div class="container">
                <h3><strong>PDF/Image Files</strong> </h3>
            </div>
        </div>
        <div class="container">
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <div style="background-color: aliceblue; border: solid 5px antiquewhite;">
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
                                        <asp:LinkButton ID="btnView" runat="server" CommandName="myView" Text='<%# Bind("FileName") %>'></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDate_Modified" ForeColor="#666666" runat="server" Text='<%# Bind("Date_Modified") %>'></asp:Label>
                                    </td>
                                </tr>

                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
