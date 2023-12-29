<%@ Page Language="C#" MasterPageFile="~/KMDIweb/PO/PO.Master" AutoEventWireup="true" CodeBehind="PO_Laminated_Rpt.aspx.cs" Inherits="KMDIweb.KMDIweb.PO.PO_Laminated_Rpt" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="content">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2 class="text-center">Laminated</h2>
        </div>
        <div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>" SelectCommand="Web_PO_Stp" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource1_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="Command" Type="String" DefaultValue="Get_PO" />
                    <asp:SessionParameter Name="PO_No" SessionField="POPO_No" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:sqlcon %>" SelectCommand="Web_PO_Stp" SelectCommandType="StoredProcedure" OnSelecting="SqlDataSource2_Selecting">
                <SelectParameters>
                    <asp:Parameter Name="Command" Type="String" DefaultValue="Get_Glass_PO" />
                    <asp:SessionParameter Name="JO_No" SessionField="POJO_No" Type="String" />
                    <asp:SessionParameter Name="PO_No" SessionField="POPO_No" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
               <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                   <rsweb:ReportViewer ID="ReportViewer1" Width="100%" Height="800px" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                       <LocalReport ReportPath="KMDIweb\Global\Reports\PO_Laminated.rdlc">
                        <DataSources>
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource1" Name="DataSet1" />
                            <rsweb:ReportDataSource DataSourceId="SqlDataSource2" Name="DataSet2" />
                        </DataSources>
                    </LocalReport>
                   </rsweb:ReportViewer>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
