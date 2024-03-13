<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/AE/AccountingClearance/AC.Master" CodeBehind="AC_ProjectList.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AccountingClearance.AC_ProjectList" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Accg Clearance | Request</title>
    <style>
        .nopm {
            padding: 0;
            margin: 0;
        }
    </style>
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
            <div class="row nopm">
                <div class="col-sm-6 nopm">
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
                <div class="col-sm-6 nopm">
                    <div class="well">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <div class="row nopm">
                                    <div class="col-sm-4 nopm">
                                        <span>Status</span>
                                        <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control" Style="border-radius: 0;">
                                            <asp:ListItem Text="-All-" Value=""></asp:ListItem>
                                            <asp:ListItem Text="For Approval" Value="For Approval"></asp:ListItem>
                                            <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
                                            <asp:ListItem Text="Hold" Value="Hold"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-4 nopm">
                                        <span>Date Filter</span>
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="ddlDate_Filter" Style="border-radius: 0;">
                                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                            <asp:ListItem Text="For Approval Date" Value="For Approval Date"></asp:ListItem>
                                            <asp:ListItem Text="Date Approved" Value="Date Approved"></asp:ListItem>
                                            <asp:ListItem Text="Date Hold" Value="Date Hold"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-4 nopm">
                                        <span>Date</span>
                                        <asp:TextBox runat="server" TextMode="Date" ID="tboxDate" CssClass="form-control" Style="border-radius: 0;"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row nopm">
                                    <div class="col-sm-6 nopm">
                                        <span>Account Executive</span>
                                        <asp:DropDownList runat="server" ID="ddlAE" CssClass="form-control" Style="border-radius: 0;"></asp:DropDownList>
                                    </div>
                                    <div class="col-sm-6 nopm">
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
            <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div style="overflow-x: auto;">
                        <asp:GridView runat="server" ID="gvProject" AutoGenerateColumns="false" AllowPaging="true" Width="100%" GridLines="None" ShowHeader="false" CssClass=""
                            OnRowCommand="gvProject_RowCommand" OnPageIndexChanging="gvProject_PageIndexChanging" OnRowDataBound="gvProject_RowDataBound">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div style='padding: 0; border: 2px solid; margin: 2px; border-color: <%# Eval("Status").ToString().Contains("Approved") ? "Green" :
                                                                          Eval("Status").ToString().Contains("For Approval") ? "Yellow" :
                                                                          Eval("Status").ToString().Contains("Hold") ? "Red" : "#e0e0e0" %>;'>
                                            <div style='color: <%# Eval("Status").ToString().Contains("Approved") ? "white" :
                                                                   Eval("Status").ToString().Contains("Hold") ? "white" : "black" %>; background-color: <%# Eval("Status").ToString().Contains("Approved") ? "Green" :
                                                                   Eval("Status").ToString().Contains("Approval") ? "Yellow" :
                                                                   Eval("Status").ToString().Contains("Hold") ? "Red" : "#e0e0e0" %>; padding: 5px;'>
                                                <span style="font-size: large; letter-spacing: 3px;"><%# Eval("Status") %></span>
                                                <span class="pull-right text-right">
                                                    <span style="font-size: small"><%# Eval("Status_Date") %></span>
                                                </span>
                                            </div>
                                            <div class="row nopm">
                                                <div class="col-sm-6 nopm">
                                                    <div style="padding: 10px; background-color: white;">
                                                        <span style="font-size: medium; font-weight: bold;"><%# Eval("Project_Label") %></span><br />
                                                        <span class="" style="font-size: smaller;"><%# Eval("FullAdd") %></span><br />
                                                        <span style="font-size:smaller"><%# Eval("Job_Order_No").ToString() == "" ? Eval("Parentjono").ToString() : Eval("Job_Order_No").ToString() %></span>
                                                        <asp:Label ID="lblJob_Order_No" Font-Size="Smaller" Visible="false" runat="server" Text='<%# Bind("Job_Order_No") %>'></asp:Label>
                                                        <asp:Label ID="lblParentjono" Font-Size="Smaller" Visible="false" runat="server" Text='<%# Bind("Parentjono") %>'></asp:Label>
                                                    </div>
                                                    <div class="text-center" style="padding-bottom: 10px;">
                                                        <asp:LinkButton ID="btnCancelRequest" Style="" Visible='<%# Eval("Status").ToString() == "Approved" || Eval("Status").ToString() == "" ? false:true %>'
                                                            runat="server" CommandName="cancelRequest" CssClass="btn btn-default" OnClientClick="return confirm('continue to cancel request?')">c a n c e l</asp:LinkButton>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 nopm">
                                                    <div style="border-left: 1px solid #bab9b9; padding: 0; height: inherit;">
                                                        <div class="text-center" style="border-bottom: 1px solid #bab9b9; padding: 5px;">
                                                            <span class="" style="font-size: small; letter-spacing: 1px; text-transform: uppercase"><%# Eval("Acct_Exec_Incharge") %></span>
                                                        </div>
                                                        <div style="padding-left: 10px; padding-right: 10px; background-color: white; border-bottom: 1px solid #bab9b9; font-size: small;">
                                                            <span>Payment Status: </span>
                                                            <span class="pull-right text-right">
                                                                <span class='<%# Convert.ToDecimal(Eval("Collection_Per")) >= 100 ? "text-success" : "text-danger" %>'>
                                                                    <%# Convert.ToDecimal(Eval("Collection_Per")).ToString("n2") %>%</span><br />
                                                                <span style='visibility: <%# Eval("Requested_Date").ToString() == "" ? "hidden" : "visible" %>;'><%# Eval("Requested_Date").ToString() %><br />
                                                                </span>
                                                                <span style='visibility: <%# Eval("Approved_Date").ToString() == "" ? "hidden" : "visible" %>;'><%# Eval("Approved_Date").ToString() %><br />
                                                                </span>
                                                                <span style='visibility: <%# Eval("Hold_Date").ToString() == "" ? "hidden" : "visible" %>;'><%# Eval("Hold_Date").ToString() %></span>
                                                            </span>
                                                            <br />
                                                            <span style='visibility: <%# Eval("Requested_Date").ToString() == "" ? "hidden" : "visible" %>;'>For Approval Date:</span><br />
                                                            <span style='visibility: <%# Eval("Approved_Date").ToString() == "" ? "hidden" : "visible" %>;'>Date Approved:<br />
                                                            </span>
                                                            <span style='visibility: <%# Eval("Hold_Date").ToString() == "" ? "hidden" : "visible" %>;'>Date Hold:</span>
                                                        </div>
                                                        <div style="padding-left: 10px;">
                                                            <asp:Label ID="lblHoldReason" Font-Size="small" runat="server" Visible='<%# Eval("Status").ToString().Contains("Hold") ? true:false %>'>
                                                               <span>Hold Reason: </span><span class="text-danger"><%# Eval("Hold_Reason") %></span>
                                                            </asp:Label>
                                                        </div>
                                                        <div style="background-color: white;">
                                                            <a data-toggle="collapse" style="margin-left: 10px; border-radius: 0; font-size: medium" class="" href='<%# "#"+Eval("number").ToString() %>' role="button" aria-expanded="false" aria-controls="collapseExample">Add request</a>
                                                            <div class="collapse" id='<%# Eval("number").ToString() %>'>
                                                                <asp:Panel ID="pnlRequestForm" Visible='<%# Eval("Status").ToString() == "" ? true:true %>' runat="server">
                                                                    <div class="well well-sm" style="border-radius: 0;">
                                                                        <span>Select Contract</span>
                                                                        <div class="input-group" style="margin: 0;">
                                                                            <asp:DropDownList ID="dlJO" CssClass="form-control" runat="server"></asp:DropDownList>
                                                                            <div class="input-group-btn">
                                                                                <asp:LinkButton ID="btnSendRequest" runat="server" CommandName="sendRequest" CssClass="btn btn-success">send request</asp:LinkButton>
                                                                            </div>
                                                                        </div>
                                                                    </div>
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
