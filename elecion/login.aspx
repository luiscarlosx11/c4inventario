<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="elecion.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui" />
    <title>Icaten - Plataforma de Gestión Escolar</title>
    <link rel="apple-touch-icon" href="/app-assets/images/ico/favicon2.png" />
    <link rel="shortcut icon" type="image/x-icon" href="/app-assets/images/ico/favicon2.ico" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i%7COpen+Sans:300,300i,400,400i,600,600i,700,700i" rel="stylesheet" />
    <!-- BEGIN VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="/app-assets/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/feather/style.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/flag-icon-css/css/flag-icon.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/pace.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css" />
    <!-- END VENDOR CSS-->
    <!-- BEGIN STACK CSS-->
    <link rel="stylesheet" type="text/css" href="/app-assets/css/bootstrap-extended.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/app.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/colors.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <!-- END STACK CSS-->
    <!-- BEGIN Page Level CSS-->
    <link rel="stylesheet" type="text/css" href="/app-assets/css/core/menu/menu-types/vertical-menu.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/core/menu/menu-types/vertical-overlay-menu.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/pages/login-register.css" />
    <script src="/assets/js/cyrpto/core-min.js"></script>
    <script src="/assets/js/cyrpto/cipher-core.js"></script>
    <script src="/assets/js/cyrpto/mode-cfb.js"></script>
    <script src="/assets/js/cyrpto/enc-base64-min.js"></script>
    <script src="/assets/js/cyrpto/aes.js"></script>
    <!-- END Page Level CSS-->
    <!-- BEGIN Custom CSS-->
    <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />
    <!-- END Custom CSS-->
</head>
<body data-open="click" data-menu="vertical-menu" data-col="1-column" class="vertical-layout vertical-menu 1-column bg-full-screen-image blank-page blank-page">
    <!-- ////////////////////////////////////////////////////////////////////////////-->
    <div class="app-content content container-fluid">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body">
                <section class="flexbox-container">
                    <div class="col-md-3 col-lg-3 offset-md-4 col-xs-10 offset-xs-1 col-sm-10 box-shadow-2 p-0">
                        <div class="card border-grey border-lighten-3 m-0">
                            <div class="card-header no-border primary">
                                <div class="card-title text-xs-center">
                                    <div class="p-1">
                                        <img src="/images/rendilana.png" alt="icaten" class="img-fluid"/>
                                    </div>
                                </div>
                                
                                <h4 class="text-muted text-xs-center text-bold-600"><span>Plataforma de Gestión Escolar</span></h4>
                            </div>
                            <div class="card-body collapse in">
                                <div class="card-block">
                                    <form id="form1" class="form-horizontal form-simple" runat="server" novalidate autocomplete="off">
                                        <asp:HiddenField ID="hep" runat="server" />
                                        <fieldset class="form-group position-relative has-icon-left mb-0">
                                            <asp:TextBox runat="server" CssClass="form-control form-control" ID="username" placeholder="Usuario"></asp:TextBox>
                                            <div class="form-control-position">
                                                <i class="ft-user"></i>
                                            </div>
                                        </fieldset>
                                        <br /><br />
                                        <fieldset class="form-group position-relative has-icon-left">
                                            <asp:TextBox runat="server" CssClass="form-control form-control" ID="userpasswd" TextMode="Password" placeholder="Contraseña"></asp:TextBox>
                                            <div class="form-control-position">
                                                <i class="fa fa-key"></i>
                                            </div>
                                        </fieldset>
                                        <br />
                                        <asp:Button ID="ilogin" runat="server" OnClick="ilogin_Click" OnClientClick="dp();" style="display:none" Text="Login"  UseSubmitBehavior="false"/>
                                        <button type="button" class="btn btn-primary btn-block" onclick="validaForm()" id="ingresar">
                                             <span class="text-bold-700">I N G R E S A R</span>
                                        </button>
                                        <br />
                                        <asp:Label runat="server" ID="error" style="color:red;font-weight:bold"></asp:Label>
                                       <!-- MODAL -->
                                        <div class="modal fade text-xs-left" id="bootstrap" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true" data-keyboard="false" data-backdrop="static">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header bg-primary white">
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                        <h3 class="modal-title" id="myModalLabel35">Código de Autorización</h3>
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
                                                                               
                                                                                    <div class="form-group row">
                                                                                        <label class="col-md-3 label-control" for="cvomun">Ingresar código</label>
                                                                                        <div class="col-md-9">
                                                                                            <asp:TextBox ID="codigo" CssClass="form-control" MaxLength="8" placeholder="Código" name="codigo" runat="server"></asp:TextBox>
                                                                                        </div>
                                                                                    </div>

                                                                                <asp:Label runat="server" ID="error2" style="color:red;font-weight:bold"></asp:Label>
                                                                                
                                                                            </div>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="modal-footer">
                                                        <asp:Button ID="acodigo" runat="server" OnClick="acodigo_Click" style="display:none" UseSubmitBehavior="false" />
                                                        <button class="btn btn-primary"  onclick="validaCodigo()"  type="button" data-backdrop="false" >
                                                            <i class="fa fa-check-square-o"></i>Aceptar
                                                        </button>

                                                        <button type="button" class="btn btn-danger mr-2" data-dismiss="modal" id="cerrarModal">
                                                            <i class="ft-x"></i>Cancelar
                                                        </button>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>

                                       <!-- FIN MODAL -->

                                    </form>
                                </div>
                            </div>
                            <div class="card-footer">
                               
                            </div>
                        </div>
                    </div>
                </section>

            </div>
        </div>
    </div>

    
    <!-- ////////////////////////////////////////////////////////////////////////////-->

    <!-- BEGIN VENDOR JS-->
    <script src="/app-assets/vendors/js/vendors.min.js" type="text/javascript"></script>
    <!-- BEGIN VENDOR JS-->
    <!-- BEGIN PAGE VENDOR JS-->
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN STACK JS-->
    <script src="/app-assets/js/core/app-menu.js" type="text/javascript"></script>
    <script src="/app-assets/js/core/app.js" type="text/javascript"></script>
    <script>

        var walert = 0;

        $(document).ready(function () {
           

            $('html').bind('keypress', function (e) {
               
                if (e.keyCode === 13) {

                    if (walert == 0) {
                        $("#ingresar").click();
                        return false;
                    }
                    else {
                        swal.close();
                    }
                }
            });

           

        });

        function validaForm() {
            walert = 1;
            if($("#username").val()==''){
                alerta('Atención', 'Ingrese su usuario', 'warning', $("*[id$='username']"));
                return false;
            }
            if ($("#userpasswd").val() == '') {
                alerta('Atención', 'Ingrese su usuario', 'warning', $("*[id$='userpasswd']"));
                return false;
            }

            walert = 0;
            mostrarLoading(); 
            walert = 3;
            $('#<%=ilogin.ClientID %>').click();
            
            return true;

        }

        function alerta(titulo, msj, tipo, input) {

            swal({
                title: titulo,
                html: msj,
                type: tipo,
                confirmButtonColor: '#00B5B8',
                onAfterClose: () => {
                    input.focus();
                    walert = 0;
                }
            })

        }

        function validaCodigo() {

            if($("#codigo").val()==''){
                swal("Atención", "Ingrese el código via sms", "warning");
                return false;
            }

            $('#<%=acodigo.ClientID %>').click()
            return true;

        }

        function modal() {
            $("#bootstrap").modal('toggle');
        }

        function swaError() {
            swal("Error en la Operación", "Código de autorización incorrecto)", "error");
        }

        function setCookie(cname, cvalue, exdays) {
            var d = new Date();
            d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
            var expires = "expires=" + d.toUTCString();
            document.cookie = cname + "=" + cvalue + "; " + expires;
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
            var palabra = $("*[id$='userpasswd']").val();
            palabra = palabra.trim();
            var encrypted = CryptoJS.AES.encrypt(palabra, communicationKey, {
                iv: communicationIV,
                mode: CryptoJS.mode.CBC
            });

            $("*[id$='hep']").val(CryptoJS.enc.Base64.stringify(encrypted.ciphertext));

        }

        function mostrarLoading() {
            //$("#prueba").modal('show');

            swal({
                title: "Procesando...",
                text: "Espere por favor",
                showConfirmButton: false,
                imageUrl: "/images/processing.gif",
                imageSize: "150x20",
                allowOutsideClick: false
            });
        }

        function cerrarLoading() {
            swal.close();
        }

    </script>
    <!-- END STACK JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    <script src="/app-assets/js/scripts/forms/form-login-register.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/extensions/sweet-alerts.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL JS-->


</body>
</html>
