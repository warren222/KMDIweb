<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/EngrItinerary/EngrItineraryMaster.Master" CodeBehind="Engr_Itinerary.aspx.cs" Inherits="KMDIweb.KMDIweb.EngrItinerary.Engr_Itinerary" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Engineers' | Itinerary</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
        <div class="container">
            <h3>Engineers' Itinerary</h3>
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
                    <div class="well">
                        <div class="row nopm">
                            <div class="col-sm-6 nopm">
                                <span>Engineer</span>
                                <asp:DropDownList ID="ddlEngr" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-sm-6 nopm">
                                <span>Month</span>
                                <div class="input-group">
                                    <asp:DropDownList ID="ddlMonth" Width="60%" runat="server" CssClass="form-control">
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
                                    <asp:TextBox ID="tboxYear" runat="server" Width="40%" CssClass="form-control" TextMode="Number" MaxLength="3000"></asp:TextBox>
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
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView runat="server" AutoGenerateColumns="false" ID="gvCalendar">
                <Columns>
                    <asp:TemplateField HeaderText="Monday" ItemStyle-Wrap="true">
                        <ItemTemplate>
                            <div style="min-width: 167px; white-space: normal;">
                                <asp:LinkButton ID="linkbtn1" CommandName="viewlistMon" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                         <span class="FontSmall">
                                             <%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Monday")).ToString("ddd") : "" %></span>
                                        <span class="wf_calendar_date"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Monday")).ToString("dd") : "" %></span>
                                </asp:LinkButton>
                                <asp:Label ID="lbl1date" Visible="false" runat="server" Text='<%# Bind("Monday") %>'></asp:Label>
                                <div class="text-left">
                                    <asp:Label ID="lbl1content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Monday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Tuesday" ItemStyle-Wrap="true">
                        <ItemTemplate>
                            <div style="min-width: 167px; white-space: normal;">
                                <asp:LinkButton ID="linkbtn2" CommandName="viewlistTue" runat="server" Font-Bold="true" Font-Size="X-Large" Visible='<%# Eval("Context").ToString() == "Date" ? true : false %>'>
                                         <span class="FontSmall"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Tuesday")).ToString("ddd") : "" %></span>
                                        <span class="wf_calendar_date"><%# Eval("Context").ToString() == "Date" ? Convert.ToDateTime(Eval("Tuesday")).ToString("dd") : "" %></span>
                                </asp:LinkButton>
                                <asp:Label ID="lbl2date" Visible="false" runat="server" Text='<%# Bind("Tuesday") %>'></asp:Label>
                                <div class="text-left">
                                    <asp:Label ID="lbl2content" Visible='<%# Eval("Context").ToString() == "Content" ? true : false %>' runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Tuesday").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
