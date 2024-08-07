﻿<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AF/AF_Master.Master" AutoEventWireup="true" CodeBehind="AF_Project_Request.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AF.AF_Project_Request" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AF | Project Request</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>Request Page</h2>
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-default" Text="back" OnClick="btnBack_Click"></asp:LinkButton>
                </div>
            </div>
            <div style="padding: 10px; font-family: Bahnschrift; background-color: white;" class="text-left">
                <asp:Label ID="lblProject" Font-Size="Medium" runat="server"></asp:Label><br />
                <asp:Label ID="lblAddress" Font-Size="Small" runat="server"></asp:Label><br />
                <asp:Label ID="lblJO" Font-Size="Small" runat="server"></asp:Label>
            </div>
            <div style="background-color:whitesmoke;padding:5px; font-family: Bahnschrift;"  class="text-center">
                <span><asp:Label ID="lblContract_Price" Font-Size="Large" runat="server"></asp:Label></span><br />
                <span style="font-size:medium;font-family:Bradley Hand ITC; font-weight:bold;">contract price</span>
            </div>
            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>
                    <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <div>
                <div class="btn-group" role="group" aria-label="...">
                    <span class="btn btn-primary" style="font-size: large">Request Form <span class="glyphicon glyphicon-hand-right"></span></span>
                    <a data-toggle="collapse" href="#Pnl_Search" role="button" class="btn btn-primary" style="font-size: large" aria-expanded="false" aria-controls="collapseExample">
                        <span class="glyphicon glyphicon-align-justify"></span>
                    </a>
                </div>
            </div>
            <br />
            <div>
                <div class="collapse" id="Pnl_Search">
                    <div style="overflow-x: auto">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="gvArchEmp" runat="server" GridLines="Horizontal" ShowHeader="False" CssClass="wf_tbl" AutoGenerateColumns="False" Width="100%" CellPadding="4" ForeColor="Black" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Architect">
                                            <ItemTemplate>
                                                <div style="min-width: 370px;">
                                                    <asp:Label ID="lblIdentifier" Visible="false" runat="server" Text='<%# Eval("IDENTIFIER") %>'></asp:Label>
                                                    <asp:CheckBox ID="cbox" runat="server" Text='<%# Eval("NAME") %>' /><br />
                                                    <span style="font-size: smaller; margin-left: 15px;"><%# Eval("OFFICENAME") %></span><br />
                                                    <span style="font-size: smaller; margin-left: 15px;"><%# Eval("POSITION") %></span><br />
                                                    <span style="font-size: medium; margin-left: 15px;color:forestgreen"><%# Eval("AMOUNT") %></span>
                                                    <span style="font-family:Bradley Hand ITC; font-weight:bold;font-size:small">total received amount</span>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <div style="min-width: 370px;">
                                                    <div class="row" style="margin: 0;">
                                                        <div class="col-xs-3">
                                                            <span>Request:</span>
                                                            <asp:DropDownList ID="ddlRequest" Width="100px" Style="border-radius: 0px;" CssClass="form-control" runat="server">
                                                                <asp:ListItem Text="AF" Value="AF"></asp:ListItem>
                                                                <asp:ListItem Text="Treat" Value="Treat"></asp:ListItem>
                                                                <asp:ListItem Text="Gift" Value="Gift"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-xs-9">
                                                            <span>Particular:</span>
                                                            <asp:TextBox ID="tboxParticular" Text='<%# Eval("AF") %>' runat="server" Style="border-radius: 0px;" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                    <SortedDescendingHeaderStyle BackColor="#242121" />
                                    <EmptyDataTemplate>
                                        <p style="font-size: x-large" class="text-danger">0 architect assigned!</p>
                                    </EmptyDataTemplate>
                                </asp:GridView>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                        <ContentTemplate>
                            <div class="pull-right">
                                <asp:LinkButton ID="btnSubmitRequest" runat="server" CssClass="btn btn-success" Text="submit request" OnClick="btnSubmitRequest_Click"></asp:LinkButton>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div>
                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvSummary" GridLines="None" AutoGenerateColumns="false" runat="server">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <table border="1" class="wf_tbl">
                                            <tr class="text-center">
                                                <td>For Checking</td>
                                                <td>For Approval</td>
                                                <td>&nbsp&nbsp Approved &nbsp&nbsp</td>
                                            </tr>
                                            <tr class="text-center">
                                                <td><span style="font-size: xx-large; color: skyblue"><%# Eval("For_Checking") %></span></td>
                                                <td><span style="font-size: xx-large; color: orange"><%# Eval("For_Approval") %></span></td>
                                                <td><span style="font-size: xx-large; color: green"><%# Eval("Approved") %></span></td>
                                            </tr>
                                        </table>

                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <br />
            <h2>Requested AF</h2>
            <div style="overflow-x: auto">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvRequestList" Width="100%" runat="server" ShowHeader="false" AutoGenerateColumns="False" OnRowCommand="gvRequestList_RowCommand"
                            GridLines="None">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div style='border: 2px solid; border-color: <%# Eval("Req_Status").ToString() == "For Checking" ? "SkyBlue" :
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
                                                <div class="row" style="margin: 0; padding: 0;">
                                                    <div class="col-sm-6" style="margin: 0; padding: 0;">
                                                        <div style="background-color: white; padding: 10px;">
                                                            <span style="font-weight: bold; font-size: medium;"><%# Eval("NAME") %></span>
                                                            <span class="pull-right text-right">
                                                                <span style="font-size: medium;"><%# Eval("Requested_Date") %></span><br />
                                                                <span style="font-size: medium;" class="text-info"><%# Eval("Request") %></span><br />
                                                            </span>
                                                            <br />
                                                            <span style="font-size: smaller"><%# Eval("OFFICENAME") %></span><br />
                                                            <span style="font-size: smaller"><%# Eval("POSITION") %></span><br />
                                                        </div>
                                                        <div class="text-center">
                                                            <asp:LinkButton ID="btnDelete" Visible='<%# Eval("Req_Status").ToString() == "For Checking" ? true : false %>' runat="server" CssClass="btn btn-default" CommandName="MyDelete" OnClientClick="return confirm('delete this request?')">c a n c e l</asp:LinkButton>
                                                            <asp:Label ID="lblId" runat="server" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6" style="margin: 0; padding: 0;">
                                                        <div style="border-left: 1px solid #bab9b9; padding: 5px; padding-left: 0px; height: inherit;">
                                                            <div class="text-center" style="letter-spacing: 5px;"><span>PARTICULARS</span></div>
                                                            <div style="padding-left: 10px; background-color: white;">
                                                                <asp:Panel runat="server" Visible="false" ID="pnlCommentEdit">
                                                                    <span>Comment</span>
                                                                    <asp:TextBox runat="server" ID="tboxComment" CssClass="form-control" Text='<%# Bind("Particular") %>' TextMode="MultiLine" Rows="2"></asp:TextBox>
                                                                    <asp:LinkButton runat="server" ID="btnSave" CommandName="mySend" CssClass="btn btn-default">s u b m i t</asp:LinkButton>
                                                                </asp:Panel>
                                                                <asp:Panel runat="server" Visible="true" ID="pnlComment">
                                                                    <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Particular").ToString(), "\r\n|\r|\n", "<br>")) %></span><br />
                                                                    <span style="font-size: small;" class="text-success"><%# "Requested by "+Eval("Account_Exec") %></span><br />
                                                                    <span style="font-size: small" class="text-muted"><%# Eval("Requested_Date") %></span><span class="pull-right"><asp:LinkButton ID="btnEdit" Visible='<%# Eval("Req_Status").ToString() == "For Checking" ? true : false %>' CommandName="myEdit" runat="server">Edit</asp:LinkButton>
                                                                    </span>
                                                                </asp:Panel>
                                                            </div>
                                                            <div style="border-bottom: 1px solid #bab9b9; border-top: 1px solid #bab9b9; padding-left: 10px;">
                                                                <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Checked_Remarks").ToString(), "\r\n|\r|\n", "<br>")) %></span><br />
                                                                <span style="font-size: small;" class="text-success"><%# ""+Eval("Checked_By") %></span><br />
                                                                <span style="font-size: small" class="text-muted"><%# Eval("Checked_Date") %></span>
                                                            </div>
                                                            <div style="padding-left: 10px; background-color: white;">
                                                                <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("Approval_Remarks").ToString(), "\r\n|\r|\n", "<br>")) %></span><br />
                                                                <span style="font-size: small;" class="text-success"><%# ""+Eval("Approved_By") %></span><br />
                                                                <span style="font-size: small" class="text-muted"><%# Eval("Approved_Date") %></span>
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
                                <p style="font-size: x-large" class="text-danger">0 request found!</p>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
