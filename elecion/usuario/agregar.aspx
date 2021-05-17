<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="agregar.aspx.cs" Inherits="elecion.usuarios.agregar" %>
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
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
    <asp:HiddenField ID="hep" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
  
    
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                         <div class="media-body">
                        <h4 class="font-weight-bold">Usuario</h4>
                        <span class="font-small-3">
                           
                    </div>
                    </div>
                    <div class="card-body collapse in">
                        <div class="card-block">
                            

                            <div class="form-body">
                                
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                    
                                        <label for="nombre" class="text-bold-600">Nombre</label>
                                    
                                            <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" placeholder="Nombre" MaxLength="40" name="nombre" runat="server"></asp:TextBox>
                                             <div class="help-block"></div>
                                    
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                    <div class="form-group">
                                    
                                        <label class="label-control text-bold-600" for="nombre" >Apellido Paterno</label>
                                    
                                            <asp:TextBox ID="apaterno" CssClass="form-control text-uppercase" placeholder="Apellido Paterno" MaxLength="40" name="nombre" runat="server"></asp:TextBox>
                                             <div class="help-block"></div>
                                    
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                      
                                    <label class="label-control text-bold-600" for="nombre">Apellido Materno</label>
                                   
                                        <asp:TextBox ID="amaterno" CssClass="form-control text-uppercase" placeholder="Apellido Materno" MaxLength="40" name="nombre" runat="server"></asp:TextBox>
                                         <div class="help-block"></div>
                                    
                                    </div>
                                </div>
                                </div>
                                <div class="row">
                                <div class="col-md-4">                                
                                    <div class="form-group">
                                        <label class="text-bold-600">Login</label>
                                    
                                            <asp:HiddenField runat="server" ID="idP" Value="0"/> 
                                            <asp:TextBox ID="usuario" CssClass="form-control" MaxLength="18" placeholder="Nombre de usuario" name="cusuario" runat="server"></asp:TextBox>
                                                                            
                                    </div>
                                </div>

                                    <div class="col-md-4">                                
                                        <div class="form-group">
                                            <label class="text-bold-600">Password</label>
                                    
                                                <asp:HiddenField runat="server" ID="HiddenField1" Value="0"/> 
                                                <asp:TextBox ID="pass" CssClass="form-control" MaxLength="18" placeholder="Nombre de usuario" name="cusuario" runat="server"></asp:TextBox>
                                                                            
                                        </div>
                                    </div>

                                    <div class="col-md-4">                                
                                        <div class="form-group">
                                            <label for="activo" class="text-bold-600">Activo</label>
                                    
                                            <div class="skin skin-flat">
                                                <asp:CheckBox runat="server" ID="activo"/>
                                            </div>
                                    
                                        </div>
                                    </div>
                                 </div>

                                

                             <div class="row">
                                 <div class="col-md-4 ocultar">
                                 <div class="form-group">
                                    <label  for="tipo" class="text-bold-600">Tipo </label>
                                    
                                     
                                         <asp:DropDownList runat="server" ID="tipo" CssClass="select2 form-control" DataSourceID="DsTipos" DataTextField="tipoUsuario" DataValueField="idtipousuario" AutoPostBack="false" ></asp:DropDownList>
                                         <asp:SqlDataSource ID="DsTipos" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT IDTIPOUSUARIO, TIPOUSUARIO FROM tipousuario ORDER BY ORDEN"></asp:SqlDataSource>
                                          
                                    </div>
                                </div>

                                 <div class="col-md-8">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Roles</label>
                                                    <asp:HiddenField runat="server" ID="tagsdiscap" />
                                                    <asp:DropDownList runat="server" ID="xxdiscapacidad" CssClass="select2 form-control" DataSourceID="DStipousuario" DataTextField="tipousuario" DataValueField="idtipousuario" Style="width: 100%" multiple="multiple" onchange=""></asp:DropDownList>
                                                    <asp:SqlDataSource ID="DStipousuario" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idtipousuario, tipousuario FROM tipousuario ORDER BY tipousuario"></asp:SqlDataSource>

                                                </div>
                                            </div>

                                 
                                 <div class="col-md-4">
                                 <div class="form-group">
                                    <label  for="tipo" class="text-bold-600">Plantel </label>                                                                         
                                         <asp:DropDownList runat="server" ID="area" CssClass="select2 form-control" DataSourceID="DsAreas" DataTextField="nombre" DataValueField="idsucursal" AutoPostBack="false" ></asp:DropDownList>
                                         <asp:SqlDataSource ID="DsAreas" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idsucursal, nombre FROM sucursal ORDER BY nombre"></asp:SqlDataSource>                                          
                                    </div>
                                </div>
                                
                           
                            </div>

                                <div class="row">

                                    <div class="col-md-4">
                                    <div class="form-group">
                                        <label  for="email" class="text-bold-600">E-mail</label>
                                    
                                            <asp:TextBox ID="email" CssClass="form-control email-inputmask" placeholder="E-mail" MaxLength="35" name="email" runat="server"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                    <div class="form-group">
                                        <label  for="telefono" class="text-bold-600">Télefono</label>
                                    
                                            <asp:TextBox ID="telefono" CssClass="form-control phone-inputmask"  placeholder="Teléfono" name="phone" runat="server"></asp:TextBox>
                                         
                                        </div>
                                    </div>

                                </div>



                            <div class="form-actions right">
                                    <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" class="ocultar" />                                                                           
                                    <asp:Button runat="server" ID="volver" OnClick="volverListado" class="ocultar"/>
                                    
                                    <button class="btn btn-primary" onclick="valida()" type="button"> 
	                                    <i class="fa fa-check-square-o"></i> Guardar
	                                 </button>
                 
	                                 <button type="button" class="btn btn-danger mr-1" onclick="regresar()" id="cancelar">
	                                    <i class="ft-x"></i> Cancelar
	                                 </button>     
                                    
                                    <button type="reset" class="btn btn-danger" style="display:none" id="reset">Reset <i class="fa fa-refresh position-right"></i></button>                                                              
	                                
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
        $("#catusuarios").addClass("active");

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
            
            var nombre = $("*[id$='nombre']").val();
            var apaterno = $("*[id$='apaterno']").val();
            var amaterno = $("*[id$='amaterno']").val();

            var usuario = $("*[id$='usuario']").val();
            var pass = $("*[id$='pass']").val();
            var email = $("*[id$='email']").val();
            

           
            if (nombre == '') {
                swal("Atención", "Ingrese el nombre del usuario", "warning");
                return false;
            }
            if (apaterno == '') {
                swal("Atención", "Ingrese el apellido paterno del usuario", "warning");
                return false;
            }
            if (amaterno == '') {
                swal("Atención", "Ingrese el apellido materno del usuario", "warning");
                return false;
            }
            if (usuario == '') {
                swal("Atención", "Ingrese un nombre de usuario", "warning");
                return false;
            }
            if (pass == '') {
                swal("Atención", "Ingrese una contraseña para el usuario", "warning");
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
              type: 'warning',
              showCancelButton: true,
              confirmButtonColor: "#DD6B55",
              confirmButtonText: "Si",
              cancelButtonText: "No",
            }).then((result) => {
              if (result.value) {
                mostrarLoading();
                    $('#<%= volver.ClientID %>').click();
              }
            })
                        
        }
          
        function checarP(value) {
            password = $("*[id$='psswd']").val();
            if (value != password) {
                //  $('#error').html("Constraseñas no coinciden");
                //$("*[id$='msj']").html("Constraseñas no coinciden");
            } else {
                //  $('#error').html("");
               // $("*[id$='msj']").html("");
            }
        }

        function setCookie(cname, cvalue, exdays) {
            var d = new Date();
            d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
            var expires = "expires=" + d.toUTCString();
            document.cookie = cname + "=" + cvalue + "; " + expires;
        }

        function getCookie(cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1);
                if (c.indexOf(name) == 0)
                    return c.substring(name.length, c.length);
            }
            return "";
        }

        function makeid() {
            var text = "";
            var possible = "abcdefghijklmnopqrstuvwxyz0123456789";

            for (var i = 0; i < 44; i++)
                text += possible.charAt(Math.floor(Math.random() * possible.length));

            return text;
        }

        function cargatags() {     
           
            var discap = $("*[id$='tagsdiscap']").val(); 
            var arreglo = discap.split("|"); 
            $("*[id$='discapacidad']").val(arreglo);            
            $("*[id$='discapacidad']").trigger('change');
        }

        function cargatagsInv() {
           
            $("*[id$='tagsdiscap']").val($("*[id$='xxdiscapacidad']").val()); 
            $("*[id$='tagsmot']").val($("*[id$='motivo']").val());  
            $("*[id$='tagsmed']").val($("*[id$='medio']").val());
           


        }

        <%
        System.Security.Cryptography.Aes aes = new System.Security.Cryptography.AesManaged();
        aes.GenerateKey();
        aes.GenerateIV();
        byte[] iv = aes.IV;
        byte[] key = aes.Key;
        %>

        setCookie("IV", "<%=Convert.ToBase64String(iv)%>", 1);
        setCookie("SessionCookie", "<%=Convert.ToBase64String(key)%>", 1);

        function dp() {

            var communicationKey = CryptoJS.enc.Base64.parse("<%=Convert.ToBase64String(key)%>");

            var communicationIV = CryptoJS.enc.Base64.parse("<%=Convert.ToBase64String(iv)%>");
            var palabra = $("*[id$='psswd']").val();

            var encrypted = CryptoJS.AES.encrypt(palabra, communicationKey, {
                iv: communicationIV,
                mode: CryptoJS.mode.CBC
            });

            console.log(palabra);
            console.log(encrypted);
            console.log(CryptoJS.enc.Base64.stringify(encrypted.ciphertext));
            $("*[id$='hep']").val(CryptoJS.enc.Base64.stringify(encrypted.ciphertext));
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

             $("*[id$='xxdiscapacidad']").on("select2:select", function (e) { cargatagsInv(); });
            $("*[id$='xxdiscapacidad']").on("select2:unselect", function (e) { cargatagsInv(); var self = $(this);
            setTimeout(function() {
                self.select2('close');
                }, 0);
            });

            $("*[id$='xxdiscapacidad']").on('select2:opening select2:closing', function( event ) {
                var $searchfield = $(this).parent().find('.select2-search__field');
                $searchfield.prop('disabled', true);
            });

           cargatags();

        }
    </script>

</asp:Content>
