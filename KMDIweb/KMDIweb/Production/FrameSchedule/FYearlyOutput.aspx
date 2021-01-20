<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="FYearlyOutput.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.FYearlyOutput" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Yearly output insight</title>
</asp:Content>
<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="content">
    <div class="well">
        <h2>Frame Fabrication Load/Output Chart</h2>
    </div>
    <div class="container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


        <div class="well">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon" style="background-color: cornflowerblue">
                                    <span style="color: white"><b>year</b></span>
                                </div>
                                <asp:TextBox ID="tboxy1" CssClass="form-control" TextMode="Number" MaxLength="9999" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon" style="background-color: orange">
                                    <span style="color: white"><b>year</b></span>
                                </div>
                                <asp:TextBox ID="tboxy2" CssClass="form-control" TextMode="Number" MaxLength="9999" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon">
                                </div>
                                <asp:DropDownList ID="ddlSearchby" CssClass="form-control" runat="server">
                                    <asp:ListItem Value="Output" Text="Output"></asp:ListItem>
                                    <asp:ListItem Value="Load" Text="Load"></asp:ListItem>
                                </asp:DropDownList>

                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon">
                                </div>
                                <asp:DropDownList ID="ddlChartType" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChartType_SelectedIndexChanged"></asp:DropDownList>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnsubmit" CssClass="btn btn-default" runat="server" OnClick="btnsubmit_Click">submit</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
                        <asp:Chart ID="Chart1" runat="server" Width="1049px" Height="506px">

                            <Titles>
                                <asp:Title Text="Monthly Frame Points Chart"></asp:Title>
                            </Titles>
                            <Series>
                                <asp:Series Name="Year_1" IsValueShownAsLabel="true" IsVisibleInLegend="true" XValueMember="MM" YValueMembers="qty1" ChartArea="ChartArea1" ChartType="Column" Legend="Legend1">
                                </asp:Series>
                                <asp:Series Name="Year_2" IsValueShownAsLabel="true" IsVisibleInLegend="true" XValueMember="MM" YValueMembers="qty2" ChartArea="ChartArea1" ChartType="Column" Legend="Legend1">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisX Title="Month"></AxisX>
                                    <AxisY Title="Frame Points"></AxisY>
                                    <%--      <Area3DStyle Enable3D="true" />--%>
                                </asp:ChartArea>
                            </ChartAreas>

                        </asp:Chart>
                    </asp:Panel>
          
            <br />
         
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    Sort Order
                                </div>
                                <asp:DropDownList ID="ddlOrderBy" CssClass="form-control" runat="server">
                                    <asp:ListItem Text="Ascending" Value="ASC"></asp:ListItem>
                                    <asp:ListItem Text="Descending" Value="DESC"></asp:ListItem>
                                </asp:DropDownList>
                            </div>

                        </div>
                        <div class="col-sm-6">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    Sort By<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="mm" ControlToValidate="ddlSortBy" ForeColor="Red" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                </div>
                                <asp:DropDownList ID="ddlSortBy" CssClass="form-control" runat="server">
                                </asp:DropDownList>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSort"  ValidationGroup="mm" CssClass="btn btn-default" runat="server" OnClick="btnSort_Click">SORT</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" OnRowDataBound="GridView1_RowDataBound" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                      <Columns>
                          <asp:TemplateField>
                              <ItemTemplate>
                                  <%# Container.DataItemIndex+1 %>
                              </ItemTemplate>
                          </asp:TemplateField>
                          <asp:TemplateField HeaderText="Month">
                              <ItemTemplate>
                                  <asp:Label ID="lblMM" runat="server" Text='<%# Bind("MM") %>'></asp:Label>
                              </ItemTemplate>
                          </asp:TemplateField>
                            <asp:TemplateField>
                              <ItemTemplate>
                                  <asp:Label ID="lbly1" runat="server" Text='<%# Bind("qty1Formated") %>'></asp:Label>
                              </ItemTemplate>
                          </asp:TemplateField>
                            <asp:TemplateField>
                              <ItemTemplate>
                                  <asp:Label ID="lbly2" runat="server" Text='<%# Bind("qty2Formated") %>'></asp:Label>
                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                        
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                        <RowStyle BackColor="White" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#808080" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#383838" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>


    </div>
</asp:Content>
