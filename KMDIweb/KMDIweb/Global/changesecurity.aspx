<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="changesecurity.aspx.cs" Inherits="KMDIweb.KMDIapp.changesecurity" %>



<!DOCTYPE html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <script src="../../Scripts/bootstrap.js"></script>
    <link href="../../Content/bootstrap.css" rel="stylesheet" />
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>
    <link href="css/gridcss.css" rel="stylesheet" />
    <title>Change Security</title>
    <style>
        body, html {
            height: 100%;
        }

        .wrapper {
            display: flex;
            /*align-items: center;
            flex-direction: column;*/
            justify-content: center;
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
          <div class="container">
        <div class="well">
            <h1>
                <strong>Change Security</strong><small></small>
            </h1>
        </div>

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:ValidationSummary ID="ValidationSummary2" CssClass="alert alert-danger" ValidationGroup="errorval" runat="server" />
        <div class="wrapper">
            <div style="width: 400px; background-color: whitesmoke; padding: 25px; height: 100%">
                Username<br />
                <asp:TextBox ID="usernametbox" CssClass="form-control" placeholder="new username" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="usernametbox"
                    ValidationGroup="val1" ErrorMessage="Username is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <br />
                New password<br />
                <asp:TextBox ID="npassword" TextMode="Password" CssClass="form-control" placeholder="new password" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="npassword"
                    ValidationGroup="val1" ErrorMessage="new password is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <br />
                confirm password<br />
                <asp:TextBox ID="confirmpasswordtbox" TextMode="Password" CssClass=" form-control" placeholder="confirm new password" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="confirmpasswordtbox"
                    ValidationGroup="val1" ErrorMessage="confirm password is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="confirmpasswordtbox" ControlToCompare="npassword"
                    ValidationGroup="val1" ErrorMessage="password did not match" ForeColor="Red">*</asp:CompareValidator>
                <br />
                Old password<br />
                <asp:TextBox ID="oldpasswordtbox" TextMode="Password" CssClass=" form-control" placeholder="old password" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="oldpasswordtbox"
                    ValidationGroup="val1" ErrorMessage="Old password is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                <br />
                <asp:LinkButton ID="LinkButton1" CssClass="form-control btn btn-primary" ValidationGroup="val1" runat="server" OnClick="LinkButton1_Click">confirm changes</asp:LinkButton>
                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" runat="server" class="alert alert-danger" />
            </div>
        </div>
    </div>
    </form>
</body>
</html>
