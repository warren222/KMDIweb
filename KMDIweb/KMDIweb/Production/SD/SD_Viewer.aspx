<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SD_Viewer.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.SD.SD_Viewer" %>

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
    <title>SD | File</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<body style="background-color: #bfbfbf;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <div>
                <div style="  background-color: #303030;border-bottom: solid 5px #ff006e;padding-left:10px">
                    <div style="padding: 10px;color:antiquewhite;font-family:Calibri">
                        <asp:Label runat="server" ID="lblProject_Name" ForeColor="White" Font-Size="XX-Large"></asp:Label><br />
                        <asp:Label runat="server" Visible="false" ID="lblJO"></asp:Label>
                        <asp:Label runat="server" Font-Size="Medium" ID="lblAddress"></asp:Label><br />
                        <asp:Label runat="server" Font-Size="Medium" ID="lblSubJO"></asp:Label>
                    </div>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>


            <div>
                <div class="row nopm" style="padding: 10px; color: white; background-color: #2f2f2f">
                    <div class="col-sm-4"></div>
                    <div class="col-sm-4 text-center">
                        <span class="text-muted">SELECT K#</span>
                        <asp:DropDownList ID="ddlK_No" runat="server" Style="background-color: #272727; border-color: #565656; color: ghostwhite; height: 40px;" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlK_No_SelectedIndexChanged"></asp:DropDownList>
                        <asp:LinkButton runat="server" ID="btnSearch" Visible="false" BackColor="#b72162" BorderColor="#b72162" Style="margin-top: 5px;" CssClass=" wf_control_btn btn btn-success" Width="100%" OnClick="btnSearch_Click">search</asp:LinkButton>
                    </div>
                    <div class="col-sm-4"></div>
                </div>
                <asp:Label ID="lblError" CssClass="text-danger" runat="server" Text=""></asp:Label>
                <br />
                <br />
                <div style="overflow-x: auto">
                    <asp:DataList ID="DataList1" CCellSpacing="20" Width="100%" CellPadding="5" RepeatDirection="Horizontal" RepeatColumns="4" runat="server" OnItemCommand="DataList1_ItemCommand">
                        <ItemTemplate>
                          <table border="0">
                                <tr>
                                    <td class="text-center">
                                        <asp:HyperLink ID="HyperLink2"
                                            CssClass='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-image-link"%>'
                                            NavigateUrl='<%# Eval("File_Path").ToString() %>'
                                            data-lightbox='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-set"%>'
                                            data-title='<%# Eval("FileName").ToString() %>' runat="server">
                                            <asp:Image ID="Image2" Style="object-fit: contain;max-height:300px;" CssClass='<%# Eval("File_Path").ToString() == ".pdf"? "imgcs img-thumbnail" : " imgcs img-thumbnail example-image"%>'
                                                ImageUrl='<%# Eval("FileExtension").ToString() == ".pdf" ? "~/Images/pdflogo.png" : Eval("File_Path") %>' runat="server" />
                                        </asp:HyperLink>
                                    </td>
                                </tr>
                              <tr> 
                                    <td>
                                        <asp:Label ID="lblFile_Path" Visible="true" runat="server" Text='<%# Bind("File_Path") %>'></asp:Label>
                                        <span><%# Eval("FileName") %></span><br />
                                        <asp:LinkButton ID="btnView" Visible="true" runat="server" CommandName="myView" Text="Open in new tab"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDate_Modified" ForeColor="#666666"  runat="server" Text='<%# Bind("Date_Modified") %>'></asp:Label>
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
