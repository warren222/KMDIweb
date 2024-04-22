<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/AE/AF/AF_Master.Master" CodeBehind="AF_New_Payment.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AF.AF_New_Payment" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Available AF | New Payment</title>
    <style>
        .nopad {
            padding: 0;
        }

        .nomargin {
            margin: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>Available AF</h2>
                </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="row nomargin">
            <div class="col-sm-2 nomargin"></div>
            <div class="col-sm-8 nomargin">
                <div class="well">
                    <div class="row" style="padding: 0; margin: 0;">
                        <div class="col-sm-5" style="padding: 0; margin: 0;">
                            <span>Account Executive</span>
                            <asp:DropDownList runat="server" ID="ddlAE" Style="border-radius: 0;" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-sm-7" style="padding: 0; margin: 0;">
                            <span>Find</span>
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="tboxSearch" Style="border-radius: 0;" CssClass="form-control"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-primary" OnClick="btnSearch_Click">search</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-2 nomargin"></div>
        </div>
        <div class="row nomargin">
            <div class="col-sm-2 nomargin"></div>
            <div class="col-sm-8 nomargin">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div style="overflow-x: auto">
                            <asp:GridView ID="gvAF" runat="server" Width="99%" ShowHeader="false" GridLines="None" AutoGenerateColumns="false" OnRowCommand="gvAF_RowCommand">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div style="border: 2px solid; border-color: aqua; margin-bottom: 5px;">
                                                <div style="min-width: 370px; white-space: nowrap;">
                                                    <asp:Label ID="lblPayment_Id" runat="server" Visible="false" Text='<%# Bind("Payment_Id") %>'></asp:Label>
                                                    <asp:Label ID="lblIdentifier" runat="server" Visible="false" Text='<%# Bind("Identifier") %>'></asp:Label>
                                                    <div style="padding: 5px; border-top-right-radius: 0px; color: black; background-color: aqua">
                                                        <span style="font-size: large; letter-spacing: 3px;">
                                                            <asp:Label ID="lblPayType" runat="server" Text='<%# Bind("PAYTYPE") %>'></asp:Label></span>
                                                        <span class="pull-right text-right">
                                                            <span style="font-size: small"><%# Eval("Acct_Exec_Incharge").ToString() %></span>
                                                        </span>
                                                    </div>
                                                    <div class="row nomargin nopad">
                                                        <div class="col-sm-6 nomargin nopad">
                                                            <div style="background-color: white; padding: 10px;">
                                                                <span style="font-weight: bold; font-size: medium"><%# Eval("PROJECT") %></span>
                                                                <span class="pull-right text-right">
                                                                    <span style="font-size: medium"><%# Eval("PaymentDate") %></span><br />
                                                                    <span style="font-size: medium;color:limegreen;"><%# Eval("PAYMENT") %></span>
                                                                </span>
                                                                <br />
                                                                <span style="font-size: smaller">
                                                                    <asp:Label ID="lblParentjono" runat="server" Text='<%# Bind("PARENTJONO") %>'></asp:Label></span>
                                                            </div>
                                                            <div class="text-center" style="background-color: whitesmoke; padding: 10px;">
                                                                <span style="font-weight: bold"><%# Eval("NAME") %></span><br />
                                                                <span style="font-size: smaller"><%# Eval("OFFICENAME") %></span><br />
                                                                <span style="font-size: smaller"><%# Eval("POSITION") %></span>
                                                            </div>
                                                            <div style="background-color: white; padding: 10px; font-size:small">
                                                                <span>AF Releasing:</span>
                                                                <span class="pull-right text-right">
                                                                    <span><%# Eval("AFReleasing").ToString() %></span><br />
                                                                    <span><%# Eval("Received_Amount").ToString() %></span>
                                                                    <span>(<%# Eval("Received_Pct").ToString() %>)</span><br />
                                                                    <br />
                                                                </span>
                                                                <br />
                                                                <span>AF Received:</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-6 nomargin nopad">
                                                            <div style="border-left: 1px solid #bab9b9; padding: 5px; padding-left: 0px; height: inherit;">
                                                                <div class="text-center" style="letter-spacing: 5px;"><span>REQUEST FORM</span></div>
                                                            </div>
                                                            <div style="border-left: 1px solid #bab9b9; font-size: small; padding: 5px; height: inherit; background-color: white;">
                                                                <span>AF(%):</span>
                                                                <span class="pull-right text-right">
                                                                    <span><%# Eval("AF").ToString() %></span><br />
                                                                    <span><%# Eval("Amount").ToString() %></span><br />
                                                                </span>
                                                                <br />
                                                                <span>AF Value:</span>
                                                            </div>
                                                            <div style="min-width: 370px; border-left: 1px solid #bab9b9; padding: 5px; height: inherit; background-color: whitesmoke;">
                                                                <span>Remarks:</span>
                                                                <asp:TextBox ID="tboxParticular" Text='<%# Eval("Remarks") %>' runat="server" Style="border-radius: 0px;" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                                <div class="row">
                                                                    <div class="col-xs-4"></div>
                                                                    <div class="col-xs-8">
                                                                        <span>Request:</span>
                                                                        <div class="input-group">
                                                                            <asp:DropDownList ID="ddlRequest" Style="border-radius: 0px;" CssClass="form-control" runat="server">
                                                                                <asp:ListItem Text="AF" Value="AF"></asp:ListItem>
                                                                                <asp:ListItem Text="Treat" Value="Treat"></asp:ListItem>
                                                                                <asp:ListItem Text="Gift" Value="Gift"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            <div class="input-group-btn">
                                                                                <asp:LinkButton runat="server" ID="btnSend" Style="border-radius: 0;" CommandName="send_request" CssClass="btn btn-default" OnClientClick="return confirm('send this request?')">s e n d <span class="glyphicon glyphicon-send"></span></asp:LinkButton>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>

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
            <div class="col-sm-2 nomargin"></div>
        </div>
    </div>
</asp:Content>
