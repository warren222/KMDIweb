﻿<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AF/AF_Master.Master" AutoEventWireup="true" CodeBehind="AF_For_Checking.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AF.AF_For_Checking" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AF | Request</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>AF Requests</h2>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>

            <div class="row">
                <div class="col-sm-6">
                    <div>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvSummary" ShowHeader="false" GridLines="None" Width="100%" AutoGenerateColumns="false" runat="server" OnRowCommand="gvSummary_RowCommand">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <table border="1" class="wf_tbl">
                                                    <tr class="text-center">
                                                        <td style ="width:100px;">For Checking</td>
                                                        <td style ="width:100px;">For Approval</td>
                                                        <td style ="width:100px;">Approved</td>
                                                        <td style ="width:100px;">Hold</td>
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
                <div class="col-sm-6">
                    <div class="well">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <span>Status</span>
                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                            <asp:ListItem Text="Hold" Value="Hold"></asp:ListItem>
                                            <asp:ListItem Text="For Checking" Value="For Checking"></asp:ListItem>
                                            <asp:ListItem Text="For Approval" Value="For Approval"></asp:ListItem>
                                            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
                                            <asp:ListItem Text="Done" Value="Done"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-8">
                                        <span>Account Executive</span>
                                        <asp:DropDownList runat="server" ID="ddlAE" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
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
            <div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div style="overflow-x: auto">
                            <asp:GridView ID="gv1" runat="server" Width="100%" BackColor="green" CssClass="wf_tbl" ShowHeader="false" GridLines="None" AutoGenerateColumns="false" OnRowDataBound="gv1_RowDataBound" OnRowCommand="gv1_RowCommand" AllowPaging="True" OnPageIndexChanging="gv1_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label runat="server" Visible="false" ID="lblStatus" Text='<%# Bind("Req_Status")%>'></asp:Label>
                                            <asp:Label runat="server" Visible="false" ID="lblHoldBy" Text='<%# Bind("Hold_By")%>'></asp:Label>
                                            <div style='border-left: 2px solid; border-color: <%# Eval("Req_Status").ToString() == "For Checking" ? "SkyBlue" :
                                                        Eval("Req_Status").ToString() == "Hold" ? "Red" :
                                                Eval("Req_Status").ToString() == "For Approval" ? "Orange" :
                                                Eval("Req_Status").ToString() == "Approved" ? "Green" : "Black" %>;'>
                                                <div style="min-width: 370px; white-space: normal; margin-bottom: 20px;">
                                                    <asp:Panel ID="pnlStatus" runat="server"
                                                        Width="100px" Style="padding: 5px; border-top-right-radius: 30px;"
                                                        ForeColor='<%# Eval("Req_Status").ToString() == "For Approval" || Eval("Req_Status").ToString() == "For Checking" ? System.Drawing.Color.Black : System.Drawing.Color.White %>'
                                                        BackColor='<%# Eval("Req_Status").ToString() == "For Checking" ? System.Drawing.Color.SkyBlue :
                                                        Eval("Req_Status").ToString() == "Hold" ? System.Drawing.Color.Red :
                                                Eval("Req_Status").ToString() == "For Approval" ? System.Drawing.Color.Orange :
                                                Eval("Req_Status").ToString() == "Approved" ? System.Drawing.Color.Green : System.Drawing.Color.Black %>'>
                                                        <span><%# Eval("Req_Status") %></span>
                                                    </asp:Panel>
                                                    <asp:Panel ID="pnl1" runat="server" BorderStyle="Dashed" Style="border-bottom-width: 0px" BorderWidth="0px" BorderColor='<%# Eval("Req_Status").ToString() == "For Checking" ? System.Drawing.Color.SkyBlue :
                                                Eval("Req_Status").ToString() == "For Approval" ? System.Drawing.Color.Orange :
                                                Eval("Req_Status").ToString() == "Approved" ? System.Drawing.Color.Green : System.Drawing.Color.Black %>'
                                                        Width="100%">
                                                        <div style="padding: 10px; background-color: white">
                                                            <span style="font-weight: bold"><%# Eval("NAME") %></span>
                                                            <span class="pull-right text-right">
                                                                <span style="font-size: small"><%# Eval("Requested_Date") %></span><br />
                                                                <span style="font-size: smaller"><%# Eval("Request") %></span><br />
                                                                <asp:Label ID="lblId" runat="server" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                                                <asp:LinkButton ID="btnDone" CssClass="btn btn-success" Visible="false"
                                                                    CommandName="myDone" runat="server" OnClientClick="return confirm('update status to done?')">Done</asp:LinkButton>
                                                                <asp:LinkButton ID="btnHold" CssClass="btn btn-danger" Visible="false"
                                                                    CommandName="myHold" runat="server" OnClientClick="return confirm('update status to hold?')">Hold</asp:LinkButton>
                                                                <asp:LinkButton ID="btnUnhold" CssClass="btn btn-warning" Visible="false"
                                                                    CommandName="myUnhold" runat="server" OnClientClick="return confirm('cancel hold status?')">Unhold</asp:LinkButton>
                                                            </span>
                                                            <br />
                                                            <span style="font-size: smaller"><%# Eval("OFFICENAME") %></span><br />
                                                            <span style="font-size: smaller"><%# Eval("POSITION") %></span><br />
                                                        </div>


                                                        <div class="text-center" style="background-color: whitesmoke; padding: 5px;">
                                                            <br />
                                                            <span><%# Eval("Project_Label") %></span><br />
                                                            <span style="font-size: smaller"><%# Eval("Fulladd") %></span>
                                                        </div>
                                                        <div style="background-color: cornsilk;">
                                                            <div style="border-left: solid 0px skyblue; padding: 10px">
                                                                <asp:Panel runat="server" Visible="true" ID="pnlCommentParticular">
                                                                    <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Particular").ToString(), "\r\n|\r|\n", "<br>")) %></span>
                                                                    <span style="font-size: small;" class="text-info">&nbsp;&nbsp;&nbsp;<%# "-"+Eval("Account_Exec") %></span> <span style="font-size: small" class="text-muted"><%# Eval("Requested_Date") %></span>
                                                                    <span class="pull-right">
                                                                        <asp:LinkButton ID="btnEditParticular" Visible="False" CommandName="myEditParticular" runat="server">Edit</asp:LinkButton>
                                                                </asp:Panel>
                                                                <asp:Panel runat="server" Visible="false" ID="pnlCommentEditParticular">
                                                                    <span>Comment</span>
                                                                    <asp:TextBox runat="server" ID="tboxCommentParticular" CssClass="form-control" Text='<%# Bind("Particular") %>' TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                                    <asp:LinkButton runat="server" ID="btnSaveParticular" CommandName="mySaveParticular" CssClass="btn btn-default">s u b m i t</asp:LinkButton>
                                                                </asp:Panel>

                                                            </div>
                                                            <div style="border-left: solid 0px orange; min-height: 35px; border-top: 0.5px solid #bab9b9; padding: 10px">
                                                                <asp:Panel runat="server" Visible='<%# Eval("Req_Status").ToString() == "For Checking" ? true : false %>' ID="pnlCommentEdit">
                                                                    <span>Comment</span>
                                                                    <asp:TextBox runat="server" ID="tboxComment" CssClass="form-control" Text='<%# Bind("Checked_Remarks") %>' TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                                    <asp:LinkButton runat="server" ID="btnSave" CommandName="myCheck" CssClass="btn btn-default">s u b m i t</asp:LinkButton>
                                                                </asp:Panel>
                                                                <asp:Panel runat="server" Visible='<%# Eval("Req_Status").ToString() == "For Checking" ? false : true %>' ID="pnlComment">
                                                                    <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Checked_Remarks").ToString(), "\r\n|\r|\n", "<br>")) %>
                                                                        <span style="font-size: small;" class="text-info">&nbsp;&nbsp;&nbsp;<%# "-"+Eval("Checked_By") %></span> <span style="font-size: small" class="text-muted"><%# Eval("Checked_Date") %></span><span class="pull-right"><asp:LinkButton ID="btnEdit" Visible='<%# Eval("Req_Status").ToString() == "For Approval" ? true : false %>' CommandName="myEdit" runat="server">Edit</asp:LinkButton>
                                                                        </span>
                                                                    </span>
                                                                </asp:Panel>
                                                            </div>
                                                            <div style="border-left: solid 0px green; min-height: 35px; border-top: 0.5px solid #bab9b9; padding: 10px">
                                                                <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Approval_Remarks").ToString(), "\r\n|\r|\n", "<br>")) %></span>
                                                                <span style="font-size: small;" class="text-info">&nbsp;&nbsp;&nbsp;<%# "-"+Eval("Approved_By") %></span> <span style="font-size: small" class="text-muted"><%# Eval("Approved_Date") %></span>
                                                            </div>

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