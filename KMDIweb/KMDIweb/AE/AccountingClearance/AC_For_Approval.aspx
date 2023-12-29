<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/AE/AccountingClearance/AC.Master" CodeBehind="AC_For_Approval.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AccountingClearance.AC_For_Approval" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Accg Clearance | Approval</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <div class="container text-left">
                <h2>Accg Clearance Approval</h2>
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
                            OnRowCommand="gvProject_RowCommand" OnPageIndexChanging="gvProject_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="lblId" Visible="false" runat="server" CssClass="text-info" Text='<%# Bind("Id") %>'></asp:Label>
                                        <div style='padding: 5px; border-left: 3px solid; margin-left: 10px; border-color: <%# Eval("Status").ToString().Contains("Approved") ? "Green" :
                                                        Eval("Status").ToString().Contains("For Approval") ? "Yellow" :
                                                        Eval("Status").ToString().Contains("Hold") ? "Red" : "Black" %>;'>
                                            <span style="font-size: medium"><%# Eval("Project_Label") %></span><br />
                                            <span class="text-muted" style="font-size: smaller;"><%# Eval("FullAdd") %></span><br />
                                            <asp:Label ID="lblParentjono" runat="server" CssClass="text-info" Text='<%# Bind("Parentjono") %>'></asp:Label>
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

                                            <asp:LinkButton ID="btnApproved" Style="margin-top: 8px;" Visible='<%# Eval("Status").ToString() == "For Approval" || Eval("Status").ToString() == "Hold" ? true:false %>' runat="server" CommandName="approve" CssClass="btn btn-success" OnClientClick="return confirm('continue to approve?')"><span class="glyphicon glyphicon-ok"></span> approve</asp:LinkButton>
                                            <asp:LinkButton ID="btnHold" Style="margin-top: 8px;" Visible='<%# Eval("Status").ToString() == "For Approval" ? true:false %>' runat="server" CommandName="hold" CssClass="btn btn-danger"><span class="glyphicon glyphicon-info-sign"></span> hold request</asp:LinkButton>

                                            <asp:Panel ID="pnlHold" Visible="false" runat="server">
                                                <br />
                                                <span>Reason for hold</span>
                                                <asp:TextBox ID="tboxHoldReason" runat="server" CssClass="form-control"></asp:TextBox>
                                                <asp:LinkButton ID="btnSubmit" runat="server" CommandName="btnsubmitHold" CssClass="btn btn-default"><span>submit</span></asp:LinkButton>
                                                <asp:LinkButton ID="btnCancel" runat="server" CommandName="btncancelHold" CssClass="btn btn-default"><span>cancel</span></asp:LinkButton>
                                            </asp:Panel>
                                        </div>
                                        <br />
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
