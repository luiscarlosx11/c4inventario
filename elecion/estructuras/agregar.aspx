<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="agregar.aspx.cs" Inherits="elecion.estructuras.agregar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/daterange/daterangepicker.css" /> 
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/datetime/bootstrap-datetimepicker.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/pickadate/pickadate.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/pickers/daterange/daterange.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/toastr.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/extensions/toastr.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/forms/checkboxes-radios.css" />

    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Presupuesto</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Campaña</a>
                </li>
                  <li class="breadcrumb-item"><a href="#">Estructura</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Clasificación</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cuerpo" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <asp:UpdatePanel runat="server" ID="pU">
         <ContentTemplate>
	    <div class="row">
	        <div class="col-md-12">
	            <div class="card">
	                <div class="card-header">
	                    <h4 class="card-title" id="horz-layout-basic">Registro de Estructura</h4>
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
                                     <asp:HiddenField runat="server" ID="idP" Value="0"/>                                     
							    </p>
						    </div>
	                  	                    		   
                                    <div class="form-group row">
	                            	        <label class="col-md-3 label-control" for="nombre">Nombre</label>
		                                    <div class="col-md-6">                                              
                                              <asp:TextBox ID="nombre" CssClass="form-control" placeholder="nombre" name="nombre" runat="server" ></asp:TextBox>
                                              
		                                     </div>
		                             </div>

                                     <div class="form-group row">
	                            	        <label class="col-md-3 label-control" for="descripcion">Descripción</label>
		                                    <div class="col-md-6">                                              
                                              <asp:TextBox ID="descripcion" CssClass="form-control" Rows="4" TextMode="MultiLine" placeholder="Descripción" name="descripcion" runat="server" ></asp:TextBox>
                                              
		                                     </div>
		                             </div>

                                     <!--
                                    <div class="form-group row">
	                            	        <label class="col-md-3 label-control" for="nombre">Tipo de organización</label>
		                                    <div class="col-md-4">                                                                                                                                                                                      
                                                    <asp:RadioButton GroupName="tipoorg" runat="server" ID="tipogral" OnCheckedChanged="tipogral_CheckedChanged" Text="General"  AutoPostBack="true" Checked="true"/>       
                                                    <asp:RadioButton GroupName="tipoorg" runat="server" ID="tipoespec" OnCheckedChanged="tipogral_CheckedChanged" Text="Específico" AutoPostBack="true"/>                                                                                                                                                                                                                   
		                                    </div>
		                             </div>

                                    <div class="form-group row">
	                            	        <label class="col-md-3 label-control" for="nombre">Nivel de organización</label>
		                                    <div class="col-md-3">                                              
                                             <asp:DropDownList runat="server" ID="nivelorg" name="nivelorg" CssClass="select2 form-control" Enabled="false" style="width:100%">
                                                <asp:ListItem Value="1">Distrito Federal</asp:ListItem>
                                                <asp:ListItem Value="2">Distrito Local</asp:ListItem>
                                                <asp:ListItem Value="3">Municipio</asp:ListItem>
                                                <asp:ListItem Value="4">Demarcación</asp:ListItem>
                                                <asp:ListItem Value="5">Sección</asp:ListItem>
                                            </asp:DropDownList>                        
		                                    </div>
		                             </div>
                                    -->

                                                                         
					        </div>
                                                        
                            <div class="form-actions right">
                                    <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" class="ocultar" />                                                                           
                                    <asp:Button runat="server" ID="volver" OnClick="regresar"  class="ocultar" />
                                    
                                    <button class="btn btn-primary" onclick="valida()" type="button"> 
	                                    <i class="fa fa-check-square-o"></i> Guardar
	                                 </button>
                 
	                                 <button type="button" class="btn btn-warning mr-1" onclick="regresar()" id="cancelar">
	                                    <i class="ft-x"></i> Volver
	                                 </button>  
	                            </div>
    	                           	                       	                                  
                            
	                </div>
	            </div>
	        </div>
	
  </ContentTemplate>
   </asp:UpdatePanel>  
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

     <script src="/app-assets/vendors/js/extensions/toastr.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>
    
    

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

        $(document).prop('title', 'PLACEL - Registro de Gastos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#orgestructura").addClass("active");
        $(document).ready(function () {
           
        });

        

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

       

        function valida() {
            
            var nombre = $("*[id$='nombre']").val();
            var descripcion = $("*[id$='descripcion']").val();
            
            if (nombre == '') {
                swal("Atención", "Indique el nombre de la estructura", "warning");
                return false;
            }
            if (descripcion == '') {
                swal("Atención", "Ingrese la descripcion de la estructura", "warning");
                return false;            
            }
                
            mostrarLoading();
            $('#<%= guardar.ClientID %>').click();
                        
            return true;
                                            
        }


    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="PageLevelJS" runat="server">
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
                loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");
       

        }
    </script>

</asp:Content>