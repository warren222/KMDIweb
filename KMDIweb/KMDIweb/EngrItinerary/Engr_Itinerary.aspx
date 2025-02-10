<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/EngrItinerary/EngrItineraryMaster.Master" CodeBehind="Engr_Itinerary.aspx.cs" Inherits="KMDIweb.KMDIweb.EngrItinerary.Engr_Itinerary" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Engineers' | Itinerary</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }

        .wf_body {
            /*background-color: #323232;*/
            background-image: url('../Images/446.jpg');
            background-size: 350px;
            background-position: center top;
            background-repeat: repeat;
            /*background-size: 100%;*/
            /*color: rgba(226, 238, 239, 0.5);*/
            color: white;
            border-top: solid 5px #ff006e;
            border-bottom: solid 5px #ff006e;
            /*font-family: Bahnschrift;*/
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color:aliceblue;">


        <div class="well" style="background-color: #303030; border-color: transparent; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>Engineers' Itinerary Calendar</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="row nopm">
            <div class="col-sm-6 nopm">
            </div>
            <div class="col-sm-6 nopm">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="well" style="border-color: transparent;">
                            <div class="row nopm">
                                <div class="col-sm-4 nopm">
                                    <span>Engineer</span>
                                    <asp:DropDownList ID="ddlEngr" Style="border-radius: 0" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                                <div class="col-sm-3 nopm">
                                    <span>Report</span>
                                    <asp:DropDownList runat="server" Style="border-radius: 0" CssClass="form-control" ID="ddlHasReport">
                                        <asp:ListItem Value="1" Text="w/"></asp:ListItem>
                                        <asp:ListItem Value="0" Text="w/o"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-5 nopm">
                                    <span>Month</span>
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddlMonth" Style="border-radius: 0" Width="60%" runat="server" CssClass="form-control">
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
                                        <asp:DropDownList ID="ddlYear" Style="border-radius: 0" runat="server" Width="40%" CssClass="form-control"></asp:DropDownList>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-danger"
                                                Style="background-color: #ff006e; border-color: #ff006e" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="wf_body">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="wf_selected_header">
                        <span class=" FontXLarge">
                            <asp:Label ID="lblSelectedMonth" runat="server" Font-Size="X-Large"></asp:Label>
                        </span>
                    </div>
                    <div style="overflow-x: auto">
                        <asp:GridView runat="server" AutoGenerateColumns="false" CssClass="wf_calendar" GridLines="None" ID="gvCalendar" OnRowDataBound="gvCalendar_RowDataBound" OnRowCommand="gvCalendar_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="Monday" ItemStyle-Wrap="true">
                                    <ItemTemplate>
                                        <asp:Label ID="lblContext" Visible="false" runat="server" Text='<%# Bind("Context") %>'></asp:Label>
                                        <asp:Label ID="lblSelected_Month" Visible="false" runat="server" Text='<%# Bind("Selected_Month") %>'></asp:Label>


                                        <asp:Panel runat="server" ID="pnl1" Style="min-width: 167px; white-space: normal;" CssClass='<%# Eval("Sorter").ToString() == "2" && (Eval("Context").ToString() == "Content" && Eval("Monday").ToString() != "") ? "wf_calendar_content5" :"" %>'>
                                            <asp:LinkButton ID="linkbtn1" CommandName="viewlistMon" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                         <span class="FontSmall">
                                             <%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Monday")).ToString("ddd") : "" %></span>
                                        <span class="wf_calendar_date"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Monday")).ToString("dd") : "" %></span>
                                            </asp:LinkButton>
                                            <asp:Label ID="lbl1date" Visible="false" runat="server" Text='<%# Bind("Monday") %>'></asp:Label>
                                            <div class="text-left FontMedium">
                                                <asp:Label ID="lbl1content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Monday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                                            </div>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="True"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tuesday" ItemStyle-Wrap="true">
                                    <ItemTemplate>
                                        <asp:Panel runat="server" ID="pnl2" Style="min-width: 167px; white-space: normal;" class='<%# Eval("Sorter").ToString() == "2" && (Eval("Context").ToString() == "Content" && Eval("Tuesday").ToString() != "") ? "wf_calendar_content5" :"" %>'>
                                            <asp:LinkButton ID="linkbtn2" CommandName="viewlistTue" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                         <span class="FontSmall"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Tuesday")).ToString("ddd") : "" %></span>
                                        <span class="wf_calendar_date"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Tuesday")).ToString("dd") : "" %></span>
                                            </asp:LinkButton>
                                            <asp:Label ID="lbl2date" Visible="false" runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                                            <div class="text-left FontMedium">
                                                <asp:Label ID="lbl2content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Tuesday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                                            </div>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="True"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Wednesday" ItemStyle-Wrap="true">
                                    <ItemTemplate>
                                        <asp:Panel runat="server" ID="pnl3" Style="min-width: 167px;" class='<%# Eval("Sorter").ToString() == "2" && (Eval("Context").ToString() == "Content" && Eval("Wednesday").ToString() != "") ? "wf_calendar_content5" :"" %>'>
                                            <asp:LinkButton ID="linkbtn3" CommandName="viewlistWed" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                         <span class="FontSmall"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Wednesday")).ToString("ddd") : "" %></span>
                                        <span class="wf_calendar_date"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Wednesday")).ToString("dd") : "" %></span>
                                            </asp:LinkButton>
                                            <asp:Label ID="lbl3date" Visible="false" runat="server" Text='<%# Bind("Wednesday") %>'></asp:Label>
                                            <div class="text-left FontMedium">
                                                <asp:Label ID="lbl3content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Wednesday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                                            </div>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="True"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Thursday" ItemStyle-Wrap="true">
                                    <ItemTemplate>
                                        <asp:Panel runat="server" ID="pnl4" Style="min-width: 167px;" class='<%# Eval("Sorter").ToString() == "2" && (Eval("Context").ToString() == "Content" && Eval("Thursday").ToString() != "") ? "wf_calendar_content5" :"" %>'>
                                            <asp:LinkButton ID="linkbtn4" CommandName="viewlistThu" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                         <span class="FontSmall"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Thursday")).ToString("ddd") : "" %></span>
                                        <span class="wf_calendar_date"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Thursday")).ToString("dd") : "" %></span>
                                            </asp:LinkButton>
                                            <asp:Label ID="lbl4date" Visible="false" runat="server" Text='<%# Bind("Thursday") %>'></asp:Label>
                                            <div class="text-left FontMedium">
                                                <asp:Label ID="lbl4content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Thursday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                                            </div>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="True"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Friday" ItemStyle-Wrap="true">
                                    <ItemTemplate>
                                        <asp:Panel runat="server" ID="pnl5" Style="min-width: 167px;" class='<%# Eval("Sorter").ToString() == "2" && (Eval("Context").ToString() == "Content" && Eval("Friday").ToString() != "") ? "wf_calendar_content5" :"" %>'>
                                            <asp:LinkButton ID="linkbtn5" CommandName="viewlistFri" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                         <span class="FontSmall"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Friday")).ToString("ddd") : "" %></span>
                                        <span class="wf_calendar_date"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Friday")).ToString("dd") : "" %></span>
                                            </asp:LinkButton>
                                            <asp:Label ID="lbl5date" Visible="false" runat="server" Text='<%# Bind("Friday") %>'></asp:Label>
                                            <div class="text-left FontMedium">
                                                <asp:Label ID="lbl5content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Friday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                                            </div>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="True"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Saturday" ItemStyle-Wrap="true">
                                    <ItemTemplate>
                                        <asp:Panel runat="server" ID="pnl6" Style="min-width: 167px;" class='<%# Eval("Sorter").ToString() == "2" && (Eval("Context").ToString() == "Content" && Eval("Saturday").ToString() != "") ? "wf_calendar_content5" :"" %>'>
                                            <asp:LinkButton ID="linkbtn6" CommandName="viewlistSat" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                         <span class="FontSmall"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Saturday")).ToString("ddd") : "" %></span>
                                        <span class="wf_calendar_date"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Saturday")).ToString("dd") : "" %></span>
                                            </asp:LinkButton>
                                            <asp:Label ID="lbl6date" Visible="false" runat="server" Text='<%# Bind("Saturday") %>'></asp:Label>
                                            <div class="text-left FontMedium">
                                                <asp:Label ID="lbl6content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Saturday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                                            </div>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="True"></ItemStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sunday" HeaderStyle-Width="200px" ItemStyle-Wrap="true">
                                    <ItemTemplate>
                                        <asp:Panel runat="server" ID="pnl7" Style="min-width: 167px;" class='<%# Eval("Sorter").ToString() == "2" && (Eval("Context").ToString() == "Content" && Eval("Sunday").ToString() != "") ? "wf_calendar_content5" :"" %>'>
                                            <asp:LinkButton ID="linkbtn7" CommandName="viewlistSun" ForeColor="Red" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                         <span class="FontSmall"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Sunday")).ToString("ddd") : "" %></span>
                                        <span class="wf_calendar_date"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Sunday")).ToString("dd") : "" %></span>
                                            </asp:LinkButton>
                                            <asp:Label ID="lbl7date" Visible="false" runat="server" Text='<%# Bind("Sunday") %>'></asp:Label>
                                            <div class="text-left FontMedium">
                                                <asp:Label ID="lbl7content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Sunday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                                            </div>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="True"></ItemStyle>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
