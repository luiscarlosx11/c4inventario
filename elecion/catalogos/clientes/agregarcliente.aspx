<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="agregarcliente.aspx.cs" Inherits="elecion.catalogos.agregarcliente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/forms/checkboxes-radios.css"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Catálogos</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="/usuarios/control.aspx">Catálogos</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Clientes</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
    <asp:HiddenField ID="hep" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
  
    
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title" id="horz-layout-basic">Datos del Cliente</h4>
                        <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                        <div class="heading-elements">
                            <ul class="list-inline mb-0">
                               
                            </ul>
                        </div>
                    </div>
                    <div class="card-body collapse in">
                        <div class="card-block">
                            

                            <div class="form-body">
                                <div class="row">
                                    <div class="col-md-3">

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <asp:Image ID="fotopa" runat="server" Height="300" Width="100%" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12 centrarCelda">

                                                <asp:FileUpload ID="Bfoto" runat="server" accept="image/*" onchange="showpreview(this);" class="ocultar"></asp:FileUpload>
                                                <button class="btn btn-primary" onclick="$('#<%= Bfoto.ClientID %>').click();" type="button">
                                                    <i class="fa fa-check-square-o"></i>Seleccionar foto
                                                </button>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-md-9">

                                        <div class="row">

                                            <div class="col-md-3">
                                                <div class="form-group">

                                                    <label class="text-bold-600">Clave</label>

                                                    <asp:TextBox ID="clave" CssClass="form-control text-uppercase" placeholder="Clave" name="clave" runat="server"></asp:TextBox>


                                                </div>
                                            </div>

                                            <div class="col-md-9">
                                                <div class="form-group">

                                                    <label for="nombre" class="text-bold-600">Nombre</label>

                                                    <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" placeholder="Nombre" name="nombre" runat="server"></asp:TextBox>

                                                </div>
                                            </div>



                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Domicilio</label>
                                                    <asp:TextBox ID="calle" CssClass="form-control text-uppercase" placeholder="Calle y numero" name="calle" runat="server"></asp:TextBox>

                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Colonia</label>
                                                    <asp:TextBox ID="colonia" CssClass="form-control text-uppercase" placeholder="Colonia" name="colonia" runat="server"></asp:TextBox>

                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="text-bold-600">CP</label>
                                                    <asp:TextBox ID="cp" CssClass="form-control text-uppercase" placeholder="Cp" name="cp" runat="server"></asp:TextBox>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Estado </label>
                                                    <asp:DropDownList runat="server" ID="entidad" CssClass="select2 form-control" DataSourceID="DsEntidades" DataTextField="entidad" DataValueField="identidad" AutoPostBack="false"></asp:DropDownList>
                                                    <asp:SqlDataSource ID="DsEntidades" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT identidad, entidad FROM entidad ORDER BY entidad"></asp:SqlDataSource>

                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Localidad</label>
                                                    <asp:TextBox ID="localidad" CssClass="form-control text-uppercase" placeholder="Localidad" name="localidad" runat="server"></asp:TextBox>

                                                </div>
                                            </div>
                                        </div>
                                        <!--<div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Login</label>

                                            <asp:HiddenField runat="server" ID="idP" Value="0" />
                                            <asp:TextBox ID="usuario" CssClass="form-control" MaxLength="18" placeholder="Nombre de usuario" name="cusuario" runat="server"></asp:TextBox>

                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>Password</label>

                                            <asp:HiddenField runat="server" ID="HiddenField1" Value="0" />
                                            <asp:TextBox ID="pass" CssClass="form-control" MaxLength="18" placeholder="Nombre de usuario" name="cusuario" runat="server"></asp:TextBox>

                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="activo">Activo</label>

                                            <div class="skin skin-flat">
                                                <asp:CheckBox runat="server" ID="activo" />
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                -->




                                        <div class="row">

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="text-bold-600">E-mail</label>

                                                    <asp:TextBox ID="email" CssClass="form-control email-inputmask" placeholder="E-mail" MaxLength="35" name="email" runat="server"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Télefono</label>

                                                    <asp:TextBox ID="telefono" CssClass="form-control phone-inputmask" placeholder="Teléfono" name="phone" runat="server"></asp:TextBox>

                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Celular</label>

                                                    <asp:TextBox ID="celular" CssClass="form-control phone-inputmask" placeholder="Celular" name="celular" runat="server"></asp:TextBox>

                                                </div>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Observaciones</label>
                                                    <asp:TextBox ID="observaciones" CssClass="form-control text-uppercase" Rows="7" TextMode="MultiLine" placeholder="Nota o comentario" name="nota" runat="server"></asp:TextBox>

                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                </div>

                                <div class="form-actions right">
                                    <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" class="ocultar" />
                                    <asp:Button runat="server" ID="volver" OnClick="volverListado" class="ocultar" />

                                    <button class="btn btn-primary" onclick="valida()" type="button">
                                        <i class="fa fa-check-square-o"></i>Guardar
                                    </button>

                                    <button type="button" class="btn btn-danger mr-1" onclick="regresar()" id="cancelar">
                                        <i class="ft-x"></i>Cancelar
                                    </button>

                                    <button type="reset" class="btn btn-danger" style="display: none" id="reset">Reset <i class="fa fa-refresh position-right"></i></button>

                                </div>

                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

   

    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/assets/js/cyrpto/core-min.js"></script>
    <script src="/assets/js/cyrpto/cipher-core.js"></script>
    <script src="/assets/js/cyrpto/mode-cfb.js"></script>
    <script src="/assets/js/cyrpto/enc-base64-min.js"></script>
    <script src="/assets/js/cyrpto/aes.js"></script>
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
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

        //$(document).prop('title', 'PLACEL - Agregar Usuario');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catun").addClass("active");

        function showpreview(input) {

            if (input.files && input.files[0]) {
                
                var reader = new FileReader();
                reader.onload = function (e) {                  
                    $('#fotop').attr('src', e.target.result);
                    $("*[id$='fotopa']").attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }

        }

        function exito() {
             swal({
                title: "Operación",
                text: "Usuario agregado con exito",
                type: "success",
                closeOnConfirm: false
            },
            function (isConfirm) {
                if (isConfirm) {
                    window.location.href = "/usuarios";
                } 
            });
        }

        function valida() {
            
            var clave = $("*[id$='clave']").val().trim();
            var nombre = $("*[id$='nombre']").val().trim();
            var calle = $("*[id$='calle']").val().trim();
            var colonia = $("*[id$='colonia']").val().trim();
            var identidad = $("*[id$='identidad']").val();
            var localidad = $("*[id$='localidad']").val().trim();
            var celular = $("*[id$='celular']").val().trim();
        
            
            if (clave == '') {
                swal("Atención", "Ingrese la clave de identificación del cliente", "warning");
                return false;
            }           
            if (nombre == '') {
                swal("Atención", "Ingrese el nombre del cliente", "warning");
                return false;
            }          
            if (calle == '') {
                swal("Atención", "Ingrese la calle y número del domicilio del cliente", "warning");
                return false;
            }
            if (colonia == '') {
                swal("Atención", "Ingrese la colonia domicilio del cliente", "warning");
                return false;
            }
            if (identidad == 0) {
                swal("Atención", "Ingrese la entidad del domicilio del cliente", "warning");
                return false;
            }
            if (localidad == '') {
                swal("Atención", "Ingrese la localidad del domicilio del cliente", "warning");
                return false;
            }
            if (celular == '') {
                swal("Atención", "Ingrese un número de celular del cliente", "warning");
                return false;
            }
                                                   
            mostrarLoading();
            $('#<%= guardar.ClientID %>').click();                   
            return true;
                                           
        }

        function regresar() {
           
             swal({
                title: "Los datos no guardados se perderán, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Si",
                cancelButtonText: "No",
                closeOnConfirm: true,
                closeOnCancel: true
            },
            function (isConfirm) {
                if (isConfirm) {
                    mostrarLoading();                    
                    $('#<%= volver.ClientID %>').click();                    
                } 
            });

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

            
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
                loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
                loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

        }
    </script>

</asp:Content>
