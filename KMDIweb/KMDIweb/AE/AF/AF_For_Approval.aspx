<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AF/AF_Master.Master" AutoEventWireup="true" CodeBehind="AF_For_Approval.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AF.AF_For_Approval" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AF | For Approval</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>AF For Approval</h2>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="row">
                <div class="col-sm-4">
                    <div>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvSummary" ShowHeader="false" GridLines="None" Width="100%" AutoGenerateColumns="false" runat="server" OnRowCommand="gvSummary_RowCommand">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <table border="1" class="wf_tbl">
                                                    <tr class="text-center">
                                                        <td style="width: 100px;">For Approval</td>
                                                        <td style="width: 100px;">Approved</td>
                                                        <td style="width: 100px;">Hold</td>
                                                    </tr>
                                                    <tr class="text-center">
                                                        <td>
                                                            <asp:LinkButton ID="btnForApproval" CommandName="ForApproval" runat="server"><span style="font-size: xx-large; color: orange"><%# Eval("For_Approval") %></span></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="btnApproved" CommandName="Approved" runat="server"><span style="font-size: xx-large; color: green"><%# Eval("Approved") %></span></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="btnHold" CommandName="Hold" runat="server"><span style="font-size: xx-large; color: red"><%# Eval("Hold_Approval") %></span></asp:LinkButton></td>
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
                <div class="col-sm-8">
                    <div class="well">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div>

                                </div>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <span>Status</span>
                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                            <asp:ListItem Text="Hold" Value="Hold"></asp:ListItem>
                                            <asp:ListItem Text="For Approval" Value="For Approval"></asp:ListItem>
                                            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
                                            <asp:ListItem Text="Done" Value="Done"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-4">
                                        <span>Account Executive</span>
                                        <asp:DropDownList runat="server" ID="ddlAE" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                    <div class="col-sm-5">
                                        <span>Find</span>
                                        <div class="input-group">
                                            <asp:TextBox runat="server" ID="tboxSearch" CssClass="form-control"></asp:TextBox>
                                            <div class="input-group-btn">
                                                <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-default" OnClick="btnSearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
            <br />
            <div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div style="overflow-x: auto">
                            <asp:GridView ID="gv1" runat="server" Width="100%" ShowHeader="false" GridLines="None" AutoGenerateColumns="false"
                                OnRowCommand="gv1_RowCommand" AllowPaging="True" OnPageIndexChanging="gv1_PageIndexChanging" OnRowDataBound="gv1_RowDataBound">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label runat="server" Visible="false" ID="lblStatus" Text='<%# Bind("Req_Status")%>'></asp:Label>
                                            <asp:Label runat="server" Visible="false" ID="lblHoldBy" Text='<%# Bind("Hold_By")%>'></asp:Label>
                                            <div style='border: 2px solid; border-color: <%# Eval("Req_Status").ToString() == "For Checking" ? "SkyBlue" :
                                                        Eval("Req_Status").ToString() == "Hold" ? "Red" :
                                                Eval("Req_Status").ToString() == "For Approval" ? "Orange" :
                                                Eval("Req_Status").ToString() == "Approved" ? "Green" : "Black" %>;'>
                                                <div style="min-width: 370px; white-space: normal; margin-bottom: 20px;">
                                                    <asp:Panel ID="pnlStatus" runat="server"
                                                        Style="padding: 5px; border-top-right-radius: 0px;"
                                                        ForeColor='<%# Eval("Req_Status").ToString() == "For Approval" || Eval("Req_Status").ToString() == "For Checking" ? System.Drawing.Color.Black : System.Drawing.Color.White %>'
                                                        BackColor='<%# Eval("Req_Status").ToString() == "For Checking" ? System.Drawing.Color.SkyBlue :
                                                            Eval("Req_Status").ToString() == "Hold" ? System.Drawing.Color.Red :
                                                Eval("Req_Status").ToString() == "For Approval" ? System.Drawing.Color.Orange :
                                                Eval("Req_Status").ToString() == "Approved" ? System.Drawing.Color.Green : System.Drawing.Color.Black %>'>
                                                        <span style="font-size: large; letter-spacing: 3px;"><%# Eval("Req_Status") %></span>
                                                    </asp:Panel>


                                                    <div class="row" style="margin: 0; padding: 0;">
                                                        <div class="col-sm-6" style="margin: 0; padding: 0;">
                                                            <div style="background-color: white; padding: 10px;">
                                                                <span style="font-weight: bold; font-size: medium"><%# Eval("Project_Label") %></span>
                                                                <span class="pull-right text-right">
                                                                    <span style="font-size: medium"><%# Eval("Requested_Date") %></span><br />
                                                                    <span style="font-size: medium" class="text-info"><%# Eval("Request") %></span>
                                                                </span>
                                                                <br />
                                                                <span style="font-size: smaller"><%# Eval("JO_Parent") %></span>
                                                            </div>
                                                            <div class="text-center" style="background-color: whitesmoke; padding: 10px;">
                                                                <span style="font-weight: bold"><%# Eval("NAME") %></span><br />
                                                                <span style="font-size: smaller"><%# Eval("OFFICENAME") %></span><br />
                                                                <span style="font-size: smaller"><%# Eval("POSITION") %></span>
                                                            </div>
                                                            <div class="text-center">
                                                                <asp:LinkButton ID="btnHold" CssClass="btn btn-danger" Visible="false"
                                                                    CommandName="myHold" runat="server" OnClientClick="return confirm('update status to hold?')">Hold</asp:LinkButton>
                                                                <asp:LinkButton ID="btnUnhold" CssClass="btn btn-warning" Visible="false"
                                                                    CommandName="myUnhold" runat="server" OnClientClick="return confirm('cancel hold status?')">Unhold</asp:LinkButton>
                                                                <asp:Label ID="lblId" runat="server" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6" style="margin: 0; padding: 0;">
                                                            <div style="border-left: 1px solid #bab9b9; padding: 5px; padding-left: 0px; height: inherit;">
                                                                <div class="text-center" style="letter-spacing: 5px;"><span>PARTICULARS</span></div>
                                                                <div style="padding-left: 10px;background-color: white;">
                                                                    <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Particular").ToString(), "\r\n|\r|\n", "<br>")) %></span><br />
                                                                    <span style="font-size: small;" class="text-success"><%# "Requested by "+Eval("Account_Exec") %></span><br /><span style="font-size: small" class="text-muted"><%# Eval("Requested_Date") %></span>
                                                                </div>
                                                                <div style="border-bottom: 1px solid #bab9b9; border-top: 1px solid #bab9b9; padding-left: 10px;">
                                                                    <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Checked_Remarks").ToString(), "\r\n|\r|\n", "<br>")) %></span><br />
                                                                    <span style="font-size: small;" class="text-success"><%# ""+Eval("Checked_By") %></span><br /><span style="font-size: small" class="text-muted"><%# Eval("Checked_Date") %></span>
                                                                </div>
                                                                <div style="padding-left: 10px;background-color: white;">
                                                                    <asp:Panel runat="server" Visible='<%# Eval("Req_Status").ToString() == "For Approval" ? true : false %>' ID="pnlCommentEdit">
                                                                        <span>Comment</span>
                                                                        <asp:TextBox runat="server" ID="tboxComment" CssClass="form-control" Text='<%# Bind("Approval_Remarks") %>' TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                                        <asp:LinkButton runat="server" ID="btnSave" CommandName="myApprove" CssClass="btn btn-default">s u b m i t</asp:LinkButton>
                                                                    </asp:Panel>
                                                                    <asp:Panel runat="server" Visible='<%# Eval("Req_Status").ToString() == "For Approval" ? false : true %>' ID="pnlComment">
                                                                        <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Approval_Remarks").ToString(), "\r\n|\r|\n", "<br>")) %></span><br />
                                                                        <span style="font-size: small;" class="text-success"><%# ""+Eval("Approved_By") %></span><br /><span style="font-size: small" class="text-muted"><%# Eval("Approved_Date") %></span>
                                                                        <span class="pull-right">
                                                                            <asp:LinkButton ID="btnEdit" Visible='<%# Eval("Req_Status").ToString() == "Done" ? false : true %>' CommandName="myEdit" runat="server">Edit</asp:LinkButton>
                                                                        </span>
                                                                    </asp:Panel>

                                                                </div>
                                                            </div>
                                                        </div>
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
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
