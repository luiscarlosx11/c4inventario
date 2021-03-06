<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportViewerForm1.aspx.cs" Inherits="elecion.promovidos.ReportViewerForm1" EnableEventValidation="false" %>

<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Telerik HTML5 Web Forms Report Viewer Form</title>
	<script src="../jquery-1.9.1.min.js"></script>

	<style>
		#reportViewer1 {
			position: absolute;
			left: 5px;
			right: 5px;
			top: 5px;
			bottom: 5px;
			overflow: hidden;
			font-family: Verdana, Arial;
		}
	</style>

</head>
<body>

    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>     

        <telerik:ReportViewer
            ID="reportViewer1" 
			Width="1300px"
			Height="900px"
			EnableAccessibility="true"
            runat="server">
            <ReportSource IdentifierType="TypeReportSource" Identifier="elecion.promovidos.RepListadoPromovidos, elecion, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
            </ReportSource>
        </telerik:ReportViewer>

            </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>