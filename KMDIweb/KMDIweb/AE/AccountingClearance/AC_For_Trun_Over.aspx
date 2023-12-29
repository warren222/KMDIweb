<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AccountingClearance/AC.Master" AutoEventWireup="true" CodeBehind="AC_For_Trun_Over.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AccountingClearance.AC_For_Trun_Over" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>For Key Prep</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <div class="container text-left">
                <h2>For Key Prep</h2>
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
                                                    <td style="width: 100px;">For Key Prep</td>
                                                    <td style="width: 100px;">Key Released</td>
                                                    <td style="width: 100px;">COC Received</td>
                                                </tr>
                                                <tr class="text-center">
                                                    <td>
                                                        <asp:LinkButton ID="btnKeyPrep" CommandName="ForKeyPrep" runat="server"><span style="font-size: xx-large; color: orange"><%# Eval("ForKeyPrep") %></span></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnKeyReleased" CommandName="KeyReleased" runat="server"><span style="font-size: xx-large; color: green"><%# Eval("KeyReleased") %></span></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnCOCReceived" CommandName="COCReceived" runat="server"><span style="font-size: xx-large; color: gray"><%# Eval("COCReceived") %></span></asp:LinkButton></td>
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
                                            <asp:ListItem Text="For Key Prep" Value="For Key Prep"></asp:ListItem>
                                            <asp:ListItem Text="Key Released" Value="Key Released"></asp:ListItem>
                                            <asp:ListItem Text="COC Received" Value="COC Received"></asp:ListItem>
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
                        <asp:GridView ID="gvProject" runat="server" AutoGenerateColumns="false" AllowPaging="true" GridLines="None" ShowHeader="false" CssClass="wf_tbl"
                            OnPageIndexChanging="gvProject_PageIndexChanging" OnRowCommand="gvProject_RowCommand">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="lblId" Visible="false" runat="server" CssClass="text-info" Text='<%# Bind("Id") %>'></asp:Label>
                                        <div style='padding: 5px; border-left: 3px solid; margin-left: 10px; border-color: <%# Eval("Status").ToString().Contains("COC Received") ? "Gray" :
                                                        Eval("Status").ToString().Contains("Key Released") ? "Green" :
                                                        Eval("Status").ToString().Contains("For Key Prep") ? "Yellow" : "Black" %>;'>
                                            <span style="font-size: medium"><%# Eval("Project_Label") %></span><br />
                                            <span class="text-muted" style="font-size: smaller;"><%# Eval("FullAdd") %></span><br />
                                            <asp:Label ID="lblParentjono" runat="server" CssClass="text-info" Text='<%# Bind("Parentjono") %>'></asp:Label>
                                            | 

                                        <span class="" style="font-size: smaller;"><%# Eval("Acct_Exec_Incharge") %></span><br />
                                            <span class='<%# Convert.ToDecimal(Eval("Collection_Per")) >= 100 ? "text-success" : "text-danger" %>' style="font-size: x-large">
                                                <%# Convert.ToDecimal(Eval("Collection_Per")).ToString("n2") %>%</span> paid<br />
                                            <asp:Label runat="server" ID="lblStatus" Visible='<%# Eval("Status").ToString() == "" ? false:true %>'><span style='padding: 5px; border-radius: 0; border-top-right-radius: 100%; padding-right: 100px;color: <%# Eval("Status").ToString().Contains("For Key Prep") ? "black" : "white" %>;
 margin-left: -7px; background-color: <%# Eval("Status").ToString().Contains("COC Received") ? "Gray" :
                                       Eval("Status").ToString().Contains("Key Released") ? "Green" :
                                       Eval("Status").ToString().Contains("For Key Prep") ? "Yellow" : "Black" %>;'><%# Eval("Status") %> <span><%# Eval("Status_Date") %></span></span><br />
                                            </asp:Label>
                                               <asp:Label ID="lblRemarks" Font-Size="X-Large" runat="server" Visible='<%# Eval("Remarks").ToString() == "" ? false:true %>'>
                                                     <span class="text text-info"><%# Eval("Remarks") %></span><br /></asp:Label>

                                            <asp:LinkButton ID="btnReleaseKey" Style="margin-top: 8px;" Visible='<%# Eval("Status").ToString() == "For Key Prep" ? true:false %>' runat="server" CommandName="keyrelease" ForeColor="Black" CssClass="btn btn-warning" OnClientClick="return confirm('update status to key released?')"><span class="glyphicon glyphicon-lock"></span> release key</asp:LinkButton>
                                            <asp:Panel ID="pnlCOC" Visible='<%# Eval("Status").ToString() == "Key Released" ? true:false %>' runat="server">
                                                <div class="row" style="border-spacing: 0px;">
                                                    <div class="col-sm-5">
                                                        <div class="well well-sm">
                                                            <span>Remarks</span>
                                                            <div class="input-group" style="margin: 0;">
                                                                <asp:TextBox ID="tboxRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                                                                <div class="input-group-btn">
                                                                    <asp:LinkButton ID="btnCOC" runat="server" CommandName="COCreceive" CssClass="btn btn-default" OnClientClick="return confirm('update status to COC received?')"><span class="glyphicon glyphicon-check"></span> COC received</asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
