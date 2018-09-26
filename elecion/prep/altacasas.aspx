<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="altacasas.aspx.cs" Inherits="elecion.prep.altacasas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Casas Amigas</h3>
          </div>
         <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
             <div class="breadcrumb-wrapper col-xs-12">
                 <ol class="breadcrumb">
                     <li class="breadcrumb-item"><a href="/">Inicio</a>
                     </li>
                     <li class="breadcrumb-item"><a href="/casas-amigas">Casas Amiga</a>
                     </li>
                     <li class="breadcrumb-item active"><asp:Label runat="server" ID="labelcasa"></asp:Label>
                     </li>
                 </ol>
             </div>
         </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
    <asp:HiddenField runat="server" ID="hentidad" />
    <div class="row" id="header-styling">
         <div class="col-xs-12">
             <div class="card">
                 <div class="card-header">
                     <h4 class="card-title">Alta Casa Amiga</h4>
                     <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                     <div class="heading-elements">
                         <ul class="list-inline mb-0">
                             <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                         </ul>
                     </div>
                 </div>
                 <div class="card-body collapse in">
                     <div class="card-block">
                         <div class="card-text">
                             <div class="form-body">
                                 <asp:ScriptManager runat="server" ID="sc"></asp:ScriptManager>
                                 <asp:UpdatePanel runat="server" ID="uPanel">
                                     <ContentTemplate>
                                         <asp:HiddenField runat="server" ID="idch" />
                                         <asp:HiddenField runat="server" ID="hsecc" />
                                         <h4 class="form-section"><i class="ft-home"></i>Datos Casa Amiga</h4>
                                         <div class="form-group row">
                                             <label class="col-md-3 label-control" for="elector">Nombre Casa Amiga</label>
                                             <div class="col-md-6">
                                                 <asp:TextBox ID="nombre" CssClass="form-control" MaxLength="35" placeholder="Nombre, descripción casa amiga" name="nombre" runat="server"></asp:TextBox>
                                             </div>
                                         </div>

                                         <div class="form-group row">
                                             <label class="col-md-3 label-control" for="municipio">Municipio:</label>
                                             <div class="col-md-6">
                                                 <asp:DropDownList runat="server" ID="municipio" CssClass="select2 form-control" DataSourceID="DsMunicipios" DataTextField="municipio" DataValueField="idMunicipio" AutoPostBack="true" OnDataBinding="municipio_DataBinding"></asp:DropDownList>
                                                 <asp:SqlDataSource ID="DsMunicipios" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [idMunicipio], [municipio] FROM [municipios] WHERE [entidad] = @ent ORDER BY [municipio]">
                                                     <SelectParameters>
                                                         <asp:ControlParameter ControlID="hentidad" Name="ent" PropertyName="Value" />
                                                     </SelectParameters>
                                                 </asp:SqlDataSource>

                                             </div>
                                         </div>

                                         <div class="form-group row">
                                             <label class="col-md-3 label-control" for="seccion">Seccional:</label>
                                             <div class="col-md-6">
                                                 <asp:DropDownList runat="server" ID="dseccion" CssClass="select2 form-control" DataSourceID="DsSeccion" DataTextField="seccion" DataValueField="seccion" OnDataBinding="dseccion_DataBinding"></asp:DropDownList>
                                                 <asp:SqlDataSource ID="DsSeccion" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                      SelectCommand="SELECT seccion from secciones WHERE entidad = @ent and idMunicipio = @idm ">
                                                     <SelectParameters>
                                                         <asp:ControlParameter ControlID="hentidad" Name="ent" PropertyName="Value" />
                                                         <asp:ControlParameter ControlID="municipio" Name="idm" PropertyName="SelectedValue" />
                                                     </SelectParameters>
                                                 </asp:SqlDataSource>

                                             </div>
                                         </div>

                                         <div class="form-group row">
                                             <label class="col-md-3 label-control" for="colonias">Colonias</label>
                                             <div class="col-md-6">
                                                 <asp:TextBox ID="colonias" CssClass="form-control" MaxLength="35" placeholder="Colonias que abarca la casa amiga" name="colonias" runat="server"></asp:TextBox>
                                             </div>
                                         </div>

                                          <div class="form-group row">
                                             <label class="col-md-3 label-control" for="meta_op">Meta de Operadores</label>
                                             <div class="col-md-6">
                                                 <asp:TextBox ID="meta_op" CssClass="form-control" MaxLength="5" placeholder="Número meta de operadores" name="meta_op" runat="server">0</asp:TextBox>
                                             </div>
                                         </div>

                                         <div class="form-actions right">
                                             <asp:Button runat="server" ID="guardar" OnClick="guardaEdita_Click" class="ocultar" />
                                             <asp:Button runat="server" ID="volver" OnClick="pantalla_Click" class="ocultar" />

                                             <button class="btn btn-primary" onclick="valida()" type="button">
                                                 <i class="fa fa-check-square-o"></i>Guardar
                                             </button>

                                             <button type="button" class="btn btn-warning mr-1" onclick="regresar()" id="cancelar">
                                                 <i class="ft-x"></i>Cancelar
                                             </button>

                                             <button type="reset" class="btn btn-danger" style="display: none" id="reset">Reset <i class="fa fa-refresh position-right"></i></button>

                                         </div>

                                     </ContentTemplate>
                                 </asp:UpdatePanel>



                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
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

        $(document).prop('title', 'PLACEL - Casa Amigas');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#mac").addClass("active");

        function valida() {
            mostrarLoading();
            var nombre = $("*[id$='nombre']").val();
            var meta = $("*[id$='meta_op']").val();
            
            if (nombre == '') {
                swal("Atención", "Ingrese el nombre", "warning");
                return false;
            }

            if (meta == '') {
                swal("Atención", "Ingrese número meta de operadores, puede poner 0 si no se sabe de momento", "warning");
                return false;
            }
                              
            $('#<%= guardar.ClientID %>').click();                   
            return true;
                                           
        }

        function setSeccion(valor) {
            console.log("Valor: " + valor);
            $("*[id$='dseccion']").val(valor);
        }

        function exito() {

            swal({
                title: "Correcto",
                text: "Cambios guardado con éxito",
                type: "success",
                confirmButtonText: "Aceptar",
                closeOnConfirm: true,
            },
           function (isConfirm) {
               if (isConfirm) {

                   window.location.href = '/casas-amigas';
               }
           });

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

                   window.location.href = '/casas-amigas';
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
            $("*[id$='meta_op']").ForceNumericOnly();
            var valor = $("*[id$='hsecc']").val();
            if (valor != "null") {
                $("*[id$='dseccion']").val(valor);
            }
            loadJS("/app-assets/js/scripts/forms/select/form-select2.js");

        }
    </script>
</asp:Content>
