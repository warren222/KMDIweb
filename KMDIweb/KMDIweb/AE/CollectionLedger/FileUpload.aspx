<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileUpload.aspx.cs" MasterPageFile="~/KMDIweb/AE/CollectionLedger/AEMaster.Master" Inherits="KMDIweb.KMDIweb.AE.CollectionLedger.FileUpload" %>

<asp:Content runat="server" ID="content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>File upload</title>
</asp:Content>

<asp:Content runat="server" ID="content2" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     <div class="container">
    <div class="well">
        <div class="container text-center">
            <h3><strong>PDF and Image Files</strong> </h3>
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" PostBackUrl="~/KMDIweb/AE/CollectionLedger/CollectionLedgerFrm.aspx" runat="server">back to home</asp:LinkButton>
        </div>
    </div>

   
            <div class="">
                <asp:Panel ID="PNLupload" runat="server">
                    <div>
                        <div class="input-group">
                            <div class="">
                                <label class="btn btn-default">
                                    <%--  <span><strong>Browse File</strong></span>--%>
                                    <asp:FileUpload ID="FileUpload1" CssClass="responsiveFont" runat="server" AllowMultiple="True"></asp:FileUpload>
                                </label>
                            </div>
                                <asp:LinkButton ID="LinkButton2" runat="server" ValidationGroup="g1" CssClass="btn btn-default" OnClick="Button1_Click">Upload file <span class="glyphicon"></span></asp:LinkButton>         
                        </div>
                    </div>
                </asp:Panel>
                <br />
                <br />
                <asp:Panel ID="Panel2" runat="server">
                    <div class="alert alert-danger">
                        <asp:Label ID="errorlbl" runat="server" Text=""></asp:Label>
                    </div>
                </asp:Panel>
            </div>

        <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary2" runat="server" />


        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
                    <asp:GridView ID="GridView1" GridLines="None" ShowHeader="false" runat="server" AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand" OnDataBound="GridView1_DataBound">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <br />
                                    <div class="vl">
                                        <asp:Image ID="Image1" ImageUrl='<%#  Eval("Filetype").ToString() == ".pdf" ? "~/KMDIweb/Images/pdf-icon.png" : "~/KMDIweb/Images/Photos-icon.png" %>' Width="30" Height="30" runat="server" />
                                    &nbsp;&nbsp;

                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="File Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblid" runat="server" Text='<%# Bind("ID") %>' Visible="false"></asp:Label>
                                    <asp:LinkButton ID="lbtnfilename" Font-Size="Medium" CssClass="text-info responsiveFont" runat="server" CommandName="viewfile" Text='<%# Bind("FILENAME") %>'></asp:LinkButton>&nbsp;&nbsp;
                           <asp:LinkButton ID="BTNdelete" CssClass="text-danger responsiveFont" Font-Size="Large" CommandName="mydelete" runat="server" OnClientClick="return confirm('delete this file?');"><span class="glyphicon glyphicon-remove-sign"></span></asp:LinkButton>
                                    <br />
                                        <asp:Label ID="lbldate" CssClass="text-muted" runat="server" Text='<%# Bind("inputted") %>'></asp:Label>
                                    <asp:Label ID="lblfilepath" runat="server" Text='<%# Bind("path") %>' Visible="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <RowStyle Wrap="False" />
                    </asp:GridView>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

