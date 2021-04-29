<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="NoticeForIncompleteItem.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.NoticeForIncompleteItem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Notice For Incomplete Items</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2>Notice For Inclomplete Items</h2>
        </div>
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
        <asp:Label ID="lblProject" runat="server" Font-Size="Large" Text="Project"></asp:Label><br />
        <asp:Label ID="lblAddress" runat="server" Font-Size="Small" CssClass="text-muted" Text="Address"></asp:Label><br />
        <div class="col-md-4">
            <div class="input-group">
                <div class="input-group-addon">
                    Date
                </div>
                <asp:TextBox ID="tboxDate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </div>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tboxDate" runat="server" ValidationGroup="errorval" ErrorMessage="Date is a required field" CssClass="text-danger">*</asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
            <asp:GridView ID="GridView1" CssClass="table" runat="server" AutoGenerateColumns="false" ShowFooter="True">
                <Columns>
                    <asp:TemplateField HeaderText="K#">
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Visible="false" Text='<%#Bind("Id") %>'></asp:Label>
                            <asp:Label ID="lblKno" runat="server" Text='<%#Bind("KMDI_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <asp:TextBox ID="tboxDescription" CssClass="form-control" Text='<%#Bind("Description") %>' runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
        Reason<br />
        <asp:TextBox ID="tboxReason" TextMode="MultiLine" CssClass="form-control" runat="server" Rows="10"></asp:TextBox>
        <asp:Button ID="saveBTN" runat="server" ValidationGroup="errorval" CssClass="btn btn-primary" Text="Submit" OnClick="saveBTN_Click" />
        <asp:Button ID="cancelBtn" runat="server" CssClass="btn btn-default" Text="Cancel" OnClick="cancelBtn_Click" Visible="False" />
        <br />
        <br />
        <h2>List of Notices</h2>
        <asp:GridView ID="GridView2" runat="server" GridLines="None" AutoGenerateColumns="false" OnRowCommand="GridView2_RowCommand">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <asp:Label ID="lblId" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                            </div>
                            <div class="panel-body">
                                <asp:Label ID="lblg2Project" runat="server" Font-Size="Large" Text='<%# Bind("Project") %>'></asp:Label><br />
                                <asp:Label ID="lblg2Address" runat="server" Font-Size="Small" CssClass="text-muted" Text='<%# Bind("Address") %>'></asp:Label><br />
                                <asp:Label ID="lblg2Dated" runat="server" Font-Size="X-Large" CssClass="text-muted" Text='<%# Bind("Dated") %>'></asp:Label>

                                <asp:Label ID="lblg2NotFormattedDate" runat="server" Visible="false" Font-Size="X-Large" CssClass="text-muted" Text='<%# Bind("NotFormattedDate") %>'></asp:Label>
                                <asp:Label ID="lblg2Reason" runat="server" Visible="false" Font-Size="X-Large" CssClass="text-muted" Text='<%# Bind("Reason") %>'></asp:Label>
                                <asp:Label ID="lblg2PreparedBy" runat="server" Visible="false" Font-Size="X-Large" CssClass="text-muted" Text='<%# Bind("Prepared_by") %>'></asp:Label>
                            </div>
                            <div class="panel-footer">
                                <asp:LinkButton ID="LinkButton1" CommandName="Report" runat="server" CssClass="btn btn-primary">View Report</asp:LinkButton>
                                <asp:LinkButton ID="LinkButton2" CommandName="EditRecord" runat="server" CssClass="btn btn-success">Edit Record</asp:LinkButton>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
