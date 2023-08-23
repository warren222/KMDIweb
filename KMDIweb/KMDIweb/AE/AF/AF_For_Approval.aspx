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
            <div class="well">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="row">
                            <div class="col-sm-3">
                                <span>Status</span>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="For Approval" Value="For Approval"></asp:ListItem>
                                    <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
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
                                        <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-primary" OnClick="btnSearch_Click">search</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div style="overflow-x: auto">
                            <asp:GridView ID="gv1" runat="server" Width="100%" CssClass="wf_tbl" ShowHeader="false" GridLines="None" AutoGenerateColumns="false" OnRowCommand="gv1_RowCommand" AllowPaging="True" OnPageIndexChanging="gv1_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div style="min-width: 370px; white-space: nowrap; margin-bottom: 20px;">
                                                <asp:Panel ID="pnlStatus" runat="server"
                                                    Width="100px" Style="padding: 5px; border-top-right-radius: 30px;"
                                                    ForeColor='<%# Eval("Req_Status").ToString() == "For Checking" ? System.Drawing.Color.Black : System.Drawing.Color.White %>'
                                                    BackColor='<%# Eval("Req_Status").ToString() == "For Checking" ? System.Drawing.Color.Yellow :
                                                Eval("Req_Status").ToString() == "For Approval" ? System.Drawing.Color.Orange :
                                                Eval("Req_Status").ToString() == "Approved" ? System.Drawing.Color.Green : System.Drawing.Color.Red %>'>
                                                    <span><%# Eval("Req_Status") %></span>
                                                </asp:Panel>
                                                <div style="background-color: white; padding: 10px;">
                                                    <span style="font-weight: bold"><%# Eval("NAME") %></span>
                                                    <span class="pull-right text-right">
                                                        <span style="font-size: small"><%# Eval("Requested_Date") %></span><br />
                                                        <span style="font-size: smaller"><%# Eval("Request") %></span><br />
                                                        <asp:Label ID="lblId" runat="server" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                                    </span>
                                                    <br />
                                                    <span style="font-size: smaller"><%# Eval("OFFICENAME") %></span><br />
                                                    <span style="font-size: smaller"><%# Eval("POSITION") %></span><br />
                                                </div>
                                                <div class="text-center" style="background-color: whitesmoke; padding: 10px;">
                                                    <span><%# Eval("Project_Label") %></span><br />
                                                    <span style="font-size: smaller"><%# Eval("Fulladd") %></span>
                                                </div>
                                                <div style="background-color: cornsilk">
                                                    <div style="border-left: solid 5px yellow; padding: 10px">
                                                        <span style="font-size: small"><%# Eval("Particular") %></span><br />
                                                        <span style="font-size: small; font-weight: bold" class="text-info">- <%# Eval("Account_Exec") %></span>
                                                        <span style="font-size: small" class="text-info"><%# Eval("Requested_Date") %></span>
                                                    </div>
                                                    <div style="border-left: solid 5px orange; border-top: 0.5px solid #bab9b9; padding: 10px">
                                                        <span style="font-size: small"><%# Eval("Checked_Remarks") %></span><br />
                                                        <span style="font-size: small; font-weight: bold" class="text-info">- <%# Eval("Checked_By") %></span>
                                                        <span style="font-size: small" class="text-info"><%# Eval("Checked_Date") %></span>
                                                    </div>
                                                    <div style="border-left: solid 5px green; min-height: 35px; border-top: 0.5px solid #bab9b9; padding: 10px">
                                                        <asp:Panel runat="server" Visible='<%# Eval("Req_Status").ToString() == "For Approval" ? true : false %>' ID="pnlCommentEdit">
                                                            <span>Comment</span>
                                                            <asp:TextBox runat="server" ID="tboxComment" CssClass="form-control" Text='<%# Bind("Approval_Remarks") %>' TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                            <asp:LinkButton runat="server" ID="btnSave" CommandName="myApprove" CssClass="btn btn-success">s u b m i t</asp:LinkButton>
                                                        </asp:Panel>
                                                        <asp:Panel runat="server" Visible='<%# Eval("Req_Status").ToString() == "For Approval" ? false : true %>' ID="pnlComment">
                                                            <span style="font-size: small"><%# Eval("Approval_Remarks") %><br />
                                                                <span style="font-size: small; font-weight: bold" class="text-info">- <%# Eval("Approved_By") %></span>
                                                                <span style="font-size: small" class="text-info"><%# Eval("Approved_Date") %></span>
                                                                <span class="pull-right">
                                                                    <asp:LinkButton ID="btnEdit" CommandName="myEdit" runat="server">Edit</asp:LinkButton>
                                                                </span>
                                                            </span>
                                                        </asp:Panel>

                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
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
