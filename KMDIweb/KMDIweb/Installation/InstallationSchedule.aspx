<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/Installation/InstallationMaster.Master" CodeBehind="InstallationSchedule.aspx.cs" Inherits="KMDIweb.KMDIweb.Installation.InstallationSchedule" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Installation Schedule</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">

        <div class="well">
            <h2>Installation Schedule
            </h2>

            <asp:Panel ID="Panel4" runat="server">
                <div class="row">
                    <div class="col-sm-4">
                        START<br />
                        <asp:TextBox ID="tboxSdate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-sm-4">
                        END<br />
                        <asp:TextBox ID="tboxEdate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-sm-4">
                        PROJECT<br />
                        <div class="input-group">
                            <asp:TextBox ID="tboxSearch" CssClass="form-control" runat="server"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" runat="server" OnClick="LinkButton2_Click">search</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

        </div>




        <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
            <asp:Panel ID="PNLschedule" runat="server">
                <asp:GridView ID="GridView1" CssClass="table" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" GridLines="Both" CellSpacing="1" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="PROJECT" ItemStyle-BackColor="White" ItemStyle-BorderColor="Silver" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="BTNkno" runat="server" CommandName="loadkno" Font-Bold="true" Text='<%# Bind("PIR2_PROJECTNAME") %>'></asp:LinkButton><br />
                                <asp:Label ID="lblInstruction" Font-Size="Small" Visible="false" CssClass="text-muted" runat="server" Text='<%# Bind("PIR2_SPECIALINSTRUCTIONS") %>'></asp:Label>
                                <asp:Label ID="lblAddress" Font-Size="Small" CssClass="text-muted" runat="server" Text='<%# Bind("Fulladd") %>'></asp:Label><br />
                                <asp:Label ID="lblparentjono" Font-Size="Smaller" runat="server" Text='<%# Bind("PIR2_PARENTJONO") %>'></asp:Label><br />
                                <asp:Label ID="lblEngr" Font-Size="Smaller" CssClass="text-warning" runat="server" Text='<%# Bind("ENGR") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SCHEDULE" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblStart" runat="server" Text='<%# Bind("PIR2_START_DATE") %>'></asp:Label><br />
                                <asp:Label ID="lblEnd" runat="server" Text='<%# Bind("PIR2_END_DATE") %>'></asp:Label>
                                <itemstyle wrap="False" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="LOCATION" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblLocation" runat="server" Text='<%# Bind("PIR2_PROJLOCATION") %>'></asp:Label>
                                <itemstyle wrap="False" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-Width="200px" HeaderText="INSTALLERS" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblinstallershidden" runat="server" Visible="false" Text='<%# Bind("Installers") %>'></asp:Label>
                                <asp:Label ID="lblInstallers" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Installers").ToString(), "\r\n|\r|\n", "<br>"))  %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="200px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-Width="200px" HeaderText="Driver" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <div class="text-center">
                                    <asp:Label ID="lblPlatenumber" Font-Size="Larger" CssClass="text-muted" runat="server" Text='<%# Bind("Plate_No") %>'></asp:Label><br />
                                    <br />
                                    <asp:Label ID="lblDriver" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Driver").ToString(), "\r\n|\r|\n", "<br>"))  %>'></asp:Label>
                                </div>

                                <br />
                                <br />

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Driver Instructions" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblDriverInstructor" runat="server" Text='<%# Bind("PIR2_DRIVERINSTRUCTIONS") %>'></asp:Label><br />
                                <br />
                                <asp:Label ID="lblDriverNote" runat="server" Text='<%# Bind("Driver_Note") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />

                    <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                    <PagerStyle CssClass="GridPager" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#594B9C" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#33276A" />
                </asp:GridView>
            </asp:Panel>
            <asp:Panel ID="PNLkno" Visible="false" ScrollBars="Auto" runat="server">
                <div class="text-center">
                    <h2 style="font-weight: bold;">UPDATE REPORT</h2>
                </div>
                <asp:LinkButton ID="LinkButton1" Width="100%" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click">BACK TO SCHEDULE</asp:LinkButton><br />
                <br />
                <div class="well">
                    <asp:Label ID="lblProjectS2" Font-Bold="true" runat="server" Font-Size="Large" Text="Label"></asp:Label><br />
                    <asp:Label ID="lblAddressS2" CssClass="text-muted" Font-Size="Small" runat="server" Text="Label"></asp:Label>
                </div>
                <div class="alert alert-success">
                    <h4>
                        <strong>
                            <asp:Label ID="lblWarning" runat="server" Text="Label"></asp:Label></strong>
                        <asp:Label ID="lblInstructions" runat="server" Text="Label"></asp:Label>
                    </h4>
                </div>
                <asp:Panel ID="panel2" Visible="false" runat="server">
                    <div class="well">
                        <div class="text-center">
                            <h3>SELECT JOB DONE</h3>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <asp:CheckBox ID="cboxFrame" Text="Frame" runat="server" />
                                    </div>
                                    <div class="col-xs-4">
                                        <asp:CheckBox ID="cboxSash" Text="Sash" runat="server" />
                                    </div>
                                    <div class="col-xs-4">
                                        <asp:CheckBox ID="cboxGlass" Text="Glass" runat="server" />
                                    </div>

                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <asp:CheckBox ID="cboxFoam" Text="Foam" runat="server" />
                                    </div>
                                    <div class="col-xs-4">
                                        <asp:CheckBox ID="cboxSealant" Text="Sealant" runat="server" />
                                    </div>
                                    <div class="col-xs-4">
                                        <asp:CheckBox ID="cboxPlastic" Text="Plastic" runat="server" />
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <asp:CheckBox ID="cboxHandle" Text="Handle" runat="server" />
                                    </div>
                                    <div class="col-xs-4">
                                        <asp:CheckBox ID="cboxScreen" Text="Screen" runat="server" />
                                    </div>
                                    <div class="col-xs-4">
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </asp:Panel>
                <div>
                    <div class="row">
                        <div class="col-sm-6">
                        </div>
                        <div class="col-sm-6">
                            <div style="background-color: bisque; padding: 10px;">
                                <asp:Panel ID="Panel5" runat="server">
                                    Pumili ng date para sa check function
                             <br />
                                    <asp:TextBox ID="tboxDate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
                <br />


                <div style="background-color: aliceblue; padding: 10px;">
                    <div class="row">
                        <div class="col-sm-4">

                            <span style="font-size: large">Mag search base sa k# at location:</span>
                        </div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    K no.
                                </div>
                                <asp:DropDownList ID="ddlkno" CssClass="form-control" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <div class="input-group-addon">
                                    Location
                                </div>
                                <asp:DropDownList ID="ddllocation" CssClass="form-control" runat="server"></asp:DropDownList>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="LinkButton6" runat="server" CssClass="btn btn-primary" OnClick="LinkButton6_Click">SEARCH</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <asp:Panel ID="panelContainer" ScrollBars="Auto" runat="server">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="GridView2" CssClass="table" AutoGenerateColumns="False" runat="server" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellPadding="3" CellSpacing="1" GridLines="Both" OnRowCommand="GridView2_RowCommand">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox Visible="false" ID="cboxselect" runat="server" />
                                            <asp:Label ID="lblid" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="KMDI#" ItemStyle-BorderColor="Silver" ItemStyle-BackColor="White">
                                        <ItemTemplate>
                                            <asp:Label ID="lbljoborderno" Visible="false" runat="server" Text='<%# Bind("job_order_no") %>'></asp:Label>
                                            <asp:Label ID="lblkmdi" Font-Size="Medium" Font-Bold="true" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                            <asp:Label ID="lblitemno" runat="server" CssClass="text-muted" Text='<%# Bind("item_no") %>'></asp:Label><br />
                                            <asp:Label ID="lbllocation" runat="server" CssClass="text-muted" Text='<%# Bind("location") %>'></asp:Label>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="DIMENSION" ItemStyle-BorderColor="Silver" ItemStyle-BackColor="White" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblwidth" runat="server" Text='<%# Bind("width") %>'></asp:Label>w x
                                            <asp:Label ID="lblheight" runat="server" Text='<%# Bind("height") %>'></asp:Label>h
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FRAME" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnFrame" CommandName="Frame" runat="server" Text='<%# Bind("frame") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Frame</span><br />
                                                <asp:Label ID="lblkmdi2" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearFrame" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearFrame" Visible='<%# Eval("Clear_Frame").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Frame") %>'></asp:LinkButton>
                                                <asp:Label ID="lblframeInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("frame_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnFrameUpdate" CommandName="UpdateFrame" CssClass="btn btn-default" Visible='<%# Eval("Frame").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SASH" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnSash" CommandName="Sash" runat="server" Text='<%# Bind("sash") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Sash</span><br />
                                                <asp:Label ID="lblkmdi3" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearSash" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearSash" Visible='<%# Eval("Clear_Sash").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Sash") %>'></asp:LinkButton>
                                                <asp:Label ID="lblSashInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("sash_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnSashUpdate" CssClass="btn btn-default" CommandName="UpdateSash" Visible='<%# Eval("Sash").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FOAM" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnFoam" CommandName="Foam" runat="server" Text='<%# Bind("FOAM") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Foam</span><br />
                                                <asp:Label ID="lblkmdi5" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearFoam" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearFoam" Visible='<%# Eval("Clear_Foam").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Foam") %>'></asp:LinkButton>
                                                <asp:Label ID="lblfoamInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("foam_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnFoamUpdate" CssClass="btn btn-default" CommandName="UpdateFoam" Visible='<%# Eval("Foam").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SEALANT IN" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnSealant" CommandName="Sealant" runat="server" Text='<%# Bind("SEALANT") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Sealant In</span><br />
                                                <asp:Label ID="lblkmdi6" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearSealant" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearSealant" Visible='<%# Eval("Clear_Sealant").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Sealant") %>'></asp:LinkButton>
                                                <asp:Label ID="lblsealantInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("sealant_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnSealantUpdate" CssClass="btn btn-default" CommandName="UpdateSealant" Visible='<%# Eval("Sealant").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SEALANT OUT" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnSealantOut" CommandName="SealantOut" runat="server" Text='<%# Bind("SEALANT_OUT") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Sealant Out</span><br />
                                                <asp:Label ID="lblkmdi66" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearSealantOut" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearSealantOut" Visible='<%# Eval("Clear_Sealant_Out").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Sealant_Out") %>'></asp:LinkButton>
                                                <asp:Label ID="lblsealantOutInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("sealant_out_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnSealantOutUpdate" CssClass="btn btn-default" CommandName="UpdateSealantOut" Visible='<%# Eval("SEALANT_OUT").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GLASS" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnGlass" CommandName="Glass" runat="server" Text='<%# Bind("GLASS") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Glass</span><br />
                                                <asp:Label ID="lblkmdi4" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearGlass" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearGlass" Visible='<%# Eval("Clear_Glass").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Glass") %>'></asp:LinkButton>
                                                <asp:Label ID="lblglassInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("glass_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnGlassUpdate" CssClass="btn btn-default" CommandName="UpdateGlass" Visible='<%# Eval("Glass").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GLASS U-SEAL" ItemStyle-Wrap="false" ItemStyle-BackColor="#ffffcc" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="#ffff99" HeaderStyle-BorderColor="Silver" ItemStyle-BorderColor="Silver">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnGlassUSeal" CommandName="GlassUSeal" runat="server" Text='<%# Bind("GLASS_U_SEAL") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Glass U-Seal</span><br />
                                                <asp:Label ID="lblkmdi68" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearGlassUSeal" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearGlassUSeal" Visible='<%# Eval("Clear_Glass_U_Seal").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Glass_U_Seal") %>'></asp:LinkButton>
                                                <asp:Label ID="lblglassUSealInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("GLASS_U_Seal_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnGlassUSealUpdate" CssClass="btn btn-default" CommandName="UpdateGlassUSeal" Visible='<%# Eval("Glass_U_Seal").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ADD'L REINF" ItemStyle-Wrap="false" ItemStyle-BackColor="#ffffcc" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="#ffff99" HeaderStyle-BorderColor="Silver" ItemStyle-BorderColor="Silver">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnAddlReinf" CommandName="AddlReinf" runat="server" Text='<%# Bind("ADDL_REINF") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Add'l Reinf</span><br />
                                                <asp:Label ID="lblkmdi69" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearAddlReinf" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearAddlReinf" Visible='<%# Eval("Clear_Addl_Reinf").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Addl_Reinf") %>'></asp:LinkButton>
                                                <asp:Label ID="lbladdlReinfInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Addl_Reinf_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnAddlReinfUpdate" CssClass="btn btn-default" CommandName="UpdateAddlReinf" Visible='<%# Eval("Addl_Reinf").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="STRIKER" ItemStyle-Wrap="false" ItemStyle-BackColor="#ffffcc" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="#ffff99" HeaderStyle-BorderColor="Silver" ItemStyle-BorderColor="Silver">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnStriker" CommandName="Striker" runat="server" Text='<%# Bind("STRIKER") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Striker</span><br />
                                                <asp:Label ID="lblkmdi70" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearStriker" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearStriker" Visible='<%# Eval("Clear_Striker").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Striker") %>'></asp:LinkButton>
                                                <asp:Label ID="lblstrikerInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Striker_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnStrikerUpdate" CssClass="btn btn-default" CommandName="UpdateStriker" Visible='<%# Eval("Striker").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SEALING BLOCK" ItemStyle-Wrap="false" ItemStyle-BackColor="#ffffcc" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="#ffff99" HeaderStyle-BorderColor="Silver" ItemStyle-BorderColor="Silver">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnSealingBlock" CommandName="SealingBlock" runat="server" Text='<%# Bind("SEALING_BLOCK") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Sealing Block</span><br />
                                                <asp:Label ID="lblkmdi71" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearSealingBlock" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearSealingBlock" Visible='<%# Eval("Clear_Sealing_Block").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Sealing_Block") %>'></asp:LinkButton>
                                                <asp:Label ID="lblsealingBlockInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Sealing_Block_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnSealingBlockUpdate" CssClass="btn btn-default" CommandName="UpdateSealingBlock" Visible='<%# Eval("Sealing_Block").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="1646" ItemStyle-Wrap="false" ItemStyle-BackColor="#ffffcc" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="#ffff99" HeaderStyle-BorderColor="Silver" ItemStyle-BorderColor="Silver">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnAcc1646" CommandName="Acc1646" runat="server" Text='<%# Bind("ACC_1646") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">1646</span><br />
                                                <asp:Label ID="lblkmdi72" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearAcc1646" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearAcc1646" Visible='<%# Eval("Clear_Acc_1646").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Acc_1646") %>'></asp:LinkButton>
                                                <asp:Label ID="lblacc1646Installer" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Acc_1646_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnAcc1646Update" CssClass="btn btn-default" CommandName="UpdateAcc1646" Visible='<%# Eval("Acc_1646").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ANTI-LIFT DEVICE" ItemStyle-Wrap="false" ItemStyle-BackColor="#ffffcc" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="#ffff99" HeaderStyle-BorderColor="Silver" ItemStyle-BorderColor="Silver">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnAtiLiftDevice" CommandName="AntiLiftDevice" runat="server" Text='<%# Bind("ANTI_LIFT_DEVICE") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Anti-lift Device</span><br />
                                                <asp:Label ID="lblkmdi73" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearAntiLiftDevice" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearAntiLiftDevice" Visible='<%# Eval("Clear_Anti_Lift_Device").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Anti_Lift_Device") %>'></asp:LinkButton>
                                                <asp:Label ID="lblantiLiftDeviceInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Anti_Lift_Device_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnAntiLiftDeviceUpdate" CssClass="btn btn-default" CommandName="UpdateAntiLiftDevice" Visible='<%# Eval("Anti_Lift_Device").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="6059" ItemStyle-Wrap="false" ItemStyle-BackColor="#ffffcc" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="#ffff99" HeaderStyle-BorderColor="Silver" ItemStyle-BorderColor="Silver">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnAcc6059" CommandName="Acc6059" runat="server" Text='<%# Bind("ACC_6059") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">6059</span><br />
                                                <asp:Label ID="lblkmdi74" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearAcc6059" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearAcc6059" Visible='<%# Eval("Clear_Acc_6059").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Acc_6059") %>'></asp:LinkButton>
                                                <asp:Label ID="lblacc6059Installer" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Acc_6059_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnAcc6059Update" CssClass="btn btn-default" CommandName="UpdateAcc6059" Visible='<%# Eval("Acc_6059").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="BUFFER STOPPER" ItemStyle-Wrap="false" ItemStyle-BackColor="#ffffcc" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="#ffff99" HeaderStyle-BorderColor="Silver" ItemStyle-BorderColor="Silver">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnBufferStopper" CommandName="BufferStopper" runat="server" Text='<%# Bind("BUFFER_STOPPER") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Buffer Stopper</span><br />
                                                <asp:Label ID="lblkmdi75" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearBufferStopper" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearBufferStopper" Visible='<%# Eval("Clear_Buffer_Stopper").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Buffer_Stopper") %>'></asp:LinkButton>
                                                <asp:Label ID="lblbufferStopperInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Buffer_Stopper_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnBufferStopperUpdate" CssClass="btn btn-default" CommandName="UpdateBufferStopper" Visible='<%# Eval("Buffer_Stopper").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PVC MILLED w/ REINF" ItemStyle-Wrap="false" ItemStyle-BackColor="#ffffcc" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="#ffff99" HeaderStyle-BorderColor="Silver" ItemStyle-BorderColor="Silver">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnPVCMilledWReinf" CommandName="PVCMilledWReinf" runat="server" Text='<%# Bind("PVC_MILLED_W_REINF") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">PVC Milled w/ Reinf</span><br />
                                                <asp:Label ID="lblkmdi76" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearPVCMilledWReinf" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearPVCMilledWReinf" Visible='<%# Eval("Clear_PVC_Milled_W_Reinf").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_PVC_Milled_W_Reinf") %>'></asp:LinkButton>
                                                <asp:Label ID="lblpVCMilledWReinfInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("PVC_MILLED_W_REINF_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnPVCMilledWReinfUpdate" CssClass="btn btn-default" CommandName="UpdatePVCMilledWReinf" Visible='<%# Eval("PVC_MILLED_W_REINF").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="MILLED SNAPPER" ItemStyle-Wrap="false" ItemStyle-BackColor="#ffffcc" HeaderStyle-ForeColor="Black" HeaderStyle-BackColor="#ffff99" HeaderStyle-BorderColor="Silver" ItemStyle-BorderColor="Silver">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnMilledSnapper" CommandName="MilledSnapper" runat="server" Text='<%# Bind("MILLED_SNAPPER") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Milled Snapper</span><br />
                                                <asp:Label ID="lblkmdi77" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearMilledSnapper" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearMilledSnapper" Visible='<%# Eval("Clear_Milled_Snapper").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Milled_Snapper") %>'></asp:LinkButton>
                                                <asp:Label ID="lblmilledSnapperInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("Milled_Snapper_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnMilledSnapperUpdate" CssClass="btn btn-default" CommandName="UpdateMilledSnapper" Visible='<%# Eval("Milled_Snapper").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PLASTIC" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnPlastic" CommandName="Plastic" runat="server" Text='<%# Bind("PLASTIC") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Plastic</span><br />
                                                <asp:Label ID="lblkmdi7" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearPlastic" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearPlastic" Visible='<%# Eval("Clear_Plastic").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Plastic") %>'></asp:LinkButton>
                                                <asp:Label ID="lblplasticInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("plastic_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnPlasticUpdate" CssClass="btn btn-default" CommandName="UpdatePlastic" Visible='<%# Eval("Plastic").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="CLEANING" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnCleaning" CommandName="Cleaning" runat="server" Text='<%# Bind("CLEANING") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Cleaning</span><br />
                                                <asp:Label ID="lblkmdi98" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearCleaning" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearCleaning" Visible='<%# Eval("Clear_Cleaning").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Cleaning") %>'></asp:LinkButton>
                                                <asp:Label ID="lblcleaningInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("cleaning_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnCleaningUpdate" CssClass="btn btn-default" CommandName="UpdateCleaning" Visible='<%# Eval("Cleaning").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="HANDLE" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnHandle" CommandName="Handle" runat="server" Text='<%# Bind("I_HANDLE") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Handle</span><br />
                                                <asp:Label ID="lblkmdi8" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearHandle" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearHandle" Visible='<%# Eval("Clear_Handle").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Handle") %>'></asp:LinkButton>
                                                <asp:Label ID="lblihandleInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("i_handle_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnHandleUpdate" CssClass="btn btn-default" CommandName="UpdateHandle" Visible='<%# Eval("I_Handle").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SCREENS" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnScreen" CommandName="Screen" runat="server" Text='<%# Bind("SCREENS") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Screen</span><br />
                                                <asp:Label ID="lblkmdi9" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearScreen" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearScreens" Visible='<%# Eval("Clear_Screens").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Screens") %>'></asp:LinkButton>
                                                <asp:Label ID="lblscreenInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("screens_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnScreenUpdate" CssClass="btn btn-default" CommandName="UpdateScreen" Visible='<%# Eval("Screens").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="X BARS" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnXBars" CommandName="XBars" runat="server" Text='<%# Bind("X_Bars") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">X Bars</span><br />
                                                <asp:Label ID="lblkmdi78" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearXBars" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearXBars" Visible='<%# Eval("Clear_X_Bars").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_X_Bars") %>'></asp:LinkButton>
                                                <asp:Label ID="lblxBarsInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("x_bars_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnXBarsUpdate" CssClass="btn btn-default" CommandName="UpdateXBars" Visible='<%# Eval("X_Bars").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FINAL CLEANING" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnFinalCleaning" CommandName="FinalCleaning" runat="server" Text='<%# Bind("FINAL_CLEANING") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Final Cleaning</span><br />
                                                <asp:Label ID="lblkmdi80" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearFinalCleaning" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearFinalCleaning" Visible='<%# Eval("Clear_Final_Cleaning").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Final_Cleaning") %>'></asp:LinkButton>
                                                <asp:Label ID="lblfinalCleaningInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("final_cleaning_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnfinalCleaningUpdate" CssClass="btn btn-default" CommandName="UpdateFinalCleaning" Visible='<%# Eval("FINAL_CLEANING").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="FINAL QC" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <div style="min-width: 140px;">
                                                <asp:LinkButton ID="lbtnFinalQC" CommandName="FinalQC" runat="server" Text='<%# Bind("FINAL_QC") %>'></asp:LinkButton><br />
                                                <span class="text-muted" style="font-size: small">Final QC</span><br />
                                                <asp:Label ID="lblkmdi79" runat="server" Text='<%# Bind("kmdi_no") %>'></asp:Label><br />
                                                <asp:LinkButton ID="btnClearFinalQC" OnClientClick="return confirm('clear this record?')" CssClass="text-danger" CommandName="ClearFinalQC" Visible='<%# Eval("Clear_Final_QC").ToString() == "" ? false : true %>' runat="server" Text='<%# Bind("Clear_Final_QC") %>'></asp:LinkButton>
                                                <asp:Label ID="lblfinalQCInstaller" Visible="false" runat="server" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("final_qc_installer").ToString(), ",", "<br>")) %>'></asp:Label>
                                                <asp:LinkButton ID="btnfinalQCUpdate" CssClass="btn btn-default" CommandName="UpdateFinalQC" Visible='<%# Eval("FINAL_QC").ToString() == "" ? true : false %>' runat="server">check</asp:LinkButton>
                                            </div>
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
                            <div id="myModal" class="modal fade" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">
                                                <asp:Label ID="lblmodalKno" Font-Bold="true" CssClass="text-info" runat="server" Text=""></asp:Label>
                                                /
                                                <asp:Label ID="lblmodalLocation" CssClass="text-muted" runat="server" Text=""></asp:Label></h5>
                                        </div>
                                        <div class="modal-body">
                                            <div class="text-center">
                                                <h5><strong>
                                                    <asp:Label ID="lblmodalHeader" runat="server" Text=""></asp:Label></strong></h5>
                                            </div>
                                            <asp:Label ID="lblmodalInstallers" CssClass="text-muted" runat="server" Text=""></asp:Label>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <asp:LinkButton ID="LinkButton3" Visible="false" OnClientClick="return confirm('save changes?')" CssClass="btn btn-primary" runat="server" OnClick="LinkButton3_Click">save changes</asp:LinkButton>

                            <br />
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>


                <br />
                <br />
                <div class="well">
                    <div class="text-center">
                        <h3>Non-productive activities</h3>
                    </div>
                    <br />
                    <div>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="Panel3" Visible="false" runat="server">
                                    <span>Select your activity</span><br />
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddlActivity" CssClass="form-control" runat="server">
                                            <asp:ListItem Text="Layout opening" Value="Layout opening"></asp:ListItem>
                                            <asp:ListItem Text="Travel/Hanap boarding house" Value="Travel/Hanap boarding house"></asp:ListItem>
                                            <asp:ListItem Text="Aftersales" Value="Aftersales"></asp:ListItem>
                                            <asp:ListItem Text="Hauling Frame/Sash/Glass" Value="Hauling Frame/Sash/Glass"></asp:ListItem>
                                            <asp:ListItem Text="Shipment" Value="Shipment"></asp:ListItem>
                                            <asp:ListItem Text="Adjustment" Value="Adjustment"></asp:ListItem>
                                            <asp:ListItem Text="Process ID" Value="Process ID"></asp:ListItem>
                                            <asp:ListItem Text="Change Schedule" Value="Change Schedule"></asp:ListItem>
                                        </asp:DropDownList>
                                        <div class="input-group-btn">
                                            <asp:LinkButton ID="LinkButton4" CssClass="btn btn-primary" runat="server" OnClick="LinkButton4_Click">add</asp:LinkButton>
                                        </div>
                                    </div>
                                </asp:Panel>
                                <br />
                                <div class="well">
                                    <span>Other</span>
                                    <div>
                                        <asp:TextBox ID="tboxActivity" TextMode="MultiLine" CssClass="form-control" runat="server" Rows="5"></asp:TextBox>
                                        <br />
                                        <asp:LinkButton ID="LinkButton5" CssClass="btn btn-primary" runat="server" OnClick="LinkButton5_Click">submit</asp:LinkButton>
                                    </div>
                                </div>
                                <br />
                                <asp:Panel ID="panel20" ScrollBars="Auto" runat="server">
                                    <asp:GridView ID="GridView3" CssClass="table" AutoGenerateColumns="False" runat="server" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black" EmptyDataText="No record" OnRowCommand="GridView3_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="ACTIVITY" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblId" runat="server" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                                    <asp:Label ID="lblactivity" runat="server" Text='<%# Bind("activity") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DATE" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldated" runat="server" Text='<%# Bind("DATED") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Wrap="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnDelete" OnClientClick="return confirm('delete this record?')" CssClass="text-danger" CommandName="myDelete" Visible='<%# Eval("Clear_Data").ToString() == "" ? false : true %>' runat="server">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#CCCCCC" />
                                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                        <RowStyle BackColor="White" />
                                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                        <SortedAscendingHeaderStyle BackColor="#808080" />
                                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                        <SortedDescendingHeaderStyle BackColor="#383838" />
                                    </asp:GridView>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </div>
                </div>
            </asp:Panel>
        </asp:Panel>

    </div>
</asp:Content>
