<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="tablero.aspx.cs" Inherits="elecion.tablero" %>
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
            <h3 class="content-header-title">iPSEC Soporte Técnico</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Inicio</a>
                </li>

              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
<div class="row">
<div class="col-lg-12 col-md-12 col-xs-12">

        
            <div class="card">
                <div class="card-header no-border-bottom">
                    <h4 class="card-title">Bienvenido</h4>
                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                    <div class="heading-elements">
                        <ul class="list-inline mb-0">
                        </ul>
                    </div>
                </div>

                <div class="card-body collapse in">

                    <div class="row">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body text-xs-center">
                                    <div class="card-block">
                                        <img src="../../../app-assets/images/portrait/medium/avatar-m-1.png" class="rounded-circle  height-150" alt="Card image">
                                    </div>
                                    <div class="card-block">
                                        <h4 class="card-title">
                                            <asp:Label ID="nombre" runat="server"></asp:Label>
                                        </h4>
                                        <h6 class="card-subtitle text-muted">
                                            <asp:Label ID="apellidos" runat="server"></asp:Label>
                                        </h6>
                                       
                                    </div>
                                    
                                </div>

                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body text-xs-center">                                    
                                    <div class="card-block">
                                        <h4 class="card-title">
                                            CREDENCIALES
                                        </h4>
                                       
                                        <h6>
                                            <asp:Label ID="login" runat="server"></asp:Label>
                                        </h6>
                                        <h6>
                                            <asp:Label ID="Label4" runat="server">******</asp:Label>
                                        </h6>
                                        <br />
                                        <h4 class="card-title">
                                            CONTACTO
                                        </h4>
                                        <h6>
                                            <asp:Label ID="telefono" runat="server"></asp:Label>
                                        </h6>
                                        <h6>
                                            <asp:Label ID="email" runat="server"></asp:Label>
                                        </h6>
                                        <br />
                                        <button type="button" class="btn btn-primary mr-1" data-toggle="tooltip" data-original-title="Modificar" onclick="abrirModal()">
                                            <i class="ft-check"></i> Modificar   
                                        </button>
                                    </div>
                                    
                                </div>

                            </div>
                        </div>
                        
                    </div>

           
        </div>

        
           
</div>
</div>
    </div>
    
    <div class="row">
    <div class="col-lg-12 col-md-12 col-xs-12">
        <div class="card">
            <div class="card-header no-border-bottom">
                <h4 class="card-title">Actualmente cuenta con estos Tickets</h4>
                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                       
                    </ul>
                </div>
            </div>
            <div class="card-body collapse in">
                <div class="card-block">
                   <div class="row">
                            <div class="col-xl-3 col-lg-6 col-xs-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="p-2 text-xs-center bg-primary bg-darken-2 media-left media-middle">
                                                <i class="icon-camera font-large-2 white"></i>
                                            </div>
                                            <div class="p-2 bg-primary white media-body">
                                                <h5>Atendidos</h5>
                                                <h5 class="text-bold-400"><asp:Label runat="server" ID="atendidos"></asp:Label></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                             <div class="col-xl-3 col-lg-6 col-xs-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="p-2 text-xs-center bg-success bg-darken-2 media-left media-middle">
                                                <i class="icon-basket-loaded font-large-2 white"></i>
                                            </div>
                                            <div class="p-2 bg-success white media-body">
                                                <h5>Activos</h5>
                                                <h5 class="text-bold-400"><asp:Label runat="server" ID="activos"></asp:Label></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-lg-6 col-xs-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="p-2 text-xs-center bg-danger bg-darken-2 media-left media-middle">
                                                <i class="icon-user font-large-2 white"></i>
                                            </div>
                                            <div class="p-2 bg-danger white media-body">
                                                <h5>Cancelados</h5>
                                                <h5 class="text-bold-400"><asp:Label runat="server" ID="cancelados"></asp:Label></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
        
                            <div class="col-xl-3 col-lg-6 col-xs-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="p-2 text-xs-center bg-warning bg-darken-2 media-left media-middle">
                                                <i class="icon-wallet font-large-2 white"></i>
                                            </div>
                                            <div class="p-2 bg-warning white media-body">
                                                <h5>Notas</h5>
                                                <h5 class="text-bold-400"><asp:Label runat="server" ID="notas"></asp:Label></h5>
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

    <div class="modal fade text-xs-left" id="bootstrap" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 class="modal-title" id="myModalLabel35">ÁREA TÉCNICA</h3>
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
                                            
                                                <div class="row">

                                                    <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Login</label>
                                    
                                                            <asp:TextBox ID="user" CssClass="form-control" placeholder="login" MaxLength="35" name="email" runat="server" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>                                                    

                                                </div>

                                            <div class="row">                                                    

                                                    <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Nuevo password</label>
                                    
                                                            <asp:TextBox ID="pass" CssClass="form-control"  placeholder="Nuevo Password" name="pass" runat="server"></asp:TextBox>
                                         
                                                        </div>
                                                    </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Confirme password</label>
                                    
                                                            <asp:TextBox ID="pass2" CssClass="form-control"  placeholder="Confirme Password" name="pass2" runat="server"></asp:TextBox>
                                         
                                                        </div>
                                                    </div>

                                                </div>

                                           
                                                <div class="row">

                                                    <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>E-mail</label>
                                    
                                                            <asp:TextBox ID="email2" CssClass="form-control email-inputmask" placeholder="E-mail" MaxLength="35" name="email2" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label>Télefono</label>
                                    
                                                            <asp:TextBox ID="telefono2" CssClass="form-control phone-inputmask"  placeholder="Teléfono" name="telefono2" runat="server"></asp:TextBox>
                                         
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


                <div class="modal-footer">
                    <asp:Button runat="server" ID="guardar" OnClick="guardaEdita"  Style="display: none"/>                    

                    <button class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false">
                        <i class="fa fa-check-square-o"></i>Aceptar
                    </button>

                    <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
                        <i class="ft-x"></i>Cancelar
                    </button>
                </div>



            </div>
        </div>


    </div>
<!--/ Analytics spakline & chartjs  -->

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
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

        $(".nav-item>ul>li.active").removeClass("active");
        $("#tablero").addClass("active");

        function abrirModal() {
                      
            $("#bootstrap").modal('show');
        }

        function valida() {
            
           
            var pass = $("*[id$='pass']").val();
            var pass2 = $("*[id$='pass2']").val();
            var email = $("*[id$='email2']").val();
            var telefono = $("*[id$='telefono2']").val();
            
           
            if (pass != pass2) {
                swal("Atención", "Los password no coinciden", "warning");
                return false;
            }
            
            if (email == '') {
                swal("Atención", "Ingrese una dirección de correo", "warning");
                return false;
            }
            if (telefono == '') {
                swal("Atención", "Ingrese un teléfono", "warning");
                return false;
            }
                             
            mostrarLoading();
            $('#<%= guardar.ClientID %>').click();                   
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

        }
    </script>
</asp:Content>
