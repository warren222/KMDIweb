<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fileupload.aspx.cs" MasterPageFile="~/KMDIweb/Delivery/ScannedDR/DRscannedReportMaster.Master" Inherits="KMDIweb.KMDIweb.Delivery.ScannedDR.Fileupload" %>

<asp:Content runat="server" ID="content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>File upload</title>
</asp:Content>

<asp:Content runat="server" ID="content2" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="well banner">
        <div class="container">
            <h1><strong>PDF and Image Files</strong> </h1>
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" PostBackUrl="~/KMDIweb/Delivery/ScannedDR/DRscannedHome.aspx" runat="server">back to home</asp:LinkButton>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-sm-6">
                <asp:Label ID="LBLproject" Font-Bold="true" Font-Size="XX-Large" runat="server" Text="Label"></asp:Label><br />
                <asp:Label ID="LBLaddress" Font-Size="Large" runat="server" Text="Label"></asp:Label><br />
                <asp:Label ID="LBLjo" Font-Size="Small" runat="server" Text="Label"></asp:Label>
            </div>
            <div class="col-sm-6">
                <asp:Panel ID="PNLupload" runat="server">
                    <div class="navbar-left">
                        <label class="btn btn-default">
                            <%--  <span><strong>Browse File</strong></span>--%>
                            <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="True"></asp:FileUpload>
                        </label>
                    </div>
                    <div class="navbar-right">
                        <div class="input-group">
                            <div class="input-group-addon">
                                upload date
                            </div>
                            <asp:TextBox ID="TBOXdate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton2" runat="server" ValidationGroup="g1" CssClass="btn btn-default" OnClick="Button1_Click">Upload file <span class="glyphicon"></span></asp:LinkButton>
                            </div>
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
        </div>


        <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary2" runat="server" />

        <div class="well">
            <asp:Label ID="LBLspecification" runat="server" Font-Size="Medium" Text="Label"></asp:Label>
        </div>
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
                                        <asp:Label ID="lbldate"  Font-Size="Medium" CssClass="text-muted"  runat="server" Text='<%# Bind("udate") %>'></asp:Label>&nbsp;&nbsp;

                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="File Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblid" runat="server" Text='<%# Bind("ID") %>' Visible="false"></asp:Label>
                                    <asp:LinkButton ID="lbtnfilename" Font-Size="Medium" CssClass="text-info" runat="server" CommandName="viewfile" Text='<%# Bind("FILENAME") %>'></asp:LinkButton>&nbsp;&nbsp;
                           <asp:LinkButton ID="BTNdelete" CssClass="text-danger" Font-Size="Large" CommandName="mydelete" runat="server" OnClientClick="return confirm('delete this file?');"><span class="glyphicon glyphicon-remove-sign"></span></asp:LinkButton>
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
