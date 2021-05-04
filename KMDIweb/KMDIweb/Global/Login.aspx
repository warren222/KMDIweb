<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="KMDIweb.SCREENfab.Login" %>

<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<html xmlns="http://www.w3.org/1999/xhtml">


<head runat="server">

    <title>Log in</title>

    <script src="../../Scripts/bootstrap.js"></script>
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>
    <link href="css/gridcss.css" rel="stylesheet" />
    <style>
        body, html, form {
            height: 100%;
        }

        .wrapper {
            background-color: #e4e5e7;
            display: flex;
            align-items: center;
            flex-direction: column;
            justify-content: center;
            width: 100%;
            min-height: 100%;
            height: 100%;
        }

        .themecolor {
            background-color: #c32361;
            border-color: #c32361;
        }

        .myform {
            background-color: white;
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
    <form id="form1" runat="server" style="height: 100%">

        <div class="wrapper">

            <div class="myform">
                <div class="container">
                    <div class="well themecolor" style="text-align: center; border-radius: 0; color: white">
                        <h1><strong>KM</strong>
                            <br />
                            <small style="color: #ea4c89">web application</small></h1>
                    </div>
                    <div class="panel panel-danger" style="width: 400px;">
                        <div class="panel-heading">
                            <h4>User Login</h4>
                        </div>
                        <div class="panel-body">
                            <small style="text-align: center">Choose data source</small>
                            <br />
                            <div class="input-group">
                                <div class="input-group-addon">
                                    <span class="glyphicon glyphicon-cloud"></span>
                                </div>
                                <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                                    <asp:ListItem Text="server 1" Value="server 1"></asp:ListItem>
                                    <asp:ListItem Text="server 2" Value="server 2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
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
                            <asp:LinkButton ID="LinkButton1" CssClass="form-control btn btn-danger themecolor" OnClick="Button1_Click" runat="server"><span class="glyphicon glyphicon-log-in"></span>&nbsp; login</asp:LinkButton>

                            <asp:ValidationSummary CssClass="alert alert-danger" ValidationGroup="val1" ID="ValidationSummary1" runat="server" />


                        </div>
                        <div class="panel-footer">

                            <p><small>Copyright 2020. Kenneth and Mock windows and doors. All rights Reserved.</small></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </form>
</body>
</html>
