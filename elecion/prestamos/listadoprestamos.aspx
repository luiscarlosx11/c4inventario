<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="listadoprestamos.aspx.cs" Inherits="elecion.tickets.listadoprestamos" EnableEventValidation="false"%>
<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>

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

        
        #reportViewer1 {
            position: absolute;
            width: 100%;
            height: 1000px;
            font-family: 'segoe ui', 'ms sans serif';
            overflow: hidden;
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
                <li class="breadcrumb-item active"><a href="#">Préstamos</a>
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
                                        <h4>Empeños </h4>
                                        <span><asp:Label runat="server" ID="labelConteo"></asp:Label> actualmente</span>
                                    </div>
                                    <div class="media-right media-middle">
                                        <button type="button" id="nuevo" runat="server" onclick="insertar()" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                            <i class="ft-file"></i> Nuevo empeño 
                                        </button>                                      
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

                                     <div class="col-md-4">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Cliente</label>
											<asp:TextBox ID="bcliente" CssClass="form-control text-uppercase"  placeholder="Cliente" name="cliente" runat="server" OnTextChanged="listadoTickets" AutoPostBack="true"></asp:TextBox>
										</div>
									</div>

                                   <div class="col-md-4">
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
                                                <button type="button" id="bauxeditar" onclick="editarReg();" class="btn btn-icon btn-primary">
                                                    <i class="fa fa-pencil"></i> Detalles
                                                </button>

                                                <button type="button" id="Button1" runat="server" onclick="algo()" class="btn btn-icon btn-success" data-toggle="modal">
                                                    <i class="fa fa-file-text-o"></i> Boleta
                                                </button>

                                                <button type="button" id="bauxrefrendar" onclick="abrirModalRefrendo(1);" class="btn btn-icon btn-warning">
                                                    <i class="fa fa-undo"></i>  Refrendar
                                                </button>

                                                <button type="button" id="bauxdesempenar" onclick="abrirModalRefrendo(6);" class="btn btn-icon btn-info lighten-1">
                                                    <i class="fa fa-check"></i> Desempeñar
                                                </button>

                                                <button type="button" id="bauxenajenar" onclick="abrirModalRefrendo(2);" class="btn btn-icon btn-danger">
                                                    <i class="fa fa-random"></i> Enajenar
                                                </button>


                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12"><br />
                                                <asp:GridView runat="server" ID="dlCustomers" PageSize="25" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration"
                                                    AutoGenerateColumns="False" DataSourceID="DSTickets"
                                                    AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros" OnPageIndexChanged="listadoTickets" OnRowDataBound="dlCustomers_RowDataBound">
                                                    <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                                    <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                                    <Columns>

                                                        <asp:TemplateField HeaderText="" ItemStyle-Width="10px" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>

                                                                <input id="<%# Eval("idempeno") %>" type="checkbox" class="cks" value="<%# Container.DataItemIndex%>">
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:BoundField DataField="folio" HeaderText="Folio" SortExpression="folio" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" ItemStyle-Width="120px" />
                                                        <asp:BoundField DataField="cliente" HeaderText="Cliente" SortExpression="cliente" ItemStyle-Width="400px" ItemStyle-CssClass=""/>
                                                        <asp:BoundField DataField="fechaempeno" HeaderText="Fecha" SortExpression="fechaempeno" ItemStyle-Width="150px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" />
                                                        <asp:BoundField DataField="fechavence" HeaderText="Vence" SortExpression="fechavence" ItemStyle-Width="150px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" />
                                                        <asp:BoundField DataField="prestamo" HeaderText="Préstamo" SortExpression="prestamo" ItemStyle-Width="150px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" DataFormatString="{0:c}" HtmlEncode="False"/>
                                                        <asp:BoundField DataField="descripcion" HeaderText="Artículo" SortExpression="descripcion" ItemStyle-Width="450px" ItemStyle-CssClass=""/>
                                                        <asp:BoundField DataField="dias" HeaderText="Dias" SortExpression="dias" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" ItemStyle-Width="80px" />

                                                        <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="0px" ItemStyle-CssClass="ocultar" HeaderStyle-CssClass="ocultar">
                                                            <ItemTemplate>
                                                                <div class="ocultar">
                                                                    
                                                                    <button type="button" id="refrendar_<%# Eval("idempeno")%>" onclick="ModalRefrendo(<%# Eval("idempeno")%>,<%# Eval("idsucursal")%>,<%# Eval("idarticulo")%>,'<%# Eval("folio")%>','<%# Eval("cliente")%>','<%# Eval("descripcion")%>',<%# Eval("prestamo")%>,'<%# Eval("pagar")%>',<%# Eval("tasa")%>,<%# Eval("dias")%>,<%# Eval("recargos")%>,1);" class="btn btn-icon btn-success btn-sm"
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

                                    <div class="row">
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
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Préstamo</label>
                                                <asp:Label ID="lprestamo" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Ultimo refrendo hace</label>
                                                <asp:Label ID="ldias" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>
                                       
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Tasa de Interés</label>
                                                <asp:Label ID="ltasa" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>


                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Intereses</label>
                                                <asp:Label ID="lintereses" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Recargos</label>
                                                <asp:Label ID="lrecargos" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Total a pagar</label>
                                                <asp:HiddenField ID="hpago" runat="server"/>
                                                <asp:Label ID="lpago" runat="server" CssClass="col-md-12"></asp:Label>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                </div>
                                
                        </div>

                        <div class="modal-footer">
                             <button class="btn btn-primary" onclick="procesoRefrendo()" type="button" id="bmrefrendar">
                               <i class="ft-file"></i>Refrendar 
                             </button>

                            <button class="btn btn-primary" onclick="procesoDesempeno()" type="button" id="bmdesempeno">
                               <i class="ft-file"></i>Desempeñar 
                             </button>

                            <button class="btn btn-primary" onclick="procesoEnajenar()" type="button" id="bmenajenar">
                               <i class="ft-file"></i>Enajenar 
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


     <div class="modal fade" id="boleta" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title" id="myModalLabel36"><asp:Label ID="Label1" runat="server"></asp:Label></h3>
                        </div>

                        <div class="modal-body">

                            <div class="row">
                                <div class="col-md-12">
                                    
                                    
                                </div>
                            </div>

                        </div>

                        <div class="modal-footer">
                             

                            <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarM2">
                                <i class="ft-x"></i>Cancelar	                    
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
        $("#listaprestamos").addClass("active");
                            

        function algo() {     
            
            var id= $("*[id$='idP']").val();

            if(id==0){
                swal("Atención", "Seleccione un empeño para realizar operaciones sobre él", "warning");
                return false;
            }

            var url = "../reportes/RVBoleta.aspx?idempeno="+$("*[id$='idP']").val()+"&idsucursal="+$("*[id$='idS']").val();
            window.open(url,'_blank');

            //8$("#boleta").modal('show');

        }

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
            $("*[id$='idP']").val(actual.id);
            

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
            
            var id= $("*[id$='idP']").val();

            if(id==0){
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
           
             swal({
                title: "Se realizará el refrendo sobre esta boleta, ¿Desea continuar?",
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
           
             swal({
                title: "Se realizará el desempeño sobre esta boleta, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Si",
                cancelButtonText: "no",
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
                title: "Se realizará la enajenación sobre esta boleta, ¿Desea continuar?",
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

        function ModalRefrendo(idempeno, idsucursal, idarticulo, folio, cliente, articulo, prestamo, pago, tasa, dias, recargos, op) {
            
            //$(".modal-backdrop").remove();      
            $("[id$='fotoarticulo']").attr("src", 'http://localhost:1973/cs/HandlerImageArticulo.ashx?id=' + idarticulo);

            $("*[id$='idP']").val(idempeno);
            $("*[id$='idS']").val(idsucursal);
            $("*[id$='idO']").val(op);

            $("*[id$='lfolio']").text(folio);
            $("*[id$='lnombre']").text(cliente);
            $("*[id$='larticulo']").text(articulo);
            $("*[id$='lprestamo']").text(prestamo);
            $("*[id$='ltasa']").text(tasa+" %");
            $("*[id$='lintereses']").text(pago);
            $("*[id$='lrecargos']").text(recargos);
            $("*[id$='ldias']").text(dias+" dias");

            
           
            
            //$("#refrendo").modal('show');
            
        }
       

        function abrirModalRefrendo(op) {
            
            var id= $("*[id$='idP']").val();

            if(id==0){
                swal("Atención", "Seleccione un empeño para realizar operaciones sobre él", "warning");
                return false;

            }
            $("*[id$='idO']").val(op);

            var total = 0;

            var prestamo = $("*[id$='lprestamo']").text();
            var pago = $("*[id$='lintereses']").text();
            var recargos = $("*[id$='lrecargos']").text();

            

            if (op == 1) {
                total = pago;
                $("*[id$='titulo']").text('REFRENDO');
                $("#bmrefrendar").show();
                $("#bmdesempeno").hide();
                $("#bmenajenar").hide();

                if(total==0){
                    swal("Atención", "No existe un monto generado por intereses, no es posible realizar un refrendo sobre este empeño", "warning");
                    return false;
                }

                total = parseFloat(pago) + parseFloat(recargos);
                total = total.toFixed(2);

            }
            else if (op == 2 || op == 6) {
                total = parseFloat(prestamo) + parseFloat(pago) + parseFloat(recargos);
                total = total.toFixed(2);

                if (op == 6) {
                    $("*[id$='titulo']").text('DESEMPEÑO');
                    $("#bmrefrendar").hide();
                    $("#bmdesempeno").show();
                    $("#bmenajenar").hide();
                } else {
                    $("*[id$='titulo']").text('ENAJENACIÓN');
                    $("#bmrefrendar").hide();
                    $("#bmdesempeno").hide();
                    $("#bmenajenar").show();
                }
            }
            $("*[id$='lpago']").text(total);
            $("*[id$='hpago']").val(total);


            $("#refrendo").modal('show');
        }


        function cerrarModalRefrendo() {
            $("#refrendo").modal('hide');
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

        
        
        loadJS("/app-assets/vendors/js/extensions/jquery.knob.min.js");
        loadJS("/app-assets/js/scripts/extensions/knob.js");

        loadJS("/app-assets/data/jvector/visitor-data.js");
        loadJS("/app-assets/vendors/js/charts/jquery.sparkline.min.js");
        loadJS("/app-assets/vendors/js/extensions/unslider-min.js");
        loadJS("/app-assets/vendors/js/forms/select/select2.full.min.js");

       
        loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
        loadJS("/app-assets/vendors/js/extensions/jquery.raty.js");
        loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");


        
                                        
    }
    
        </script>
</asp:Content>
