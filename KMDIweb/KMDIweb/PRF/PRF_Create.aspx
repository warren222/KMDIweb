﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/KMDIweb/PRF/PRF_Master.Master" CodeBehind="PRF_Create.aspx.cs" Inherits="KMDIweb.KMDIweb.PRF.PRF_Create" %>


<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PRF | Create</title>
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
                <h3>Create PRF</h3>
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
            <div class="panel panel-info">
                <div class="panel-heading">
                    <asp:Label ID="lblControlNumberHeader" runat="server" Text="Please get a control number to proceed."></asp:Label>
                </div>
                <asp:Panel ID="pnlCtrlNumberCreate" runat="server">
                    <div class="row">
                        <div class="col-sm-4">
                        </div>
                        <div class="col-sm-4">
                            <div style="margin: 5px; text-align: center;">
                                <span>Select Due Date</span>
                                <asp:TextBox ID="tboxDueDate" runat="server" TextMode="Date" ValidationGroup="inputVal" CssClass="form-control"></asp:TextBox>
                                <asp:LinkButton ID="btnCreate" runat="server" CssClass="btn btn-success" ValidationGroup="inputVal" Width="100%"
                                    Style="border-radius: 0px; background-color: #87ddff; border-color: #87ddff; color: black;" OnClick="btnCreate_Click">Get Control Number</asp:LinkButton>
                                <asp:RequiredFieldValidator ID="rfvDueDate" runat="server" ControlToValidate="tboxDueDate" ValidationGroup="inputVal" ForeColor="Red" ErrorMessage="Sorry! Please select due date."></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-4">
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlControlNumber" runat="server">
                    <asp:GridView ID="gvControlNo" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="false" Width="100%" AllowPaging="True" PageSize="1">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="text-center">
                                        <asp:Label ID="lblId" runat="server" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                        <div class="text-left">
                                            <span style="font-size: xx-large"><%# Eval("Control_No") %></span>
                                            <span class="pull-right text-right">
                                                <span style="font-size: small"><%# Eval("Date_Inputted") %></span><br />
                                                <span style="font-size: small"><%# Eval("Requested_By") %></span>
                                            </span>
                                            <br />
                                            <span style="font-size: large"><%# Eval("Due_Date") %></span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>




            <asp:Panel runat="server" Visible="false" ID="pnlPRFInput">
                <div class="well" style="margin-bottom: 0; padding-right: 0; padding-left: 0;">
                    <h4>Purchase Request Form</h4>
                    <div class="row nopm">
                        <div class="col-sm-4 nopm">
                            <span>Item Description</span>
                            <asp:TextBox ID="tboxItemDescription" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-sm-2 nopm">
                            <span>Quantity</span>
                            <asp:TextBox ID="tboxQuantity" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-sm-2 nopm">
                            <span>Account</span>
                            <asp:TextBox ID="tboxAccount" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-sm-4 nopm">
                            <span>Remarks</span>
                            <asp:TextBox ID="tboxRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <asp:LinkButton runat="server" ID="btnProceed" Width="100%" CssClass="btn btn-success" Style="border-radius: 0px;" OnClick="btnProceed_Click">
                <span class="glyphicon glyphicon-chevron-down"></span> Add</asp:LinkButton>
                </div>
                <div style="background-color: #b0e9ff; color: black; padding: 5px;">
                    <span>Request List</span>
                </div>
                <asp:GridView ID="gvItems" Width="100%" CssClass="tblLocal" runat="server" AutoGenerateColumns="false" OnRowCommand="gvItems_RowCommand">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnDelete" CommandName="execDelete" OnClientClick="return confirm('delete this item?')">Delete</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:Label ID="lblItemId" runat="server" Visible="false" Text='<%# Bind("Id") %>'></asp:Label>
                                <div>
                                    <span><%# Eval("Item_Description") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <div class="text-center">
                                    <span><%# Eval("Qty") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Account">
                            <ItemTemplate>
                                <div class="text-center">
                                    <span><%# Eval("Account") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Remarks">
                            <ItemTemplate>
                                <div>
                                    <span><%# Eval("Remarks") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </asp:Panel>

        </div>
    </div>

</asp:Content>
