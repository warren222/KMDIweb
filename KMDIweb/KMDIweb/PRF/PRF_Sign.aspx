﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PRF_Sign.aspx.cs" Inherits="KMDIweb.KMDIweb.PRF.PRF_Sign" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PRF Signing</title>
    <script src="../../Scripts/bootstrap.js"></script>
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.min.js"></script>
    <script src="../../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Global/scripts/sign.js"></script>
    <script>
        $(document).ready(function () {
            $('#myCanvas').sign({
                resetButton: $('#resetSign'),
                lineWidth: 2
            });
        });
    </script>
    <style>
        #myCanvas {
            border: 4px solid #444;
            border-radius: 1px;
        }

        .tbl td {
            padding-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container-fluid">

     <div class="row">
                <div class="col-sm-6">

                    <canvas id="myCanvas"></canvas>
                    <input type='hidden' id='myurl' name='myurl' />
                    <input type='hidden' id='myurl1' name='myurl1' />
                    <br />
                    <asp:Button runat="server" CssClass="btn btn-warning" Text="Reset Sign" ID='resetSign' />
                    <br />
                    <br />
                    <br />


                    <script>
                        function successfulmessage() {
                            alert('Signature captured successfully!');
                        }
                        function storeimage() {
                            var canvas = document.getElementById('myCanvas');
                            var context = canvas.getContext('2d');
                            var dataURL = canvas.toDataURL();
                            var h = document.getElementById('myurl');
                            h.value = dataURL;

                            //document.getElementById('resetSign').click();
                            //document.getElementById('Image1').src = dataURL;
                        }
                    </script>
                </div>
                <div class="col-sm-6">

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>


                            <div class="container">
                                <div class="page-header">
                                    <h1>
                                        <small>
                                            <asp:Label ID="Label1" runat="server" Text="Signature Form">
                                            </asp:Label></small></h1>
                                    <div class="navbar-right">
                                        <asp:LinkButton runat="server" ID="btnBack" OnClick="btnBack_Click" CssClass="btn btn-default"><span class="glyphicon glyphicon-chevron-left"></span> back</asp:LinkButton>
                                    </div>
                                </div>
                                <asp:Panel ID="Panel1" runat="server">
                                   <%-- <asp:TextBox ID="tboxName" CssClass="form-control" placeholder="Full name" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tboxName" Text="*" ForeColor="Red" ValidationGroup="g1"
                                        ErrorMessage="Full name is required"></asp:RequiredFieldValidator>
                                    <br />--%>

                                    <asp:Button ID="Button2" CssClass="btn btn-primary" ValidationGroup="g1" OnClientClick="storeimage()" Width="200" runat="server" Text="capture signature" OnClick="Button2_Click" /><br />
                                    <br />
                                    <asp:Button ID="Button1" runat="server" Width="200" CssClass="btn btn-danger" Text="use my signature" OnClick="Button1_Click" />
                                    <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="g1" CssClass="alert alert-danger" runat="server" />
                                </asp:Panel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
