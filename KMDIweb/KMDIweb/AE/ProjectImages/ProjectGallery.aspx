<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectGallery.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.ProjectImages.ProjectGallery" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <script src="../../../Scripts/bootstrap.js"></script>
    <script src="../../../Scripts/lightbox-plus-jquery.min.js"></script>
    <%--    <script type="text/javascript" src='<%= Page.ResolveClientUrl("~/Scripts/lightbox-plus-jquery.min.js") %>'></script>--%>
    <link href="../../../Content/bootstrap.css" rel="stylesheet" />
    <link href="../../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../../../Scripts/bootstrap.min.js"></script>
    <link href="../../Global/css/gridcss.css" rel="stylesheet" />
    <link href="../../Global/css/lightbox.min.css" rel="stylesheet" />
    <style>
      

        .imgcs {
            border-radius: 0;
        }
    </style>
    <title></title>
</head>
<body style="background-color:rgb(31,31,31)">
    <form id="form1" runat="server">
        <div>
            <div style="background-color:#f21f77;">
                <div style="padding: 10px;">
                    <asp:Label runat="server" ID="lblProject_Name" ForeColor="White" Font-Size="XX-Large"></asp:Label><br />
                    <asp:Label runat="server" Visible="false" ID="lblJO"></asp:Label>
               
                    <asp:Label runat="server" Font-Bold="true" Font-Size="X-Large" ID="lblAddress"></asp:Label>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-10">
                <asp:DataList ID="DataList1" CellSpacing="20" Width="100%" CellPadding="5" RepeatDirection="Horizontal" RepeatColumns="1" runat="server">
                    <ItemTemplate>
                       
                            <asp:HyperLink ID="HyperLink2"
                                CssClass='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-image-link"%>'
                                NavigateUrl='<%# Eval("File_Path").ToString() %>'
                                data-lightbox='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-set"%>'
                                data-title='<%# Eval("FileName").ToString() %>' runat="server">
                                <asp:Image ID="Image2" Style="object-fit: contain;" CssClass='<%# Eval("File_Path").ToString() == ".pdf"? "imgcs img-thumbnail" : " imgcs img-thumbnail example-image"%>'
                                    ImageUrl='<%# Eval("File_Path").ToString() == ".pdf" ? "~/Images/pdflogo.png" : Eval("File_Path") %>' runat="server" />
                            </asp:HyperLink>

                    
                    </ItemTemplate>
                </asp:DataList>
            </div>
            <div class="col-sm-1"></div>
        </div>
    </form>
</body>
</html>
