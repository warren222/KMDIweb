﻿<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AF/AF_Master.Master" AutoEventWireup="true" CodeBehind="AF_For_Checking.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AF.AF_For_Checking" %>

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
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>For Checking</h2>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>

            <div class="row nopm">
                <div class="col-sm-6 nopm">
                    <div>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvSummary" ShowHeader="false" GridLines="None" Width="100%" AutoGenerateColumns="false" runat="server" OnRowCommand="gvSummary_RowCommand">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <table border="1" class="wf_tbl">
                                                    <tr class="text-center">
                                                        <td style="width: 100px;">For Checking</td>
                                                        <td style="width: 100px;">For Approval</td>
                                                        <td style="width: 100px;">Approved</td>
                                                        <td style="width: 100px;">Hold</td>
                                                    </tr>
                                                    <tr class="text-center">
                                                        <td>
                                                            <asp:LinkButton ID="btnForChecking" CommandName="ForChecking" runat="server"><span style="font-size: xx-large; color: skyblue"><%# Eval("For_Checking") %></span></asp:LinkButton></td>
                                                        <td>
                                                            <asp:LinkButton ID="btnForApproval" CommandName="ForApproval" runat="server"><span style="font-size: xx-large; color: orange"><%# Eval("For_Approval") %></span></asp:LinkButton></td>
                                                        <td>
                                                            <asp:LinkButton ID="btnApproved" CommandName="Approved" runat="server"><span style="font-size: xx-large; color: green"><%# Eval("Approved") %></span></asp:LinkButton></td>
                                                        <td>
                                                            <asp:LinkButton ID="btnHold" CommandName="Hold" runat="server"><span style="font-size: xx-large; color: red"><%# Eval("Hold") %></span></asp:LinkButton></td>
                                                    </tr>
                                                </table>

                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="col-sm-6 nopm">
                    <div class="well">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="row" style="margin: 0; padding: 0;">
                                    <div class="col-sm-4" style="margin: 0; padding: 0;">
                                        <span>Status</span>
                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" Style="border-radius: 0;">
                                            <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                            <asp:ListItem Text="Hold" Value="Hold"></asp:ListItem>
                                            <asp:ListItem Text="For Checking" Value="For Checking"></asp:ListItem>
                                            <asp:ListItem Text="For Approval" Value="For Approval"></asp:ListItem>
                                            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
                                            <asp:ListItem Text="Done" Value="Done"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-4" style="margin: 0; padding: 0;">
                                        <span>Date Filter</span>
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="ddlDate_Filter" Style="border-radius: 0;">
                                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                            <asp:ListItem Value="Date Requested" Text="Date Requested"></asp:ListItem>
                                            <asp:ListItem Value="Date Checked" Text="Date Checked"></asp:ListItem>
                                            <asp:ListItem Value="Date Approved" Text="Date Approved"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-4" style="margin: 0; padding: 0;">
                                        <span>Date</span>
                                        <asp:TextBox runat="server" TextMode="Date" ID="tboxDate" CssClass="form-control" Style="border-radius: 0;"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row" style="margin: 0; padding: 0;">
                                    <div class="col-sm-6" style="margin: 0; padding: 0;">
                                        <asp:Label ID="lblAE" runat="server">Account Executive</asp:Label>
                                        <asp:DropDownList runat="server" ID="ddlAE" CssClass="form-control" Style="border-radius: 0;"></asp:DropDownList>
                                    </div>
                                    <div class="col-sm-6" style="margin: 0; padding: 0;">
                                        <span>Find</span>
                                        <div class="input-group">
                                            <asp:TextBox runat="server" ID="tboxSearch" CssClass="form-control" Style="border-radius: 0;"></asp:TextBox>
                                            <div class="input-group-btn">
                                                <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-default" Style="border-radius: 0;" OnClick="btnSearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
            <div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div style="overflow-x: auto">
                            <asp:GridView ID="gv1" runat="server" Width="100%" BackColor="White" CssClass="" ShowHeader="false" GridLines="None" AutoGenerateColumns="false" OnRowDataBound="gv1_RowDataBound" OnRowCommand="gv1_RowCommand" AllowPaging="True" OnPageIndexChanging="gv1_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label runat="server" Visible="false" ID="lblStatus" Text='<%# Bind("Req_Status")%>'></asp:Label>
                                            <asp:Label runat="server" Visible="false" ID="lblHoldBy" Text='<%# Bind("Hold_By")%>'></asp:Label>
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
                                                                <div class="text-center">
                                                                    <asp:Label ID="lblId" runat="server" Visible="false" ForeColor="Red" Text='<%# Bind("Id") %>'></asp:Label>
                                                                    <asp:LinkButton ID="btnDone" CssClass="btn btn-success" Visible="false" Width="120px"
                                                                        CommandName="myDone" runat="server" OnClientClick="return confirm('update status to done?')"><span class="glyphicon glyphicon-check"></span> d o n e</asp:LinkButton>
                                                                    <asp:LinkButton ID="btnHold" CssClass="btn btn-danger" Visible="false" Width="120px"
                                                                        CommandName="myHold" runat="server" OnClientClick="return confirm('hold this request?')"><span class="glyphicon glyphicon-ban-circle"></span> h o l d</asp:LinkButton>
                                                                    <asp:LinkButton ID="btnUnhold" CssClass="btn btn-warning" Visible="false" Width="120px" ForeColor="Black"
                                                                        CommandName="myUnhold" runat="server" OnClientClick="return confirm('release this AF?')"><span class="glyphicon glyphicon-ok-circle"></span> r e l e a s e</asp:LinkButton>
                                                                    <asp:LinkButton ID="btnCancel" CssClass="btn btn-default" Visible='<%# Eval("Req_Status").ToString() == "For Checking" ? true : false %>' Width="120px"
                                                                        CommandName="myCancel" runat="server" OnClientClick="return confirm('cancel this request?')"><span class="glyphicon glyphicon-trash"></span> c a n c e l</asp:LinkButton>
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
                                                                                <asp:Panel runat="server" Visible="true" ID="pnlRequestedRemarks">
                                                                                    <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Particular").ToString(), "\r\n|\r|\n", "<br>")) %></span>
                                                                                    <span class="pull-right">
                                                                                        <asp:LinkButton ID="btnEditParticular" Visible="False" CommandName="myEditParticular" runat="server">Edit</asp:LinkButton>
                                                                                    </span>
                                                                                </asp:Panel>
                                                                                <asp:Panel runat="server" Visible="false" ID="pnlRequestedRemarksEdit">
                                                                                    <span>Comment</span>
                                                                                    <asp:TextBox runat="server" ID="tboxCommentParticular" CssClass="form-control" Text='<%# Bind("Particular") %>' TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                                                    <asp:LinkButton runat="server" ID="btnSaveParticular" CommandName="mySaveParticular" CssClass="btn btn-default">s e n d <span class="glyphicon glyphicon-send"></span></asp:LinkButton>
                                                                                </asp:Panel>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div style="border-bottom: 1px solid #bab9b9; background-color: white; border-top: 1px solid #bab9b9; padding: 5px; padding-left: 10px;">
                                                                        <div style="display: flex; flex-flow: row wrap;">
                                                                            <div style="width: 30%; vertical-align: text-top;">
                                                                                <asp:Panel ID="pnlCheckedDate" runat="server">
                                                                                    <span class="" style="font-size: small"><%# Eval("Checked_Date") %></span><br />
                                                                                    <span style="font-size: smaller;" class="text-muted"><%# Eval("Checked_By") %></span>
                                                                                </asp:Panel>
                                                                            </div>
                                                                            <div style="width: 70%; vertical-align: text-top;">
                                                                                <asp:Panel runat="server" Visible='<%# Eval("Req_Status").ToString() == "For Checking" ? true : false %>' ID="pnlCheckedRemarksEdit">
                                                                                    <span>Comment</span>
                                                                                    <asp:TextBox runat="server" ID="tboxComment" CssClass="form-control" Text='<%# Bind("Checked_Remarks") %>' TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                                                    <asp:LinkButton runat="server" ID="btnSave" CommandName="myCheck" CssClass="btn btn-default">s e n d <span class="glyphicon glyphicon-send"></span></asp:LinkButton>
                                                                                </asp:Panel>
                                                                                <asp:Panel runat="server" Visible='<%# Eval("Req_Status").ToString() == "For Checking" ? false : true %>' ID="pnlCheckedRemarks">
                                                                                    <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Checked_Remarks").ToString(), "\r\n|\r|\n", "<br>")) %></span>
                                                                                    <span class="pull-right">
                                                                                        <asp:LinkButton ID="btnEdit" Visible='<%# Eval("Req_Status").ToString() == "For Approval" ? true : false %>' CommandName="myEdit" runat="server">Edit</asp:LinkButton>
                                                                                    </span>
                                                                                </asp:Panel>
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                    <div style="padding: 5px; padding-left: 10px; background-color: whitesmoke;">
                                                                        <div style="display: flex; flex-flow: row wrap;">
                                                                            <div style="width: 30%; vertical-align: text-top;">
                                                                                <asp:Panel ID="pnlApprovedDate" runat="server">
                                                                                    <span style="font-size: small" class=""><%# Eval("General_Remarks_Date") %></span><br />
                                                                                    <span style="font-size: smaller;" class="text-muted"><%# Eval("General_Remarks_By") %></span>
                                                                                </asp:Panel>

                                                                            </div>
                                                                            <div style="width: 70%; vertical-align: text-top;">
                                                                                <asp:Panel ID="pnlApprovedRemarks" runat="server">
                                                                                    <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Approval_Remarks").ToString(), "\r\n|\r|\n", "<br>")) %></span>
                                                                                </asp:Panel>
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

                                                        <div>
                                                            <asp:GridView ID="gvFiles" runat="server" ShowHeader="false" BorderColor="#bab9b9" Width="100%" AutoGenerateColumns="false" Style="border-spacing: 0px;" GridLines="Both">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <div style="margin: 0; padding: 0;" class="text-center">
                                                                                <asp:HyperLink ID="HyperLink1"
                                                                                    CssClass='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-image-link"%>'
                                                                                    NavigateUrl='<%# Eval("File_Path").ToString() %>'
                                                                                    data-lightbox='<%# Eval("FileExtension").ToString() == ".pdf" ? "" : "example-set"%>' data-title='<%# Eval("FileName").ToString() %>' runat="server">
                                                                                 <%--   <asp:Image ID="Image2" Width="100px" Style="object-fit: contain; min-width: 100px; min-height: 100px;" Height="100px" CssClass='<%# Eval("File_Path").ToString() == ".pdf"? "wf_img img-thumbnail" : "wf_img img-thumbnail example-image"%>'
                                                                                        ImageUrl='<%# Eval("File_Path").ToString() == ".pdf" ? "~/Images/pdflogo.png" : Eval("File_Path") %>' runat="server" />--%>
                                                                                    <span style="font-size:medium"  class='<%# Eval("FileExtension").ToString() == ".pdf"? "" : "example-image"%>'><%# Eval("FileName") %></span>
                                                                                </asp:HyperLink>
                                                                            <%--    <asp:Label ID="lblFile_Path" Visible="false" runat="server" Text='<%# Bind("File_Path") %>'></asp:Label>
                                                                                <asp:LinkButton ID="btnView" Font-Size="Large" runat="server" CommandName="myView" Text='<%# Bind("FileName") %>'></asp:LinkButton>--%>
                                                                            </div>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                        <div style="background-color: antiquewhite; padding: 5px;" class="text-center">
                                                            <asp:LinkButton ID="btnUploadedFiles" runat="server" Visible="false" Font-Size="Large" CommandName="myUploadFile">File Manager >>></asp:LinkButton>
                                                        </div>
                                                    </asp:Panel>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <p style="font-size: x-large" class="text-danger">0 result found!</p>
                                </EmptyDataTemplate>
                                <PagerSettings PageButtonCount="15" Position="TopAndBottom" />
                                <PagerStyle CssClass="GridPager" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" />
                            </asp:GridView>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
