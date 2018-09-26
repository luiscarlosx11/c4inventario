<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="usuario.aspx.cs" Inherits="elecion.usuarios.usuario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
    <asp:HiddenField ID="hep" runat="server" />
    <asp:ScriptManager runat="server" ID="sc"></asp:ScriptManager>
    <section class="input-validation inputmask">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body collapse in">
                        <div class="card-block">
                            <div class="card-text">
                                Usuario
                            </div>
                            <div class="form-body">
                                <h4 class="form-section"><i class="icon-user-follow"></i>Información Personal</h4>

                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="cusuario">Usuario: </label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="cusuario" CssClass="form-control" placeholder="Nombre de usuario" MaxLength="4" name="cusuario" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="nombre">Nombre: </label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="nombre" CssClass="form-control" placeholder="Nombre" MaxLength="40" name="fname" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="activo">Activo: </label>
                                    <div class="col-md-9">
                                        <asp:DropDownList runat="server" ID="activo" name="activo">
                                            <asp:ListItem Value="1">Sí</asp:ListItem>
                                            <asp:ListItem Value="0">No</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="tipo">Tipo: </label>
                                    <div class="col-md-9">
                                        <asp:DropDownList runat="server" ID="tipo" name="tipo">
                                            <asp:ListItem Value="1">1</asp:ListItem>
                                            <asp:ListItem Value="2">2</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>


                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="email">E-mail</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="email" CssClass="form-control email-inputmask" placeholder="E-mail" MaxLength="35" name="email" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="telefono">Télefono</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="telefono" CssClass="form-control phone-inputmask" placeholder="Teléfono" name="phone" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="psswd">Nueva Contraseña</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="psswd" CssClass="form-control" placeholder="Contraseña" TextMode="Password" name="psswd" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="psswdcc">Repetir Contraseña</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="psswdcc" onkeyup="checarP(this.value);" TextMode="Password" CssClass="form-control" placeholder="Escribir nuevamente la contraseña" name="psswdcc" runat="server"></asp:TextBox>
                                         <br />
                                        <asp:Label runat="server" ID="msj"></asp:Label>
                                    </div>
                                </div>

                                <h4 class="form-section"><i class="ft-map-pin"></i>Domicilio</h4>
                                <asp:UpdatePanel runat="server" ID="UP">
                                    <ContentTemplate>
                                        <div class="form-group row">
                                            <label class="col-md-3 label-control" for="municipio">Municipio</label>
                                            <div class="col-md-9">
                                                <asp:DropDownList runat="server" ID="municipio" CssClass="select2 form-control" DataSourceID="DsMunicipios" DataTextField="municipio" DataValueField="idMunicipio" AutoPostBack="true"></asp:DropDownList>
                                                <asp:SqlDataSource ID="DsMunicipios" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [idMunicipio], [municipio] FROM [municipios]"></asp:SqlDataSource>
                                                <div class="help-block"></div>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-md-3 label-control" for="colonias">Colonia</label>
                                            <div class="col-md-9">
                                                <asp:DropDownList runat="server" ID="colonias" CssClass="select2 form-control" DataSourceID="DsColonia" DataTextField="colonia" DataValueField="idColonia" AutoPostBack="true" OnDataBound="colonias_DataBound"></asp:DropDownList>
                                                <asp:SqlDataSource ID="DsColonia" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                    SelectCommand="SELECT idColonia, colonia FROM colonias WHERE idMunicipio =@idmun">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="municipio" Name="idmun" PropertyName="SelectedValue" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-md-3 label-control" for="calle">Calle</label>
                                            <div class="col-md-9">
                                                <asp:DropDownList runat="server" ID="calle" CssClass="select2 form-control" DataTextField="calle" DataValueField="idCalle" DataSourceID="DsCalle"></asp:DropDownList>
                                                <asp:SqlDataSource ID="DsCalle" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idCalle, calle from Vialidades WHERE idColonia =@idcol">
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
                                    <div class="col-md-9">
                                        <asp:TextBox ID="numext" CssClass="form-control" placeholder="Número Exterior" MaxLength="10" name="fname" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="numint">Número Interior</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="numint" CssClass="form-control" placeholder="Número Interior" MaxLength="10" name="fname2" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label class="col-md-3 label-control" for="cp">Código Postal</label>
                                    <div class="col-md-9">
                                        <asp:TextBox ID="cp" CssClass="form-control" placeholder="Código Postal" MaxLength="5" name="email" runat="server"></asp:TextBox>
                                        <br />
                                       
                                    </div>
                                </div>

                            </div>
                            <div class="form-actions right">
                                <asp:Button runat="server" ID="guardar" OnClick="guardar_Click" CssClass="ocultar" OnClientClick="dp()"/>
                                <button class="btn btn-primary" onclick="$('#<%=guardar.ClientID %>').click()">
                                    <i class="fa fa-check-square-o"></i>Guardar
                                </button>
                                <button type="submit" class="btn btn-warning mr-1">
                                    <i class="ft-x"></i>Aceptar
                                </button>
                                <button type="button" onclick="alerta();" class="btn btn-warning mr-1">
                                    <i class="ft-x"></i>Cancelar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
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
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>
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

        $(document).prop('title', 'PLACEL - Promovidos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catu").addClass("active");

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

        function swaExito() {
            //swal("Registro añadido con exito.");
            swal("Operación exitosa", "Cambios guardados con exito", "success")
        }

        function swaError(error) {
            swal("Error en la Operación", "No se pudo añadir el registro.\n " + error + ")", "error");
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
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

        }
    </script>
</asp:Content>
