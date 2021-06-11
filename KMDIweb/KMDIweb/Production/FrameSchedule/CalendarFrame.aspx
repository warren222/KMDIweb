<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Production/FrameSchedule/FrameScheduleMaster.Master" CodeBehind="CalendarFrame.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.FrameSchedule.CalendarFrame" %>

<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%--  <meta name="viewport" content="width=device-width, initial-scale=1" />--%>
    <%--   <meta content="width=device-width, initial-scale=1" name="viewport" />--%>
    <title>Frame Calendar</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h2>Due Date Calendar
            <asp:Label ID="lblDate" runat="server" CssClass="text-primary" Text=""></asp:Label></h2>
          <div class="col-sm-4">
                    <div class="input-group">
                        <div class="input-group-addon">
                            AE/ENGR.
                        </div>
                        <asp:DropDownList ID="ddlae" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
        <div class="col-sm-4">
            <div class="input-group">

                <div class="input-group-addon">
                    Month
                </div>
                <asp:DropDownList CssClass="form-control" ID="ddlmonth" runat="server">
                    <asp:ListItem Text="Jan" Value="01"></asp:ListItem>
                    <asp:ListItem Text="Feb" Value="02"></asp:ListItem>
                    <asp:ListItem Text="Mar" Value="03"></asp:ListItem>
                    <asp:ListItem Text="Apr" Value="04"></asp:ListItem>
                    <asp:ListItem Text="May" Value="05"></asp:ListItem>
                    <asp:ListItem Text="Jun" Value="06"></asp:ListItem>
                    <asp:ListItem Text="Jul" Value="07"></asp:ListItem>
                    <asp:ListItem Text="Aug" Value="08"></asp:ListItem>
                    <asp:ListItem Text="Sep" Value="09"></asp:ListItem>
                    <asp:ListItem Text="Oct" Value="10"></asp:ListItem>
                    <asp:ListItem Text="Nov" Value="11"></asp:ListItem>
                    <asp:ListItem Text="Dec" Value="12"></asp:ListItem>
                </asp:DropDownList>
                <div class="input-group-addon">
                    <asp:CheckBox ID="CheckBox1" Text="Fabricated" runat="server" Checked="True" />
                </div>

            </div>
        </div>
        <div class="col-sm-4">
            <div class="input-group">
                <div class="input-group-addon">
                    Year
                </div>
                <asp:TextBox ID="tboxyear" runat="server" TextMode="Number" CssClass="form-control">2021</asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">Submit</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>



    <h1 class="text-center">
        <strong>
            <asp:Label ID="lblMonth" CssClass="text-success" runat="server"></asp:Label></strong>
    </h1>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <asp:Panel runat="server" ID="Panel1" ScrollBars="Auto">
                <asp:GridView ID="GridView1" CssClass="tbl" AutoGenerateColumns="False" runat="server" CellPadding="3" GridLines="Both" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellSpacing="1" OnDataBound="GridView1_DataBound" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Monday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl1points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Monday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnMon" CommandName="viewlistMon" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Monday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl1date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Monday") %>'></asp:Label>
                                <asp:Label ID="lbl1content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Regex.Replace(Eval("Monday").ToString(), "\r\n|\r|\n", "<br>") %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tuesday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl2points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnTue" CommandName="viewlistTue" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Tuesday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl2date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                                <asp:Label ID="lbl2content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Regex.Replace(Eval("Tuesday").ToString(), "\r\n|\r|\n", "<br>") %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Wednesday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl3points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Wednesday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnWed" CommandName="viewlistWed" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Wednesday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl3date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Wednesday") %>'></asp:Label>
                                <asp:Label ID="lbl3content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Regex.Replace(Eval("Wednesday").ToString(), "\r\n|\r|\n", "<br>") %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thursday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl4points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Thursday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnThu" CommandName="viewlistThu" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Thursday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl4date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Thursday") %>'></asp:Label>
                                <asp:Label ID="lbl4content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Regex.Replace(Eval("Thursday").ToString(), "\r\n|\r|\n", "<br>") %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Friday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl5points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Friday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnFri" CommandName="viewlistFri" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Friday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl5date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Friday") %>'></asp:Label>
                                <asp:Label ID="lbl5content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Regex.Replace(Eval("Friday").ToString(), "\r\n|\r|\n", "<br>") %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Saturday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl6points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Saturday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnSat" CommandName="viewlistSat" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Saturday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl6date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Saturday") %>'></asp:Label>
                                <asp:Label ID="lbl6content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Regex.Replace(Eval("Saturday").ToString(), "\r\n|\r|\n", "<br>") %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sunday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl7points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Sunday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnSun" CommandName="viewlistSun" ForeColor="Red" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Sunday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl7date" ForeColor="Red" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Sunday") %>'></asp:Label>
                                <asp:Label ID="lbl7content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Regex.Replace(Eval("Sunday").ToString(), "\r\n|\r|\n", "<br>") %>'></asp:Label>
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
            </asp:Panel>
            <div id="myModal" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <asp:Label ID="lblmodalHeader" Font-Size="Larger" CssClass="text-info" runat="server" Text="Label"></asp:Label><br />
                                <asp:Label ID="lblmodalTotalPoints" CssClass="text-success" runat="server" Text="Label"></asp:Label>&nbsp;points/<asp:Label ID="lblmodalTotalQty" CssClass="text-success" runat="server" Text="Label"></asp:Label>&nbsp;items
                            </h5>

                        </div>
                        <div class="modal-body">
                            <asp:GridView ID="GridView2" CssClass="table" GridLines="None" AutoGenerateColumns="False" runat="server">
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
                            </asp:GridView>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="well">
                <h2>Summary of scheduled projects for&nbsp;<strong><asp:Label ID="lblMonth2" CssClass="text-success" runat="server"></asp:Label></strong> </h2>
            </div>
            <asp:GridView ID="GridView3" CssClass="table" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="Both">
                <Columns>
                    <asp:TemplateField HeaderText="PROJECT">
                        <ItemTemplate>
                            <asp:Label ID="lblproject" runat="server" Text='<%# Bind("PROJECT_LABEL") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="POINTS">
                        <ItemTemplate>
                            <asp:Label ID="lblpoints" runat="server" Text='<%# Bind("POINTS") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SCHEDULE">
                        <ItemTemplate>
                            <asp:Label ID="lblschedule" runat="server" Text='<%# Bind("SCHEDULE") %>'></asp:Label>
                        </ItemTemplate>
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
