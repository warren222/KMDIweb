﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Glass_Notif_List.aspx.cs" MasterPageFile="~/KMDIweb/GlassNotification/GlassNotificationMaster.Master" Inherits="KMDIweb.KMDIweb.GlassNotification.Glass_Notif_List" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Glass | Notification</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }

        .bcRed {
            background-color: red;
            color: white;
        }

        .bcOrange {
            background-color: orange;
            color: black;
        }

        .bcBlue {
            background-color: aqua;
            color: black;
        }

        .bcYellow {
            background-color: yellow;
            color: black;
        }
    </style>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>Glass Notifications</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="row nopm">
            <div class="col-sm-6 nopm">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvSummary" ShowHeader="false" GridLines="None" Width="100%" AutoGenerateColumns="false" runat="server" OnRowCommand="gvSummary_RowCommand" OnRowDataBound="gvSummary_RowDataBound" AllowPaging="True" PageSize="1">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <table border="1" style="border-color: bisque;" class="wf_tbl">
                                            <tr>
                                                <th style="background-color: whitesmoke" class="text-center" colspan="4">For Signature</th>
                                                <th style="background-color: whitesmoke" class="text-center">Signed</th>
                                            </tr>

                                            <tr class="text-center" style="padding: 2px;">
                                                <td style="width: 100px; padding: 2px;">Prepared By<br />
                                                    (Glass)</td>
                                                <td style="width: 100px; padding: 2px;">Noted By<br />
                                                    (Sir. Mon)</td>
                                                <td style="width: 100px; padding: 2px;">Received By<br />
                                                    (Delivery)</td>
                                                <td style="width: 100px; padding: 2px;">Noted By<br />
                                                    (Sr. Cule)</td>
                                                <td style="width: 100px; padding: 2px;">All</td>
                                            </tr>
                                            <tr class="text-center">
                                                <td>
                                                    <asp:LinkButton ID="btnPreparedBy" CssClass='<%# Eval("Notif_Prepared_By").ToString() == "0" ? "" : "badge bcBlue" %>' CommandName="PreparedBy" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Prepared_By") %></span></asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="btnNotedByPM" CssClass='<%# Eval("Notif_Noted_By_PM").ToString() == "0" ? "" : "badge bcRed" %>' CommandName="NotedBy" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Noted_By_PM") %></span></asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="btnReceivedBy" CssClass='<%# Eval("Notif_Received_By").ToString() == "0" ? "" : "badge bcOrange" %>' CommandName="ReceivedBy" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Received_By") %></span></asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="btnNotedByIM" CssClass='<%# Eval("Notif_Noted_By_IM").ToString() == "0" ? "" : "badge bcYellow" %>' CommandName="NotedBySirCule" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Noted_By_IM") %></span></asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="btnSigned" CssClass='<%# Eval("Notif_Signed").ToString() == "0" ? "" : "" %>' CommandName="SignedNotifications" Style="font-size: xx-large; color: green" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Signed") %></span></asp:LinkButton></td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="col-sm-6 nopm">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <div class="well">
                            <div class="row nopm">
                                <div class="col-sm-4">
                                    <span>Date Filter</span>
                                    <asp:DropDownList runat="server" ID="ddlDateFilter" CssClass="form-control">
                                        <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                        <asp:ListItem Value="Date Prepared" Text="Date Prepared"></asp:ListItem>
                                        <asp:ListItem Value="Date Noted PM" Text="Date Noted (Engr. Mon)"></asp:ListItem>
                                        <asp:ListItem Value="Date Received" Text="Date Received"></asp:ListItem>
                                        <asp:ListItem Value="Date Noted IM" Text="Date Noted (Engr. Cule)"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-8">
                                    <span>Date</span>
                                    <asp:TextBox runat="server" ID="tboxDate" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row nopm">
                                <div class="col-sm-4">
                                    <asp:Label ID="lblForSignature" runat="server">For Signature</asp:Label>
                                    <asp:DropDownList ID="ddlForSignature" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                        <asp:ListItem Value="Prepared By" Text="Prepared By"></asp:ListItem>
                                        <asp:ListItem Value="Noted By PM" Text="Noted By (Engr. Mon)"></asp:ListItem>
                                        <asp:ListItem Value="Received By" Text="Received By"></asp:ListItem>
                                        <asp:ListItem Value="Noted By IM" Text="Noted By (Engr. Cule)"></asp:ListItem>
                                        <asp:ListItem Value="Signed Notifications" style="color: green; font-weight: bold; font-style: italic;" Text="Signed Notifications"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-8">
                                    <span>Search</span>
                                    <div class="input-group">
                                        <asp:TextBox runat="server" ID="tboxFind" CssClass="form-control"></asp:TextBox>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-danger" Style="background-color: #ff006e; border-color: #ff006e" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div class="container">
            <asp:LinkButton ID="btnCreate" runat="server" CssClass="btn btn-default"
                OnClick="btnCreate_Click">Create New Notification</asp:LinkButton>
        </div>


        <div class="container">
            <div style="overflow-x: auto">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvGlassNotifList" runat="server" Width="100%"
                            OnPageIndexChanging="gvGlassNotifList_PageIndexChanging"
                            AutoGenerateColumns="false" GridLines="None" AllowPaging="True" Style="min-width: 700px;"
                            OnRowCommand="gvGlassNotifList_RowCommand" OnRowDataBound="gvGlassNotifList_RowDataBound">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="panel panel-danger" style='border-color: <%# Eval("Noted_By_IM").ToString() != "" ? "#80ffa2" : 
                                                                                   Eval("Received_By").ToString() != "" ? "#eeff80" :
                                                                                   Eval("Noted_By_PM").ToString() != "" ? "#ffc080" :
                                                                                   Eval("Prepared_By").ToString() != "" ? "#ff8080" :
                                                                                   "#80f0ff" %>'>
                                            <div class="panel-heading" style='color: black ; background-color: <%# Eval("Noted_By_IM").ToString() != "" ? "#80ffa2" : 
                                                                                   Eval("Received_By").ToString() != "" ? "#eeff80" :
                                                                                   Eval("Noted_By_PM").ToString() != "" ? "#ffc080" :
                                                                                   Eval("Prepared_By").ToString() != "" ? "#ff8080" :
                                                                                   "#80f0ff" %>'>
                                                <asp:Label runat="server" ID="lblId" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                                <asp:Label runat="server" ID="lblNoted_By_PM" Visible="false" Text='<%# Bind("Noted_By_PM") %>'></asp:Label>
                                                <asp:Label runat="server" ID="lblNoted_By_IM" Visible="false" Text='<%# Bind("Noted_By_IM") %>'></asp:Label>
                                                <asp:Label runat="server" ID="lblPO" Visible="false" Text='<%# Bind("PO") %>'></asp:Label>
                                                <asp:Label runat="server" ID="lblJO" Visible="false" Text='<%# Bind("JO") %>'></asp:Label>
                                                <asp:Label runat="server" ID="lblControl_No" Text='<%# Bind("Control_No") %>'></asp:Label>
                                                <span class="pull-right">
                                                    <asp:LinkButton runat="server" ID="btnDelete" Visible="false" CommandName="execDelete" OnClientClick="return confirm('Do you want to delete this notification?')"><span class="glyphicon glyphicon-remove"></span></asp:LinkButton>
                                                </span>
                                            </div>
                                            <div class="panel-body">
                                                <asp:LinkButton ID="btnProject_Name" CommandName="view_notification" runat="server">
                                        <span style="font-size: large; font-weight: bold;"><%# Eval("Project_Name") %></span>
                                                </asp:LinkButton>
                                                <span class="pull-right text-right">
                                                    <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" CommandName="execEdit"></asp:LinkButton>

                                                </span>
                                                <br />
                                                <span style="font-size: small"><%# Eval("Supplier") %></span><br />
                                                <span style="font-size: small"><%# Eval("PO") %></span><br />
                                                <span style="font-size: small;" class="text-muted"><%# Eval("Date_Filed") %></span><br />
                                                <asp:LinkButton ID="btnReceivingUpdate" runat="server" Visible="false" Text="Add Updates" CssClass="btn btn-success" style="padding:5px;"
                                                    CommandName="execReceivingUpdate"></asp:LinkButton>
                                            </div>
                                            <div class="row nopm">
                                                <div class="col-xs-3 nopm">
                                                    <asp:Image ID="Image1" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/Glass_Notification/" + Eval("Control_No").ToString() + "/Signatures/Prepared_By.jpg" %>' />
                                                    <br />
                                                    <span><%# Eval("Prepared_By") %></span><br />
                                                    <span style="font-size: smaller"><%# Eval("Prepared_By_Date") %></span><br />
                                                    <span class="text-muted">Prepared by:</span>
                                                </div>
                                                <div class="col-xs-3 nopm">
                                                    <asp:Image ID="Image2" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/Glass_Notification/" + Eval("Control_No").ToString() + "/Signatures/Noted_By_PM.jpg" %>' />
                                                    <br />
                                                    <span><%# Eval("Noted_By_PM") %></span><br />
                                                    <span style="font-size: smaller"><%# Eval("Noted_By_PM_Date") %></span><br />
                                                    <span class="text-muted">Noted by:</span>
                                                </div>
                                                <div class="col-xs-3 nopm">
                                                    <asp:Image ID="Image3" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/Glass_Notification/" + Eval("Control_No").ToString() + "/Signatures/Received_By.jpg" %>' />
                                                    <br />
                                                    <span><%# Eval("Received_By") %></span><br />
                                                    <span style="font-size: smaller"><%# Eval("Received_By_Date") %></span><br />
                                                    <span class="text-muted">Received by:</span>
                                                </div>
                                                <div class="col-xs-3 nopm">
                                                    <asp:Image ID="Image4" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/Glass_Notification/" + Eval("Control_No").ToString() + "/Signatures/Noted_By_IM.jpg" %>' />
                                                    <br />
                                                    <span><%# Eval("Noted_By_IM") %></span><br />
                                                    <span style="font-size: smaller"><%# Eval("Noted_By_IM_Date") %></span><br />
                                                    <span class="text-muted">Noted by:</span>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="alert alert-info">
                                    <h3><strong>Empty Table!</strong>
                                    </h3>
                                </div>
                            </EmptyDataTemplate>
                            <EditRowStyle BorderStyle="None" BorderWidth="0px" />
                            <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                            <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
