<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="recommendation.aspx.cs" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.recommendation" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Recommendation</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <div class="container">
        <div class="well">
            <h2>Recommendation</h2>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
        <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
            <asp:GridView ID="GridView1" CssClass="table" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="K#">
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Visible="false" Text='<%#Bind("Id") %>'></asp:Label>
                            <asp:Label ID="lblKno" runat="server" Text='<%#Bind("KMDI_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <asp:Label ID="lblDescription" runat="server" Text='<%#Bind("_Description") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
         <asp:GridView ID="GridView2" CssClass="table" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="Reason">
                        <ItemTemplate>
                            <asp:Label ID="lblReason" runat="server" Text='<%#Bind("Reason") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        Recommendation:  
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="errorval" ControlToValidate="TboxRecommendation" runat="server" CssClass="text-danger" ErrorMessage="Recommendation is a required field">*</asp:RequiredFieldValidator>
        <asp:TextBox ID="TboxRecommendation" TextMode="MultiLine" Rows="10" CssClass="form-control" runat="server"></asp:TextBox>

        <br />
        Completion date:     
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="errorval" ControlToValidate="TboxCompletionDate" runat="server" CssClass="text-danger" ErrorMessage="Completion date is a reqired field">*</asp:RequiredFieldValidator>
        <asp:TextBox ID="TboxCompletionDate" TextMode="MultiLine" Rows="10" CssClass="form-control" runat="server"></asp:TextBox>

        <br />
        <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="Submit" ValidationGroup="errorval" OnClick="Button1_Click" />
    </div>
</asp:Content>
