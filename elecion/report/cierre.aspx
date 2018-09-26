<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false"CodeBehind="cierre.aspx.cs" Inherits="elecion.report.cierre" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .ascending a {
	       /* background:url(/images/descending.png) right no-repeat;*/
	        display:block;
        }

        .descending a {
	      /*  background:url(/images/ascending.png) right no-repeat;*/
	        display:block;
	
        }

   
   
}
    </style>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

        <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css"/>

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/daterange/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/datetime/bootstrap-datetimepicker.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/pickadate/pickadate.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/pickers/daterange/daterange.css">


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">REPORTES</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Reportes</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Corte Diario</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
   
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>
            <div class="row" id="header-styling">
                <div class="col-xs-12">
                    <div class="card">
                        <div class="card-header">
                            <asp:HiddenField ID="idS" runat="server"/>
                            <h4 class="card-title">CORTE DIARIO</h4>
                            <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                            <div class="heading-elements">
                                <ul class="list-inline mb-0">
                                  
                                </ul>
                            </div>
                        </div>
                        <div class="card-body collapse in">
                            <div class="row">

                                <div class="col-md-12">
                                    
                                    <div class="card no-border">
                                        <div class="card-body">
                                            <div class="card-block">
                                                <div class="media">
                                                    <div class="media-body">
                                                        <h1 class="display-4">
                                                            <asp:Label runat="server" ID="lsaldocaja">$0.00</asp:Label></h1>
                                                        <span class="text-muted">Saldo en Caja</span>
                                                    </div>
                                                    <div class="media-right media-middle">
                                                        <button type="button" id="nuevo" runat="server" onclick="insertar()" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                            <i class="ft-file"></i>Nuevo empeño 
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="sp-line-total-cost"></div>
                                        </div>
                                    </div>
                                 
                                </div>

                            </div>
                            <div class="row">

                                <div class="col-md-6">

                                    <div class="col-md-12">
                                    <div class="card overflow-hidden">
                                        <div class="card-body">
                                            <div class="media">
                                                <div class="media-left bg-teal p-2 media-middle">
                                                    <i class="icon-pencil font-large-2 white"></i>
                                                </div>
                                                <div class="media-body p-2">
                                                    <h4>Saldo</h4>
                                                    <span>Inicial</span>
                                                </div>
                                                <div class="media-right p-2 media-middle">
                                                    <h1 class="black">
                                                        <asp:Label runat="server" ID="lsaldoinicial">$0.00</asp:Label></h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="card overflow-hidden">
                                        <div class="card-body">
                                            <div class="media">
                                                <div class="media-left bg-success p-2 media-middle">
                                                    <i class="icon-pencil font-large-2 white"></i>
                                                </div>
                                                <div class="media-body p-2">
                                                    <h4>Total</h4>
                                                    <span>Ventas</span>
                                                </div>
                                                <div class="media-right p-2 media-middle">
                                                    <h1 class="black">
                                                        <asp:Label runat="server" ID="lventas">$0.00</asp:Label></h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="card overflow-hidden">
                                        <div class="card-body">
                                            <div class="media">
                                                <div class="media-left bg-warning p-2 media-middle">
                                                    <i class="icon-pencil font-large-2 white"></i>
                                                </div>
                                                <div class="media-body p-2">
                                                    <h4>Total</h4>
                                                    <span>Refrendos</span>
                                                </div>
                                                <div class="media-right p-2 media-middle">
                                                    <h1 class="black">
                                                        <asp:Label runat="server" ID="lrefrendos">$0.00</asp:Label></h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12">
                                    <div class="card overflow-hidden">
                                        <div class="card-body">
                                            <div class="media">
                                                <div class="media-left bg-cyan p-2 media-middle">
                                                    <i class="icon-pencil font-large-2 white"></i>
                                                </div>
                                                <div class="media-body p-2">
                                                    <h4>Total</h4>
                                                    <span>Apartados</span>
                                                </div>
                                                <div class="media-right p-2 media-middle">
                                                    <h1 class="black">
                                                        <asp:Label runat="server" ID="lapartados">$0.00</asp:Label></h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>



                                <div class="col-md-12">
                                    <div class="card overflow-hidden">
                                        <div class="card-body">
                                            <div class="media">
                                                <div class="media-left bg-danger p-2 media-middle">
                                                    <i class="icon-pencil font-large-2 white"></i>
                                                </div>
                                                <div class="media-body p-2">
                                                    <h4>Total</h4>
                                                    <span>Préstamos</span>
                                                </div>
                                                <div class="media-right p-2 media-middle">
                                                    <h1 class="black">
                                                        <asp:Label runat="server" ID="lprestamos">$0.00</asp:Label></h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                                <div class="col-md-6">
                                    <div class="col-md-12">
                                        <div class="row">

                                    

                                     <div class="col-md-6">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Fecha</label>
											<asp:TextBox ID="bfecha" CssClass="form-control pickadate text-uppercase" placeholder="Fecha" name="bfecha" runat="server" AutoPostBack="true" Text="" OnTextChanged="getDatos">

											</asp:TextBox>
										</div>
									</div>                                  
                                 </div>  
                                    
                                </div>


                                    <div class="col-md-12">
                                    <div class="card overflow-hidden">
                                        <div class="card-body">
                                            <div class="media">
                                                <div class="media-left bg-success p-2 media-middle">
                                                    <i class="icon-pencil font-large-2 white"></i>
                                                </div>
                                                <div class="media-body p-2">
                                                    <h4>Total</h4>
                                                    <span>Ingresos</span>
                                                </div>
                                                <div class="media-right p-2 media-middle">
                                                    <h1 class="black">
                                                        <asp:Label runat="server" ID="lingresos">$0.00</asp:Label></h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                                    <div class="col-md-12">
                                    <div class="card overflow-hidden">
                                        <div class="card-body">
                                            <div class="media">
                                                <div class="media-left bg-danger p-2 media-middle">
                                                    <i class="icon-pencil font-large-2 white"></i>
                                                </div>
                                                <div class="media-body p-2">
                                                    <h4>Total</h4>
                                                    <span>Egresos</span>
                                                </div>
                                                <div class="media-right p-2 media-middle">
                                                    <h1 class="black">
                                                        <asp:Label runat="server" ID="legresos">$0.00</asp:Label></h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                </div>
                             </div>
                            
                            

                           
                           
                            </div>
                            
                           
                        
                    </div>
                </div>
            </div>

     
   
            
                </section>
	        </div>
            
  
    </ContentTemplate>
    </asp:UpdatePanel> 
              
           
     </asp:Content>      

<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

     <script src="/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.date.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.time.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/legacy.js" type="text/javascript"></script>

    <script src="/app-assets/data/jvector/visitor-data.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/chart.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/unslider-min.js" type="text/javascript"></script>

    <script src="/app-assets/js/scripts/cards/card-statistics.js" type="text/javascript"></script>



    <script>
        
        $(".nav-item>ul>li.active").removeClass("active");
        $("#corted").addClass("active");

        

        function abrirModal(idp, ids, concepto, importe) {
                                   
            $("*[id$='idP']").val(idp);
            $("*[id$='idS']").val(ids);
            $("*[id$='concepto']").val(concepto);
            $("*[id$='importe']").val(importe);
        
            $("#bootstrap").modal('show');
        }

        function eliminarRegistro(idp, ids, concepto) {

            $("*[id$='idP']").val(idp);
            $("*[id$='idS']").val(ids);


             swal({
                title: "Se realizará la cancelación de este ingreso, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Si",
                cancelButtonText: "No",
                closeOnConfirm: false,
                closeOnCancel: true
            },
            function (isConfirm) {
                if (isConfirm) {
                    mostrarLoading();
                   
                   
                } 
            });

        }


        function valida() {
       
            var concepto = $("*[id$='concepto']").val();
            var importe = $("*[id$='importe']").val();

            if (concepto == '' ) {               
                 swal("Atención", "Ingrese el concepto del ingreso", "warning");                             
                return false;
            }

            if (importe == '' || importe == '0') {
                swal("Atención", "Ingrese el importe del ingreso", "warning");
                return false;
            }
                
                mostrarLoading();

                $('#bootstrap').modal('hide');
;                return true;
                               
            
        }
       

        
    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
    <script>

        function loadJS(file) {
            // DOM: Create the script element
            var jsElm = document.createElement("script");
            // set the type attribute
            jsElm.type = "application/javascript";
            // make the script element load file
            jsElm.src = file;
            // finally insert the element to the body element in order to load the script
            document.body.appendChild(jsElm);
        }

        function pageLoad(sender, args) {

               // $("*[id$='cp']").ForceNumericOnly(); 
               // $("*[id$='seccion']").ForceNumericOnly();
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
                loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
                loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

                loadJS("/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js");
                loadJS("/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.date.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.time.js");
                loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");

                $('.pickadate').pickadate({
                    format: 'yyyy-mm-dd',
                    formatSubmit: 'yyyy-mm-dd',
                    monthsFull: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                    weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab'],
                    today: 'Hoy',
                    clear: 'Limpiar',
                });
                

                $("#sp-line-total-cost").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                    type: 'line',
                    width: '100%',
                    height: '100px',
                    lineColor: '#6695CA',
                    fillColor: '#6695CA',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });

               
        }
    </script>
</asp:Content>
