<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AccountingClearance/AC.Master" AutoEventWireup="true" CodeBehind="AC_For_Trun_Over.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AccountingClearance.AC_For_Trun_Over" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>For Key Prep</title>
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
                <h2>For Key Prep</h2>
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
                <div class="col-sm-6 nopm">
                    <div class="well">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <div class="row nopm">
                                    <div class="col-sm-4 nopm">
                                        <span>Status</span>
                                        <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control" Style="border-radius: 0;">
                                            <asp:ListItem Text="-All-" Value=""></asp:ListItem>
                                            <asp:ListItem Text="For Key Prep" Value="For Key Prep"></asp:ListItem>
                                            <asp:ListItem Text="Key Released" Value="Key Released"></asp:ListItem>
                                            <asp:ListItem Text="COC Received" Value="COC Received"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-4 nopm">
                                        <span>Date Filter</span>
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="ddlDate_Filter" Style="border-radius: 0;">
                                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                            <asp:ListItem Text="For Key Prep Date" Value="For Key Prep Date"></asp:ListItem>
                                            <asp:ListItem Text="Key Released Date" Value="Key Released Date"></asp:ListItem>
                                            <asp:ListItem Text="COC Received Date" Value="COC Received Date"></asp:ListItem>
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
                        <asp:GridView ID="gvProject" runat="server" AutoGenerateColumns="false" AllowPaging="true" GridLines="None" Width="100%" ShowHeader="false" CssClass=""
                            OnPageIndexChanging="gvProject_PageIndexChanging" OnRowCommand="gvProject_RowCommand">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="lblId" Visible="false" runat="server" CssClass="text-info" Text='<%# Bind("Id") %>'></asp:Label>
                                        <div style='padding: 0; border: 2px solid; margin: 2px; border-color: <%# Eval("Status").ToString().Contains("COC Received") ? "Gray" :
                                                        Eval("Status").ToString().Contains("Key Released") ? "Green" :
                                                        Eval("Status").ToString().Contains("For Key Prep") ? "Yellow" : "#e0e0e0" %>;'>
                                            <div style='padding: 5px; color: <%# Eval("Status").ToString().Contains("For Key Prep") ? "black" : "white" %>; background-color: <%# Eval("Status").ToString().Contains("COC Received") ? "Gray" :
                                                                                       Eval("Status").ToString().Contains("Key Released") ? "Green" :
                                                                                       Eval("Status").ToString().Contains("For Key Prep") ? "Yellow" : "#e0e0e0" %>;'>
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
                                                        <asp:Label ID="lblJob_Order_No" Font-Size="Smaller" runat="server" Text='<%# Bind("Job_Order_No") %>'></asp:Label>
                                                        <asp:Label ID="lblParentjono" Font-Size="Smaller" Visible="false" runat="server" Text='<%# Bind("Parentjono") %>'></asp:Label>
                                                    </div>
                                                    <div class="text-center" style="padding-bottom: 10px;">
                                                        <asp:LinkButton ID="btnReleaseKey" Visible='<%# Eval("Status").ToString() == "For Key Prep" ? true:false %>' runat="server" CommandName="keyrelease" ForeColor="Black" CssClass="btn btn-warning" OnClientClick="return confirm('update status to key released?')">
                                                            r e l e a s e&nbsp;&nbsp;k e y</asp:LinkButton>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6 nopm">
                                                    <div style="border-left: 1px solid #bab9b9; padding: 0; height: inherit;">
                                                        <div class="text-center" style="border-bottom: 1px solid #bab9b9; padding: 5px;">
                                                            <span class="" style="font-size: small; letter-spacing: 1px; text-transform: uppercase"><%# Eval("Acct_Exec_Incharge") %></span>
                                                        </div>
                                                        <div style="padding-left: 10px;padding-right:10px; background-color: white; border-bottom: 1px solid #bab9b9;">
                                                            <span>Payment Status: </span>
                                                            <span class="pull-right text-right">
                                                                <span class='<%# Convert.ToDecimal(Eval("Collection_Per")) >= 100 ? "text-success" : "text-danger" %>'>
                                                                    <%# Convert.ToDecimal(Eval("Collection_Per")).ToString("n2") %>%</span><br />
                                                                <span style='visibility: <%# Eval("Approved_Date").ToString() == "" ? "hidden" : "visible" %>;'><%# Eval("Approved_Date").ToString() %><br />
                                                                </span>
                                                                <span style='visibility: <%# Eval("Key_Released_Date").ToString() == "" ? "hidden" : "visible" %>;'><%# Eval("Key_Released_Date").ToString() %><br />
                                                                </span>
                                                                <span style='visibility: <%# Eval("COC_Received").ToString() == "" ? "hidden" : "visible" %>;'><%# Eval("COC_Received").ToString() %></span>
                                                            </span>
                                                            <br />
                                                            <span style='visibility: <%# Eval("Approved_Date").ToString() == "" ? "hidden" : "visible" %>;'>For Key Prep Date:</span><br />
                                                            <span style='visibility: <%# Eval("Key_Released_Date").ToString() == "" ? "hidden" : "visible" %>;'>Key Released Date:<br />
                                                            </span>
                                                            <span style='visibility: <%# Eval("COC_Received").ToString() == "" ? "hidden" : "visible" %>;'>COC Received Date:</span>
                                                        </div>
                                                        <div style="border-bottom: 0px solid #bab9b9; padding-left: 10px;">
                                                            <asp:Label ID="lblHoldReason" Font-Size="small" runat="server" Visible='<%# Eval("Status").ToString().Contains("Hold") ? true:false %>'>
                                                               <span>Hold Reason: </span><span class="text-danger"><%# Eval("Hold_Reason") %></span>
                                                            </asp:Label>
                                                        </div>
                                                        <div style="background-color: white; border-bottom: 0px solid #bab9b9;">
                                                            <asp:Panel ID="pnlCOC" Visible='<%# Eval("Status").ToString() == "Key Released" ? true:false %>' runat="server">
                                                                <div class="well well-sm" style="border-radius: 0;">
                                                                    <span>Remarks</span>
                                                                    <div class="input-group" style="margin: 0;">
                                                                        <asp:TextBox ID="tboxRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        <div class="input-group-btn">
                                                                            <asp:LinkButton ID="btnCOC" runat="server" CommandName="COCreceive" CssClass="btn btn-default" OnClientClick="return confirm('update status to COC received?')">
                                                                                COC received</asp:LinkButton>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </asp:Panel>
                                                        </div>
                                                        <div style="">
                                                            <asp:Panel runat="server" ID="pnlRemarks" Style="padding: 10px;" CssClass="alert alert-info" Visible='<%# Eval("Remarks").ToString() == "" ? false:true %>' role="alert">
                                                                <asp:Label ID="lblRemarks" ForeColor="Black" runat="server">
                                                     <span>Remarks: </span> <span class=""><%# Eval("Remarks") %></span></asp:Label>
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
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
