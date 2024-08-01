<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/AE/ProjectImages/Project_ImageMaster.Master" CodeBehind="Project_Images.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.ProjectImages.Project_Images" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Project Image</title>
    <style>
        .nopad {
            padding: 0;
        }

        .nomargin {
            margin: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>Project Image</h2>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="row nomargin">
            <div class="col-sm-2 nomargin"></div>
            <div class="col-sm-8 nomargin">
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
            <div class="col-sm-2 nomargin"></div>
        </div>
        <div class="row nomargin">
            <div class="col-sm-2 nomargin"></div>
            <div class="col-sm-8 nomargin">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" GridLines="None" AllowPaging="true" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                             <div style="border:1px solid #808080;margin-bottom:15px;">
                                    <div style="background-color:white;padding:10px;">
                                        <span style="font-size: large;"><%# Eval("Project_Name") %></span><br />
                                        <span style="font-size: small;"><%# Eval("Address") %></span><br />
                                        <asp:Label ID="lblJOB_ORDER_NO" runat="server" Text='<%# Bind("JOB_ORDER_NO") %>'></asp:Label>
                                    </div>
                                     <div style="padding:10px;background-color:whitesmoke;width:100%;">
                                        <asp:DataList ID="DataList1" GridLines="None" CellPadding="5" RepeatDirection="Horizontal" RepeatColumns="8" runat="server">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td css="">
                                                            <asp:HyperLink ID="HyperLink1"
                                                                CssClass='<%# Eval("IMG").ToString() == ".pdf" ? "" : "example-image-link"%>'
                                                                NavigateUrl='<%# Eval("IMG").ToString() %>'
                                                                data-lightbox='<%# Eval("IMG").ToString() == ".pdf" ? "" : "example-set"%>' data-title='<%# Eval("IMG").ToString() %>' runat="server">
                                                                <asp:Image ID="Image2" Width="100px" Style="object-fit: contain; min-width: 100px; min-height: 100px;" Height="100px" CssClass='<%# Eval("IMG").ToString() == ".pdf"? "wf_img img-thumbnail" : "wf_img img-thumbnail example-image"%>'
                                                                    ImageUrl='<%# Eval("IMG").ToString() == ".pdf" ? "~/Images/pdflogo.png" : Eval("IMG") %>' runat="server" />
                                                            </asp:HyperLink>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
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
            <div class="col-sm-2 nomargin"></div>
        </div>
    </div>
</asp:Content>
