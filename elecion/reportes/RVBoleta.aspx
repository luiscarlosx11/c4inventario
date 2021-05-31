<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RVBoleta.aspx.cs" Inherits="elecion.reportes.RVBoleta" %>

<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rendilana - Boleta de Empe�o</title>
	 <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

    <link href="https://kendo.cdn.telerik.com/2018.2.620/styles/kendo.common.min.css" rel="stylesheet" />
    <link href="https://kendo.cdn.telerik.com/2018.2.620/styles/kendo.blueopal.min.css" rel="stylesheet" />

	<!--If Kendo is used it should be added before the report viewer.-->
	<script src="/api/reports/resources/js/telerikReportViewer"></script>
    <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />
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
    <form runat="server" >
        <telerik:ReportViewer
            ID="reportViewer1" 
			Width="100%"
			Height="100%"
			EnableAccessibility="true"
            runat="server" ViewMode="PrintPreview">
            <ReportSource IdentifierType="TypeReportSource" Identifier="ReportLibrary.ReportBoleta, ReportLibrary, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null">
                 <Parameters>
                    <telerik:Parameter Name="idempeno" />
                    <telerik:Parameter Name="idsucursal" />
                </Parameters>
            </ReportSource>
        </telerik:ReportViewer>
    </form>
</body>
</html>