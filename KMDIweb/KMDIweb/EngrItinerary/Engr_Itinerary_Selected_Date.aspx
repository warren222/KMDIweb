<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/EngrItinerary/EngrItineraryMaster.Master" CodeBehind="Engr_Itinerary_Selected_Date.aspx.cs" Inherits="KMDIweb.KMDIweb.EngrItinerary.Engr_Itinerary_Selected_Date" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

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
                <asp:LinkButton ID="btnBack" runat="server" CssClass="btn btn-warning FontLarge" ForeColor="Black" OnClick="btnBack_Click"><span class="glyphicon glyphicon-chevron-left"></span> back to calendar</asp:LinkButton>
                <asp:LinkButton ID="btnReport" runat="server" CssClass="btn btn-primary FontLarge" ForeColor="White" OnClick="btnReport_Click">view report <span class="glyphicon glyphicon-chevron-right"></span></asp:LinkButton>
            </span>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="container" style="background-color: white;">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#II">Instl Engr's Itinerary</a></li>
                <li><a data-toggle="tab" href="#DR">Engr's Daily Report</a></li>
            </ul>
            <div class="tab-content">
                <div id="II" class="tab-pane fade in active">
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div>
                                <div class="row nopm">
                                    <div class="col-sm-8 nopm"></div>
                                    <div class="col-sm-4 nopm">
                                        <div class="input-group">
                                            <asp:TextBox ID="tboxSearchProjectII" placeholder="search project here" runat="server" CssClass="form-control"></asp:TextBox>
                                            <div class="input-group-btn">
                                                <asp:LinkButton runat="server" ID="btnIISearch" Style="background-color: #ff006e; border-color: #ff006e" CssClass="btn btn-primary" OnClick="btnIISearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="wf_selected_header">
                                    <span class=" FontLarge">
                                        <span>Project List</span>
                                    </span>
                                </div>
                                <div style="overflow-x: auto;">
                                    <asp:GridView runat="server" ID="gvIIProject" AutoGenerateColumns="false" AllowPaging="true" CssClass="tblLocal FontSmall" OnRowCommand="gvIIProject_RowCommand" OnPageIndexChanging="gvIIProject_PageIndexChanging" PageSize="8">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnSelectProjectII" runat="server" CommandName="execSelect">Select</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectII" runat="server" Text='<%# Bind("Project") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="JO">
                                                <ItemTemplate>
                                                    <span><%# Eval("Parentjono") %></span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Address">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAddressII" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <div class="">
                                                <h3><strong>Sorry! No result found :(</strong>
                                                </h3>
                                            </div>
                                        </EmptyDataTemplate>
                                        <PagerSettings PageButtonCount="8" Position="Bottom" />
                                        <PagerStyle CssClass="GridPager" BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        <RowStyle ForeColor="#000066" />
                                        <SelectedRowStyle BackColor="#303030" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                                    </asp:GridView>
                                </div>
                            </div>
                            <br />


                            <div class="well well-sm">
                                <span class="FontMedium" style="font-weight: bold">
                                    <asp:Label ID="lblIIFormLabel" runat="server" Text="Input Form"></asp:Label></span><br />
                                <br />
                                <div class="row">
                                    <div class="col-sm-6">
                                        <span>Project</span>
                                        <asp:TextBox ID="tboxIIProject" runat="server" CssClass="form-control"></asp:TextBox>
                                        <span>Address</span>
                                        <asp:TextBox ID="tboxIIAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                        <div class="row nopm">
                                            <div class="col-xs-6 nopm">
                                                <span>Appt. Time</span>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tboxIIApptTime"
                                                    ValidationGroup="valInputII" runat="server" ErrorMessage="Appt. time is required!" ForeColor="Red"><span class="glyphicon glyphicon-certificate"></span></asp:RequiredFieldValidator>
                                                <asp:TextBox ID="tboxIIApptTime" runat="server" ValidationGroup="valInputII" CssClass="form-control" TextMode="Time" format="hh:mm"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <span>Concern</span>
                                        <asp:TextBox ID="tboxIIConcern" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox><br />
                                        <div class="text-right">
                                            <asp:LinkButton ID="btnIIAdd" Style="border-radius: 0;" ValidationGroup="valInputII" CssClass="btn btn-success" runat="server" OnClick="btnIIAdd_Click">Add</asp:LinkButton>
                                            <asp:LinkButton ID="btnIIUpdate" Visible="false" Style="border-radius: 0;" ValidationGroup="valInputII" CssClass="btn btn-success" runat="server" OnClick="btnIIUpdate_Click">Update</asp:LinkButton>
                                            <asp:LinkButton ID="btnIICancel" Visible="false" Style="border-radius: 0;" CssClass="btn btn-success" runat="server" OnClick="btnIICancel_Click">Cancel</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <asp:ValidationSummary ID="ValidationSummary2" CssClass="alert alert-danger" ValidationGroup="valInputII" runat="server" />


                            <div class="wf_selected_header">
                                <span class=" FontLarge">
                                    <span>Instl Engineer's Itinerary</span>
                                </span>
                            </div>
                            <div style="overflow-x: auto">
                                <asp:GridView ID="gvInstItinerary" runat="server" CssClass="tblLocal FontMedium" AutoGenerateColumns="false" OnRowCommand="gvInstItinerary_RowCommand">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblIIId" runat="server" Visible="false" Text='<%# Bind("AUTONUM") %>'></asp:Label>
                                                <asp:LinkButton ID="btnIIEdit" runat="server" CommandName="execEdit">Edit</asp:LinkButton>
                                                | 
                                                  <asp:LinkButton ID="btnIIDelete" runat="server" CommandName="execDelete" OnClientClick="return confirm('Delete this item?')">Delete</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project">
                                            <ItemTemplate>
                                                <div style="min-width: 200px; white-space: normal; line-height: 12px; padding: 5px;">
                                                    <asp:LinkButton ID="lblIIProject" runat="server" OnClientClick="return confirm('Add to daily report?')" CommandName="execAddDailyReport" ForeColor="Black" Text='<%# Bind("PROJECT") %>'></asp:LinkButton><br />
                                                    <asp:Label ID="lblIIAddress" CssClass="FontSmall" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Appt. Time">
                                            <ItemTemplate>
                                                <div style="min-width: 100px;" class="text-center">
                                                    <asp:Label ID="lblIIAppttime" runat="server" Text='<%# Bind("Appttime") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Concern">
                                            <ItemTemplate>
                                                <div style="white-space: normal; min-width: 370px;">
                                                    <asp:Label ID="lblIIConcern" runat="server" Text='<%# Bind("Concern") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div id="DR" class="tab-pane fade">
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div>
                                <div class="row nopm">
                                    <div class="col-sm-8 nopm"></div>
                                    <div class="col-sm-4 nopm">
                                        <div class="input-group">
                                            <asp:TextBox ID="tboxSearchProjectDR" placeholder="search project here" runat="server" CssClass="form-control"></asp:TextBox>
                                            <div class="input-group-btn">
                                                <asp:LinkButton runat="server" ID="btnDRSearch" Style="background-color: #ff006e; border-color: #ff006e" CssClass="btn btn-primary" OnClick="btnDRSearch_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <div class="wf_selected_header">
                                    <span class=" FontLarge">
                                        <span>Project List</span>
                                    </span>
                                </div>
                                <div style="overflow-x: auto;">
                                    <asp:GridView runat="server" ID="gvDRProject" AutoGenerateColumns="false" AllowPaging="true" CssClass="tblLocal FontSmall" OnRowCommand="gvDRProject_RowCommand" OnPageIndexChanging="gvDRProject_PageIndexChanging" PageSize="8">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnSelectProjectDR" runat="server" CommandName="execSelect">Select</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Project">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProjectDR" runat="server" Text='<%# Bind("Project") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="JO">
                                                <ItemTemplate>
                                                    <span><%# Eval("Parentjono") %></span>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Address">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAddressDR" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                            <div class="">
                                                <h3><strong>Sorry! No result found :(</strong>
                                                </h3>
                                            </div>
                                        </EmptyDataTemplate>
                                        <PagerSettings PageButtonCount="8" Position="Bottom" />
                                        <PagerStyle CssClass="GridPager" BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        <RowStyle ForeColor="#000066" />
                                        <SelectedRowStyle BackColor="#303030" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                                    </asp:GridView>
                                </div>
                            </div>
                            <br />


                            <div class="well well-sm">
                                <span class="FontMedium" style="font-weight: bold">
                                    <asp:Label ID="lblDRFormLabel" runat="server" Text="Input Form"></asp:Label></span><br />
                                <br />
                                <div class="row">
                                    <div class="col-sm-6">
                                        <span>Project</span>
                                        <asp:TextBox ID="tboxDRProject" runat="server" CssClass="form-control"></asp:TextBox>
                                        <span>Address</span>
                                        <asp:TextBox ID="tboxDRAddress" runat="server" CssClass="form-control"></asp:TextBox>
                                        <div class="row nopm">
                                            <div class="col-xs-6 nopm">
                                                <span>Arrival</span><asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="tboxDRArrival" ValidationGroup="valInputDR" runat="server" ForeColor="Red" ErrorMessage="Arrival time is required!"><span class="glyphicon glyphicon-certificate"></span></asp:RequiredFieldValidator>
                                                <asp:TextBox ID="tboxDRArrival" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                            </div>
                                            <div class="col-xs-6 nopm">
                                                <span>Depart</span><asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="tboxDRDepart" ValidationGroup="valInputDR" runat="server" ForeColor="Red" ErrorMessage="Depart time is required!"><span class="glyphicon glyphicon-certificate"></span></asp:RequiredFieldValidator>
                                                <asp:TextBox ID="tboxDRDepart" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <span>Remarks</span>
                                        <asp:TextBox ID="tboxDRRemarks" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox><br />
                                        <div class="text-right">
                                            <asp:LinkButton ID="btnDRAdd" ValidationGroup="valInputDR" Style="border-radius: 0;" CssClass="btn btn-success" runat="server" OnClick="btnDRAdd_Click">Add</asp:LinkButton>
                                            <asp:LinkButton ID="btnDRUpdate" Visible="false" Style="border-radius: 0;" ValidationGroup="valInputDR" CssClass="btn btn-success" runat="server" OnClick="btnDRUpdate_Click">Update</asp:LinkButton>
                                            <asp:LinkButton ID="btnDRCancel" Visible="false" Style="border-radius: 0;" CssClass="btn btn-success" runat="server" OnClick="btnDRCancel_Click">Cancel</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <asp:ValidationSummary ID="ValidationSummary3" CssClass="alert alert-danger" ValidationGroup="valInputDR" runat="server" />


                            <div class="wf_selected_header">
                                <span class=" FontLarge">
                                    <span>Engineer's Daily Report</span>
                                </span>
                            </div>
                            <div style="overflow-x: auto">
                                <asp:GridView ID="gvDailyReport" runat="server" CssClass="tblLocal FontMedium" AutoGenerateColumns="false" OnRowCommand="gvDailyReport_RowCommand">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="lblDRId" runat="server" Visible="false" Text='<%# Bind("AUTONUM") %>'></asp:Label>
                                                <asp:LinkButton ID="btnDREdit" runat="server" CommandName="execEdit">Edit</asp:LinkButton>
                                                | 
                                                <asp:LinkButton ID="btnDRDelete" runat="server" CommandName="execDelete" OnClientClick="return confirm('Delete this item?')">Delete</asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Project">
                                            <ItemTemplate>
                                                <div style="min-width: 200px; white-space: normal; line-height: 12px; padding: 5px;">
                                                    <asp:Label ID="lblDRProject" runat="server" Text='<%# Bind("PROJECT") %>'></asp:Label><br />
                                                    <asp:Label ID="lblDRAddress" CssClass="FontSmall" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Arrival">
                                            <ItemTemplate>
                                                <div style="min-width: 100px;" class="text-center">
                                                    <asp:Label ID="lblDRArrival" runat="server" Text='<%# Bind("ARRIVAL") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Depart">
                                            <ItemTemplate>
                                                <div style="min-width: 100px;" class="text-center">
                                                    <asp:Label ID="lblDRDepart" runat="server" Text='<%# Bind("DEPART") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Remarks">
                                            <ItemTemplate>
                                                <div style="white-space: normal; min-width: 370px;">
                                                    <asp:Label ID="lblDRRemarks" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
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

        </div>

    </div>


</asp:Content>

