<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="KMDIweb.KMDIweb.Production.ScreenSchedule.WebForm1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="border:1px solid black;">
            <tr>
                <td class="auto-style1"><b>Select Chart Type:</b></td>
                <td class="auto-style1">
                    <asp:DropDownList ID="DropDownList1" AutoPostBack="true" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>

                </td>
            </tr>
        </table>
        <asp:Chart ID="Chart1" runat="server">
        <Series>
            <asp:Series Name="Series1" XValueMember="MM" YValueMembers="Amount">
              <%--  <Points>
                    <asp:DataPoint AxisLabel="War" YValues="100" />
                        <asp:DataPoint AxisLabel="War" YValues="100" />
                        <asp:DataPoint AxisLabel="War" YValues="100" />
                </Points>--%>
            </asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1">
                <AxisX Title="name"></AxisX>
                <AxisY Title="points"></AxisY>
            </asp:ChartArea>
        </ChartAreas>
    </asp:Chart>
    </div>
    </form>
</body>
</html>
