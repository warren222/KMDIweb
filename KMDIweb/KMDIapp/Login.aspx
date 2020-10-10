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
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <div class="row">
                <div class="col-sm-6">
                    <div class="well">
                        <strong>Choose data source</strong>
                        <br />
                        <asp:RadioButton ID="server1" GroupName="con" CssClass="text-success" Text="Server 1" runat="server" />&nbsp;&nbsp;
                    <asp:RadioButton ID="server2" Text="Server 2" CssClass="text-success" GroupName="con" runat="server" />
                    </div>
                    <blockquote>
                        <asp:TextBox ID="tboxusername" Height="40" placeholder="username" CssClass="form-control" runat="server"></asp:TextBox><br />
                        <asp:TextBox ID="tboxpassword" Height="40" placeholder="password" CssClass="form-control" TextMode="Password" runat="server"></asp:TextBox><br />
                        <div class="checkbox">
                            <asp:CheckBox ID="CheckBox1" runat="server" Text="Remember me" />
                        </div>
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Login" OnClick="Button1_Click" />
                        <asp:ValidationSummary CssClass="alert alert-danger" ValidationGroup="val1" ID="ValidationSummary1" runat="server" />
                    </blockquote>
                </div>
                <div class="col-sm-6">
                </div>
            </div>
        </div>
        <footer class="container-fluid text-center" style="background-color: white; margin-top: 0px;">
            <br />
            <br />
            <br />
            <p>Copyright 2020. Kenneth and Mock windows and doors. All rights Reserved.</p>
        </footer>
    </form>
</body>
</html>
