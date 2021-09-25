<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CollectionLedgerFrm.aspx.cs" MasterPageFile="~/KMDIweb/AE/CollectionLedger/AEMaster.Master" Inherits="KMDIweb.KMDIweb.AE.CollectionLedger.CollectionLedgerFrm" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Collection Ledger</title>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <div class="container text-center">
                <h2>Collection Ledger</h2>
            </div>
        </div>
        <a data-toggle="collapse" href="#cpnl" role="button" aria-expanded="false" class="btn btn-default" aria-controls="collapseExample">FILTER KEYS
        </a>

        <div class="collapse" id="cpnl">
            <div style="padding: 10px; background-color: whitesmoke; border-radius: 10px;">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="text-center">DATE INPUTTED RANGE</div>
                        <span>DATE BEGIN</span><br />
                        <asp:TextBox ID="tboxBegin" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox><br />
                        <span>DATE END</span><br />
                        <asp:TextBox ID="tboxEnd" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox><br />
                    </div>
                    <div class="col-sm-6">
                        <span>PROJECT</span><br />
                        <asp:TextBox ID="tboxProject" CssClass="form-control" runat="server"></asp:TextBox><br />
                        <br />
                        <asp:LinkButton ID="LinkButton2" CssClass="btn btn-success" Width="100%" runat="server" OnClick="LinkButton2_Click">SEARCH</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">ADD NEW RECORD</asp:LinkButton><br />
        <br />
        <asp:GridView ID="GridView1" Width="100%" GridLines="None" BackColor="WhiteSmoke" AutoGenerateColumns="False" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div style="padding: 5px; margin-bottom: 10px; border-left: solid #00ff21 4px; background-color: white;">
                            <span style="font-size: large;">
                                <asp:Label ID="CollectionId" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="lblCheckDetails" Width="65%" runat="server" class="responsiveFont" Text='<%# Bind("CHECKDETAILS") %>'></asp:Label>
                            </span>
                            <span style="font-size: large; color: LimeGreen" class="pull-right">
                                <span class="responsiveFont">PHP </span>
                                <asp:Label ID="Label1" runat="server" class="responsiveFont" Text='<%# Bind("AMOUNT") %>'></asp:Label>
                            </span>
                            <br />
                            <div>
                                <span class="responsiveFont text-info">CHECK/PAYMENT DATE:</span>
                                <span class="pull-right">
                                    <asp:Label ID="Label2" runat="server" class="responsiveFont" Text='<%# Bind("PAYMENT_OR_CHECKDATE") %>'></asp:Label>
                                </span>
                            </div>
                            <div>
                                <span class="responsiveFont text-info">DATE COLLECTED:</span>
                                <span class="pull-right">
                                    <asp:Label ID="Label3" runat="server" class="responsiveFont" Text='<%# Bind("DATECOLLECTED") %>'></asp:Label>
                                </span>
                            </div>
                            <br />
                            <div>
                                <asp:Label ID="Label4" Font-Bold="true" runat="server" class="responsiveFont text-muted" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                            </div>
                            <br />
                            <asp:LinkButton ID="UploadBtn" CommandName="UploadFile" CssClass="btn btn-success" runat="server">UPLOAD FILE</asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerStyle CssClass="GridPager" />
            <HeaderStyle Wrap="False" />
            <PagerSettings PageButtonCount="8" Position="TopAndBottom" />

            <EmptyDataTemplate>
                <div>
                    <h3><strong>Sorry, No Result Found!</strong>
                    </h3>
                </div>
            </EmptyDataTemplate>
            <RowStyle Wrap="True" />
        </asp:GridView>
    </div>
</asp:Content>
