<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="listadoapartados.aspx.cs" Inherits="elecion.tickets.listadoapartados" EnableEventValidation="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


  <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
    <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />
    
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/raty/jquery.raty.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/simple-line-icons/style.min.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/forms/checkboxes-radios.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/core/colors/palette-tooltip.css">
    <!-- END VENDOR CSS-->
    <style>
        .truncar {
          /* hide text if it more than N lines  */
          overflow: hidden;
           
          /* for set '...' in absolute position */
          position: relative; 
          /* use this value to count block height */
          line-height: 1.2em;
          /* max-height = line-height (1.2) * lines max number (3) */
          max-height: 4.8em; 
          /* fix problem when last visible word doesn't adjoin right side  */
          text-align: justify;  
          /* place for '...' */
          margin-right: 0em;
          padding-right: 1em;
         
        }

        /* create the ... */
            .truncar:before {
              /* points in the end */
              content: '...';
              /* absolute position */
              position: absolute;
              /* set position to right bottom corner of block */
              right: 0;
              bottom: 0;
            }

        /* hide ... if we have text, which is less than or equal to max lines */
        .truncar:after {
          /* points in the end */
          content: '';
          /* absolute position */
          position: absolute;
          /* set position to right bottom corner of text */
          right: 0;
          /* set width and height */
          width: 1em;
          height: 1em;
          margin-top: 0.2em;
          /* bg color = bg color under block */
          background: white;
        }
    </style>

    <!-- END Custom CSS-->
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Préstamos</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Procesos</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Apartados</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
 <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
 <asp:UpdatePanel runat="server" ID="PUSeguimiento" UpdateMode="Conditional">
    <ContentTemplate>
<div class="row">
    <div class="col-lg-12 col-md-12 col-xs-12">
        <div class="row">
                <asp:HiddenField runat="server" ID="idP" />
                <asp:HiddenField runat="server" ID="idS" />
                <asp:HiddenField runat="server" ID="idO" />
                <asp:HiddenField runat="server" ID="idF" />
                <asp:Button runat="server" ID="Bnuevo" OnClick="nuevoRegistro" Style="display: none" />
                <asp:Button runat="server" ID="Beditar" OnClick="editarRegistro" Style="display: none" />
                <asp:Button runat="server" ID="Bconsultar" OnClick="listadoTickets" Style="display: none" />
                <asp:Button runat="server" ID="Brefrendo" OnClick="refrendaEmpeno" Style="display: none" />
                
            <div class="col-md-12">
                    <div class="card overflow-hidden">
                        <div class="card-body">
                            <div class="card-block cleartfix">
                                <div class="media">
                                    <div class="media-left media-middle">
                                        <i class="icon-speech primary font-large-2 mr-2"></i>
                                    </div>
                                    <div class="media-body">
                                        <h4>Apartados </h4>
                                        <span><asp:Label runat="server" ID="labelConteo"></asp:Label> actualmente</span>
                                    </div>
                                    
                                </div>
                            </div>
                            <div class="card-block card-dashboard">
                                 <div class="row">

                                    <div class="col-md-3">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">No. Boleta</label>
											<asp:TextBox ID="bfolio" CssClass="form-control"  placeholder="Boleta" name="boleta" runat="server" OnTextChanged="listadoTickets" AutoPostBack="true"></asp:TextBox>
										</div>
									</div>

                                     <div class="col-md-3">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Categoría</label>
											 <asp:DropDownList runat="server" ID="categorias" CssClass="select2 form-control" DataSourceID="Dscategorias" DataTextField="categoria" AutoPostBack="true" DataValueField="idcategoria" OnDataBound="categoriasDataBound" OnSelectedIndexChanged="categorias_SelectedIndexChanged">
                                             
                                             </asp:DropDownList>
                                              
                                                                <asp:SqlDataSource ID="Dscategorias" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                                    SelectCommand="SELECT idcategoria, categoria from categoria order by categoria"></asp:SqlDataSource>
										</div>
									</div>

                                     <div class="col-md-3">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Subcategoría</label>
											<asp:DropDownList runat="server" ID="subcategorias" CssClass="select2 form-control" DataSourceID="Dssubcategorias" DataTextField="subcategoria" DataValueField="idsubcategoria" AutoPostBack="true" OnSelectedIndexChanged="subcategorias_SelectedIndexChanged" OnDataBound="subcategorias_DataBound" OnDataBinding="subcategorias_DataBinding">
                                               

											</asp:DropDownList>
                                                                <asp:SqlDataSource ID="Dssubcategorias" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idsubcategoria, subcategoria FROM subcategoria  WHERE idcategoria =@idcat ORDER BY subcategoria">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="categorias" Name="idcat" PropertyName="SelectedValue" />

                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
										</div>
									</div>

                                   <div class="col-md-3">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Artículo</label>
											<asp:TextBox ID="barticulo" CssClass="form-control text-uppercase"  placeholder="Artículo" name="articulo" runat="server" OnTextChanged="listadoTickets" AutoPostBack="true"></asp:TextBox>
										</div>
									</div>
                              </div>

                                <div class="row">

                                    <div class="col-md-12">

                                        <div class="row">
                                            <div class="col-md-12">
                                                <button type="button" id="bauxhistorial" onclick="abrirModalHistorial();" class="btn btn-icon btn-blue-grey lighten-1">
                                                    <i class="fa fa-calendar"></i>  Historial
                                                </button>
                                               
                                                <button type="button" id="bauxrefrendar" onclick="abrirModalRefrendo(4);" class="btn btn-icon btn-warning"
                                                   >
                                                    <i class="fa fa-undo"></i> Abonar
                                                </button>

                                                <button type="button" id="bauxenajenar" onclick="abrirModalRefrendo(100);" class="btn btn-icon btn-danger"
                                                    >
                                                    <i class="ft-x"></i> Cancelar apartado
                                                </button>

                                                
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12"><br />
                                                <asp:GridView runat="server" ID="dlCustomers" PageSize="10" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration"
                                                    AutoGenerateColumns="False" DataSourceID="DSTickets"
                                                    AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros" OnRowDataBound="dlCustomers_RowDataBound">
                                                    <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                                    <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                                    <Columns>

                                                        <asp:TemplateField HeaderText="" ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>

                                                                <input id="<%# Eval("idempeno")+"_"+Eval("idsucursal") %>" type="checkbox" class="cks" value="<%# Container.DataItemIndex%>">
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:BoundField DataField="folio" HeaderText="Folio" SortExpression="folio" ItemStyle-CssClass="centrarCelda" HeaderStyle-CssClass="centrarCelda" ItemStyle-Width="120px" />   
                                                        <asp:BoundField DataField="cliente2" HeaderText="Cliente" SortExpression="cliente2" ItemStyle-Width="300px" />
                                                        <asp:BoundField DataField="categoria" HeaderText="Categoría" SortExpression="categoria" />                                                                                                             
                                                        <asp:BoundField DataField="fechaenajenacion" HeaderText="Enajenado en" SortExpression="fechaenajenacion" ItemStyle-CssClass="centrarCelda" HeaderStyle-CssClass="centrarCelda" />
                                                        <asp:BoundField DataField="precio" HeaderText="Precio" SortExpression="precio" ItemStyle-CssClass="centrarCelda" HeaderStyle-CssClass="centrarCelda" DataFormatString="{0:c}" HtmlEncode="False"/>
                                                        <asp:BoundField DataField="descripcion" HeaderText="Artículo" SortExpression="descripcion" />
                                                       

                                                        <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="0px" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar">
                                                            <ItemTemplate>
                                                                <div class="ocultar">
                                                                    
                                                                    <button type="button" id="refrendar_<%# Eval("idempeno")+"_"+Eval("idsucursal") %>" onclick="ModalRefrendo(<%# Eval("idempeno")%>,<%# Eval("idsucursal")%>,<%# Eval("idarticulo")%>,'<%# Eval("folio")%>','<%# Eval("cliente")%>','<%# Eval("descripcion")%>',<%# Eval("precio")%>,'<%# Eval("cliente2")%>',<%# Eval("abonototal")%> ,1);" class="btn btn-icon btn-success btn-sm"
                                                                        data-toggle="tooltip" data-original-title="Refrendar">
                                                                        <i class="ft-edit"></i>
                                                                    </button>

                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>

                                                </asp:GridView>

                                                <asp:SqlDataSource ID="DSTickets" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>
                                            </div>
                                        </div>
                                    </div>

                            </div>


                            <div class="row">
                                <div class="col-md-12 ">

                                    <div class="text-xs-center">
                                        <nav aria-label="Page navigation">
                                            <h5 class="text-xs-center"></h5>
                                            <asp:HiddenField ID="pagina" runat="server" Value="1" />
                                            <ul class="pagination pagination-lg mb-1">
                                            </ul>
                                        </nav>

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


<!--/ Analytics spakline & chartjs  -->


<!-- Audience by country & users visit-->

    

  
<!-- Analytics map based session -->
    


<!-- Analytics map based session -->
   </ContentTemplate>
     </asp:UpdatePanel>

     <asp:UpdatePanel runat="server" ID="updatePanelTop" UpdateMode="Conditional" ChildrenAsTriggers="True">
        <ContentTemplate>
            <div class="modal fade" id="refrendo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title" id="myModalLabel35"><asp:Label ID="titulo" runat="server"></asp:Label></h3>
                        </div>

                        <div class="modal-body">

                            <div class="row">
                                <div class="col-md-5">

                                    <div class="row">

                                        <div class="col-md-12">

                                            <asp:Image ID="fotoarticulo" runat="server" Height="300" Width="100%" />

                                        </div>
                                    </div>

                                </div>
                                <div class="col-md-7">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Folio</label>
                                                <asp:Label ID="lfolio" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>
                                    </div>  

                                    <div class="row ocultar">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Cliente</label>
                                                <asp:Label ID="lnombre" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>
                                    </div> 
                            
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Artículo</label>
                                                <asp:Label ID="larticulo" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>
                                    </div> 

                                   
                                    
                                   <div class="row">  
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Cliente</label>
                                                <asp:Label ID="lcomprador" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>
                                       </div>                                        
                                    

                                     <div class="row">                                        
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Precio</label>
                                                <asp:HiddenField ID="hpago" runat="server"/>
                                                <asp:Label ID="lpago" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div> 
                                         
                                         <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Último abono hace</label>                                                
                                                <asp:Label ID="ldias" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>                                        
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Abonado</label>                                                
                                                <asp:Label ID="labonado" runat="server" CssClass="col-md-12">0</asp:Label>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <asp:HiddenField ID="vender" runat="server"/>
                                                <label for="cliente" class="text-bold-600">Liquida con</label>                                                
                                                <asp:Label ID="lliquida" runat="server" CssClass="col-md-12">0</asp:Label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" id="dapartar">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Nuevo abono</label>
                                                <asp:TextBox ID="cantidad" CssClass="form-control text-uppercase"  placeholder="Cantidad" name="cantidad" runat="server" ></asp:TextBox>
                                            </div>
                                        </div>
                                                                                                                      
                                    </div>

                                   
                                </div>
                                </div>
                                
                        </div>

                        <div class="modal-footer">
                             <button class="btn btn-primary" onclick="procesoRefrendo()" type="button" id="bmrefrendar">
                               <i class="ft-file"></i>Abonar 
                             </button>

                            <button class="btn btn-primary" onclick="procesoDesempeno()" type="button" id="bmdesempeno">
                               <i class="ft-file"></i>Vender 
                             </button>

                            <button class="btn btn-primary" onclick="procesoEnajenar()" type="button" id="bmenajenar">
                               <i class="ft-file"></i>Cancelar apartado 
                             </button>

                            <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarM">
                                <i class="ft-x"></i>Cancelar	                    
                            </button>

                        </div>
                    </div>


                </div>

            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="modal fade" id="mhistorial" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title" id="myModalLabel36"><asp:Label ID="titulohistorial" runat="server"></asp:Label></h3>
                        </div>

                        <div class="modal-body">

                            <div class="row">
                                <div class="col-md-12">
                                    <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                              
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:Button runat="server" ID="bhistorial" OnClick="listadoHistorial" Style="display: none" />
                                            <div class="card-block card-dashboard">
                                                <div style="overflow-x: auto; width: 100%">
                                                    <asp:GridView runat="server" ID="ghistorial" PageSize="10" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration"
                                                        AutoGenerateColumns="False" DataSourceID="DShistorial" 
                                                        AlternatingRowStyle-BackColor="#F5F7FA">
                                                        <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                                        <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="No." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px">
                                                                <ItemTemplate>
                                                                    <%# Container.DataItemIndex + 1 %>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            
                                                            <asp:BoundField DataField="tipomovimiento" HeaderText="Tipo" SortExpression="tipomovimiento" ItemStyle-Width="200px" />
                                                            <asp:BoundField DataField="fecha" HeaderText="Fecha" SortExpression="fecha" ItemStyle-Width="150px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" />
                                                            <asp:BoundField DataField="hora" HeaderText="Hora" SortExpression="hora" ItemStyle-Width="150px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" />
                                                            <asp:BoundField DataField="importe" HeaderText="Importe" SortExpression="importe" ItemStyle-Width="150px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" DataFormatString="{0:c}" HtmlEncode="False" />

                                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="0px" ItemStyle-CssClass="centrarCelda" HeaderStyle-CssClass="centrarCelda">
                                                            <ItemTemplate>
                                                                <div class="<%# Eval("idtipomovimiento").Equals(2)?"ocultar":"" %>">
                                                                    
                                                                    <button type="button"  onclick="reimprimir(<%# Eval("idhistorial")%>,<%# Eval("idempeno")%>,<%# Eval("idsucursal")%>,<%# Eval("idtipomovimiento")%>,'<%# Eval("folio")%>');" class="btn btn-icon btn-success btn-sm"
                                                                        data-toggle="tooltip" data-original-title="Refrendar">
                                                                        <i class="ft-printer"></i>
                                                                    </button>
                                                                    </div>
                                                                
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        </Columns>

                                                    </asp:GridView>

                                                    <asp:SqlDataSource ID="DShistorial" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand=""></asp:SqlDataSource>
                                                </div>
                                            </div>

                                        </div>

                                    </div>

                                    </ContentTemplate>
                                    </asp:UpdatePanel>
                                    
                                </div>
                            </div>

                        </div>

                        <div class="modal-footer">
                             

                            <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarM2">
                                <i class="ft-x"></i>Cerrar	                    
                            </button>

                        </div>
                    </div>


                </div>

            </div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">     
    <script src="/app-assets/vendors/js/extensions/jquery.knob.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/extensions/knob.js" type="text/javascript"></script>

    <script src="/app-assets/data/jvector/visitor-data.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/unslider-min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/jquery.raty.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>
    
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN STACK JS-->

    <!-- END STACK JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    
    <script>
        
        $(".nav-item>ul>li.active").removeClass("active");
        $("#listaapartados").addClass("active");
                               
        function insertar() {
            mostrarLoading();
            $("*[id$='idP']").val(0);
            $('#<%= Bnuevo.ClientID %>').click();
        }
                
        $(document).ready(function () {
            $('.cks').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                increaseArea: '20%' // optional
            });                      

        });

        $('.cks').on('ifChecked', function (event) {
            var actual = this;

            $("#refrendar_" + actual.id).click();

            var aux = actual.id;
            var res = aux.split("_");

            $("*[id$='idP']").val(res[0]);
            $("*[id$='idS']").val(res[1]);


            $('.cks').each(function (id) {
                if (this.id != actual.id) {
                    $(this).iCheck('uncheck');
                }
            });

        });
                

        function paging(pagina) {
            $("*[id$='pagina']").val(pagina);
            $('#<%= Bconsultar.ClientID %>').click();
        }
       
        function asignar(idticket) {
            // mostrarLoading();
            $("*[id$='idP']").val(idticket);
           $('#<%= Beditar.ClientID %>').click();
        }

        function editarReg() {

            var id = $("*[id$='idP']").val();

            if (id == 0) {
                swal("Atención", "Seleccione un empeño para realizar operaciones sobre él", "warning");
                return false;
            }

           mostrarLoading();
           //$("*[id$='idP']").val(idticket);
           $('#<%= Beditar.ClientID %>').click();
        }


        function eliminar(idticket) {
            // mostrarLoading();
            $("*[id$='idP']").val(idticket);
           $('#<%= Beditar.ClientID %>').click();
        }


        function procesoRefrendo() {

            
            var cantidad = $("*[id$='cantidad']").val();
            var precioorig = $("*[id$='hpago']").val();           
            var precio = $("*[id$='lpago']").text();
           // alert(precio);
            precio = parseFloat(precio);

            if (cantidad == '' || cantidad=='0') {
                swal("Atención", "Ingrese la cantidad con la cual se realiza el apartado", "warning");
                return false;
            }

            cantidad = parseFloat(cantidad);


            if (cantidad < 0) {
                swal("Atención", "Ingrese la cantidad con la cual se realiza el apartado", "warning");
                return false;
            }

            if (cantidad > precio) {
                swal("Atención", "La cantidad del abono no puede ser mayor al precio del artículo", "warning");
                return false;
            }

            var total = parseFloat($("*[id$='lliquida']").text());


            if (cantidad > total) {
                swal("Atención", "La cantidad del abono no puede ser mayor al monto por liquidar", "warning");
                return false;
            }

            if (cantidad == total)
                $("*[id$='vender']").val(1);
            else
                $("*[id$='vender']").val(0);

             swal({
                title: "Se realizará el abono de este artículo, ¿Desea continuar?",
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
                    cerrarModalRefrendo();
                    $('#<%= Brefrendo.ClientID %>').click(); 
                    
                } 
            });


        }

        function procesoDesempeno() {
           
            var cliente = $("*[id$='comprador']").val();
            var telefono = $("*[id$='telefono']").val();
            

            if (cliente == '') {
                swal("Atención", "Ingrese el nombre del cliente que realiza la compra", "warning");
                return false;
            }

            if (telefono == '') {
                swal("Atención", "Ingrese un número de teléfono del cliente que realiza la compra", "warning");
                return false;
            }

             swal({
                title: "Se realizará la venta de este artículo, ¿Desea continuar?",
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
                    cerrarModalRefrendo();
                    $('#<%= Brefrendo.ClientID %>').click(); 
                    
                } 
            });


        }

        function procesoEnajenar() {
           
            

             swal({
               title: "Se realizará la cancelación del apartado de este artículo, ¿Desea continuar?",
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
                    cerrarModalRefrendo();
                    $('#<%= Brefrendo.ClientID %>').click(); 
                    
                } 
            });


        }

        function ModalRefrendo(idempeno, idsucursal, idarticulo, folio, cliente, articulo, prestamo, cliente2, abonototal, op) {
           

            //$(".modal-backdrop").remove();      
            $("[id$='fotoarticulo']").attr("src", 'http://localhost:1973/cs/HandlerImageArticulo.ashx?id=' + idarticulo);

            $("*[id$='idP']").val(idempeno);
            $("*[id$='idS']").val(idsucursal);
            $("*[id$='idO']").val(op);

            $("*[id$='idF']").val(folio);

            $("*[id$='lfolio']").text(folio);
            $("*[id$='lnombre']").text(cliente);
            $("*[id$='larticulo']").text(articulo);
            $("*[id$='lpago']").text(prestamo);
            $("*[id$='hpago']").text(prestamo);

            $("*[id$='labonado']").text(abonototal);            
            $("*[id$='lcomprador']").text(cliente2);

            var total = parseFloat(prestamo) - parseFloat(abonototal);

            $("*[id$='lliquida']").text(total);
                                  
            //$("#refrendo").modal('show');
            
        }
       

        function abrirModalRefrendo(op) {
            

            var id = $("*[id$='idP']").val();

            if (id == 0) {
                swal("Atención", "Seleccione un empeño para realizar operaciones sobre él", "warning");
                return false;
            }


            $("*[id$='comprador']").val('');
            $("*[id$='telefono']").val('');
            $("*[id$='cantidad']").val('');
            $("*[id$='dinero']").val('');

            $("*[id$='idO']").val(op);

            var total = 0;
       
            if (op == 4) {
                
                $("*[id$='titulo']").text('ABONAR');
                $("#bmrefrendar").show();
                $("#bmdesempeno").hide();
                $("#bmenajenar").hide();
                $("#dprecio").hide();
                $("#dtventa").hide();

                $("#dapartar").show();
                $("#dcliente").show();                

            }
            else if (op == 5 || op == 100) {
                
                if (op == 5) {
                    
                   

                } else {
                   
                    $("*[id$='titulo']").text('CANCELAR APARTADO');
                    $("#bmrefrendar").hide();
                    $("#bmdesempeno").hide();
                    $("#bmenajenar").show();
                    $("#dprecio").show();
                    $("#dapartar").hide();
                   ;
                }
            }          
            
           
            $("#refrendo").modal('show');
        }


        function cerrarModalRefrendo() {
            $("#refrendo").modal('hide');
        }



        function abrirModalHistorial() {

            var id = $("*[id$='idP']").val();

            if (id == 0) {
                swal("Atención", "Seleccione un empeño para realizar operaciones sobre él", "warning");
                return false;

            }

            mostrarLoading();
            $("*[id$='titulohistorial']").text('HISTORIAL - ' + $("*[id$='lfolio']").text());

            $('#<%= bhistorial.ClientID %>').click();
            
        }


        function reimprimir(idhistorial, idempeno, idsucursal, idtipomovimiento, folio) {
            var url = "";

            if (idtipomovimiento == 1)
                url = "../reportes/RVTicket.aspx?idempeno=" + idempeno + "&idsucursal=" + idsucursal + "&idhistorial=" + idhistorial;
            else if (idtipomovimiento == 3 || idtipomovimiento == 4)
                url = "../reportes/RVTicketApartado.aspx?idempeno=" + idempeno + "&idsucursal=" + idsucursal + "&idhistorial=" + idhistorial;
            else if (idtipomovimiento == 5)
                url = "../reportes/RVTicketVenta.aspx?idempeno=" + idempeno + "&idsucursal=" + idsucursal + "&idhistorial=" + idhistorial;
            else if (idtipomovimiento == 6)
                url = "../reportes/RVTicketDesempeno.aspx?idempeno=" + idempeno + "&idsucursal=" + idsucursal + "&idhistorial=" + idhistorial;

            window.open(url, '_blank');
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

        
        /*
        loadJS("/app-assets/vendors/js/extensions/jquery.knob.min.js");
        loadJS("/app-assets/js/scripts/extensions/knob.js");

        loadJS("/app-assets/data/jvector/visitor-data.js");
        loadJS("/app-assets/vendors/js/charts/jquery.sparkline.min.js");
        loadJS("/app-assets/vendors/js/extensions/unslider-min.js");
        loadJS("/app-assets/vendors/js/forms/select/select2.full.min.js");
        
       
        loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
        loadJS("/app-assets/vendors/js/extensions/jquery.raty.js");
        loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");*/

        loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
        // loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
        // loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
        loadJS("/app-assets/js/scripts/extensions/rating.js");
        loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");


        
                                        
    }
    
        </script>
</asp:Content>
