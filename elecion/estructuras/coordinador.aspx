<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="coordinador.aspx.cs" Inherits="elecion.estructuras.coordinador" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/forms/checkboxes-radios.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Estructura</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="/estructuras/estructuras.aspx">Estructuras</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Agregar</a>
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
                        <h4 class="card-title">ORGANIGRAMA</h4>
                        <asp:HiddenField runat="server" ID="idP" Value="0"/> 
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
                               
                            </div>

                            <div class="form-body">
                                <h4 class="form-section"><i class="icon-user-follow"></i>Información Personal</h4>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="nombre">Nombre</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="nombre" CssClass="form-control"  placeholder="Nombre" MaxLength="50" name="nombre" runat="server"></asp:TextBox>
                                        
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="apaterno">Apellido Paterno</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="apaterno" CssClass="form-control" placeholder="Apellido Paterno" MaxLength="40" name="fname" runat="server"></asp:TextBox>
                                        
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="amaterno">Apellido Materno</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="amaterno" CssClass="form-control" placeholder="Apellido Materno" MaxLength="40" name="fname2" runat="server"></asp:TextBox>
                                        
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="email">E-mail</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="email" CssClass="form-control email-inputmask" placeholder="E-mail" MaxLength="35" name="email" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="telefono">Télefono</label>
                                    <div class="col-md-6">
                                        <asp:TextBox ID="telefono" CssClass="form-control phone-inputmask" placeholder="Teléfono" name="phone" runat="server"></asp:TextBox>
                                       
                                    </div>
                                </div>

                                <div class="form-group row" id="divestructura" runat="server">
                                    <label class="col-md-3 label-control" for="tipo">Estructura: </label>
                                    <div class="col-md-6">
                                        <asp:DropDownList runat="server" ID="dEstructura" CssClass="select2 form-control" name="tipo" DataSourceID="DsEstructura" DataTextField="nombre"
                                            DataValueField="idEstructura">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="DsEstructura" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [idEstructura], [nombre] FROM [estructuras] order by nombre"></asp:SqlDataSource>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="activo">Es coordinador</label>
                                    <div class="col-md-9">
                                         <div class="skin skin-flat">
                                        <asp:CheckBox runat="server" ID="activo"/>
                                        </div>
                                    </div>
                                </div>

                                <asp:UpdatePanel runat="server" ID="UPCoord">
                                 <ContentTemplate>
                                <div class="form-group row">
                                      <label class="col-md-3 label-control" for="municipio">Municipio</label>
                                            <div class="col-md-6">
                                                <asp:DropDownList runat="server" ID="municipiocoord" CssClass="select2 form-control" DataSourceID="DsMunicipiosCoord" DataTextField="municipio" DataValueField="idMunicipio" OnDataBound="municipiosCoord_DataBound" AutoPostBack="true" >
                                                    <asp:ListItem Value="0">Seleccione un Municipio</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="DsMunicipiosCoord" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idMunicipio, municipio FROM municipios where entidad=18 order by municipio"></asp:SqlDataSource>
                                                
                                            </div>
                                 </div>

                                <div class="form-group row">
                                            <label class="col-md-3 label-control" for="demarcacion">Demarcación</label>
                                            <div class="col-md-4">
                                               <asp:DropDownList runat="server" ID="demarcacion" CssClass="select2 form-control" DataSourceID="DsDemarcacion" DataTextField="demarcacion" DataValueField="demarcacion" OnDataBound="demarcacion_DataBound" AutoPostBack="true" AppendDataBoundItems="True" >
                                                <asp:ListItem Value="0">Seleccione una Demarcación</asp:ListItem>
                                               </asp:DropDownList>                                                
                                                <asp:SqlDataSource ID="DsDemarcacion" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT demarcacion FROM demarcaciones WHERE idmunicipio =@idmun and entidad = 18 ORDER BY demarcacion">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="municipiocoord" Name="idmun" PropertyName="SelectedValue" />                                                        
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </div>                                            
                                 </div>

                                 <div class="form-group row">
                                     <label class="col-md-3 label-control" for="seccion">Sección</label>
                                            <div class="col-md-4">
                                               <asp:DropDownList runat="server" ID="seccional" CssClass="select2 form-control" DataSourceID="DsSeccional" DataTextFied="seccion" DataValueField="seccion" AppendDataBoundItems="True">
                                                   <asp:ListItem Value="0">Seleccione una Sección</asp:ListItem>
                                               </asp:DropDownList>
                                                <asp:SqlDataSource ID="DsSeccional" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [seccion] FROM [secciones] WHERE idMunicipio =@idmun and entidad = 18 and demarcacion=@demar ORDER BY [seccion]">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="municipiocoord" Name="idmun" PropertyName="SelectedValue" />                                                        
                                                        <asp:ControlParameter ControlID="demarcacion" Name="demar" PropertyName="SelectedValue" /> 
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </div>
                                      
                                 </div>

                                </ContentTemplate>
                                </asp:UpdatePanel>

                     

                                <h4 class="form-section"><i class="ft-map-pin"></i>Domicilio</h4>
                                <asp:UpdatePanel runat="server" ID="UP">
                                    <ContentTemplate>
                                        <div class="form-group row">
                                            <label class="col-md-3 label-control" for="municipio">Municipio</label>
                                            <div class="col-md-6">
                                                <asp:DropDownList runat="server" ID="municipio" CssClass="select2 form-control" DataSourceID="DsMunicipios" DataTextField="municipio" DataValueField="idMunicipio" OnDataBound="municipios_DataBound" AutoPostBack="true"></asp:DropDownList>
                                                <asp:SqlDataSource ID="DsMunicipios" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [idMunicipio], [municipio] FROM [municipios] where entidad=18 order by municipio"></asp:SqlDataSource>
                                                
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-md-3 label-control" for="colonias">Colonia</label>
                                            <div class="col-md-6">
                                                <asp:DropDownList runat="server" ID="colonias" CssClass="select2 form-control" DataSourceID="DsColonia" DataTextField="colonia" DataValueField="idColonia" AutoPostBack="true" OnDataBound="colonias_DataBound"></asp:DropDownList>
                                                <asp:SqlDataSource ID="DsColonia" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                    SelectCommand="SELECT idColonia, colonia FROM colonias WHERE idMunicipio =@idmun and entidad = 18 order by colonia">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="municipio" Name="idmun" PropertyName="SelectedValue" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-md-3 label-control" for="calle">Calle</label>
                                            <div class="col-md-6">
                                                <asp:DropDownList runat="server" ID="calle" CssClass="select2 form-control" DataTextField="calle" DataValueField="idCalle" DataSourceID="DsCalle"></asp:DropDownList>
                                                <asp:SqlDataSource ID="DsCalle" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idCalle, calle from Vialidades WHERE idColonia =@idcol and entidad = 18 order by calle">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="colonias" Name="idcol" PropertyName="SelectedValue" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>

                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="numext">Número Exterior</label>
                                    <div class="col-md-4">
                                        <asp:TextBox ID="numext" CssClass="form-control" placeholder="Número Exterior" MaxLength="10" name="fname" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="numint">Número Interior</label>
                                    <div class="col-md-4">
                                        <asp:TextBox ID="numint" CssClass="form-control" placeholder="Número Interior" MaxLength="10" name="fname2" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="cp">Código Postal</label>
                                    <div class="col-md-4">
                                        <asp:TextBox ID="cp" CssClass="form-control" placeholder="Código Postal" MaxLength="5" name="email" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <div class="form-actions right">
                                <asp:Button runat="server" ID="guardar" OnClick="guardar_Click" CssClass="ocultar" OnClientClick="dp()" />
                                <asp:Button runat="server" ID="volver" OnClick="regresarListado"  class="ocultar" />

                                
                                <button class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false"> 
	                                <i class="fa fa-check-square-o"></i> Guardar
	                             </button>

                                <button type="button" class="btn btn-warning mr-1" onclick="regresar()" id="cancelar">
	                                    <i class="ft-x"></i> Cancelar
	                                 </button> 
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

        $(document).prop('title', 'PLACEL - Agregar Coordinador');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#orgestructura").addClass("active");
        $(document).ready(function () {

        })

        function valida() {
            var nombre = $("*[id$='nombre']").val();
            var apaterno = $("*[id$='apaterno']").val();
            var amaterno = $("*[id$='amaterno']").val();
            var telefono = $("*[id$='telefono']").val();

            
            if (nombre == '') {
                swal("Atención", "Ingrese el nombre", "warning");
                return false;
            }                
            if (apaterno == '') {
                swal("Atención", "Ingrese el apellido paterno", "warning");
                return false;
            }
            if (amaterno == '') {
                swal("Atención", "Ingrese el apellido materno", "warning");
                return false;
            }
            if (telefono == '') {
                swal("Atención", "Ingrese el teléfono", "warning");
                return false;
            }
                                     
            
            mostrarLoading();
            $('#<%= guardar.ClientID %>').click();
            return true;
                              
            
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
                    mostrarLoading();
                    $('#<%= volver.ClientID %>').click();
                } 
            });

        }

        function checarP(value) {
            password = $("*[id$='psswd']").val();
            if (value != password) {
                //  $('#error').html("Constraseñas no coinciden");
                $("*[id$='msj']").html("Constraseñas no coinciden");
            } else {
                //  $('#error').html("");
                $("*[id$='msj']").html("");
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

        function llenar() {
            $("*[id$='nombre']").val("_");
            $("*[id$='paterno']").val("_");
            $("*[id$='materno']").val("_");
            $("*[id$='telefono']").val("1111111111");
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
                $("*[id$='volver']").jqBootstrapValidation("destroy");
                $("*[id$='cp']").ForceNumericOnly(); 
                $("*[id$='seccion']").ForceNumericOnly();
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
                loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
                loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

        }
    </script>
</asp:Content>