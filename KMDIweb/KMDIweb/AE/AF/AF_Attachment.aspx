<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AF/AF_Master.Master" AutoEventWireup="true" CodeBehind="AF_Attachment.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AF.AF_Attachment" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AF | Requested</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }
    </style>
</asp:Content>


<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <h1>Uploaded Files</h1>
                <asp:LinkButton ID="btnBack" CssClass="btn btn-default" OnClick="btnBack_Click" runat="server">b a c k</asp:LinkButton>
            </div>
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
            <br />
            <div>
                <asp:GridView ID="gvAF" AutoGenerateColumns="false" GridLines="None" ShowHeader="false" Width="100%" runat="server">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div style='border: 2px solid; padding: 0; margin-bottom: 5px; background-color: azure; border-color: <%# Eval("Req_Status").ToString() == "For Checking" ? "SkyBlue" :
                                                        Eval("Req_Status").ToString() == "Hold" ? "Red" :
                                                Eval("Req_Status").ToString() == "For Approval" ? "Orange" :
                                                Eval("Req_Status").ToString() == "Approved" ? "Green" : "Black" %>;'>
                                    <div style="min-width: 370px; white-space: normal;">
                                        <asp:Panel ID="pnlStatus" runat="server"
                                            Style="padding: 5px; border-top-right-radius: 0px;"
                                            ForeColor='<%# Eval("Req_Status").ToString() == "For Approval" || Eval("Req_Status").ToString() == "For Checking" ? System.Drawing.Color.Black : System.Drawing.Color.White %>'
                                            BackColor='<%# Eval("Req_Status").ToString() == "For Checking" ? System.Drawing.Color.SkyBlue :
                                                        Eval("Req_Status").ToString() == "Hold" ? System.Drawing.Color.Red :
                                                Eval("Req_Status").ToString() == "For Approval" ? System.Drawing.Color.Orange :
                                                Eval("Req_Status").ToString() == "Approved" ? System.Drawing.Color.Green : System.Drawing.Color.Black %>'>
                                            <span style="font-size: large; letter-spacing: 3px;"><%# Eval("Req_Status") %></span>
                                            <span class="pull-right text-right">
                                                <span style="font-size: small"><%# Eval("ACCT_EXEC_INCHARGE").ToString() %></span>
                                            </span>
                                        </asp:Panel>
                                        <asp:Panel ID="pnl1" runat="server" BorderStyle="Dashed" Style="border-bottom-width: 0px" BorderWidth="0px" BorderColor='<%# Eval("Req_Status").ToString() == "For Checking" ? System.Drawing.Color.SkyBlue :
                                                Eval("Req_Status").ToString() == "For Approval" ? System.Drawing.Color.Orange :
                                                Eval("Req_Status").ToString() == "Approved" ? System.Drawing.Color.Green : System.Drawing.Color.Black %>'
                                            Width="100%">
                                        </asp:Panel>
                                        <div class="row" style="margin: 0; padding: 0;">
                                            <div class="col-sm-6" style="margin: 0; padding: 0;">
                                                <div class="text-center" style="letter-spacing: 5px; padding: 5px; text-transform: uppercase;"><span><%# Eval("Payment_Type") %></span></div>
                                                <div style="padding: 10px; background-color: white">
                                                    <span style="font-weight: bold; font-size: medium"><%# Eval("Project_Label") %></span>
                                                    <span class="pull-right text-right">
                                                        <span style="font-size: medium"><%# Eval("Payment_Date") %></span><br />
                                                        <span style="font-size: medium; color: limegreen;"><%# Eval("PAYMENT_FORMATTED") %></span>
                                                    </span>
                                                    <br />
                                                    <span style="font-size: smaller"><%# Eval("JO_Parent") %></span>
                                                </div>
                                                <div class="text-center" style="background-color: whitesmoke; padding: 5px;">
                                                    <span style="font-weight: bold"><%# Eval("NAME") %></span><br />
                                                    <span style="font-size: smaller"><%# Eval("OFFICENAME") %></span><br />
                                                    <span style="font-size: smaller"><%# Eval("POSITION") %></span>
                                                </div>
                                                <br />
                                                <asp:Panel ID="pnlNote" Style="padding: 5px; padding-left: 10px;" class="text-center" runat="server"
                                                    Visible='<%# Eval("Req_Status").ToString() == "Approved" || Eval("Req_Status").ToString() == "Done" || Eval("Hold_Status").ToString() == "Approved" ? true : false %>'>
                                                    <span style="font-family: Candara Light; color: green; font-weight: bold">Approved by <%# Eval("Approved_By").ToString() %> on <%# Eval("Approved_Date") %></span>
                                                </asp:Panel>

                                            </div>
                                            <div class="col-sm-6" style="margin: 0; padding: 0;">
                                                <div class="text-center" style="letter-spacing: 5px; padding: 5px; border-left: 1px solid #bab9b9;"><span>PARTICULARS</span></div>
                                                <div style="border-left: 1px solid #bab9b9; padding: 0px; height: inherit;">
                                                    <div style="background-color: antiquewhite; font-size: small; padding: 5px; padding-left: 10px;">
                                                        <span>Request Type:</span>
                                                        <span class="pull-right text-right">
                                                            <span class="" style="text-transform: uppercase"><%# Eval("Request") %></span><br />
                                                            <span class=""><%# Eval("AF_Releasing") %></span>
                                                        </span>
                                                        <br />
                                                        <span>AF Releasing:</span>
                                                    </div>
                                                    <div style="padding: 5px; padding-left: 10px; background-color: whitesmoke;">
                                                        <div style="display: flex; flex-flow: row wrap;">
                                                            <div style="width: 30%; vertical-align: text-top;">
                                                                <span style="font-size: small"><%# Eval("Requested_Date") %></span><br />
                                                                <span style="font-size: smaller;" class="text-muted"><%# Eval("Account_Exec") %></span>
                                                            </div>
                                                            <div style="width: 70%; vertical-align: text-top;">
                                                                    <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Particular").ToString(), "\r\n|\r|\n", "<br>")) %></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div style="border-bottom: 1px solid #bab9b9; background-color: white; border-top: 1px solid #bab9b9; padding: 5px; padding-left: 10px;">
                                                        <div style="display: flex; flex-flow: row wrap;">
                                                            <div style="width: 30%; vertical-align: text-top;">
                                                                    <span class="" style="font-size: small"><%# Eval("Checked_Date") %></span><br />
                                                                    <span style="font-size: smaller;" class="text-muted"><%# Eval("Checked_By") %></span>
                                                            </div>
                                                            <div style="width: 70%; vertical-align: text-top;">
                                                                <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Checked_Remarks").ToString(), "\r\n|\r|\n", "<br>")) %></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div style="padding: 5px; padding-left: 10px; background-color: whitesmoke;">
                                                        <div style="display: flex; flex-flow: row wrap;">
                                                            <div style="width: 30%; vertical-align: text-top;">
                                                                <span style="font-size: small" class=""><%# Eval("General_Remarks_Date") %></span><br />
                                                                <span style="font-size: smaller;" class="text-muted"><%# Eval("General_Remarks_By") %></span>
                                                            </div>
                                                            <div style="width: 70%; vertical-align: text-top;">
                                                                <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Approval_Remarks").ToString(), "\r\n|\r|\n", "<br>")) %></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <asp:Panel ID="pnlHoldReason" runat="server" Visible='<%# Eval("Hold_Reason").ToString() == "" ? false : true %>'
                                                        Style="padding: 5px; padding-left: 10px; background-color: white; border-top: 1px solid #bab9b9;">
                                                        <div style="display: flex; flex-flow: row wrap;">
                                                            <div style="width: 30%; vertical-align: text-top;">
                                                                <span style="font-size: small"><%# Eval("Hold_Date") %></span><br />
                                                                <span style="font-size: smaller;" class="text-muted"><%# Eval("Hold_By") %></span>
                                                            </div>
                                                            <div style="width: 70%; vertical-align: text-top;">
                                                                <span style="font-size: small; color: red;"><%# Eval("Hold_Reason") %></span>
                                                            </div>
                                                        </div>
                                                    </asp:Panel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </div>
</asp:Content>
