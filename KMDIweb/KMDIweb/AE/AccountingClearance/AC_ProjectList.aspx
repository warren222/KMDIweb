<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/AE/AccountingClearance/AC.Master" CodeBehind="AC_ProjectList.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AccountingClearance.AC_ProjectList" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Accg Clearance | Request</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <div class="container text-left">
                <h2>Accg Clearance Request</h2>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div>
            <div class="row">
                <div class="col-sm-6">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="gvSummary" ShowHeader="false" GridLines="None" Width="100%" AutoGenerateColumns="false" OnRowCommand="gvSummary_RowCommand" runat="server">
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
                                                        <asp:LinkButton ID="btnForApproval" CommandName="ForApproval" runat="server"><span style="font-size: xx-large; color: orange"><%# Eval("ForApproval") %></span></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnApproved" CommandName="Approved" runat="server"><span style="font-size: xx-large; color: green"><%# Eval("Approved") %></span></asp:LinkButton>
                                                    </td>
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
                <div class="col-sm-6">
                    <div class="well">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <span>Account Executive</span>
                                <asp:DropDownList runat="server" ID="ddlAE" CssClass="form-control"></asp:DropDownList>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <span>Status</span>
                                        <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control">
                                            <asp:ListItem Text="-All-" Value=""></asp:ListItem>
                                            <asp:ListItem Text="For Approval" Value="For Approval"></asp:ListItem>
                                            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
                                            <asp:ListItem Text="Hold" Value="Hold"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-8">
                                        <span>Find</span>
                                        <div class="input-group">
                                            <asp:TextBox runat="server" ID="tboxSearch" CssClass="form-control"></asp:TextBox>
                                            <div class="input-group-btn">
                                                <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-primary" OnClick="btnSearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
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
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div style="overflow-x: auto;">
                        <asp:GridView runat="server" ID="gvProject" AutoGenerateColumns="false" AllowPaging="true" GridLines="None" ShowHeader="false" CssClass="wf_tbl"
                            OnRowCommand="gvProject_RowCommand" OnPageIndexChanging="gvProject_PageIndexChanging" OnRowDataBound="gvProject_RowDataBound">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div style='padding: 5px; border-left: 3px solid; margin-left: 10px; border-color: <%# Eval("Status").ToString().Contains("Approved") ? "Green" :
                                                        Eval("Status").ToString().Contains("For Approval") ? "Yellow" :
                                                        Eval("Status").ToString().Contains("Hold") ? "Red" : "Black" %>;'>
                                            <span style="font-size: large"><%# Eval("Project_Label") %></span><br />
                                            <span class="text-muted" style="font-size: smaller;"><%# Eval("FullAdd") %></span><br />
                                            <asp:Label ID="lblJob_Order_No" runat="server" CssClass="text-info" Text='<%# Bind("Job_Order_No") %>'></asp:Label>
                                            <asp:Label ID="lblParentjono" Visible="false" runat="server" CssClass="text-info" Text='<%# Bind("Parentjono") %>'></asp:Label>
                                            | 

                                        <span class="" style="font-size: smaller;"><%# Eval("Acct_Exec_Incharge") %></span><br />
                                            <span class='<%# Convert.ToDecimal(Eval("Collection_Per")) >= 100 ? "text-success" : "text-danger" %>' style="font-size: x-large">
                                                <%# Convert.ToDecimal(Eval("Collection_Per")).ToString("n2") %>%</span> paid<br />
                                            <asp:Label runat="server" ID="lblStatus" Visible='<%# Eval("Status").ToString() == "" ? false:true %>'><span style='padding: 5px; border-radius: 0; border-top-right-radius: 100%; color: black; padding-right: 100px; color: <%# Eval("Status").ToString().Contains("Approved") ? "white" :
           Eval("Status").ToString().Contains("Hold") ? "white" : "black" %>; margin-left: -7px; background-color: <%# Eval("Status").ToString().Contains("Approved") ? "Green" :
                                       Eval("Status").ToString().Contains("Approval") ? "Yellow" :
                                       Eval("Status").ToString().Contains("Hold") ? "Red" : "Black" %>;'><%# Eval("Status") %> <span><%# Eval("Status_Date") %></span></span><br />

                                                <asp:Label ID="lblHoldReason" Font-Size="X-Large" runat="server" Visible='<%# Eval("Status").ToString().Contains("Hold") ? true:false %>'>
                                                     <span class=""><%# Eval("Hold_Reason") %></span><br /></asp:Label>
                                            </asp:Label>
                                            <a data-toggle="collapse" style="margin-top:10px;" class="btn btn-default" href='<%# "#"+Eval("number").ToString() %>' role="button" aria-expanded="false" aria-controls="collapseExample">
                                                <span><span class="glyphicon glyphicon-resize-vertical"></span>add request</a>
                                            <div class="collapse" id='<%# Eval("number").ToString() %>'>
                                                <asp:Panel ID="pnlRequestForm" Visible='<%# Eval("Status").ToString() == "" ? true:true %>' runat="server">
                                                    <div class="row" style="border-spacing: 0px;">
                                                        <div class="col-sm-5">
                                                            <div class="well well-sm">
                                                                <span>Select Contract</span>
                                                                <div class="input-group" style="margin: 0;">
                                                                    <asp:DropDownList ID="dlJO" CssClass="form-control" runat="server"></asp:DropDownList>
                                                                    <div class="input-group-btn">
                                                                        <asp:LinkButton ID="btnSendRequest" runat="server" CommandName="sendRequest" CssClass="btn btn-primary">
                                                    <span class="glyphicon glyphicon-send"></span> send request
                                                                        </asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </asp:Panel>
                                            </div>
                                            <asp:LinkButton ID="btnCancelRequest" Style="margin-top: 8px; color: black" Visible='<%# Eval("Status").ToString() == "Approved" || Eval("Status").ToString() == "" ? false:true %>' runat="server" CommandName="cancelRequest" CssClass="btn btn-warning" OnClientClick="return confirm('continue to cancel request?')"><span class="glyphicon glyphicon-minus"></span> cancel request</asp:LinkButton>
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
</asp:Content>
