<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/EngrItinerary/EngrItineraryMaster.Master" CodeBehind="Engr_Itinerary_Selected_Date.aspx.cs" Inherits="KMDIweb.KMDIweb.EngrItinerary.Engr_Itinerary_Selected_Date" %>

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

        .tblLocal {
            width: 100%;
            white-space: nowrap;
            white-space: nowrap;
        }

            .tblLocal th, tr, td {
                padding-left: 5px;
                padding-right: 5px;
                vertical-align: top;
            }
    </style>
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="">
        <div class="well" style="background-color: #303030; border-color: transparent; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>
                    <asp:Label ID="lblDate" runat="server"></asp:Label></h3>
            </div>
            <span class="pull-right">
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-warning" ForeColor="Black" OnClick="btnBack_Click"><span class="glyphicon glyphicon-chevron-left"></span> back</asp:LinkButton>
            </span>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="container">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div style="overflow-x: auto">
                        <asp:GridView ID="gvInstItinerary" runat="server" CssClass="tblLocal FontMedium" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Project">
                                    <ItemTemplate>
                                        <div style="min-width: 200px; white-space: normal;">
                                            <span><%# Eval("PROJECT") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Appt. Time">
                                    <ItemTemplate>
                                        <div style="min-width: 100px;" class="text-center">
                                            <span><%# Eval("Appttime") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Concern">
                                    <ItemTemplate>
                                        <div style="white-space: normal; min-width: 370px;">
                                            <span><%# Eval("Concern") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>

                    <div class="well well-sm">
                        <div class="row">
                            <div class="col-sm-6">
                                <span>Project</span>
                                <asp:TextBox ID="tboxDRProject" runat="server" CssClass="form-control"></asp:TextBox>
                                <span>Address</span>
                                <asp:TextBox ID="tboxDRAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                <div class="row nopm">
                                    <div class="col-xs-6 nopm">
                                        <span>Arrival</span>
                                        <asp:TextBox ID="tboxDRArrival" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                    </div>
                                    <div class="col-xs-6 nopm">
                                        <span>Depart</span>
                                        <asp:TextBox ID="tboxDRDepart" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                    </div>
                                </div>


                            </div>
                            <div class="col-sm-6">
                                <span>Remarks</span>
                                <asp:TextBox ID="tboxRemarks" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div style="overflow-x: auto">
                        <asp:GridView ID="gvDailyReport" runat="server" CssClass="tblLocal FontMedium" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDREdit" runat="server">Edit</asp:LinkButton>
                                        <asp:LinkButton ID="btnDRDelete" runat="server">Delete</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Project">
                                    <ItemTemplate>
                                        <div style="min-width: 200px; white-space: normal;">
                                            <span><%# Eval("PROJECT") %></span><br />
                                            <span><%# Eval("ADDRESS") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Arrval">
                                    <ItemTemplate>
                                        <div style="min-width: 100px;" class="text-center">
                                            <span><%# Eval("ARRIVAL") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Depart">
                                    <ItemTemplate>
                                        <div style="min-width: 100px;" class="text-center">
                                            <span><%# Eval("DEPART") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <div style="white-space: normal; min-width: 370px;">
                                            <span><%# Eval("Remarks") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

