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


    <div class="well">
        <h3>LEGEND</h3>
        <div class="row">
            <div class="col-sm-2">
                <div style="padding: 7px; background-color: black;"><span style="color: white; font-size: small">Frame w/ cutting list</span> </div>
            </div>
            <div class="col-sm-2">
                <div style="padding: 7px; background-color: red;"><span style="color: white; font-size: small">Frame w/o cutting list</span> </div>
            </div>
            <div class="col-sm-2">
                <div style="padding: 7px; background-color: green;"><span style="color: white; font-size: small">Screen</span> </div>
            </div>
            <div class="col-sm-2">
                <div style="padding: 7px;"><span class="label label-primary" style="font-size: large">Specialized System Points</span> </div>
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
                                <asp:Label ID="lbl1specialpoints" Visible='<%# Eval("Context").ToString() == "Special_Points" ? Eval("Monday").ToString() == "0" ? false : true : false %>' CssClass="label label-primary" runat="server" Text='<%# Bind("Monday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnMon" CommandName="viewlistMon" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Monday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl1date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Monday") %>'></asp:Label>
                                <asp:Label ID="lbl1content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Monday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tuesday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl2points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                                <asp:Label ID="lbl2specialpoints" Visible='<%# Eval("Context").ToString() == "Special_Points" ? Eval("Tuesday").ToString() == "0" ? false : true : false %>' CssClass="label label-primary" runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnTue" CommandName="viewlistTue" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Tuesday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl2date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                                <asp:Label ID="lbl2content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Tuesday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Wednesday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl3points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Wednesday") %>'></asp:Label>
                                <asp:Label ID="lbl3specialpoints" Visible='<%# Eval("Context").ToString() == "Special_Points" ? Eval("Wednesday").ToString() == "0" ? false : true : false %>' CssClass="label label-primary" runat="server" Text='<%# Bind("Wednesday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnWed" CommandName="viewlistWed" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Wednesday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl3date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Wednesday") %>'></asp:Label>
                                <asp:Label ID="lbl3content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Wednesday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thursday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl4points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Thursday") %>'></asp:Label>
                                <asp:Label ID="lbl4specialpoints" Visible='<%# Eval("Context").ToString() == "Special_Points" ? Eval("Thursday").ToString() == "0" ? false : true : false %>' CssClass="label label-primary" runat="server" Text='<%# Bind("Thursday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnThu" CommandName="viewlistThu" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Thursday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl4date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Thursday") %>'></asp:Label>
                                <asp:Label ID="lbl4content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Thursday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Friday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl5points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Friday") %>'></asp:Label>
                                <asp:Label ID="lbl5specialpoints" Visible='<%# Eval("Context").ToString() == "Special_Points" ? Eval("Friday").ToString() == "0" ? false : true : false %>' CssClass="label label-primary" runat="server" Text='<%# Bind("Friday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnFri" CommandName="viewlistFri" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Friday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl5date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Friday") %>'></asp:Label>
                                <asp:Label ID="lbl5content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Friday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Saturday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl6points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Saturday") %>'></asp:Label>
                                <asp:Label ID="lbl6specialpoints" Visible='<%# Eval("Context").ToString() == "Special_Points" ? Eval("Saturday").ToString() == "0" ? false : true : false %>' CssClass="label label-primary" runat="server" Text='<%# Bind("Saturday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnSat" CommandName="viewlistSat" ForeColor="Black" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Saturday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl6date" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Saturday") %>'></asp:Label>
                                <asp:Label ID="lbl6content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Saturday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>

                            <HeaderStyle Width="200px"></HeaderStyle>

                            <ItemStyle Wrap="True"></ItemStyle>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sunday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                            <ItemTemplate>
                                <asp:Label ID="lbl7points" Visible='<%# Eval("Context").ToString() == "Points" ? true : false %>' runat="server" Text='<%# Bind("Sunday") %>'></asp:Label>
                                <asp:Label ID="lbl7specialpoints" Visible='<%# Eval("Context").ToString() == "Special_Points" ? Eval("Sunday").ToString() == "0" ? false : true : false %>' CssClass="label label-primary" runat="server" Text='<%# Bind("Sunday") %>'></asp:Label>
                                <asp:LinkButton ID="linkbtnSun" CommandName="viewlistSun" ForeColor="Red" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>' Text='<%# Bind("Sunday") %>'></asp:LinkButton>
                                <asp:Label ID="lbl7date" ForeColor="Red" Font-Bold="true" Font-Size="X-Large" Visible="false" runat="server" Text='<%# Bind("Sunday") %>'></asp:Label>
                                <asp:Label ID="lbl7content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Font-Size="X-Small" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Sunday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
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
                                    <asp:Label ID="lbl8specialpoints" Visible='<%# Eval("Context").ToString() == "Special_Points" ? true : false %>' runat="server" Text='<%# Bind("Total") %>'></asp:Label>
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



            <asp:Panel ID="Panel2" runat="server" Visible="false" ScrollBars="Auto">
                <div class="container">


                    <div class="text-center">
                        <h2>
                            <asp:Label ID="lblselecteddate" runat="server" Text="date"></asp:Label></h2>
                        <asp:Button ID="Button3" CssClass="btn btn-primary" runat="server" Text="back to calendar" OnClick="Button3_Click" />
                    </div>

                    <ul class="nav nav-tabs">
                        <li class="active"><a data-toggle="tab" href="#Frame">Frame</a></li>
                        <li><a data-toggle="tab" href="#Screen">Screen</a></li>
                    </ul>
                    <div class="tab-content">
                        <div id="Frame" class="tab-pane fade in active">
                            <asp:GridView ID="GridView4" CssClass="table" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" GridLines="Vertical" ForeColor="Black">
                                <AlternatingRowStyle BackColor="White" />
                                <Columns>

                                    <asp:TemplateField HeaderText="Project">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemproject" runat="server" Text='<%# Bind("project_label") %>'></asp:Label><br />
                                            <asp:Label ID="lblitemaddress" Font-Size="Smaller" CssClass="text-muted" runat="server" Text='<%# Bind("fulladd") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="K#/Location">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemKno" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                            <asp:Label ID="lblitemLocation" Font-Size="Smaller" CssClass="text-muted" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemDescription" runat="server" Text='<%# Bind("Description") %>'></asp:Label><br />
                                            <span class="text-muted">(<asp:Label ID="lblitemWidth" Font-Size="Smaller" CssClass="text-muted" runat="server" Text='<%# Bind("Width") %>'></asp:Label>&nbsp; x &nbsp;
                                   <asp:Label ID="lblitemHeight" Font-Size="Smaller" CssClass="text-muted" runat="server" Text='<%# Bind("Height") %>'></asp:Label>)</span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="CL number">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemCLNO" runat="server" Text='<%# Bind("CLNO") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Due_Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemDuedate" runat="server" Text='<%# Bind("due_date") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="New_Due_Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemNewDuedate" runat="server" Text='<%# Bind("New_Due_Date") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="">
                                        <ItemTemplate>
                                            <asp:Label ID="g4Id" Visible="false" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                                            <asp:CheckBox ID="cboxSelectitem" CssClass="form-control" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Points">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemPoints" CssClass='<%# Eval("Special_system").ToString() == "Yes" ? "label label-primary" : "" %>' runat="server" Text='<%# Bind("points") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#CCCC99" />
                                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle BackColor="#F7F7DE" />
                                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                                <SortedAscendingHeaderStyle BackColor="#848384" />
                                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                                <SortedDescendingHeaderStyle BackColor="#575357" />
                            </asp:GridView>
                            <div class="row">
                                <div class="col-sm-3"></div>
                                <div class="col-sm-3" style="height: 100%;">
                                    <div class="well">
                                        <h3>Reschedule checked items</h3>
                                        <span>Schedule</span><br />
                                        <asp:TextBox ID="tboxitemNewDueDate" ValidationGroup="x1" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox><br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tboxitemNewDueDate" ForeColor="Red" ValidationGroup="x1" runat="server" ErrorMessage="Schedule is a required field"></asp:RequiredFieldValidator>
                                        <br />
                                        <asp:Button ID="Button1" CssClass="btn btn-primary" ValidationGroup="x1" runat="server" Text="save" OnClick="Button1_Click" />
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="well">
                                        <h3>Reschedule cutting list</h3>
                                        <span>Cutting list</span><br />
                                        <asp:DropDownList ID="ddlClList" runat="server" ValidationGroup="x2" CssClass="form-control"></asp:DropDownList><br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ForeColor="Red" ControlToValidate="ddlClList" ValidationGroup="x2" runat="server" ErrorMessage="cutting list no. is required"></asp:RequiredFieldValidator>
                                        <br />
                                        <span>Schedule</span><br />
                                        <asp:TextBox ID="tboxitemNewDueDate2" CssClass="form-control" ValidationGroup="x2" TextMode="Date" runat="server"></asp:TextBox><br />
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ForeColor="Red" ControlToValidate="tboxitemNewDueDate2" ValidationGroup="x2" runat="server" ErrorMessage="Schedule is a required field"></asp:RequiredFieldValidator>
                                        <br />
                                        <asp:Button ID="Button2" CssClass="btn btn-warning" ValidationGroup="x2" runat="server" Text="save" OnClick="Button2_Click" />
                                    </div>
                                </div>
                                <div class="col-sm-3"></div>
                            </div>
                        </div>
                        <div id="Screen" class="tab-pane fade">
                            <asp:GridView ID="GridView5" CssClass="table" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                                <Columns>
                                    <asp:TemplateField HeaderText="Project">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemproject" runat="server" Text='<%# Bind("project_label") %>'></asp:Label><br />
                                            <asp:Label ID="lblitemaddress" Font-Size="Smaller" CssClass="text-muted" runat="server" Text='<%# Bind("fulladd") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="K#/Location">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemKno" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                            <asp:Label ID="lblitemLocation" Font-Size="Smaller" CssClass="text-muted" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Description">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemDescription" runat="server" Text='<%# Bind("Description") %>'></asp:Label><br />
                                            <span class="text-muted">(<asp:Label ID="lblitemWidth" Font-Size="Smaller" CssClass="text-muted" runat="server" Text='<%# Bind("Width") %>'></asp:Label>&nbsp; x &nbsp;
                                   <asp:Label ID="lblitemHeight" Font-Size="Smaller" CssClass="text-muted" runat="server" Text='<%# Bind("Height") %>'></asp:Label>)</span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Due_Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemDuedate" runat="server" Text='<%# Bind("due_date") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Points">
                                        <ItemTemplate>
                                            <asp:Label ID="lblitemPoints" runat="server" Text='<%# Bind("points") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                                <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                                <RowStyle BackColor="White" ForeColor="#330099" />
                                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                                <SortedAscendingCellStyle BackColor="#FEFCEB" />
                                <SortedAscendingHeaderStyle BackColor="#AF0101" />
                                <SortedDescendingCellStyle BackColor="#F6F0C0" />
                                <SortedDescendingHeaderStyle BackColor="#7E0000" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
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
                            <asp:GridView ID="GridView2" CssClass="table" GridLines="None" AutoGenerateColumns="False" runat="server" OnRowDataBound="GridView2_RowDataBound">
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



            <div class="row">
                <div class="col-sm-6">
                    <asp:Panel ID="Panel3" runat="server">
                        <asp:GridView ID="GridView6" Width="100%" AutoGenerateColumns="False" runat="server" ShowHeader="False" GridLines="None">
                            <Columns>
                                <asp:TemplateField HeaderText="Month Capacity">
                                    <ItemTemplate>
                                        <div class="panel panel-primary" style="font-size: large; width: 600px;">
                                            <div class="panel panel-heading">
                                                <div class="text-center">
                                                    <h3>STATISTICS</h3>
                                                </div>
                                            </div>
                                            <div class="panel panel-body">
                                                <div class="text-center">
                                                    <span>
                                                        <asp:Label ID="Label5" Font-Size="Large" runat="server" Text='<%# Bind("MyDate") %>'></asp:Label></span>
                                                </div>
                                                <div style="padding: 20px;">
                                                    <span>Month's Points Capacity</span>
                                                    <span class="pull-right text-right">
                                                        <span>
                                                            <asp:Label ID="lblMonthCapacity" Font-Size="Large" runat="server" Text='<%# Bind("MonthCapacity") %>'></asp:Label></span><br />
                                                        <span>
                                                            <asp:Label ID="Label1" Font-Size="Large" runat="server" Text='<%# Bind("BalanceFab") %>'></asp:Label></span><br />
                                                        <span>
                                                            <asp:Label ID="Label2" Font-Size="Large" runat="server" Text='<%# Bind("AvailablePoints") %>'></asp:Label></span>
                                                    </span>
                                                    <br />
                                                    <span>Balance Fab Points</span><br />
                                                    <span>Free Points</span><br />
                                                </div>

                                                <hr />
                                                <div class="text-center">
                                                    <span>
                                                        <h1><strong>
                                                            <asp:Label ID="Label4" class='<%# Eval("Note").ToString()=="Delay" ? "text-danger" : "text-primary" %>' runat="server" Text='<%# Bind("AvailablePointsInDays") %>'></asp:Label>&nbsp; Day(s)</strong></h1>
                                                        <asp:Label ID="Label6" class='<%# Eval("Note").ToString()=="Delay" ? "text-danger" : "text-primary" %>' runat="server" Text='<%# Bind("Note") %>'></asp:Label>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="panel panel-footer">
                                                <div class="text-center">
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("TheoreticalPoints") %>'></asp:Label><br />
                                                    <span class="text-muted">Theoretical Points</span>
                                                </div>
                                            </div>

                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </div>
                <div class="col-sm-6">
                    <asp:GridView ID="GridView3" CssClass="table" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="Both" OnRowDataBound="GridView3_RowDataBound" PageSize="20">
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
                </div>
            </div>


        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
