<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="scaccessories.aspx.cs"  MasterPageFile="~/KMDIapp/KMDIwebMaster.Master" Inherits="KMDIweb.KMDIapp.scaccessories" %>
<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
      <title>Accessories</title>
</asp:Content>
<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="content">
      <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class=" jumbotron">
        <div class="row">
            <div class="col-sm-6">
                <h1><strong>Accessories<br />
                    <small>Station's expected output</small> </strong></h1>
                <asp:LinkButton ID="BTNback" runat="server" PostBackUrl="~/KMDIapp/home.aspx" CssClass="btn btn-primary">back to home page</asp:LinkButton>
            </div>
            <div class="col-sm-6">
                <table class="table">
                    <tr>
                        <td style="background-color: LightBlue">Mon</td>
                        <td style="background-color: LightGreen">Tue</td>
                        <td style="background-color: Yellow">Wed</td>
                        <td style="background-color: Orange">Thu</td>
                        <td style="background-color: Pink">Fri</td>
                        <td style="background-color: Violet">Sat</td>
                        <td style="background-color: Teal">Sun</td>
                    </tr>
                </table>
                <table class="table">
                    <tr>
                        <td style="background-color: indigo; color: white">Accessories</td>
                        <td style="background-color: brown; color: white">Fabricated</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4><span>Filter Option </span></h4>
                    <div class="row">
                             <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    DATE BEGIN
                                </div>
                                <asp:TextBox ID="tboxBdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>

                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    DATE END
                                </div>
                                <asp:TextBox ID="tboxEdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>

                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    PROJECT
                                </div>
                                <asp:TextBox ID="TBOXproject" placeholder="project name" CssClass="form-control" runat="server"></asp:TextBox>
                                <div class="input-group-addon">
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked="true" />&nbsp;Finished
                                </div>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="BTNsearch" CssClass="btn btn-primary" runat="server" OnClick="BTNsearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                           <h3 class="text-center text-success"><span><strong>
                            <asp:Label ID="LBLschedule" runat="server" CssClass="forfont" Text="Accessories Checklist Table"></asp:Label></strong> </span></h3>
                       <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="False" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" PageSize="25" OnDataBound="GridView1_DataBound" OnRowCommand="GridView1_RowCommand" GridLines="Vertical">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField HeaderText="DUE DATE" HeaderStyle-Width="500px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLduedate" Font-Size="X-Large" Font-Bold="true" runat="server" Text='<%# Bind("DUE_DATE") %>'></asp:Label><br />
                                        <asp:Label ID="LBLyear" runat="server" Text='<%# Bind("YEAR") %>'></asp:Label><br />
                                        <asp:Label ID="LBLday" Font-Bold="true" runat="server" Text='<%# Bind("DAY") %>'></asp:Label>

                                        <asp:Label ID="LBLparentjono" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("parentjono") %>'></asp:Label>
                                        <asp:Label ID="LBLddate" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("ddate") %>'></asp:Label>
                                        <asp:Label ID="LBLschedremarks" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("sched_remarks") %>'></asp:Label>

                                        <asp:Label ID="LBLstatus" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PROJECT" HeaderStyle-Width="250px">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLprojectname" runat="server" Font-Size="Small" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="K#" HeaderStyle-Width="350px" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LINKkno" runat="server" CommandName="forcutting" Font-Bold="true" Text='<%# Bind("KNO") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CL ctrl no." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLclno" runat="server" Text='<%# Bind("CLNO") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="COLOR" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLcolor" runat="server" Text='<%# Bind("COLOR") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="QTY" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLqty" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TYPE OF SCREEN" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLscreentype" runat="server" Text='<%# Bind("TYPE_OF_SCREEN") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="REMARKS" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLremarks" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ACCESSORIES" HeaderStyle-BackColor="Indigo" HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLaccessories" Font-Size="Small" runat="server" Font-Bold="true" Text='<%# Bind("Accessories_date") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="Indigo" ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FABRICATED" HeaderStyle-BackColor="Brown" HeaderStyle-ForeColor="white" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="LBLfinished" Font-Bold="true" runat="server" Text='<%# Bind("finished") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="Brown" ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Right" BackColor="#F7F7DE" ForeColor="Black" />
                            <FooterStyle BackColor="#CCCC99" />
                            <HeaderStyle Wrap="False" BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                            <PagerSettings PageButtonCount="8" Position="TopAndBottom" />

                            <RowStyle BackColor="#F7F7DE" />
                            <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                            <SortedAscendingCellStyle BackColor="#FBFBF2" />
                            <SortedAscendingHeaderStyle BackColor="#848384" />
                            <SortedDescendingCellStyle BackColor="#EAEAD3" />
                            <SortedDescendingHeaderStyle BackColor="#575357" />
                            <EmptyDataTemplate>
                             <div>
                                    <h3><strong>Sorry, No Result Found!</strong>
                                    </h3>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>

                    </asp:Panel>

                      <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto" Visible="false">
                         <h4 class="text-warning text-center"><span style="font-size: xx-large">Item checking</span></h4>
                        <asp:LinkButton ID="LINKexit" CssClass=" form-control btn-warning text-center" runat="server" Font-Size="Larger" OnClick="LINKexit_Click">Go back to checklist</asp:LinkButton>
                        <asp:GridView ID="GridView2" CssClass="table" runat="server" CellPadding="4" ForeColor="#333333" AllowPaging="True" AutoGenerateColumns="False" OnDataBound="GridView2_DataBound" OnPageIndexChanging="GridView2_PageIndexChanging" OnRowCommand="GridView2_RowCommand" PageSize="25" GridLines="None">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:TemplateField HeaderText="DUE DATE">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLduedate" Font-Size="Medium" Font-Bold="true" runat="server" Text='<%# Bind("DUE_DATE") %>'></asp:Label><br />
                                        <asp:Label ID="g2LBLday" Font-Bold="true" Visible="false" runat="server" Text='<%# Bind("DAY") %>'></asp:Label><br />
                                        <asp:Label ID="g2LBLjoborderno" Visible="false" Font-Bold="true" runat="server" Text='<%# Bind("job_order_no") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PROJECT" HeaderStyle-Width="250px">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLprojectname" runat="server" Font-Size="Small" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="350px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="K#">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLkno" runat="server" Font-Bold="true" Text='<%# Bind("kmdi_no") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CL ctrl no.">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLclno" runat="server" Text='<%# Bind("CLNO") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="COLOR">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLcolor" runat="server" Text='<%# Bind("COLOR") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TYPE OF SCREEN">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLscreentype" runat="server" Text='<%# Bind("TYPE_OF_SCREEN") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="REMARKS">
                                    <ItemTemplate>
                                        <asp:Label ID="g2LBLremarks" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ACCESSORIES" HeaderStyle-BackColor="Indigo" HeaderStyle-ForeColor="White">
                                    <ItemTemplate>
                                          <asp:Label ID="g2LBLaccessories" Font-Size="Small" runat="server" Font-Bold="true" Text='<%# Bind("Accessories_date") %>'></asp:Label>
                                    </ItemTemplate>                           
                                    <HeaderStyle BackColor="Indigo" ForeColor="White" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="BTNcheck" CommandName="check" Visible='<%# Eval("Accessories_date").ToString() == "" ? true : false %>' runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-ok"></span>&nbsp; Check</asp:LinkButton>
                                        <asp:LinkButton ID="BTNuncheck" CommandName="uncheck" Visible='<%# Eval("uncheck").ToString() == "true" ? true : false %>' runat="server" CssClass="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp; Uncheck</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerSettings Position="TopAndBottom" PageButtonCount="8" />
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Center" BackColor="#284775"/>
                            <RowStyle BackColor="#F7F6F3" Wrap="False" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                            <EditRowStyle BackColor="#999999" />
                            <EmptyDataTemplate>
                               <div>
                                    <h3><strong>Sorry, No Result Found!</strong>
                                    </h3>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </asp:Panel>
                </div>
                <div class="panel-footer">
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>