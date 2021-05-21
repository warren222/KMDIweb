<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="CalendarFrame.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.CalendarFrame" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>List of rescheduled items</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2>Frame Schedule Calendar
            <asp:Label ID="lblDate" runat="server" CssClass="text-primary" Text=""></asp:Label></h2>
            <div class="col-sm-2">
                <div class="input-group">
                    <div class="input-group-addon">
                        Year
                    </div>
                    <asp:TextBox ID="tboxyear" runat="server" TextMode="Number" CssClass="form-control">2021</asp:TextBox>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="input-group">

                    <div class="input-group-addon">
                        Month
                    </div>
                    <asp:DropDownList CssClass="form-control" ID="ddlmonth" runat="server">
                        <asp:ListItem Text="Jan" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Feb" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Mar" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Apr" Value="4"></asp:ListItem>
                        <asp:ListItem Text="May" Value="5"></asp:ListItem>
                        <asp:ListItem Text="Jun" Value="6"></asp:ListItem>
                        <asp:ListItem Text="Jul" Value="7"></asp:ListItem>
                        <asp:ListItem Text="Aug" Value="8"></asp:ListItem>
                        <asp:ListItem Text="Sep" Value="9"></asp:ListItem>
                        <asp:ListItem Text="Oct" Value="10"></asp:ListItem>
                        <asp:ListItem Text="Nov" Value="11"></asp:ListItem>
                        <asp:ListItem Text="Dec" Value="12"></asp:ListItem>
                    </asp:DropDownList>
                    <div class="input-group-addon">
                        <asp:CheckBox ID="CheckBox1" Text="Fabricated" runat="server" />
                    </div>
                    <div class="input-group-btn">
                        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">Submit</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <asp:GridView ID="GridView1" CssClass="tbl" AutoGenerateColumns="False" runat="server" CellPadding="3" GridLines="Both" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellSpacing="1" OnDataBound="GridView1_DataBound" OnRowCommand="GridView1_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="Monday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                <ItemTemplate>
                    <asp:Label ID="lbl1points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Monday") %>'></asp:Label>
                    <asp:LinkButton ID="LinkButton2" CommandName="viewlistMonday" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Monday") %>'></asp:LinkButton>
                    <asp:Label ID="lbl1date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Monday") %>'></asp:Label>
                    <asp:Label ID="lbl1content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Bind("Monday") %>'></asp:Label>
                </ItemTemplate>

                <HeaderStyle Width="200px"></HeaderStyle>

                <ItemStyle Wrap="True"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tuesday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                <ItemTemplate>
                    <asp:Label ID="lbl2points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                    <asp:Label ID="lbl2date" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                    <asp:Label ID="lbl2content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Bind("Tuesday") %>'></asp:Label>
                </ItemTemplate>

                <HeaderStyle Width="200px"></HeaderStyle>

                <ItemStyle Wrap="True"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Wednesday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                <ItemTemplate>
                    <asp:Label ID="lbl3points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Wednesday") %>'></asp:Label>
                    <asp:Label ID="lbl3date" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' runat="server" Text='<%# Bind("Wednesday") %>'></asp:Label>
                    <asp:Label ID="lbl3content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Bind("Wednesday") %>'></asp:Label>
                </ItemTemplate>

                <HeaderStyle Width="200px"></HeaderStyle>

                <ItemStyle Wrap="True"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Thursday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                <ItemTemplate>
                    <asp:Label ID="lbl4points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Thursday") %>'></asp:Label>
                    <asp:Label ID="lbl4date" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' runat="server" Text='<%# Bind("Thursday") %>'></asp:Label>
                    <asp:Label ID="lbl4content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Bind("Thursday") %>'></asp:Label>
                </ItemTemplate>

                <HeaderStyle Width="200px"></HeaderStyle>

                <ItemStyle Wrap="True"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Friday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                <ItemTemplate>
                    <asp:Label ID="lbl5points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Friday") %>'></asp:Label>
                    <asp:Label ID="lbl5date" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' runat="server" Text='<%# Bind("Friday") %>'></asp:Label>
                    <asp:Label ID="lbl5content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Bind("Friday") %>'></asp:Label>
                </ItemTemplate>

                <HeaderStyle Width="200px"></HeaderStyle>

                <ItemStyle Wrap="True"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Saturday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                <ItemTemplate>
                    <asp:Label ID="lbl6points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Saturday") %>'></asp:Label>
                    <asp:Label ID="lbl6date" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' runat="server" Text='<%# Bind("Saturday") %>'></asp:Label>
                    <asp:Label ID="lbl6content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Bind("Saturday") %>'></asp:Label>
                </ItemTemplate>

                <HeaderStyle Width="200px"></HeaderStyle>

                <ItemStyle Wrap="True"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sunday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                <ItemTemplate>
                    <asp:Label ID="lbl7points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Sunday") %>'></asp:Label>
                    <asp:Label ID="lbl7date" ForeColor="Red" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' runat="server" Text='<%# Bind("Sunday") %>'></asp:Label>
                    <asp:Label ID="lbl7content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Bind("Sunday") %>'></asp:Label>
                </ItemTemplate>

                <HeaderStyle Width="200px"></HeaderStyle>

                <ItemStyle Wrap="True"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Total" ItemStyle-BackColor="WhiteSmoke" HeaderStyle-Width="120px" ItemStyle-Wrap="true">
                <ItemTemplate>
                    <div class="text-center">
                        <asp:Label ID="lbl8points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Total") %>'></asp:Label>
                    </div>
                    <div class="text-center">
                        <asp:Label ID="lbl8date" CssClass="text-danger" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' runat="server" Text='<%# Bind("Total") %>'></asp:Label>
                    </div>
                    <div class="text-center">
                        <asp:Label ID="lbl8content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="Medium" Text='<%# Bind("Total") %>'></asp:Label>
                    </div>
                </ItemTemplate>

                <HeaderStyle Width="120px"></HeaderStyle>

                <ItemStyle Wrap="True"></ItemStyle>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
        <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
        <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F1F1F1" />
        <SortedAscendingHeaderStyle BackColor="#594B9C" />
        <SortedDescendingCellStyle BackColor="#CAC9C9" />
        <SortedDescendingHeaderStyle BackColor="#33276A" />
    </asp:GridView>

    <div id="myModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        Header
                    </h5>
                      
                </div>
                <div class="modal-body">
                   <asp:GridView ID="GridView2" CssClass="table" AutoGenerateColumns="False" runat="server" CellPadding="4" ForeColor="Black" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellSpacing="2">
                        <Columns>
                            <asp:TemplateField HeaderText="Project">
                                <ItemTemplate>
                                       <asp:Label ID="lblmodalproject" runat="server" Text='<%# Bind("project_label") %>'></asp:Label><br />
                                    <asp:Label ID="lblmodaladdress" Font-Size="Smaller" CssClass="text-muted" runat="server" Text='<%# Bind("fulladd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="K#/Location">
                                <ItemTemplate>
                                    <asp:Label ID="lblmodalKno" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                    <asp:Label ID="lblmodalLocation" Font-Size="Smaller" CssClass="text-muted" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                          <asp:TemplateField HeaderText="Points">
                                <ItemTemplate>
                                    <asp:Label ID="lblmodalPoints" runat="server" Text='<%# Bind("points") %>'></asp:Label>
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
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
     
</asp:Content>
