<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="registrarforo.aspx.cs" Inherits="elecion.foro.registrarforo" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/datatable/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/extensions/buttons.dataTables.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/datatable/buttons.bootstrap4.min.css" />

    <style>
       .itemg{cursor:pointer;}
       .itemg:hover{background-color:#E6F0FA;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Foro Nuevo Sol</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Campaña</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Foro Nuevo Sol</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
    <asp:HiddenField runat="server" ID="idP" Value="0" />
    <asp:HiddenField runat="server" ID="hentidad" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="false" Width="800" Height="600"> </rsweb:ReportViewer>
    <div id="iframeplaceholder" style="display:none"></div>
    
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title" id="horz-layout-basic">Registro de Afiliados</h4>
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
                            <div id="divBuscar" runat="server">
                                <div class="form-body">
                                    <asp:UpdatePanel runat="server" ID="pUBus">
                                    <ContentTemplate>
                                    <div ID="divBus" runat="server" visible="true" >
                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            Consulta
                                                <asp:TextBox ID="buscar" CssClass="form-control" placeholder="Nombre completo" name="buscar" runat="server" style="text-transform: uppercase"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="form-actions right">
                                        <asp:Button runat="server" ID="bbuscar" OnClick="bbuscar_Click" class="ocultar" />                                        

                                        <button type="button" class="btn btn-primary" id="bbusca" onclick="buscar()">
                                            <i class="fa fa-check-square-o"></i>Buscar
                                        </button>

                                    </div>
                                    

                                    <div class="form-group row">
                                        <div class="col-md-12">
                                            <div style="overflow-x: auto; width: 100%">
                                            <asp:GridView runat="server" Width="100%" ID="gBusqueda" AutoGenerateColumns="false" DataSourceID="DsBusqueda" OnRowCreated="gBusqueda_RowCreated"
                                                OnSelectedIndexChanged="gBusqueda_SelectedIndexChanged" DataKeys="Clave" 
                                                CssClass="table table-striped table-bordered base-style" onclick="mostrarLoading()">                                                
                                                <RowStyle CssClass="item" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Afiliado" ItemStyle-Width="15px"  ItemStyle-HorizontalAlign="Center">
                                                         <ItemTemplate>  
                                                             <div class="row skin skin-flat">
                                                             <div class="state icheckbox_flat-green <%# Eval("afiliado")%> mr-1"></div>
                                                             </div>
                                                         </ItemTemplate>
                                                    </asp:TemplateField> 
                                                    
                                                    <asp:BoundField DataField="Clave" HeaderText="Clave" SortExpression="Clave" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="15px"/>
                                                    <asp:BoundField DataField="fechanac" HeaderText="Fecha Nac" SortExpression="fechanac" HeaderStyle-HorizontalAlign="Center" DataFormatString = "{0:dd/MM/yyyy}" ItemStyle-Width="15px"/>
                                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="Municipio" HeaderText="Municipio" SortExpression="Municipio" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="Colonia" HeaderText="Colonia" SortExpression="Colonia" HeaderStyle-HorizontalAlign="Center" />
                                                    <asp:BoundField DataField="Calle" HeaderText="Calle" SortExpression="Calle" HeaderStyle-HorizontalAlign="Center" />                                                      
                                                                                                                                                          
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="DsBusqueda" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>
                                            </div>
                                        </div>
                                    </div>
                                   

                                    </div>

                                        <div id="divResultados" runat="server" visible="false">
                                            <asp:Button runat="server" ID="bregistrom" OnClick="registroManual" class="ocultar" /> 
                                                                                   
                                            <label class="col-md-6 label-control" >No se encontraron registros, desea realizar un registro manual?</label>
                                            <button type="button" class="btn btn-danger" onclick="mostrarLoading(); $('#<%= bregistrom.ClientID %>').click();">
                                                        <i class="fa fa-check-square-o"></i>Registro Manual
                                             </button>  

                                        </div>
                                    </ContentTemplate>
                                    </asp:UpdatePanel>

                                    
                                </div>
                            </div>
                        </div>
                        
                        <asp:UpdatePanel runat="server" ID="pUDatos">
                        <ContentTemplate>
                         <div ID="divDatos" runat="server" visible="false" >
                        <div class="form-body">
                            <h4 class="form-section"><i class="ft-user"></i>Información Personal</h4>
                            <div class="form-group row">
                                <label class="col-md-3 label-control" for="elector">Clave Elector</label>
                                <div class="col-md-4">

                                    <asp:TextBox ID="elector" CssClass="form-control" MaxLength="18" placeholder="Clave INE" name="fname" runat="server"></asp:TextBox>

                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-3 label-control" for="nombre">Nombre</label>
                                <div class="col-md-6">
                                    <asp:TextBox ID="nombre" CssClass="form-control" placeholder="Nombre(s)" MaxLength="40" name="fname" runat="server"></asp:TextBox>
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
                            <div class="form-group row">
                                <label class="col-md-3 label-control" for="telefono">Estructura</label>
                                <div class="col-md-6">
                                    <asp:DropDownList CssClass="select2 form-control" runat="server" ID="estructura" DataSourceID="DsEstructura" DataTextField="nombre" DataValueField="idEstructura">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="DsEstructura" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [idEstructura], [nombre] FROM [estructuras]"></asp:SqlDataSource>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-3 label-control" for="estado">Estado</label>
                                <div class="col-md-6">
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="estado" onchange="setEstado()">
                                        <asp:ListItem Value="Favor">Favor</asp:ListItem>
                                        <asp:ListItem Value="Contra">Contra</asp:ListItem>
                                        <asp:ListItem Value="Indeciso">Indeciso</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group row" id="divPref" style="display: none">
                                <label class="col-md-3 label-control" for="telefono">Preferencia</label>
                                <div class="col-md-6">
                                    <asp:TextBox ID="preferencia" CssClass="form-control" placeholder="Noto alguna preferencia" name="preferencia" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <h4 class="form-section"><i class="ft-map-pin"></i>Domicilio</h4>
                            

                                    <div class="form-group row">
                                        <label class="col-md-3 label-control" for="municipio">Municipio</label>
                                        <div class="col-md-6">
                                            <asp:DropDownList runat="server" ID="municipio" CssClass="select2 form-control" DataSourceID="DsMunicipios" DataTextField="municipio" DataValueField="idMunicipio" AutoPostBack="true" OnDataBound="municipios_DataBound"></asp:DropDownList>
                                            <asp:SqlDataSource ID="DsMunicipios" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [idMunicipio], [municipio] FROM [municipios] WHERE [entidad] = @ent ORDER BY [municipio]">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hentidad" Name="ent" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-md-3 label-control" for="seccional">Sección</label>
                                        <div class="col-md-2">
                                            <asp:DropDownList runat="server" ID="seccional" CssClass="select2 form-control" DataSourceID="DsSeccional" DataTextField="seccion" DataValueField="seccion" AutoPostBack="false" OnDataBound="seccional_DataBound"></asp:DropDownList>
                                            <asp:SqlDataSource ID="DsSeccional" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [seccion] FROM [secciones] WHERE idMunicipio =@idmun and entidad = @ent ORDER BY [seccion]">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="municipio" Name="idmun" PropertyName="SelectedValue" />
                                                    <asp:ControlParameter ControlID="hentidad" Name="ent" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 label-control" for="colonias">Colonia
                                            <asp:Label runat="server" ID="sColonia"></asp:Label></label>
                                        <div class="col-md-6">
                                            <asp:DropDownList runat="server" ID="colonias" CssClass="select2 form-control" DataSourceID="DsColonias" DataTextField="colonia" DataValueField="idColonia" AutoPostBack="true" OnDataBound="colonias_DataBound"></asp:DropDownList>
                                            <asp:SqlDataSource ID="DsColonias" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idColonia, colonia FROM colonias  WHERE idMunicipio =@idmun and entidad = @ent ORDER BY [colonia]">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="municipio" Name="idmun" PropertyName="SelectedValue" />
                                                    <asp:ControlParameter ControlID="hentidad" Name="ent" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 label-control" for="calle">Calle
                                            <asp:Label runat="server" ID="sCalle"></asp:Label></label>
                                        <div class="col-md-6">
                                            <asp:DropDownList runat="server" ID="calle" CssClass="select2 form-control" DataTextField="calle" DataValueField="idCalle" DataSourceID="DsCalle" AutoPostBack="false"></asp:DropDownList>
                                            <asp:SqlDataSource ID="DsCalle" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idCalle, calle from Vialidades WHERE idColonia =@idcol and entidad = @ent ORDER BY calle">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="colonias" Name="idcol" PropertyName="SelectedValue" />
                                                    <asp:ControlParameter ControlID="hentidad" Name="ent" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>

                                        </div>
                                    </div>
                                
                            <div class="form-group row">
                                <label class="col-md-3 label-control" for="numext">Número Exterior</label>
                                <div class="col-md-2">
                                    <asp:TextBox ID="numext" CssClass="form-control" placeholder="Número Exterior" MaxLength="10" name="fname" runat="server"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-3 label-control" for="numint">Número Interior</label>
                                <div class="col-md-2">
                                    <asp:TextBox ID="numint" CssClass="form-control" placeholder="Número Interior" MaxLength="10" name="fname2" runat="server"></asp:TextBox>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-3 label-control" for="cp">Código Postal</label>
                                <div class="col-md-2">
                                    <asp:TextBox ID="cp" CssClass="form-control" placeholder="Código Postal" MaxLength="5" name="email" runat="server"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        

                        <div class="form-actions right">
                            <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" class="ocultar" />
                            <asp:Button runat="server" ID="volver" OnClick="pantalla" class="ocultar" />

                            <button class="btn btn-primary" onclick="valida()" type="button">
                                <i class="fa fa-check-square-o"></i>Guardar
                            </button>

                            <button type="button" class="btn btn-warning mr-1" onclick="regresar()" id="cancelar">
                                <i class="ft-x"></i>Cancelar
                            </button>

                            <button type="reset" class="btn btn-danger" style="display: none" id="reset">Reset <i class="fa fa-refresh position-right"></i></button>

                        </div>
                        </div>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                        

                    </div>
                </div>
            </div>
        </div>
    </div>
            
            
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
     <script src="/app-assets/vendors/js/tables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/datatable/dataTables.bootstrap4.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/datatable/dataTables.buttons.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/datatable/buttons.bootstrap4.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>
    <script>

        function loadiFrame2(src) {

            $("#iframeplaceholder").html("<iframe id='myiframe' width='500' height='600' name='myname' src='" + src + "' />");
        }

        function imprimir(src) {

            loadiFrame2(src); 
                //examplePDF.Print();
                $("#myiframe").load( 
                    function() {
                        $('#myname').contents().find('#download').remove();
                        window.frames['myname'].focus();
                        window.frames['myname'].print();
                       // WindowPrint();
                        /*var PDF = document.getElementById('myiframe'); 
                        PDF.focus(); 
                        PDF.contentWindow.print();*/

                       //print_frame[0].contentWindow.document;

                    }
                )

        }


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

        $(document).prop('title', 'PLACEL - Registro promovidos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#listadoforo").addClass("active");
        $(document).ready(function () {

          
        })

        function setEstado() {
            var txt = $('#<%=estado.ClientID %> option:selected').text();

            if (txt == "Contra") {
                $("*[id$='divPref']").show();
            } else {
                $("*[id$='divPref']").hide();
            }
        }

        function buscar() {
            mostrarLoading();
            $('#<%= bbuscar.ClientID %>').click();    
        }

        function valida() {
            mostrarLoading();
            var clave = $("*[id$='elector']").val();
            var nombre = $("*[id$='nombre']").val();
            var apaterno = $("*[id$='apaterno']").val();
            var amaterno = $("*[id$='amaterno']").val();
            

            if (clave == '') {
                swal("Atención", "Ingrese la clave electoral", "warning");
                cerrarLoading();
                return false;
            }
            if (nombre == '') {
                swal("Atención", "Ingrese el nombre", "warning");
                cerrarLoading();
                return false;
            }
            if (apaterno == '') {
                swal("Atención", "Ingrese el apellido paterno", "warning");
                cerrarLoading();
                return false;
            }
            if (amaterno == '') {
                swal("Atención", "Ingrese el apellido materno", "warning");
                cerrarLoading();
                return false;
            }
                  
            
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
                    
                    $('#<%= volver.ClientID %>').click();
                    //swal.close();
                   
                } 
            });

        }

    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
    <script>

        function printTrigger(elementId) {
            var getMyFrame = document.getElementById(elementId);
            getMyFrame.focus();
            getMyFrame.contentWindow.print();
        }

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
                loadJS("/app-assets/js/scripts/tables/datatables-extensions/datatable-button/datatable-html5.js");

        }
    </script>

</asp:Content>
