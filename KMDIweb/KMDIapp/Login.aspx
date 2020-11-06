<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="KMDIweb.SCREENfab.Login" %>

<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<html xmlns="http://www.w3.org/1999/xhtml">


<head runat="server">
    <title>Log in</title>

    <script src="../Scripts/bootstrap.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link href="css/gridcss.css" rel="stylesheet" />
    <style>
        html, form {
            background-color: #56baed;
        }

        .wrapper {
            display: flex;
            align-items: center;
            flex-direction: column;
            justify-content: center;
            width: 100%;
            min-height: 100%;
            padding-top: 70px;
            height: 100%;
        }

        .underlineHover:after {
            display: block;
            left: 0;
            bottom: -10px;
            width: 0;
            height: 2px;
            background-color: #56baed;
            content: "";
            transition: width 0.2s;
        }

        .underlineHover:hover {
            color: #0d0d0d;
        }

            .underlineHover:hover:after {
                width: 100%;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <div class="panel panel-primary" style="width: 400px">
                <div class="panel-heading">
                    User Login
                </div>
                <div class="panel-body">
                    <small>Choose data source</small>
                    <br />
                    <asp:RadioButton ID="server1" GroupName="con" Text="Server 1" runat="server" Font-Names="Calibri Light" />&nbsp;&nbsp;
                    <asp:RadioButton ID="server2" Text="Server 2" GroupName="con" runat="server" Font-Bold="False" Font-Names="Calibri Light" />
                    <br />
                    <br />
                    <div class="input-group">
                        <div class="input-group-addon">
                            <span class="glyphicon glyphicon-user"></span>
                        </div>
                        <asp:TextBox ID="tboxusername" Height="40" placeholder="username" CssClass="form-control" runat="server"></asp:TextBox><br />
                    </div>
                    <br />
                    <div class="input-group">
                        <div class="input-group-addon">
                            <span class="glyphicon glyphicon-lock"></span>
                        </div>
                        <asp:TextBox ID="tboxpassword" Height="40" placeholder="password" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox>
                    </div>
                    <div class="checkbox">
                        <asp:CheckBox ID="CheckBox1" runat="server" Text="Remember me" />
                    </div>
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Login" OnClick="Button1_Click" />
                    <asp:ValidationSummary CssClass="alert alert-danger" ValidationGroup="val1" ID="ValidationSummary1" runat="server" />
                </div>
                <div class="panel-footer">

                    <p><small>Copyright 2020. Kenneth and Mock windows and doors. All rights Reserved.</small></p>
                </div>
            </div>

        </div>

    </form>
</body>
</html>
