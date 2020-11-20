<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="agregarprestamo.aspx.cs" Inherits="elecion.tickets.agregarprestamo" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/forms/checkboxes-radios.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/pages/timeline.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/raty/jquery.raty.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">DATOS DE EMPEÑO</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Procesos</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Préstamos</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">        
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    
   
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h2 class="text-bold-500">
                        <asp:Label ID="folio" runat="server"></asp:Label></h2>
                    <h5 class="">
                        <asp:Label ID="fempeno" runat="server"></asp:Label></h5>
                    <h5 class="">
                        <asp:Label ID="frefrendo" runat="server"></asp:Label></h5>
                    <h5 class="">
                        <asp:Label ID="fenajenado" runat="server"></asp:Label></h5>
                    <h5 class="">
                        <asp:Label ID="fventa" runat="server"></asp:Label></h5>

                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                    <div class="heading-elements">
                        <ul class="list-inline mb-0">
                            <asp:HiddenField runat="server" ID="idP" Value="0" />
                            <asp:HiddenField runat="server" ID="idS" Value="0" />
                            <asp:HiddenField runat="server" ID="idC" Value="0" />
                            <asp:HiddenField runat="server" ID="idA" Value="0" />
                            <asp:HiddenField runat="server" ID="porcavaluo" Value="0" />
                            <asp:HiddenField runat="server" ID="porcventa" Value="0" />
                            <asp:HiddenField runat="server" ID="idPlz" Value="0" />
                            <asp:HiddenField runat="server" ID="idCfg" Value="0" />
                            <asp:HiddenField runat="server" ID="dventa" Value="0" />
                            <asp:HiddenField runat="server" ID="dtolerancia" Value="0" />
                            <asp:HiddenField runat="server" ID="dapartado" Value="0" />
                            <asp:HiddenField runat="server" ID="idiario" Value="0" />
                            

                            
                            <asp:Button runat="server" ID="volver" OnClick="volverListado" class="ocultar" UseSubmitBehavior="false"/>


                        </ul>
                    </div>

                   
                </div>
                <div class="card-body collapse in">
                    <div class="card-block">

                        <div class="form-body">

                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title"><i class="fa fa-user"></i>Cliente</h4>
                                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                                    <div class="heading-elements">
                                        <ul class="list-inline mb-0">
                                            <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                                        </ul>
                                    </div>
                                </div>

                                <asp:UpdatePanel runat="server" ID="updatePanelTop2" UpdateMode="Conditional" ChildrenAsTriggers="True">
                                 <ContentTemplate>
                                <div class="card-body collapse in datos">
                                    <div class="row">
                                        <div class="col-md-3">
                                            
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <asp:Image ID="fotopa" runat="server" Height="300" Width="100%" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 centrarCelda">
                                                    <asp:Button runat="server" ID="asignar" OnClick="getCliente" class="ocultar" />
                                                    <asp:FileUpload ID="Bfoto" runat="server" accept="image/*" onchange="showpreview(this);" class="ocultar"></asp:FileUpload>
                                                    <button class="btn btn-primary" onclick="dialogCliente()" type="button" id="BBfoto" runat="server">
                                                        <i class="fa fa-check-square-o"></i>Seleccionar foto
                                                    </button>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-9">

                                            <div class="row">

                                                <div class="col-md-3">
                                                    <div class="form-group">

                                                        <label class="text-bold-600">Clave *</label>

                                                        <asp:TextBox ID="clave" CssClass="form-control text-uppercase" placeholder="Clave" name="clave" runat="server"></asp:TextBox>


                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">

                                                        <label for="nombre" class="text-bold-600">Nombre *</label>

                                                        <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" placeholder="Nombre" name="nombre" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                                <div class="col-md-3">
                                                    <div class="form-group align-bottom">
                                                        <br />
                                                        <button class="btn btn-primary" onclick="abrirModal()" type="button" id="BBbuscarcliente" runat="server">
                                                            <i class="fa fa-check-square-o"></i>Buscar Cliente
                                                        </button>

                                                        
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Domicilio *</label>
                                                        <asp:TextBox ID="calle" CssClass="form-control text-uppercase" placeholder="Calle y numero" name="calle" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Colonia *</label>
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
                                                        <label class="text-bold-600">Estado *</label>
                                                        <asp:DropDownList runat="server" ID="entidad" CssClass="select2 form-control" DataSourceID="DsEntidades" DataTextField="entidad" DataValueField="identidad" AutoPostBack="false"></asp:DropDownList>
                                                        <asp:SqlDataSource ID="DsEntidades" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT identidad, entidad FROM entidad ORDER BY entidad"></asp:SqlDataSource>

                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Localidad *</label>
                                                        <asp:TextBox ID="localidad" CssClass="form-control text-uppercase" placeholder="Localidad" name="localidad" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                            </div>


                                            <div class="row">

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">E-mail</label>

                                                        <asp:TextBox ID="email" CssClass="form-control email-inputmask" placeholder="E-MAIL" MaxLength="35" name="email" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Télefono</label>

                                                        <asp:TextBox ID="telefono" CssClass="form-control phone-inputmask" placeholder="TELÉFONO" name="phone" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Celular *</label>

                                                        <asp:TextBox ID="celular" CssClass="form-control phone-inputmask" placeholder="CELULAR" name="celular" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Observaciones</label>
                                                        <asp:TextBox ID="observaciones" CssClass="form-control text-uppercase" Rows="2" TextMode="MultiLine" placeholder="Nota o comentario" name="nota" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                                                </ContentTemplate>
                                    </asp:UpdatePanel>
                            </div>



                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title"><i class="fa fa-shopping-cart"></i>Artículo</h4>
                                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                                    <div class="heading-elements">
                                        <ul class="list-inline mb-0">
                                            <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="card-body collapse in">
                                    <div class="row">

                                        
                                        <div class="col-md-3">

                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <asp:Image ID="fotoarticulo" runat="server" Height="300" Width="100%" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 centrarCelda">

                                                    <asp:FileUpload ID="Bfotoarticulo" runat="server" accept="image/*" onchange="showpreviewart(this);" class="ocultar"></asp:FileUpload>
                                                    <button class="btn btn-primary" onclick="dialogArticulo()" type="button" id="BBfotoarticulo" runat="server">
                                                        <i class="fa fa-check-square-o"></i>Seleccionar foto
                                                    </button>
                                                </div>
                                            </div>

                                        </div>



                                        <div class="col-md-9">

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Descripción *</label>
                                                        <asp:TextBox ID="descripcion" CssClass="form-control text-uppercase" Rows="4" TextMode="MultiLine" placeholder="Descripción" name="nota" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <asp:UpdatePanel ID="categ" runat="server">
                                                    <ContentTemplate>
                                                        <div class="col-md-6" runat="server">
                                                            <div class="form-group">
                                                                <label class="text-bold-600">Categoría *</label>
                                                                <asp:DropDownList runat="server" ID="categorias" CssClass="select2 form-control" DataSourceID="Dscategorias" DataTextField="categoria" AutoPostBack="true" DataValueField="idcategoria" OnDataBound="categoriasDataBound">
                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource ID="Dscategorias" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                                    SelectCommand="SELECT idcategoria, categoria from categoria order by categoria"></asp:SqlDataSource>

                                                            </div>
                                                        </div>

                                                        <div class="col-md-6" runat="server">
                                                            <div class="form-group">
                                                                <label class="text-bold-600">SubCategoría *</label>
                                                                <asp:DropDownList runat="server" ID="subcategorias" CssClass="select2 form-control" DataSourceID="Dssubcategorias" DataTextField="subcategoria" DataValueField="idsubcategoria" AutoPostBack="false"></asp:DropDownList>
                                                                <asp:SqlDataSource ID="Dssubcategorias" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idsubcategoria, subcategoria FROM subcategoria  WHERE idcategoria =@idcat ORDER BY subcategoria">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="categorias" Name="idcat" PropertyName="SelectedValue" />

                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </div>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>


                                            </div>



                                            
                                        </div>

                                    </div>
                                </div>
                            </div>


                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title"><i class="fa fa-usd"></i>Préstamo</h4>
                                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                                    <div class="heading-elements">
                                        <ul class="list-inline mb-0">
                                            <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="card-body collapse in">
                                    <div class="row">

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="text-bold-600">Cotitular</label>
                                                <asp:TextBox ID="cotitular" CssClass="form-control text-uppercase" placeholder="Cotitular" name="cotitular" runat="server"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="text-bold-600">Préstamo *</label>
                                                <asp:TextBox ID="prestamo" CssClass="form-control text-uppercase" placeholder="Préstamo" name="prestamo" runat="server" onkeyup="calcMontos()"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="text-bold-600">Avalúo</label>
                                                <asp:TextBox ID="reem" CssClass="form-control text-uppercase" placeholder="Avalúo" name="avaluo" runat="server"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="col-md-3 ocultar">
                                            <div class="form-group">

                                                <label class="text-bold-600">Precio Venta</label>
                                                <asp:TextBox ID="precio" CssClass="form-control text-uppercase" placeholder="Precio" name="avaluo" runat="server"></asp:TextBox>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <span class="right">
                                <asp:Button runat="server" ID="bguardar" OnClick="guardaEdita" Style="display: block" CausesValidation="true" UseSubmitBehavior="false" />
                                <button class="btn btn-primary" onclick="valida()" type="button" id="BBguardar" runat="server">
                                    <i class="fa fa-check-square-o"></i>Guardar
                                </button>

                                <button type="button" class="btn btn-danger mr-1" onclick="regresar()" id="cancelar">
                                    <i class="ft-x"></i>Volver
                                </button>

                            </span>

                        </div>




                    </div>
                </div>
            </div>
        </div>
    </div>
    
                                               
   
            <div class="modal fade" id="bootstrap" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title" id="myModalLabel35">Consulta de Clientes</h3>
                        </div>


                        <div class="modal-body">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="row">


                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Nombre</label>
                                                <asp:TextBox ID="bnombre" CssClass="form-control text-uppercase" placeholder="Nombre" name="nombre" runat="server" OnTextChanged="listadoClientes" AutoPostBack="true">

                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </div>


                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div style="overflow-x: auto; width: 100%">
                                                <asp:GridView runat="server" ID="lusuarios" PageSize="10" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered base-style"
                                                    AutoGenerateColumns="False" DataSourceID="DsUsuarios" DataKeyNames="idcliente"
                                                    AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros" OnPageIndexChanged="listadoClientes">
                                                    <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                                    <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="ncompleto" HeaderText="Nombre" SortExpression="ncompleto" />

                                                        <asp:BoundField DataField="domicilio" HeaderText="Domicilio" SortExpression="domicilio" />

                                                        <asp:TemplateField HeaderText="Seleccionar" ItemStyle-Width="80px" ItemStyle-CssClass="centrarCelda" HeaderStyle-CssClass="centrarCelda">
                                                            <ItemTemplate>

                                                                <button type="button" id="" onclick="seleccionar(<%# Eval("idcliente")%>,<%# Eval("idsucursal")%>)" class="btn btn-icon btn-success mr-1" data-toggle="tooltip" data-original-title="Seleccionar">
                                                                    <i class="ft-edit"></i>
                                                                </button>



                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>

                                                    <PagerSettings Mode="NumericFirstLast"
                                                        
                                                        Position="Bottom" />
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="DsUsuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>
                                            </div>
                                        </div>

                                         <div id="divResultados" runat="server" visible="false">
                                            
                                                                                   
                                            <label class="col-md-6 label-control" >No se encontraron registros, desea realizar un registro manual?</label>
                                            <button type="button" class="btn btn-danger" onclick="registroManual()">
                                                        <i class="fa fa-check-square-o"></i>Registro Manual
                                             </button>  

                                        </div>
                                    </div>
                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>




                        <div class="modal-footer">
                            <asp:Button runat="server" ID="Button1" Style="display: none" CausesValidation="false" />
                            <asp:Button runat="server" ID="borrar" Style="display: none" />

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
    <script src="/app-assets/vendors/js/timeline/horizontal-timeline.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/jquery.raty.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    
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

        //$(document).prop('title', 'PLACEL - Agregar Coordinador');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#ticketsact").addClass("active");
        $(document).ready(function () {
            $('textarea').keypress(function (event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                }
            });
        });

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

        function seleccionar(id,ids) {
          mostrarLoading();
          $("*[id$='idC']").val(id);
          $("*[id$='idS']").val(ids);
          $("*[id$='bnombre']").val('');
            cerrarModal();
           $('#<%= asignar.ClientID %>').click(); 
        }


        function calcMontos() {
          
            var prestamo = $("*[id$='prestamo']").val();
            var aval = parseFloat($("*[id$='porcavaluo']").val());
            var venta = parseFloat($("*[id$='porcventa']").val());
            var avaluof = 0;
            var ventaf = 0;
           
            if (prestamo != '') {

                prestamo = parseFloat(prestamo);                
                avaluof = prestamo * (1 + aval / 100);
                
                ventaf = prestamo * (1 + venta / 100);

                $("*[id$='reem']").val(avaluof.toFixed(2));
                $("*[id$='precio']").val(ventaf.toFixed(2));

            }

            
        }

        function dialogCliente() {
            $('#<%= Bfoto.ClientID %>').click();
        }

        function dialogArticulo() {
            $('#<%= Bfotoarticulo.ClientID %>').click();
        }
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

        function showpreviewart(input) {

            if (input.files && input.files[0]) {

                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#fotoarticulo').attr('src', e.target.result);
                    $("*[id$='fotoarticulo']").attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }

        }

        function valida() {

            var clave = $("*[id$='clave']").val();
            var nombre = $("*[id$='nombre']").val();
            var calle = $("*[id$='calle']").val();
            var colonia = $("*[id$='colonia']").val();
            var localidad = $("*[id$='localidad']").val();
            var celular = $("*[id$='celular']").val();

            var descripcion = $("*[id$='descripcion']").val();
            var prestamo = $("*[id$='prestamo']").val();

            if (clave == '') {
                swal("Atención", "Ingrese la clave del cliente", "warning");
                return false;
            }
            if (nombre == '') {
                swal("Atención", "Ingrese el nombre completo del cliente", "warning");
                return false;
            }
            if (calle == '') {
                swal("Atención", "Ingrese el domicilio del cliente", "warning");
                return false;
            }
            if (colonia == '') {
                swal("Atención", "Ingrese la colonia del domicilio", "warning");
                return false;
            }
            if (localidad == '') {
                swal("Atención", "Ingrese la localidad del domicilio", "warning");
                return false;
            }
            if (celular == '') {
                swal("Atención", "Ingrese el número celular del cliente", "warning");
                return false;
            }
            
            if (descripcion == '') {
                swal("Atención", "Ingrese la descripción del artículo", "warning");
                return false;
            }
            if (prestamo == '' || prestamo=='0') {
                swal("Atención", "Ingrese la cantidad del préstamo", "warning");
                return false;
            }

            
            swal({
                title: "Se generará el préstamo con los datos indicados, ¿Desea continuar?",
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
                    $('#<%= bguardar.ClientID %>').click();                
                } 
            });

       }




        function abrirModal() {            
            //$(".modal-backdrop").remove();

            $("*[id$='bnombre']").focus();
            $("#divResultados").hide();
            $("#bootstrap").modal('show');

                      
        }

        $('#bootstrap').on('shown.bs.modal', function () {
            $("*[id$='bnombre']").val('');
            $("*[id$='bnombre']").focus();
        })

        function cerrarModal() {
            $("#bootstrap").modal('hide');
        }

        function registroManual() {
            $("*[id$='idC']").val(0);
            $("#bootstrap").modal('hide');
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
           
                $("*[id$='prestamo']").ForceNumericOnly();
            
                //$("*[id$='volver']").jqBootstrapValidation("destroy");
               // $("*[id$='cp']").ForceNumericOnly(); 
                //$("*[id$='seccion']").ForceNumericOnly();
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
               // loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
               // loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                loadJS("/app-assets/js/scripts/extensions/rating.js");
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

                

        }
    </script>
</asp:Content>