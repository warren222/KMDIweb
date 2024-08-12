<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/AE/ProjectImages/Project_ImageMaster.Master" CodeBehind="Project_Photos.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.ProjectImages.Project_Photos" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Project Photos</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: white">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>Project Photos</h2>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="row nopm">
            <div class="col-sm-2 nopm"></div>
            <div class="col-sm-8 nopm">
                <div class="well">
                    <div class="row" style="padding: 0; margin: 0;">
                        <div class="col-sm-5" style="padding: 0; margin: 0;">
                            <asp:Label ID="lblAE" runat="server" Text="Account Executive"></asp:Label>
                            <asp:DropDownList runat="server" ID="ddlAE" Style="border-radius: 0;" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-sm-7" style="padding: 0; margin: 0;">
                            <span>Find</span>
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="tboxSearch" Style="border-radius: 0;" CssClass="form-control"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-primary" OnClick="btnSearch_Click">search</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-2 nopm"></div>
        </div>
        <div class="row nopm">
            <div class="col-sm-2 nopm"></div>
            <div class="col-sm-8 nopm">
                <div style="overflow-x: auto">
                    <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="false" GridLines="None" AllowPaging="true" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div style="margin-bottom: 15px;border:solid 1px #d93692;">
                                        <div style="padding: 5px; background-color: #d93692; font-family: Calibri; font-size: medium;">
                                            <asp:Label runat="server" ID="lblProject_Name" ForeColor="white" Font-Size="Large" Text='<%# Bind("Project_Name") %>'></asp:Label>
                                            <span class="pull-right">
                                                   <asp:Label ID="lblAE" ForeColor="White" runat="server" Font-Size="Smaller" Text='<%# Bind("AE") %>'></asp:Label>
                                            </span>
                                        </div>
                                        <div style="padding:5px;background-color:white;">
                                            <asp:Label ID="lblJOB_ORDER_NO" runat="server" Text='<%# Bind("JOB_ORDER_NO") %>'></asp:Label>
                                            | 
                                              <asp:Label runat="server" ID="lblAddress" Text='<%# Bind("Address") %>'></asp:Label><br />
                                            <asp:LinkButton ID="btnUploadedFiles" runat="server" Visible="false" Font-Size="Medium" CommandName="myUploadFile">File Manager</asp:LinkButton>
                                        </div>
                                        <div style="padding: 2px; width: 100%;">
                                            <asp:DataList ID="DataList1" GridLines="None" CellPadding="5" RepeatDirection="Horizontal" RepeatColumns="8" runat="server">
                                                <ItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td css="">
                                                                <asp:HyperLink ID="HyperLink2"
                                                                    CssClass='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-image-link"%>'
                                                                    NavigateUrl='<%# Eval("File_Path").ToString() %>'
                                                                    data-lightbox='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-set"%>'
                                                                    data-title='<%# Eval("FileName").ToString() %>' runat="server">
                                                                    <asp:Image ID="Image2" Width="100px" BackColor="White" Style="object-fit: contain; min-width: 100px; min-height: 80px;" Height="80px" CssClass='<%# Eval("File_Path").ToString() == ".pdf"? "wf_img img-thumbnail" : "wf_img img-thumbnail example-image"%>'
                                                                        ImageUrl='<%# Eval("File_Path").ToString() == ".pdf" ? "~/Images/pdflogo.png" : Eval("File_Path") %>' runat="server" />
                                                                </asp:HyperLink>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <div class="text-center">
                                                <asp:Label ID="lblEmpty" runat="server" Visible="true" Font-Size="Large" Font-Bold="true">No Image Found!</asp:Label>
                                            </div>
                                        </div>
                                    </div>

                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings PageButtonCount="15" Position="TopAndBottom" />
                        <PagerStyle CssClass="GridPager" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" />
                        <EmptyDataTemplate>
                            <p style="font-size: x-large" class="text-danger">0 result found!</p>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
            <div class="col-sm-2 nopm"></div>
        </div>
    </div>
</asp:Content>
