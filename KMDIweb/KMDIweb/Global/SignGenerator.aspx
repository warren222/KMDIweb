<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignGenerator.aspx.cs" Inherits="KMDIweb.KMDIweb.Global.SignGenerator" %>

<meta name="viewport" content="width=device-width, initial-scale=1">

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PO Signing</title>
    <script src="../../Scripts/bootstrap.js"></script>
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../Scripts/bootstrap.min.js"></script>
    <script src="../../Scripts/jquery-1.10.2.min.js"></script>
    <script src="scripts/sign.js"></script>
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
            border: 1px solid white;
            border-radius: 1px;
            background-color: white;
        }

        .tbl td {
            padding-bottom: 10px;
        }
    </style>
    <script>

    </script>
</head>
<body style="background-color: black;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container-fluid">

            <canvas id="myCanvas"></canvas>
            <input type='hidden' id='myurl' name='myurl' />
            <input type='hidden' id='myurl1' name='myurl1' />
            <br />
            <asp:TextBox ID="tboxName" CssClass="form-control" Width="360px" placeholder="Full name" runat="server"></asp:TextBox>
            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                <asp:Button runat="server" CssClass="btn btn-danger btn-group" Width="180" Text="Reset Sign" ID='resetSign' />
                <asp:Button ID="Button2" CssClass="btn btn-primary btn-group" Width="180" ValidationGroup="g1" OnClientClick="storeimage()" runat="server" Text="save signature" OnClick="Button2_Click" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tboxName" Text="*" ForeColor="Red" ValidationGroup="g1"
                    ErrorMessage="Full name is required"></asp:RequiredFieldValidator>
                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="g1" CssClass="alert alert-danger" runat="server" />
            </div>

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
    </form>
</body>
</html>
