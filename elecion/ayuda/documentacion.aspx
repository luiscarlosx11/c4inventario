<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="documentacion.aspx.cs" Inherits="elecion.ayuda.documentacion" %>
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
            <h3 class="content-header-title">DOCUMENTACIÓN</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Ayuda</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Documentación</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
   <asp:Button runat="server" ID="bimprimir" OnClick="imprimeSolicitud" UseSubmitBehavior="false" Style="display: none" />
    <asp:Button runat="server" ID="bimprimirGrupos" OnClick="imprimeGrupos" UseSubmitBehavior="false" Style="display: none" />
    <asp:Button runat="server" ID="bimprimirCursos" OnClick="imprimeCursos" UseSubmitBehavior="false" Style="display: none" />

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>
            <div class="row" id="header-styling">
                <div class="col-xs-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title"></h4>
                            <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                            <div class="heading-elements">
                                <ul class="list-inline mb-0">
                                  
                                </ul>
                            </div>
                        </div>
                        <div class="card-body collapse in">
                            
                                                     
                            <!--
                            <div class="card-block card-dashboard">
                                 <div class="row">
                                     
                                    <div class="col-md-4">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Concepto</label>
											<asp:TextBox ID="bfolio" CssClass="form-control text-uppercase" placeholder="Concepto" name="bfolio" runat="server" ></asp:TextBox>
										</div>
									</div>

                                     <div class="col-md-2">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Fecha inicial</label>
											<asp:TextBox ID="bfecha" CssClass="form-control pickadate text-uppercase" placeholder="Desde" name="bfecha" runat="server" Text="">

											</asp:TextBox>
										</div>
									</div>  
                                     
                                     <div class="col-md-2">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Fecha final</label>
											<asp:TextBox ID="bfechafin" CssClass="form-control pickadate text-uppercase" placeholder="Hasta" name="bfecha" runat="server" Text="">

											</asp:TextBox>
										</div>
									</div>                                  
                              </div>                              
                            
                            </div>                                                      
                           -->
                                        
                        <div class="card">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-md-3">
                                        <div class="card-block text-xs-center">
                                            <div class="card-header mb-2">
                                                <span class="danger">PDF</span>
                                                <h1 class=" blue-grey darken-1">Manual de Usuario</h1>
                                            </div>
                                            <div class="card-body">
                                                <input type="text" value="50" class="knob hide-value responsive angle-offset" data-angleoffset="0" data-thickness=".15" data-linecap="round" data-width="100" data-height="100" data-inputcolor="#e1e1e1" data-readonly="true" data-fgcolor="#FF7588" data-knob-icon="icon-notebook">
                                                <ul class="list-inline clearfix mt-2">
                                                    <button type="button" id="Button2" runat="server" onclick="document.getElementById('download').click();" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                        <a href="http://pge.icaten.gob.mx/pdf/Manualdeusuario.pdf" target="_blank" download id="download" hidden></a>
                                                        <i class="ft-print"></i>Descargar
                                                    </button>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="card-block text-xs-center">
                                            <div class="card-header mb-2">
                                                <span class="success">VIDEO</span>
                                                <h1 class=" blue-grey darken-1">Video Capacitación</h1>
                                            </div>
                                            <div class="card-body">
                                                <input type="text" value="50" class="knob hide-value responsive angle-offset" data-angleoffset="0" data-thickness=".15" data-linecap="round" data-width="100" data-height="100" data-inputcolor="#e1e1e1" data-readonly="true" data-fgcolor="#1ABC9C" data-knob-icon="icon-camcorder">
                                                <ul class="list-inline clearfix mt-2">
                                                    <button type="button" id="Button1" runat="server" onclick="document.getElementById('download').click();" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                        <a href="http://pge.icaten.gob.mx/pdf/Manualdeusuario.pdf" target="_blank" download id="download" hidden></a>
                                                        <i class="ft-print"></i>Reproducir
                                                    </button>
                                                </ul>
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

     
    <div class="modal fade text-xs-left" id="bootstrap" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
        
		        <div class="modal-dialog" role="document">
		        <div class="modal-content">
			        <div class="modal-header bg-primary white">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				        <span aria-hidden="true">&times;</span>
			        </button>
			        <h3 class="modal-title" id="myModalLabel35">INGRESO</h3>
			        </div>
			   
                       
			        <div class="modal-body">
                    <section class="input-validation inputmask">
	                            <div class="row">
	                                <div class="col-md-12">
	                                    <div class="card">
	                                        <div class="card-header">
	                                            
	                                        </div>
                                            <div class="card-body collapse in">
                                                <div class="card-block">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label>Concepto</label>
                                                                <asp:HiddenField runat="server" ID="idP" />
                                                                <asp:HiddenField runat="server" ID="idS" />
                                                                <asp:TextBox ID="concepto" CssClass="form-control text-uppercase" placeholder="Concepto" name="concepto" runat="server"></asp:TextBox>
                                                                
                                                               
                                                            </div>


                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label>Importe</label>                                                                
                                                                <asp:TextBox ID="importe" CssClass="form-control text-uppercase" name="idtipogasto" placeholder="Importe" runat="server"></asp:TextBox>                                                     </div>


                                                        </div>
                                                    </div>

                                                </div>

                                            </div>
                                            </div>
	                                    </div>
	                                </div>
	                            </div>

                        
                           
                   
			        <div class="modal-footer">
                        <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" style="display:none" CausesValidation="true"/>     
                        <asp:Button runat="server" ID="borrar" OnClick="borrarRegistro" style="display:none" />
                        
				        <button class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false"> 
	                        <i class="fa fa-check-square-o"></i> Aceptar
	                     </button>
                 
	                     <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
	                        <i class="ft-x"></i> Cancelar
	                     </button>
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

    <script src="/app-assets/vendors/js/extensions/jquery.knob.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/raphael-min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/morris.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/cards/card-statistics.js" type="text/javascript"></script>



    <script>
        
        $(".nav-item>ul>li.active").removeClass("active");
        $("#documentacion").addClass("active");

        

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
                    $('#<%= borrar.ClientID %>').click();
                    
                   
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
                $('#<%= guardar.ClientID %>').click();
                $('#bootstrap').modal('hide');
;                return true;
                               
            
        }


        function imprimirFormato(op) {

            mostrarLoading();
            
           if(op==1)
               $('#<%= bimprimir.ClientID %>').click();
           else if(op==2)
                $('#<%= bimprimirCursos.ClientID %>').click();
           else if (op == 4)
               $('#<%= bimprimirGrupos.ClientID %>').click();
            cerrarLoading();
        }

        function general() {
            var url = "../reportes/RVGeneral.aspx?idsucursal=" + $("*[id$='idS']").val() + "&fechaini=" + $("*[id$='bfecha']").val() + "&fechafin=" + $("*[id$='bfechafin']").val();            
            window.open(url, '_blank');
        }

        function fiscal() {
            var url = "../reportes/RVFiscal.aspx?idsucursal=" + $("*[id$='idS']").val() + "&fechaini=" + $("*[id$='bfecha']").val() + "&fechafin=" + $("*[id$='bfechafin']").val();
            window.open(url, '_blank');
        }

        function ventas() {
            var url = "../reportes/RVVentas.aspx?idsucursal=" + $("*[id$='idS']").val() + "&fechaini=" + $("*[id$='bfecha']").val() + "&fechafin=" + $("*[id$='bfechafin']").val();
            window.open(url, '_blank');
        }

        function comisiones() {
            var url = "../reportes/RVComisiones.aspx?idsucursal=" + $("*[id$='idS']").val() + "&fechaini=" + $("*[id$='bfecha']").val() + "&fechafin=" + $("*[id$='bfechafin']").val();
            window.open(url, '_blank');
        }

        function movimientos() {
            var url = "../reportes/RVMovDiarios.aspx?idsucursal=" + $("*[id$='idS']").val() + "&fechaini=" + $("*[id$='bfecha']").val() + "&fechafin=" + $("*[id$='bfechafin']").val();
            window.open(url, '_blank');
        }

        function intereses() {
           // var url = "../reportes/RVIntereses.aspx?idsucursal=" + $("*[id$='idS']").val() + "&fechaini=" + $("*[id$='bfecha']").val() + "&fechafin=" + $("*[id$='bfechafin']").val();
            //window.open(url, '_blank');
        }

        function existencias() {
            //var url = "../reportes/RVExistencias.aspx?idsucursal=" + $("*[id$='idS']").val() + "&fechaini=" + $("*[id$='bfecha']").val() + "&fechafin=" + $("*[id$='bfechafin']").val();
            //window.open(url, '_blank');
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

                loadJS("/app-assets/js/scripts/cards/card-statistics.js");

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
                    lineColor: '#16D39A',
                    fillColor: '#16D39A',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });

                $("#sp-line-total-cost2").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                    type: 'line',
                    width: '100%',
                    height: '100px',
                    lineColor: '#FFA87D',
                    fillColor: '#FFA87D',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });

                $("#sp-line-total-cost3").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                    type: 'line',
                    width: '100%',
                    height: '100px',
                    lineColor: '#2DCEE3',
                    fillColor: '#2DCEE3',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });

                $("#sp-line-total-cost4").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                    type: 'line',
                    width: '100%',
                    height: '100px',
                    lineColor: '#FF7588',
                    fillColor: '#FF7588',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });

                $("#sp-line-total-cost5").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                    type: 'line',
                    width: '100%',
                    height: '100px',
                    lineColor: '#FF7588',
                    fillColor: '#FF7588',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });
                //loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                //loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");

        }
    </script>
</asp:Content>
