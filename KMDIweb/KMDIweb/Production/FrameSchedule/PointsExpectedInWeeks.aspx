<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="PointsExpectedInWeeks.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.PointsExpectedInWeeks" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>POINTS INSIGHT</title>
</asp:Content>
<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="content">
    <div class="container">
        <div class="well text-center">
            <h3><strong>Production Lead Time Insight</strong> </h3>
        </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>


                <div style="overflow-x: auto">
                    <table border="1" style="width: 100%; font-family: Calibri;">
                        <tr>
                            <td style="white-space: nowrap">
                                <span style="font-size: x-large">Total project points</span>
                                <span class="text-success">(Active)</span>
                            </td>
                            <td class="text-right">
                                <asp:LinkButton ID="linkTotalproject" Font-Size="XX-Large" runat="server" OnClick="linkTotalproject_Click">LinkButton</asp:LinkButton>
                                <asp:Panel ID="pnlTotalproject" Visible="false" BackColor="Yellow" runat="server" Height="15px"></asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-center">
                                <h2>POINTS BREAKDOWN</h2>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">
                                <span style="font-size: x-large">New projects</span>
                                <span class="text-info">(No request for shop drawing)</span>
                            </td>
                            <td class="text-right">
                                <asp:LinkButton ID="linkNotrequested" Font-Size="XX-Large" runat="server" OnClick="linkNotrequested_Click">LinkButton</asp:LinkButton>
                                <asp:Panel ID="pnlNotrequested" Visible="false" BackColor="Yellow" runat="server" Height="15px"></asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">
                                <span style="font-size: x-large">Expected points to receive</span>
                                <span class="text-info">(SD in progress)</span>
                            </td>
                            <td class="text-right">
                                <asp:LinkButton ID="linkRequested" Font-Size="XX-Large" runat="server" OnClick="linkRequested_Click">LinkButton</asp:LinkButton>
                                <asp:Panel ID="pnlRequested" Visible="false" BackColor="Yellow" runat="server" Height="15px"></asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">
                                <span style="font-size: x-large">SD at hand</span>
                                <span class="text-info">(SD received only)</span>
                            </td>
                            <td class="text-right">
                                <asp:LinkButton ID="linkSDathand" Font-Size="XX-Large" runat="server" OnClick="linkSDathand_Click">LinkButton</asp:LinkButton>
                                <asp:Panel ID="pnlSDathand" Visible="false" BackColor="Yellow" runat="server" Height="15px"></asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">
                                <span style="font-size: x-large">Ongoing fabrication</span>
                                <span class="text-info">(Current production load)</span>
                            </td>
                            <td class="text-right">
                                <asp:LinkButton ID="linkOngoing" Font-Size="XX-Large" runat="server" OnClick="linkOngoing_Click">LinkButton</asp:LinkButton>
                                <asp:Panel ID="pnlOngoing" Visible="false" BackColor="Yellow" runat="server" Height="15px"></asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">
                                <span style="font-size: x-large">Fabricated</span>
                                <span class="text-info">(Fabricated points and not delivered)</span>
                            </td>
                            <td class="text-right">
                                <asp:LinkButton ID="linkFabricated" Font-Size="XX-Large" runat="server" OnClick="linkFabricated_Click">LinkButton</asp:LinkButton>
                                <asp:Panel ID="pnlFabricated" Visible="false" BackColor="Yellow" runat="server" Height="15px"></asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td style="white-space: nowrap">
                                <span style="font-size: x-large">Delivered</span>
                                <span class="text-info">(Delivered points)</span>
                            </td>
                            <td class="text-right">
                                <asp:LinkButton ID="linkDelivered" Font-Size="XX-Large" runat="server" OnClick="linkDelivered_Click">LinkButton</asp:LinkButton>
                                <asp:Panel ID="pnlDelivered" Visible="false" BackColor="Yellow" runat="server" Height="15px"></asp:Panel>
                            </td>
                        </tr>
                    </table>
                </div>

                <div style="overflow-x: auto">
                    <asp:GridView ID="GridView1" CssClass="table" RowStyle-Font-Names="Calibri" AutoGenerateColumns="False" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" PageSize="50">
                        <Columns>
                            <asp:TemplateField HeaderText="JO" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbl1" runat="server" Text='<%#Bind("SUB_JO") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle Wrap="False"></HeaderStyle>

                                <ItemStyle Wrap="False"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="JO DATE" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbl2" runat="server" Text='<%#Bind("JO_DATE") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle Wrap="False"></HeaderStyle>

                                <ItemStyle Wrap="False"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PROJECT" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbl3" runat="server" Text='<%#Bind("PROJECT") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle Wrap="False"></HeaderStyle>

                                <ItemStyle Wrap="False"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="TURN OVER" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbl4" runat="server" Text='<%#Bind("TURN_OVER") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle Wrap="False"></HeaderStyle>

                                <ItemStyle Wrap="False"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CHECKLISTED" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbl5" runat="server" Text='<%#Bind("CHECKLISTED") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle Wrap="False"></HeaderStyle>

                                <ItemStyle Wrap="False"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PROJECT DONE" ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                                <ItemTemplate>
                                    <asp:Label ID="lbl6" runat="server" Text='<%#Bind("PROJECT_DONE") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle Wrap="False"></HeaderStyle>

                                <ItemStyle Wrap="False"></ItemStyle>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                        <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                        <PagerStyle CssClass="GridPager" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="lEFT" />
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
