<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Delivery/ScannedDR/DRscannedReportMaster.Master" CodeBehind="DRupdates.aspx.cs" Inherits="KMDIweb.KMDIweb.Delivery.ScannedDR.DRupdates" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DR | Updates</title>
    <style>
        .nopm {
            margin: 0;
            padding: 0;
        }

        .tblLocal {
            font-family: Calibri;
            white-space: nowrap;
            white-space: nowrap;
        }

            .tblLocal th, tr, td {
                padding-left: 5px;
                padding-right: 5px;
            }
    </style>
</asp:Content>


<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="background-color: aliceblue">
        <div class="well" style="background-color: #303030; border-bottom: solid 5px #ff006e; padding-left: 10px; color: white; font-family: Calibri;">
            <div class="container">
                <h3>DR | Updates</h3>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="container">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="">
                        <div class="row nopm">
                            <div class="col-sm-6 nopm">
                                <div class="well well-sm">
                                    <div class="row nopm">
                                        <div class="col-sm-4 nopm">
                                            <span>Specfication</span>
                                            <asp:DropDownList ID="ddlSpecification" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="All" Text="All"></asp:ListItem>
                                                <asp:ListItem Value="Frame" Text="Frame"></asp:ListItem>
                                                <asp:ListItem Value="Screen" Text="Screen"></asp:ListItem>
                                                <asp:ListItem Value="Glass" Text="Glass"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-sm-8 nopm">
                                            <span>Search</span>
                                            <div class="input-group">
                                                <asp:TextBox ID="tboxFind" runat="server" CssClass="form-control"></asp:TextBox>
                                                <div class="input-group-btn">
                                                    <asp:LinkButton ID="btnFind" runat="server" CssClass="btn btn-primary" Style="background-color: #ff006e; border-color: #ff006e" OnClick="btnFind_Click1">GO</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 nopm">
                                <br />
                                <div class="alert alert-info alert-dismissible" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <strong>Search results for:</strong>
                                    <asp:Label ID="lblSpecification" runat="server"></asp:Label>
                                </div>
                            </div>

                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div style="background-color: #ff006e; color: white; padding: 5px;">
                        <span>DR Table</span>
                    </div>
                    <div style="overflow-x: auto;">
                        <asp:GridView runat="server" ID="gvList" AllowPaging="True" OnPageIndexChanging="gvList_PageIndexChanging"
                            Width="100%" CssClass="tblLocal" AutoGenerateColumns="false"
                            PageSize="25" BackColor="White"
                            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
                            <Columns>
                                <asp:TemplateField HeaderText="Specification">
                                    <ItemTemplate>
                                        <span><%# Eval("Specification") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Project">
                                    <ItemTemplate>
                                        <span><%# Eval("PROJECT_LABEL") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="J.O.">
                                    <ItemTemplate>
                                        <span><%# Eval("SUB_JO") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="DR">
                                    <ItemTemplate>
                                        <span><%# Eval("DR_NO") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="DR Date">
                                    <ItemTemplate>
                                        <span><%# Eval("DR") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Date Delivered">
                                    <ItemTemplate>
                                        <span><%# Eval("DATE_DELIVERED") %></span>
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
                            <PagerStyle CssClass="GridPager" BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Left" />
                        </asp:GridView>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
