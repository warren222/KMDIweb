<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CollectionLedgerFrm.aspx.cs" MasterPageFile="~/KMDIweb/AE/CollectionLedger/AEMaster.Master" Inherits="KMDIweb.KMDIweb.AE.CollectionLedger.CollectionLedgerFrm" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="container">
            <div class="well">
                <div class="container text-left">
                    <h2>Collection Ledger</h2>

                </div>
            </div>
            <a data-toggle="collapse" href="#cpnl" role="button" aria-expanded="false" class="btn btn-default" aria-controls="collapseExample">FILTER KEYS
            </a>

            <div class="collapse" id="cpnl">
                <div style="padding: 10px; background-color: whitesmoke; border-radius: 10px;">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="text-center">DATE INPUTTED RANGE</div>
                            <span>DATE BEGIN</span><br />
                            <asp:TextBox ID="tboxBegin" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                            <span>DATE END</span><br />
                            <asp:TextBox ID="tboxEnd" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox><br />
                        </div>
                        <div class="col-sm-4">
                            <br />
                            <br />
                            <asp:CheckBox ID="cboxVerified" Text="VERIFIED" Checked="true" CssClass="form-control" runat="server" /><br />
                            <asp:CheckBox ID="cboxInputted" Text="RECORDED" Checked="True" CssClass="form-control" runat="server" />
                            <br />
                        </div>
                        <div class="col-sm-4">
                            <br />
                            <span>PROJECT</span><br />
                            <asp:TextBox ID="tboxProject" CssClass="form-control" runat="server"></asp:TextBox><br />
                            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-success" Width="100%" runat="server" OnClick="LinkButton2_Click">SEARCH</asp:LinkButton>
                        </div>
                    </div>
                    <br />
                    <br />

                </div>
            </div>
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">ADD NEW RECORD</asp:LinkButton><br />
            <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" Width="100%" GridLines="None" BackColor="aliceblue" AutoGenerateColumns="False" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" PageSize="25">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div style="padding: 12px 5px 7px 5px; margin-bottom: 10px; border-left: solid #38c24c 4px; background-color: white;">
                                        <div style="font-size: large;">
                                            <asp:Label ID="Label4" Font-Bold="true" runat="server" class="responsiveFont" Text='<%# Bind("PROJECT_NAME") %>'></asp:Label>
                                        </div>
                                        <div>
                                            <span style="font-size: large;">
                                                <asp:Label ID="CollectionId" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                <asp:Label ID="lblCheckDetails" Width="65%" runat="server" class="responsiveFont" Text='<%# Bind("CHECKDETAILS") %>'></asp:Label>
                                            </span>
                                            <span style="font-size: large; color: LimeGreen" class="pull-right">
                                                <span class="responsiveFont">PHP </span>
                                                <asp:Label ID="Label1" runat="server" class="responsiveFont" Text='<%# Bind("AMOUNT") %>'></asp:Label>
                                            </span>
                                        </div>

                                        <div>
                                            <span class="responsiveFont text-info">CHECK/PAYMENT DATE:</span>
                                            <span class="pull-right">
                                                <asp:Label ID="Label2" runat="server" class="responsiveFont" Text='<%# Bind("PAYMENT_OR_CHECKDATE") %>'></asp:Label>
                                            </span>
                                        </div>
                                        <div>
                                            <span class="responsiveFont text-info">DATE COLLECTED:</span>
                                            <span class="pull-right text-right">
                                                <asp:Label ID="Label3" runat="server" class="responsiveFont" Text='<%# Bind("DATECOLLECTED") %>'></asp:Label>
                                            </span>
                                            <br />
                                            <asp:Panel ID="pnlASE" Visible='<%# Eval("ASE").ToString() != "" ? true : false %>' runat="server">
                                                <div>
                                                    <span class="responsiveFont text-info">ASE:</span>
                                                    <span class="pull-right">
                                                        <asp:Label ID="Label9" runat="server" Font-Bold="true" class="responsiveFont" Text='<%# Bind("ASE") %>'></asp:Label>
                                                    </span>
                                                </div>
                                            </asp:Panel>

                                            <span class="responsiveFont text-muted">AEIC:&nbsp;&nbsp;</span><asp:Label ID="Label6" Font-Bold="true" runat="server" class="responsiveFont" Text='<%# Bind("AE") %>'></asp:Label>
                                        </div>
                                        <div>
                                            <asp:Label ID="Label8" runat="server" Font-Size="Small" class="label label-success responsiveFont"
                                                Text='<%# Eval("AR_OR").ToString() == "" ? "" : "VERIFIED" %>'></asp:Label>

                                            <asp:Label ID="Label7" runat="server" Font-Size="Small" class="label label-warning responsiveFont"
                                                Text='<%# Eval("PARENTJONO").ToString() == "" ? "" : "RECORDED" %>'></asp:Label>

                                            <asp:Label ID="Label5" runat="server" Font-Size="Small" Text='<%# Bind("CHECK_STATUS") %>'
                                                class='<%# Eval("CHECK_STATUS").ToString() == "BOUNCED" ? "label label-danger responsiveFont" : Eval("CHECK_STATUS").ToString() == "CLEARED" ? "label label-primary responsiveFont" : "label label-default responsiveFont" %>'></asp:Label>
                                        </div>
                                        <br />
                                        <asp:LinkButton ID="UploadBtn" CommandName="UploadFile" CssClass="btn btn-default" runat="server">UPLOAD FILE</asp:LinkButton>
                                  
                                        <span class="pull-right">
                                                  <asp:LinkButton ID="DeleteBtn" Visible='<%# Eval("DeleteBtn").ToString() == "Show" ? true : false%>' OnClientClick="return confirm('clear this record?')" CommandName="DeleteItem" CssClass="btn btn-danger" runat="server">DELETE</asp:LinkButton>
                                        </span>
                                        <br />
                                        <div style="background-color: #f8e88b; margin-bottom: -5px; margin-top: 5px; margin-left: -5px;" class="text-center responsiveFont">
                                            <asp:Label ID="LBLREMARKS" runat="server" Font-Size="Small" Text='<%# Bind("REMARKS")%>'></asp:Label>
                                        </div>
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
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
