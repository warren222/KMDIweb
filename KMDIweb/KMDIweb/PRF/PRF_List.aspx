<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/PRF/PRF_Master.Master" CodeBehind="PRF_List.aspx.cs" Inherits="KMDIweb.KMDIweb.PRF.PRF_List" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PRF | List</title>
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
                <h3>Purchase Request Form List</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="row nopm">
            <div class="col-sm-6 nopm">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvSummary" ShowHeader="false" GridLines="None" Width="100%" AutoGenerateColumns="false" runat="server" AllowPaging="True" PageSize="1" OnRowCommand="gvSummary_RowCommand">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <table border="1" style="border-color: bisque;" class="wf_tbl">
                                            <tr>
                                                <th style="background-color: whitesmoke" class="text-center" colspan="4">For Signature</th>
                                                <th style="background-color: whitesmoke" class="text-center">Signed</th>
                                            </tr>

                                            <tr class="text-center" style="padding: 2px;">
                                                <td style="width: 100px; padding: 2px;">Requested By</td>
                                                <td style="width: 100px; padding: 2px;">Noted By</td>
                                                <td style="width: 100px; padding: 2px;">Received By</td>
                                                <td style="width: 100px; padding: 2px;">Approved By</td>
                                                <td style="width: 100px; padding: 2px;">All</td>
                                            </tr>
                                            <tr class="text-center">
                                                <td>
                                                    <asp:LinkButton ID="btnRequestedBy" CssClass='<%# Eval("Notif_Requested_By").ToString() == "0" ? "" : "badge bcBlue" %>' CommandName="RequestedBy" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Requested_By") %></span></asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="btnNotedBy" CssClass='<%# Eval("Notif_Noted_By").ToString() == "0" ? "" : "badge bcRed" %>' CommandName="NotedBy" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Noted_By") %></span></asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="btnReceivedBy" CssClass='<%# Eval("Notif_Received_By").ToString() == "0" ? "" : "badge bcOrange" %>' CommandName="ReceivedBy" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Received_By") %></span></asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="btnApprovedBy" CssClass='<%# Eval("Notif_Approved_By").ToString() == "0" ? "" : "badge bcYellow" %>' CommandName="ApprovedBy" Font-Bold="true" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Approved_By") %></span></asp:LinkButton></td>
                                                <td>
                                                    <asp:LinkButton ID="btnSigned" CssClass='<%# Eval("Notif_Signed").ToString() == "0" ? "" : "" %>' CommandName="SignedPRFs" Style="font-size: xx-large; color: green" runat="server"><span style="font-size: xx-large;"><%# Eval("Notif_Signed") %></span></asp:LinkButton></td>
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
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="well">
                            <div class="row nopm">
                                <div class="col-sm-4">
                                    <span>Date Filter</span>
                                    <asp:DropDownList runat="server" ID="ddlDateFilter" CssClass="form-control">
                                        <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                        <asp:ListItem Value="Date Requested" Text="Date Requested"></asp:ListItem>
                                        <asp:ListItem Value="Date Noted" Text="Date Noted"></asp:ListItem>
                                        <asp:ListItem Value="Date Received" Text="Date Received"></asp:ListItem>
                                        <asp:ListItem Value="Date Approved" Text="Date Approved"></asp:ListItem>
                                        <asp:ListItem Value="Due Date" Text="Due Date"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-sm-8">
                                    <span>Date</span>
                                    <asp:TextBox runat="server" ID="tboxDate" TextMode="Date" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row nopm">
                                <div class="col-sm-4">
                                    <span>For Signature</span>
                                    <asp:DropDownList ID="ddlForSignature" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                        <asp:ListItem Value="Requested By" Text="Requested By"></asp:ListItem>
                                        <asp:ListItem Value="Noted By" Text="Noted By"></asp:ListItem>
                                        <asp:ListItem Value="Received By" Text="Received By"></asp:ListItem>
                                        <asp:ListItem Value="Approved By" Text="Approved By"></asp:ListItem>
                                        <asp:ListItem Value="Signed PRFs" style="color: green; font-weight: bold; font-style: italic;" Text="Signed PRFs"></asp:ListItem>
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
                OnClick="btnCreate_Click">Create New PRF</asp:LinkButton>
        </div>
        <br />
        <div class="container">
            <div style="overflow-x: auto">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvList" runat="server" GridLines="None" ShowHeader="false" Width="100%" AutoGenerateColumns="false"
                            OnRowCommand="gvList_RowCommand" AllowPaging="True" OnPageIndexChanging="gvList_PageIndexChanging">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <div class="panel panel-danger" style='border-color: <%# Eval("Approved_By").ToString() != "" ? "#80ffa2" : 
                                                                                   Eval("Received_By").ToString() != "" ? "#eeff80" :
                                                                                   Eval("Noted_By").ToString() != "" ? "#ffc080" :
                                                                                   Eval("Requested_By_Date").ToString() != "" ? "#ff8080" :
                                                                                   "#80f0ff" %>'>
                                                <div class="panel-heading" style='color: black; background-color: <%# Eval("Approved_By").ToString() != "" ? "#80ffa2" : 
                                                                                   Eval("Received_By").ToString() != "" ? "#eeff80" :
                                                                                   Eval("Noted_By").ToString() != "" ? "#ffc080" :
                                                                                   Eval("Requested_By_Date").ToString() != "" ? "#ff8080" :
                                                                                   "#80f0ff" %>'>
                                                    <span><%# Eval("Date_Inputted") %></span>
                                                    <span class="pull-right">
                                                        <asp:LinkButton runat="server" ID="btnDelete" CommandName="execDelete" OnClientClick="return confirm('delete this item?')"><span class="glyphicon glyphicon-remove"></span></asp:LinkButton>
                                                    </span>
                                                </div>
                                                <div class="panel-body">
                                                    <asp:Label runat="server" Visible="false" ID="lblId" Text='<%# Bind("Id") %>'></asp:Label>
                                                    <span style="font-size: xx-large">
                                                        <asp:LinkButton runat="server" ID="btnControlNo" ForeColor="Black" CommandName="execReport" Text='<%# Bind("Control_No") %>'></asp:LinkButton>
                                                    </span>
                                                    <span class="pull-right">
                                                        <asp:LinkButton runat="server" ID="btnEdit" CommandName="execEdit">Edit</asp:LinkButton>
                                                    </span>
                                                    <br />
                                                    <span><%# Eval("Due_Date") %></span>
                                                </div>
                                                <div class="row nopm">
                                                    <div class="col-xs-3 nopm">
                                                        <asp:Image ID="Image1" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/PRF/" + Eval("Id").ToString() + "/Signatures/Requested_By.jpg" %>' />
                                                        <br />
                                                        <span><%# Eval("Requested_By") %></span><br />
                                                        <span style="font-size: smaller"><%# Eval("Requested_By_Date") %></span><br />
                                                        <span class="text-muted">Requested by:</span>
                                                    </div>
                                                    <div class="col-xs-3 nopm">
                                                        <asp:Image ID="Image2" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/PRF/" + Eval("Id").ToString() + "/Signatures/Noted_By.jpg" %>' />
                                                        <br />
                                                        <span><%# Eval("Noted_By") %></span><br />
                                                        <span style="font-size: smaller"><%# Eval("Noted_By_Date") %></span><br />
                                                        <span class="text-muted">Noted by:</span>
                                                    </div>
                                                    <div class="col-xs-3 nopm">
                                                        <asp:Image ID="Image3" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/PRF/" + Eval("Id").ToString() + "/Signatures/Received_By.jpg" %>' />
                                                        <br />
                                                        <span><%# Eval("Received_By") %></span><br />
                                                        <span style="font-size: smaller"><%# Eval("Received_By_Date") %></span><br />
                                                        <span class="text-muted">Received by:</span>
                                                    </div>
                                                    <div class="col-xs-3 nopm">
                                                        <asp:Image ID="Image4" Width="100" Height="60" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/WMS/PRF/" + Eval("Id").ToString() + "/Signatures/Approved_By.jpg" %>' />
                                                        <br />
                                                        <span><%# Eval("Approved_By") %></span><br />
                                                        <span style="font-size: smaller"><%# Eval("Approved_By_Date") %></span><br />
                                                        <span class="text-muted">Approved by:</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="">
                                    <h3><strong>Sorry! No result found :(</strong>
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
