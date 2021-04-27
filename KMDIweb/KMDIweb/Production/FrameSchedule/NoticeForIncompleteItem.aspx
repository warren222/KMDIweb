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
        <br />
        <br />
        <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
            <asp:GridView ID="GridView1" CssClass="table" runat="server" AutoGenerateColumns="false" ShowFooter="True">
                <Columns>
                    <asp:TemplateField HeaderText="K#">
                        <ItemTemplate>
                            <asp:Label ID="lblKno" runat="server" Text='<%#Bind("KMDI_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <asp:TextBox ID="tboxDescription" CssClass="form-control" runat="server"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
        Reason<br />
        <asp:TextBox ID="tboxReason" TextMode="MultiLine" CssClass="form-control" runat="server" Rows="10"></asp:TextBox>
        <asp:Button ID="saveBTN" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="saveBTN_Click" />
    </div>
</asp:Content>
