<%@ Page Language="C#" MasterPageFile="~/KMDIweb/AE/AF/AF_Master.Master" AutoEventWireup="true" CodeBehind="AF_Project_Request.aspx.cs" Inherits="KMDIweb.KMDIweb.AE.AF.AF_Project_Request" %>


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
                    <h2>AF Request</h2>
                    <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-default" Text="back" OnClick="btnBack_Click"></asp:LinkButton>
                </div>
            </div>
            <div style="padding: 10px; background-color: white;" class="text-center">
                <asp:Label ID="lblProject" Font-Size="Medium" runat="server"></asp:Label><br />
                <asp:Label ID="lblAddress" Font-Size="Small" runat="server"></asp:Label><br />
                <asp:Label ID="lblJO" Font-Size="Small" runat="server"></asp:Label>
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
                                                            <asp:TextBox ID="tboxParticular" runat="server" Style="border-radius: 0px;" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
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

            <br />
            <br />
            <h2>Requested AF</h2>
            <div style="overflow-x: auto">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvRequestList" Width="100%" CssClass="wf_tbl" runat="server" ShowHeader="false" AutoGenerateColumns="False" OnRowCommand="gvRequestList_RowCommand"
                            GridLines="None">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div style="min-width: 370px; white-space: nowrap;">
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
                                                    <asp:LinkButton ID="btnDelete" Visible='<%# Eval("Req_Status").ToString() == "For Checking" ? true : false %>' runat="server" CssClass="btn btn-default" CommandName="MyDelete" OnClientClick="return confirm('delete this record?')">d e l e t e</asp:LinkButton>
                                                    <asp:Label ID="lblId" runat="server" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                                </span>
                                                <br />
                                                <span style="font-size: smaller"><%# Eval("OFFICENAME") %></span><br />
                                                <span style="font-size: smaller"><%# Eval("POSITION") %></span><br />
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
                                                <div style="border-left: solid 5px limegreen; min-height: 35px; margin-bottom: 15px; border-top: 0.5px solid #bab9b9; padding: 10px">
                                                    <span style="font-size: small"><%# Eval("Approval_Remarks") %><br />
                                                    <span style="font-size: small; font-weight: bold" class="text-info">- <%# Eval("Approved_By") %></span>
                                                    <span style="font-size: small" class="text-info"><%# Eval("Approved_Date") %></span>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
