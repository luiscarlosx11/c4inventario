<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="registroEncuestas.aspx.cs" Inherits="elecion.encuesta.registroEncuestas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/daterange/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/datetime/bootstrap-datetimepicker.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/pickadate/pickadate.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/pickers/daterange/daterange.css">

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/toastr.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/extensions/toastr.css">

    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Encuestas</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Campaña</a>
                </li>
                  <li class="breadcrumb-item"><a href="#">Encuestas</a>
                </li
                <li class="breadcrumb-item active"><a href="#">Registro</a>
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
	    <div class="row">
	        <div class="col-md-12">
	            <div class="card">
	                <div class="card-header">
	                    <h4 class="card-title" id="horz-layout-basic">Registro de Encuestas</h4>
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
                        
	                    <div class="card-block">
						    <div class="card-text">
							    <p>
                                     
                                    <asp:Button runat="server" ID="Bborrar" OnClick="borrarRegistro" style="display:none"/> 
                                     <asp:HiddenField runat="server" ID="idP" Value="0"/> 
                                    <asp:HiddenField runat="server" ID="idtP" Value="0"/>

							    </p>
						    </div>
	                  
	                    		   <div class="form-group row">
	                            	    <label class="col-md-3 label-control" for="fecha">Inicia en</label>
		                                <div class="col-md-3">                                                 
                                            <asp:TextBox ID="fechaini" CssClass="form-control pickadate" maxlength="50" placeholder="Fecha inicio" name="fecha" runat="server" ></asp:TextBox>
                                        </div>
		                           </div>

                                    <div class="form-group row">
	                            	    <label class="col-md-3 label-control" for="fecha">Termina en</label>
		                                <div class="col-md-3">                                                 
                                            <asp:TextBox ID="fechafin" CssClass="form-control pickadate" maxlength="50" placeholder="Fecha termino" name="fechafin" runat="server" ></asp:TextBox>
                                        </div>
		                           </div>
                                    
                                    <div class="form-group row">
	                            	        <label class="col-md-3 label-control" for="concepto">Concepto</label>
		                                    <div class="col-md-6">                                              
                                              <asp:TextBox ID="concepto" CssClass="form-control" placeholder="Concepto" name="concepto" runat="server" ></asp:TextBox>
                                              
		                                     </div>
		                             </div>
                                                                       
                                     
					        </div>

                        <div class="card-block card-dashboard"> 

                                <div class="col-md-12">
                                                   
                                </div>
                                <button type="button" id="nuevo" onclick="abrirModal('','');" class="btn btn-icon btn-success mr-1" data-toggle="modal" >
                                    <i class="ft-file"></i> Nuevo Registro 
                                </button>    
                                <div style="overflow-x:auto;width:100%">                                                                                                                                                                         
                              
                                 </div>

                               </div>

                            <div class="form-actions right">
                                    <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" class="ocultar" />                                                                           
                                    <asp:Button runat="server" ID="volver" OnClick="regresar"  class="ocultar" />
                                    
                                    <button class="btn btn-primary" onclick="validaGasto()" type="button"> 
	                                    <i class="fa fa-check-square-o"></i> Guardar
	                                 </button>
                 
	                                 <button type="button" class="btn btn-warning mr-1" onclick="regresar()" id="cancelar">
	                                    <i class="ft-x"></i> Volver
	                                 </button>  
	                            </div>
    	                           	                       
	                    </div>


                <div class="modal fade text-xs-left" id="bootstrap" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35"  >
        
		        <div class="modal-dialog" role="document">
		        <div class="modal-content">
			        <div class="modal-header bg-primary white">
			       
			        <h3 class="modal-title" id="myModalLabel35">DETALLE DEL CONCEPTO DE GASTO</h3>
			        </div>
			   
                       
			        <div class="modal-body">
                    
	                            <div class="row">
	                                <div class="col-md-12">
	                                    <div class="card">
	                                        <div class="card-header">
	                                            
	                                        </div>
	                                        <div class="card-body collapse in">
	                                            <div class="card-block">
						                                              
	                    	                            <div class="form-body">
	                    		                            <form id="formaRegistro" method="get">
                                                                <div class="form-group row">
	                            	                                <label class="col-md-3 label-control" for="idtipogasto">Clave</label>
		                                                            <div class="col-md-9">
                                                                         <asp:HiddenField runat="server" ID="idg" Value="0"/>
                                                                        <asp:DropDownList runat="server" ID="tipogasto" CssClass="select2" DataSourceID="DsTipoGasto" DataTextField="tipogasto" DataValueField="idtipogasto" AutoPostBack="false" name="tipogasto" style="width:100%"></asp:DropDownList>
                                                                        <asp:SqlDataSource ID="DsTipoGasto" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idtipogasto, tipogasto FROM tipoGasto where idtipogasto not in( SELECT idtipogasto from detalleGasto where idgasto=@idgasto)" >
                                                                            <SelectParameters>
                                                                                        <asp:ControlParameter ControlID="idP" Name="idgasto" PropertyName="Value" />
                                                                            </SelectParameters>

                                                                        </asp:SqlDataSource>                                
		                                                            </div>
		                                                        </div>
                                                                <div class="form-group row">
	                            	                                <label class="col-md-3 label-control" for="monto">Monto</label>
		                                                            <div class="col-md-9">                                                                       
                                                                        <asp:TextBox ID="monto" CssClass="form-control decimal-inputmask text-md-left" maxlength="15" placeholder="Monto" name="monto" runat="server" style="text-align:center"></asp:TextBox>
		                                                            </div>
		                                                        </div>	
                                                                </form>		                                                		                                                   
							                            </div>    	                                                   
	                       
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>

                        </div>
                           
                   
			        <div class="modal-footer">
                        <asp:Button runat="server" ID="guardarConcepto" OnClick="guardaEditaConcepto" style="display:none" />     
                                               
				        <button type="button" class="btn btn-primary" onclick="valida()" > 
	                        <i class="fa fa-check-square-o"></i> Guardar
	                     </button>
                 
	                     <button type="button" class="btn btn-warning mr-1"  onclick="cerrarModal()" id="cancelarModal">
	                        <i class="ft-x"></i> Cancelar
	                     </button>
			        </div>
			       
		        </div>
		        </div>
            
                
	        </div>
                            
	                </div>
	            </div>
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
    <script src="/app-assets/vendors/js/pickers/daterange/daterangepicker.js" type="text/javascript"></script>

     <script src="/app-assets/vendors/js/extensions/toastr.min.js" type="text/javascript"></script>
    

    <script>

        jQuery.fn.ForceNumericOnly =
         function () {
             return this.each(function () {
                 $(this).keydown(function (e) {
                     var key = e.charCode || e.keyCode || 0;
                     // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
                     // home, end, period, and numpad decimal
                     return (
                         key == 8 ||
                         key == 9 ||
                         key == 13 ||
                         key == 46 ||
                         key == 110 ||
                         key == 190 ||
                         (key >= 35 && key <= 40) ||
                         (key >= 48 && key <= 57) ||
                         (key >= 96 && key <= 105));
                 });
             });
         };

        $(document).prop('title', 'PAE - Registro de Gastos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#reggastos").addClass("active");
        $(document).ready(function () {
            $('.pickadate').pickadate({
                format: 'yyyy-mm-dd',
                formatSubmit: 'yyyy-mm-dd',
                monthsFull: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab'],
                today: 'Hoy',
                clear: 'Limpiar',
                
            });

            $('#bootstrap').on('keypress', function (e) {
                if (e.keyCode === 13) {
                    e.preventDefault();
                    $(this).trigger('submit');
                }
            });

            $('#monto').inputmask({ alias: 'decimal', radixPoint: '.', digits: 2, rightAlign: false });

        });

        function abrirModal(idtipogasto, monto) {
                             
            $("*[id$='tipogasto']").val(idtipogasto);
            $("*[id$='monto']").val(monto);

            $("#bootstrap").modal('show');
        }

        function cerrarModal() {                                    
            $('#bootstrap').modal('hide');                               
        }

        function regresar() {
           
             swal({
                title: "Los datos no guardados se perderán, ¿Desea cancelar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Aceptar",
                cancelButtonText: "Cancelar",
                closeOnConfirm: true,
                closeOnCancel: true
            },
            function (isConfirm) {
                if (isConfirm) {                    
                    $('#<%= volver.ClientID %>').click();
                } 
            });

        }


        function eliminarRegistro(idP) {
            
             $("*[id$='idtP']").val(idP);
           
             swal({
                title: "Desea eliminar este registro?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Aceptar",
                cancelButtonText: "Cancelar",
                closeOnConfirm: false,
                closeOnCancel: true
            },
            function (isConfirm) {
                if (isConfirm) {
                    
                    mostrarLoading();
                    $('#<%= Bborrar.ClientID %>').click();                    
                   
                } 
            });

        }

        function validaGasto() {

            var fecha = $("*[id$='fecha']").val();
            var concepto = $("*[id$='concepto']").val();
            var seccion = $("*[id$='seccion']").val();
            
            if (fecha == '') {
                swal("Atención", "Indique la fecha del gasto", "warning");
                return false;
            }
            if (concepto == '' ) {
                swal("Atención", "Ingrese el concepto del gasto", "warning");
                return false;            
            }
            if (seccion == '' || seccion == 0) {
                swal("Atención", "Indique la sección a la que se asigna el gasto", "warning");
                return false;
            }
                
            mostrarLoading();
            $('#<%= guardar.ClientID %>').click();
                
            return true;

        }

        function valida() {
            //var idColonia = $("*[id$='idColonia']").val();
            var tipogasto = $("*[id$='tipogasto']").val();
            var monto = $("*[id$='monto']").val();
            
            if (tipogasto == ''){
                swal("Atención", "Indique el concepto del gasto", "warning");
                return false;
            }
            if (monto == '' || monto == 0) {
                swal("Atención", "Ingrese el monto del gasto", "warning");
                return false;            
            }
                
            mostrarLoading();
            $('#<%= guardarConcepto.ClientID %>').click();
            $('#bootstrap').modal('hide');
            
            return true;
                                            
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

                $("*[id$='cp']").ForceNumericOnly(); 
                $("*[id$='seccion']").ForceNumericOnly();
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
                loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
                loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

                /*loadJS("/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js");
                loadJS("/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.date.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.time.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/legacy.js");
                loadJS("/app-assets/vendors/js/pickers/daterange/daterangepicker.js");*/

        }
    </script>

</asp:Content>