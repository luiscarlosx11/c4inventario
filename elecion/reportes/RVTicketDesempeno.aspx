<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RVTicketDesempeno.aspx.cs" Inherits="elecion.reportes.RVTicketDesempeno" EnableEventValidation="false"  %>

<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rendilana - Ticket Desempeño</title>
	<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>

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
       
        <telerik:ReportViewer
            ID="reportViewer1" 
			Width="100%"
			Height="100%"
			EnableAccessibility="false"
            runat="server" PrintMode="ForcePDFPlugin">
            <ReportSource IdentifierType="TypeReportSource" Identifier="ReportLibrary.ReportTicketDesempeno, ReportLibrary">
                <Parameters>
                    <telerik:Parameter Name="idempeno" />
                    <telerik:Parameter Name="idsucursal" />
                    <telerik:Parameter Name="idhistorial" />
                </Parameters>
            </ReportSource>
        </telerik:ReportViewer>
        
        
        </form>
    

    <script>

       /* function algo() {           
        var viewer = $("#reportViewer1").data("telerik_ReportViewer");
        viewer.reportSource({
            report: viewer.reportSource().report,
            parameters: { idempeno: 1 , idsucursal:1}
        });
        }*/
        //setting the HTML5 Viewer's reportSource, causes a refresh automatically
        //if you need to force a refresh for other case, use:
        //viewer.refreshReport();
    </script>
</body>
</html>