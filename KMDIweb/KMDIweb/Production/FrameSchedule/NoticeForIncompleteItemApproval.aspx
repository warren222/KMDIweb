<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="NoticeForIncompleteItemApproval.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.NoticeForIncompleteItemApproval" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Notice For Incomplete Items Approval</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2>Notice For Incomplete Items</h2>
            <asp:CheckBox ID="CheckBox1" Text="Unsigned only" runat="server" />
            <div class="input-group">
                <div class="input-group-addon">
                    Search
                </div>
                <asp:TextBox ID="tboxSearchkey" CssClass="form-control" runat="server"></asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" runat="server" OnClick="LinkButton2_Click"><div class="glyphicon glyphicon-search"></div></asp:LinkButton>
                </div>
            </div>
        </div>
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" Width="100%" BorderStyle="None" ShowHeader="false" AllowPaging="true" GridLines="None" AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="3">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class='<%# Eval("input").ToString() == "Unsigned" ? "panel panel-success" : Eval("input").ToString() == "Signed" ? "panel panel-info" :
                                Eval("input").ToString() == "For acknowledgment" ? "panel panel-success" :  Eval("input").ToString() == "Acknowledged" ? "panel panel-info" :
                                "panel panel-warning" %>'>
                                    <div class="panel-heading">
                                        <asp:Panel ID="headPanel" runat="server" Visible='<%# Eval("input").ToString() == "" ? false : true %>'>
                                            <span class='<%# Eval("input").ToString() == "Unsigned" ? "label label-danger" : Eval("input").ToString() == "For acknowledgment" ? "label label-danger" : "label label-success" %>'>
                                                <asp:Label ID="Label6" runat="server" Font-Size="small" Text='<%# Bind("Input") %>'></asp:Label></span>
                                            <asp:Label ID="lblId" CssClass="text-left" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                            <asp:Label ID="lblAcknowledgedBy" CssClass="text-left" Visible="false" runat="server" Text='<%# Bind("Acknowledged_By") %>'></asp:Label>
                                        </asp:Panel>
                                    </div>
                                    <div class="panel-body">
                                        <asp:Label ID="lblg2Project" runat="server" Font-Size="Large" Text='<%# Bind("Project") %>'></asp:Label><br />
                                        <asp:Label ID="l0blg2Address" runat="server" Font-Size="Small" CssClass="text-muted" Text='<%# Bind("Address") %>'></asp:Label><br />
                                        <asp:Label ID="lblg2Dated" runat="server" Font-Size="X-Large" CssClass="text-muted" Text='<%# Bind("Dated") %>'></asp:Label>

                                        <asp:Label ID="lblg2NotFormattedDate" runat="server" Visible="false" Font-Size="X-Large" CssClass="text-muted" Text='<%# Bind("NotFormattedDate") %>'></asp:Label>
                                        <asp:Label ID="lblg2Reason" runat="server" Visible="false" Font-Size="X-Large" CssClass="text-muted" Text='<%# Bind("Reason") %>'></asp:Label>
                                        <asp:Label ID="lblParentjono" runat="server" Visible="false" Font-Size="X-Large" CssClass="text-muted" Text='<%# Bind("Parentjono") %>'></asp:Label>
                                    </div>
                                    <div class="panel-footer">
                                        <asp:LinkButton ID="LinkButton1" CommandName="Report" runat="server" CssClass="btn btn-primary">View Report</asp:LinkButton>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-2 text-center">

                                            <asp:Image ID="Image1" Width="120" Height="80" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/NFII/" + Eval("parentjono").ToString() + "/" + Eval("ID").ToString() + "/" + "/signature/Prepared_By.jpg" %>' />
                                            <br />
                                            <asp:Label ID="lblPreparedBy" runat="server" Text='<%# Bind("prepared_by") %>'></asp:Label><br />
                                            <span class="text-muted" style="font-size: smaller">(Delivery Coordinator)</span><br />
                                            <span class="text-muted">Prepared by</span>
                                        </div>
                                        <div class="col-xs-2 text-center">
                                            <asp:Image ID="Image3" Width="120" Height="80" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/NFII/" + Eval("parentjono").ToString() + "/" + Eval("ID").ToString() + "/" + "/signature/Approved_By2.jpg" %>' />
                                            <br />
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("approved_by2") %>'></asp:Label><br />
                                            <span class="text-muted" style="font-size: smaller">(Delivery Head)</span><br />
                                            <span class="text-muted">Approved by</span>
                                        </div>
                                        <div class="col-xs-2 text-center">
                                            <asp:Image ID="Image2" Width="120" Height="80" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/NFII/" + Eval("parentjono").ToString() + "/" + Eval("ID").ToString() + "/" + "/signature/Approved_By.jpg" %>' />
                                            <br />
                                            <asp:Label ID="lblApprovedBy" runat="server" Text='<%# Bind("approved_by") %>'></asp:Label><br />
                                            <span class="text-muted" style="font-size: smaller">(Delivery & Installation Manager)</span><br />
                                            <span class="text-muted">Approved by</span>
                                        </div>
                                        <div class="col-xs-2 text-center">
                                            <asp:Image ID="Image4" Width="120" Height="80" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/NFII/" + Eval("parentjono").ToString() + "/" + Eval("ID").ToString() + "/" + "/signature/Received_By.jpg" %>' />
                                            <br />
                                            <asp:Label ID="lblReceivedBy" runat="server" Text='<%# Bind("Received_by") %>'></asp:Label><br />
                                            <span class="text-muted" style="font-size: smaller">(Production Staff)</span><br />
                                            <span class="text-muted">Received by</span>
                                        </div>
                                        <div class="col-xs-2 text-center">
                                            <asp:Image ID="Image5" Width="120" Height="80" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDIweb/Uploads/NFII/" + Eval("parentjono").ToString() + "/" + Eval("ID").ToString() + "/" + "/signature/Noted_By.jpg" %>' />
                                            <br />
                                            <asp:Label ID="lblNotedBy" runat="server" Text='<%# Bind("Noted_by") %>'></asp:Label><br />
                                            <span class="text-muted" style="font-size: smaller">(Production Manager)</span><br />
                                            <span class="text-muted">Noted by</span>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <PagerStyle CssClass="GridPager" ForeColor="Black" HorizontalAlign="Left" />
                    <FooterStyle BackColor="#CCCC99" />
                    <HeaderStyle Wrap="False" BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                    <PagerSettings PageButtonCount="8" Position="TopAndBottom" />

                    <EmptyDataTemplate>
                        <div>
                            <h3><strong>Sorry, No Result Found!</strong>
                            </h3>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
