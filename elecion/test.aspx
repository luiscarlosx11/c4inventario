<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="elecion.test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/datatable/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/extensions/buttons.dataTables.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/datatable/buttons.bootstrap4.min.css" />
</asp:Content> 

<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">

    <div class="content-header row">
          <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">HTML 5 Data Export</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Home</a>
                </li>
                <li class="breadcrumb-item"><a href="#">DataTables</a>
                </li>
                <li class="breadcrumb-item active">HTML 5 Data Export
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content> 

<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
    <section id="html56">
        
        <div class="row">
		<div class="col-xs-12">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title">HTML5 export buttons</h4>
					<a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
					<div class="heading-elements">
						<ul class="list-inline mb-0">
							<li><a data-action="collapse"><i class="ft-minus"></i></a></li>
							<li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
							<li><a data-action="expand"><i class="ft-maximize"></i></a></li>
							<li><a data-action="close"><i class="ft-x"></i></a></li>
						</ul>
					</div>
				</div>
				<div class="card-body collapse in">
					<div class="card-block card-dashboard">
						<p class="card-text">The HTML5 export buttons plug-in for Buttons provides four export buttons:</p>
						<p>copyHtml5 - Copy to clipboard</p>
						<p>csvHtml5 - Save to CSV file</p>
						<p>excelHtml5 - Save to XLSX file - requires JSZip</p>
						<p>pdfHtml5 - Save to PDF file - requires PDFMake</p>
                        <asp:GridView runat="server" ID="tablax" CssClass="table table-striped table-bordered dataex-html5-export" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="DStablax">
                            <Columns>
                                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
                                <asp:BoundField DataField="nombre" HeaderText="nombre" SortExpression="nombre" />
                                <asp:BoundField DataField="tipo" HeaderText="tipo" SortExpression="tipo" />
                            </Columns>
                        </asp:GridView>		
					    <asp:SqlDataSource ID="DStablax" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [id], [nombre], [tipo] FROM [usuarios]"></asp:SqlDataSource>
					</div>
				</div>
			</div>
		</div>
	</div>

    </section>

</asp:Content> 

<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <!-- BEGIN PAGE VENDOR JS-->
    <script src="/app-assets/vendors/js/tables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/datatable/dataTables.bootstrap4.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/datatable/dataTables.buttons.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/datatable/buttons.bootstrap4.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/jszip.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/pdfmake.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/vfs_fonts.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/buttons.html5.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/buttons.print.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/buttons.colVis.min.js" type="text/javascript"></script>
    <!-- END PAGE VENDOR JS-->
</asp:Content>   
   
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
    <script src="/app-assets/js/scripts/tables/datatables-extensions/datatable-button/datatable-html5.js" type="text/javascript"></script>
</asp:Content>
