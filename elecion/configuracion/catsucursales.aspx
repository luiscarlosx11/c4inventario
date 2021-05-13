<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="catsucursales.aspx.cs" Inherits="elecion.catalogos.configuracion.catsucursales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .ascending a {
	     
	        display:block;
        }

        .descending a {
	       
	        display:block;
	
        }

   
   
}
    </style>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

        <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css"/>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
   
    
            <div class="content-header row">

                   <div class="col-md-3">
                       <div class="media-left media-middle">
                           <i class="fa fa-hospital-o primary font-large-2 mr-1"></i>
                       </div>
                       <div class="media-body">
                           <h4 class="font-weight-bold">Unidades Educativas</h4>
                           <span class="font-small-3">
                               <asp:Label runat="server" ID="labelConteo">0</asp:Label>
                               registro(s) encontrado(s)</span>
                       </div>

                   </div>
                    <div class="col-md-9 float-md-right">
                               <asp:HiddenField runat="server" ID="idP" />                                
                               <asp:HiddenField runat="server" ID="idS" />                               
                               <span class="pull-right">
                                   <label class="text-bold-600 font-small-3"></label>
                                   <button type="button" id="nuevo" onclick="abrirModal(0,'','','','','','','',1,false,'','','',52);" class="btn btn-icon btn-primary mr-1 text-bold-700" data-toggle="modal">
                                  
                                       Nuevo Registro 
                                   </button>
                               </span>
                           </div>
               </div>    <br />
            <div class="row" >
                   <div class="col-md-12">

                       <div class="media">
                           
                           <div class="col-md-4">
                               <div class="form-group">      
                                   <label class="text-bold-600 font-small-3">Unidad Educativa</label>
                                   <asp:TextBox ID="bname" CssClass="form-control text-uppercase" placeholder="Búsqueda por Nombre, Clave CCT..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                               </div>
                           </div>

                           <div class="col-md-2" id="busplantel" runat="server">
                               <div class="form-group">
                                   <label class="text-bold-600 font-small-3">Tipo de unidad</label>
                                   <asp:DropDownList runat="server" ID="btipounidad" CssClass="select2 form-control" DataSourceID="DSplantel" DataTextField="tiposucursal" DataValueField="idtiposucursal" AppendDataBoundItems="true" onChange="consultaPrincipal()">
                                       <asp:ListItem Value="0" Text="SELECCIONE UN TIPO"></asp:ListItem>
                                   </asp:DropDownList>
                                   <asp:SqlDataSource ID="DSplantel" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idtiposucursal, tiposucursal FROM tiposucursal ORDER BY idtiposucursal"></asp:SqlDataSource>
                               </div>
                           </div>
                                                                                                                   
                          
                       </div>

                   </div>
               </div>
            
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>

            <div class="row" id="header-styling">
                <div class="col-xs-12">
                            
                            <div class="card-block card-dashboard">
                            <div style="overflow-x:auto;width:100%"> 

                                <asp:Button runat="server" ID="Bconsultar" OnClick="listadoClientes" Style="display: none" CausesValidation="false" UseSubmitBehavior="false" />
                                <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" style="display:none" CausesValidation="false" UseSubmitBehavior="false"/>     
                                <asp:Button runat="server" ID="borrar" OnClick="borrarRegistro" style="display:none" CausesValidation="false" UseSubmitBehavior="false"/>

                            <asp:GridView runat="server" ID="lgastos" PageSize="25" AllowPaging="true"  CssClass="table table-striped lGeneral" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastos" 
                                 GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static" OnPageIndexChanged="listadoClientes"
                                >
                                <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="No." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-CssClass="primary" ItemStyle-CssClass="centrarCelda font-small-3">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="Unidad Educativa" HeaderStyle-CssClass="primary">
                                                    <ItemTemplate>

                                                        <h7 class="font-weight-bold"><%# Eval("clavecct")+ " / "+Eval("nombre")%></h7><br />
                                                        <h7 class="font-small-2  text-bold-400"><i class="fa fa-home"></i> <%# " "+Eval("direccion")%></h7>                                                        

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                                                                                                                        
                                             <asp:TemplateField HeaderText="Tipo de Unidad" ItemStyle-Width="150px" HeaderStyle-CssClass="primary centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                    <ItemTemplate>
                                                            <span class="tag bg-<%# Eval("tiposucursal").Equals("UNIDAD MÓVIL")?"danger":"success"%>"><span class="text-bold-700"><%# Eval("tiposucursal")%></span></span>                                                        
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            
                                            <asp:TemplateField HeaderText="Activo" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="primary">
                                                <ItemTemplate>
                                                    <div class="row skin skin-flat">
                                                        <div class="state icheckbox_flat-green <%# Eval("activotext")%> mr-1"></div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>  
                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="20px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                <ItemTemplate>

                                                    <button type="button" id="editar" onclick="abrirModal(<%# Eval("idsucursal")%>,'<%# Eval("nombre").ToString() %>','<%# Eval("clavecct").ToString() %>','<%# Eval("calle").ToString() %>','<%# Eval("numext").ToString() %>','<%# Eval("colonia").ToString() %>','<%# Eval("cp").ToString() %>','<%# Eval("telefono").ToString() %>', <%# Eval("idtiposucursal").ToString() %>, <%# Eval("activo").ToString() %>, '<%# Eval("telefono2").ToString() %>','<%# Eval("localidad").ToString() %>', '<%# Eval("encargado").ToString() %>', <%# Eval("idcargo").ToString() %>)" class="btn btn-icon btn-warning mr-1 btn-sm"
                                                        data-toggle="tooltip" data-original-title="Editar" >
                                                         <i class="ft-edit"></i>
                                                    </button>
                                                                                                                                                             
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            
                                    <asp:SqlDataSource ID="DsListadoGastos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="">

                                    </asp:SqlDataSource>
                               </div>
                            </div>
                        
                    </div>
                </div>
            </div>

            
      </ContentTemplate>
    </asp:UpdatePanel> 
    <div class="modal fade text-xs-left" id="bootstrap" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true" >

        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title" id="myModalLabel35">UNIDAD EDUCATIVA</h5>
                </div>

                <asp:HiddenField runat="server" ID="idr" />
                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-12">

                            <div class="row">
                                <div class="col-md-8">
                                    <div class="form-group">
                                        <label class="text-bold-600">Nombre</label>
                                        <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Nombre" name="nombre" runat="server"></asp:TextBox>

                                    </div>


                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="text-bold-600">Clave cct</label>
                                        <asp:TextBox ID="clavecct" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Clave cct" name="clavecct" runat="server"></asp:TextBox>

                                    </div>


                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="text-bold-600">Cargo</label>
                                        <asp:DropDownList runat="server" ID="cargo" CssClass="select2 form-control" DataSourceID="DScargo" DataTextField="cargo" DataValueField="idcargo" Style="width: 100%">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="DScargo" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                            SelectCommand="SELECT idcargo, cargo from cargo order by cargo"></asp:SqlDataSource>
                                    </div>

                                </div>
                                <div class="col-md-8">
                                    <div class="form-group">
                                        <label class="text-bold-600">Nombre del Encargado/Director</label>
                                        <asp:TextBox ID="encargado" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Encargado" name="encargado" runat="server"></asp:TextBox>

                                    </div>


                                </div>

                            </div>



                            <div class="row">
                                <div class="col-md-9">
                                    <div class="form-group">
                                        <label class="text-bold-600">Calle</label>

                                        <asp:TextBox ID="calle" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Calle" name="calle" runat="server"></asp:TextBox>

                                    </div>


                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="text-bold-600">Num. Ext</label>

                                        <asp:TextBox ID="numext" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Num" name="numext" runat="server"></asp:TextBox>

                                    </div>


                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-9">
                                    <div class="form-group">
                                        <label class="text-bold-600">Colonia</label>
                                        <asp:TextBox ID="colonia" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Colonia" name="colonia" runat="server"></asp:TextBox>

                                    </div>


                                </div>

                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="text-bold-600">CP</label>

                                        <asp:TextBox ID="cp" CssClass="form-control text-uppercase" MaxLength="60" placeholder="CP" name="cp" runat="server"></asp:TextBox>

                                    </div>


                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="text-bold-600">Localidad</label>
                                        <asp:TextBox ID="localidad" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Localidad" name="localidad" runat="server"></asp:TextBox>

                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="text-bold-600">Teléfono</label>
                                        <asp:TextBox ID="telefono" CssClass="form-control phone-inputmask" MaxLength="60" placeholder="Teléfono" name="telefono" runat="server"></asp:TextBox>

                                    </div>


                                </div>

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label class="text-bold-600">Teléfono Adicional</label>
                                        <asp:TextBox ID="adicional" CssClass="form-control phone-inputmask" MaxLength="60" placeholder="Teléfono" name="adicional" runat="server"></asp:TextBox>
                                    </div>
                                </div>



                            </div>

                            <div class="row">

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="text-bold-600">Tipo</label>
                                        <asp:DropDownList runat="server" ID="tiposucursal" CssClass="select2 form-control" DataSourceID="Dstiposucursal" DataTextField="tiposucursal" DataValueField="idtiposucursal" Style="width: 100%">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="Dstiposucursal" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                            SelectCommand="SELECT idtiposucursal, tiposucursal from tiposucursal order by tiposucursal"></asp:SqlDataSource>
                                    </div>

                                </div>


                                <div class="col-md-2">
                                    <div class="form-group">
                                        <label class="text-bold-600" for="activo">Activa</label>

                                        <div class="skin skin-flat">
                                            <asp:CheckBox runat="server" ID="activo" />
                                        </div>

                                    </div>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>




                <div class="modal-footer">


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
            
               
	        
            
  
   
              
           
     </asp:Content>      

<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>


    <script>
        var walert = 0;
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catsucursales").addClass("active");
/*
        $('#bootstrap').on('shown.bs.modal', function () {
            $("*[id$='nombre']").focus();
        });

        */

        function abrirModal(idsucursal, nombre, clavecct, calle, numext, colonia, cp, telefono, idtiposucursal, activo, telefono2, localidad, encargado, idcargo) {
            
                       
            $("*[id$='idg']").val(idsucursal);            
            $("*[id$='idS']").val(idsucursal);
           
            $("*[id$='nombre']").val(nombre);
            $("*[id$='calle']").val(calle);
            $("*[id$='clavecct']").val(clavecct);
            $("*[id$='numext']").val(numext);
            $("*[id$='colonia']").val(colonia);
            $("*[id$='cp']").val(cp);
            $("*[id$='telefono']").val(telefono);
            $("*[id$='adicional']").val(telefono2);
            $("*[id$='localidad']").val(localidad);
            $("*[id$='tiposucursal']").val(idtiposucursal);           
            $("*[id$='cargo']").val(idcargo);

            $("*[id$='tiposucursal']").change();
            $("*[id$='cargo']").change();

            $("*[id$='encargado']").val(encargado);
            $("*[id$='tiposucursal']").change();
                                  
            if (activo == 1)
                $("*[id$='activo']").iCheck('check');
            else
                $("*[id$='activo']").iCheck('uncheck');
        
            $("#bootstrap").modal('show');
        }

        function valida() {
       
            var nombre = $("*[id$='nombre']").val();
            var clavecct = $("*[id$='clavecct']").val();
            var calle = $("*[id$='calle']").val();
            var numext = $("*[id$='numext']").val();
            var colonia = $("*[id$='colonia']").val();
            var cp = $("*[id$='cp']").val();
            var encargado = $("*[id$='encargado']").val();
            
            var localidad = $("*[id$='localidad']").val();
            
            walert = 1;
            if (nombre == '') {                
                alerta('Atención', 'Ingrese el nombre del plantel', 'warning', $("*[id$='nombre']"));
                return false;                
            }

            if (clavecct == '') {
                alerta('Atención', 'Ingrese la clave cct del plantel', 'warning', $("*[id$='clavecct']"));
                return false;
            }

            if (calle == '') {
                alerta('Atención', 'Ingrese la dirección(calle) del plantel', 'warning', $("*[id$='calle']"));
                return false;
            }

            if (numext == '') {
                alerta('Atención', 'Ingrese la dirección(número exterior) del plantel', 'warning', $("*[id$='numext']"));
                return false;
            }

            if (colonia == '') {
                alerta('Atención', 'Ingrese la dirección(colonia) del plantel', 'warning', $("*[id$='colonia']"));
                return false;
            }

            if (localidad == '') {
                alerta('Atención', 'Ingrese la dirección(localidad) del plantel', 'warning', $("*[id$='localidad']"));
                return false;
            }

            if (encargado == '') {
                alerta('Atención', 'Ingrese el nombre del encargado del plantel', 'warning', $("*[id$='encargado']"));
                return false;
            }

                              
            walert = 0;
            mostrarLoading();
            
            $('#<%= guardar.ClientID %>').click();
            $('#bootstrap').modal('hide');            
                                           
        }

        function consultaPrincipal(op) {
            mostrarLoading();

            $('#<%= Bconsultar.ClientID %>').click();
             cerrarLoading();
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

               // $("*[id$='cp']").ForceNumericOnly(); 
               // $("*[id$='seccion']").ForceNumericOnly();
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
                loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
                loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

                loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");

                walert = 0;
                $('#bootstrap').on('shown.bs.modal', function () {
                    $("*[id$='nombre']").focus();
                });

                

            //Phone mask
                $('.phone-inputmask').inputmask("(999) 999-9999");



        }
    </script>
</asp:Content>
