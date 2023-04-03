<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/FoilingSchedule/FoilingMaster.Master" CodeBehind="FoilingCalendar.aspx.cs" Inherits="KMDIweb.KMDIweb.FoilingSchedule.FoilingCalendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-3">
                        <div class="input-group">
                            <div class="input-group-addon">
                                Specification
                            </div>
                            <asp:DropDownList ID="ddlSpecification" CssClass="form-control" runat="server">
                                <asp:ListItem Value="Frame" Text="Frame"></asp:ListItem>
                                <asp:ListItem Value="Screen" Text="Screen"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-sm-2">
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

                        </div>
                    </div>
                    <div class="col-sm-3">
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
                    <div class="col-sm-2"></div>
                </div>
                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:Label ID="lblMonth" runat="server" CssClass="" Font-Size="75px"></asp:Label>
                <asp:GridView ID="GridView1" CssClass="tbl" AutoGenerateColumns="False" CellPadding="3" GridLines="Both" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellSpacing="1" OnRowDataBound="GridView1_RowDataBound" runat="server" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Monday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lblContext" Visible="false" runat="server" Text='<%# Bind("Context") %>'></asp:Label>
                                <asp:Label ID="lblSelected_Month" Visible="false" runat="server" Text='<%# Bind("Selected_Month") %>'></asp:Label>

                                <asp:LinkButton ID="linkbtn1" CommandName="viewlistMon" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                     <span style="font-size:45px"><%#  Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Monday")).ToString("dd") : "" %></span>&nbsp;
                                    <span style="font-size:small;"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Monday")).ToString("MMM") : "" %></span>
                                </asp:LinkButton>
                                <asp:Label ID="lbl1date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Monday") %>'></asp:Label>
                                <asp:Label ID="lbl1content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Monday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tuesday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:LinkButton ID="linkbtn2" CommandName="viewlistTue" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                     <span style="font-size:45px"><%#  Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Tuesday")).ToString("dd") : "" %></span>&nbsp;
                                    <span style="font-size:small;"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Tuesday")).ToString("MMM") : "" %></span>
                                </asp:LinkButton>
                                <asp:Label ID="lbl2date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                                <asp:Label ID="lbl2content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Tuesday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Wednesday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:LinkButton ID="linkbtn3" CommandName="viewlistWed" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                     <span style="font-size:45px"><%#  Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Wednesday")).ToString("dd") : "" %></span>&nbsp;
                                    <span style="font-size:small;"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Wednesday")).ToString("MMM") : "" %></span>
                                </asp:LinkButton>
                                <asp:Label ID="lbl3date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Wednesday") %>'></asp:Label>
                                <asp:Label ID="lbl3content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Wednesday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thursday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:LinkButton ID="linkbtn4" CommandName="viewlistThu" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                     <span style="font-size:45px"><%#  Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Thursday")).ToString("dd") : "" %></span>&nbsp;
                                    <span style="font-size:small;"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Thursday")).ToString("MMM") : "" %></span>
                                </asp:LinkButton>
                                <asp:Label ID="lbl4date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Thursday") %>'></asp:Label>
                                <asp:Label ID="lbl4content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Thursday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Friday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:LinkButton ID="linkbtn5" CommandName="viewlistFri" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                     <span style="font-size:45px"><%#  Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Friday")).ToString("dd") : "" %></span>&nbsp;
                                    <span style="font-size:small;"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Friday")).ToString("MMM") : "" %></span>
                                </asp:LinkButton>
                                <asp:Label ID="lbl5date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Friday") %>'></asp:Label>
                                <asp:Label ID="lbl5content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Friday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Saturday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:LinkButton ID="linkbtn6" CommandName="viewlistSat" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                     <span style="font-size:45px"><%#  Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Saturday")).ToString("dd") : "" %></span>&nbsp;
                                    <span style="font-size:small;"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Saturday")).ToString("MMM") : "" %></span>
                                </asp:LinkButton>
                                <asp:Label ID="lbl6date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Saturday") %>'></asp:Label>
                                <asp:Label ID="lbl6content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Saturday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sunday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:LinkButton ID="linkbtn7" CommandName="viewlistSun" ForeColor="Red" runat="server" Font-Bold="true" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                    <span style="font-size:45px"><%#  Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Sunday")).ToString("dd") : "" %></span>&nbsp;
                                    <span style="font-size:small;"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Sunday")).ToString("MMM") : "" %></span>
                                </asp:LinkButton>
                                <asp:Label ID="lbl7date" ForeColor="Red" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Sunday") %>'></asp:Label>
                                <asp:Label ID="lbl7content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Sunday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>

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
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <div id="myModal" class="modal fade" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <asp:Label ID="lblmodalDate" Font-Bold="true" CssClass="text-info" runat="server" Text=""></asp:Label></h5>
                                <asp:Label ID="lblmodalYear" CssClass="text-muted" runat="server" Text=""></asp:Label>
                            </div>
                            <div class="modal-body">
                                <div style="overflow-x: auto; overflow-y: auto">
                                    <asp:GridView ID="GridView2" CssClass="tbl" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        <RowStyle ForeColor="#000066" />
                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                                    </asp:GridView>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</asp:Content>
