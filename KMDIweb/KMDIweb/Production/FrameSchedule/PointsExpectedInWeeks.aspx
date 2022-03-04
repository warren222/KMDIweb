<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="PointsExpectedInWeeks.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.PointsExpectedInWeeks" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>POINTS INSIGHT</title>
</asp:Content>
<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="content">
    <div class="container">
        <div class="well text-center">
            <h3><strong>Expected points in 3-4 weeks</strong> </h3>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div style="overflow-x: auto">
            <table class="text-center" border="1" style="width: 100%">
                <tr>
                    <td>
                        <span style="font-size: xx-large">New projects</span>
                        <span class="text-muted">(Not yet requested)</span>
                    </td>
                    <td>
                        <span style="font-size: xx-large">Expected points</span>
                        <span class="text-muted">(With shop drawing request)</span>
                    </td>
                </tr>
                <tr>
                    <td>

                        <asp:LinkButton ID="linkNotrequested" Font-Size="XX-Large" runat="server" OnClick="linkNotrequested_Click">LinkButton</asp:LinkButton>
                        <asp:Panel ID="Panel1" Visible="false" BackColor="Yellow" runat="server" Height="15px"></asp:Panel>
                    </td>
                    <td>
                        <asp:LinkButton ID="linkRequested" Font-Size="XX-Large" runat="server" OnClick="linkRequested_Click">LinkButton</asp:LinkButton>
                        <asp:Panel ID="Panel2" Visible="false" BackColor="Yellow" runat="server" Height="15px"></asp:Panel>
                    </td>
                </tr>
            </table>
        </div>

        <div style="overflow-x: auto">
            <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="false" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical">
                <Columns>
                    <asp:TemplateField HeaderText="JO" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lbl1" runat="server" Text='<%#Bind("SUB_JO") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="JO DATE" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lbl2" runat="server" Text='<%#Bind("JO_DATE") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PROJECT" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lbl3" runat="server" Text='<%#Bind("PROJECT") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TURN OVER" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lbl4" runat="server" Text='<%#Bind("TURN_OVER") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CHECKLISTED" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lbl5" runat="server" Text='<%#Bind("CHECKLISTED") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PROJECT DONE" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lbl6" runat="server" Text='<%#Bind("PROJECT_DONE") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle BackColor="#DCDCDC" />
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
