<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="movimientos.aspx.cs" Inherits="elecion.report.movimientos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .ascending a {
	       /* background:url(/images/descending.png) right no-repeat;*/
	        display:block;
        }

        .descending a {
	      /*  background:url(/images/ascending.png) right no-repeat;*/
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

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/daterange/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/datetime/bootstrap-datetimepicker.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/pickadate/pickadate.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/pickers/daterange/daterange.css">


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Reportes</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Reportes</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Movimientos</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
   
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>
            <div class="row" id="header-styling">
                <div class="col-xs-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">MOVIMIENTOS DE CAJA</h4>
                            <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                            <div class="heading-elements">
                                <ul class="list-inline mb-0">
                                  
                                </ul>
                            </div>
                        </div>
                        <div class="card-body collapse in">
                            
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="card no-border">
                                        <div class="card-body">
                                            <div class="card-block">
                                                <div class="media">
                                                    <div class="media-body">
                                                        <h1 class="display-4">
                                                            <asp:Label runat="server" ID="lventas">$0.00</asp:Label></h1>
                                                        <span class="text-muted">Ventas</span>
                                                    </div>
                                                    <div class="media-right media-middle">
                                                        <i class="icon-bulb font-large-2 blue-grey lighten-3"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="sp-line-total-cost"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card no-border">
                                        <div class="card-body">
                                            <div class="card-block">
                                                <div class="media">
                                                    <div class="media-body">
                                                        <h1 class="display-4">
                                                            <asp:Label runat="server" ID="lrefrendos">$0.00</asp:Label></h1>
                                                        <span class="text-muted">Refrendos</span>
                                                    </div>
                                                    <div class="media-right media-middle">
                                                        <i class="icon-bulb font-large-2 blue-grey lighten-3"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="sp-line-total-cost2"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card no-border">
                                        <div class="card-body">
                                            <div class="card-block">
                                                <div class="media">
                                                    <div class="media-body">
                                                        <h1 class="display-4">
                                                            <asp:Label runat="server" ID="lapartados">$0.00</asp:Label></h1>
                                                        <span class="text-muted">Apartados / Abonos</span>
                                                    </div>
                                                    <div class="media-right media-middle">
                                                        <i class="icon-bulb font-large-2 blue-grey lighten-3"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="sp-line-total-cost3"></div>
                                        </div>
                                    </div>
                                </div>

                                

                                <div class="col-md-3">
                                    <div class="card no-border">
                                        <div class="card-body">
                                            <div class="card-block">
                                                <div class="media">
                                                    <div class="media-body">
                                                        <h1 class="display-4">
                                                            <asp:Label runat="server" ID="lprestamos">$0.00</asp:Label></h1>
                                                        <span class="text-muted">Préstamos</span>
                                                    </div>
                                                    <div class="media-right media-middle">
                                                        <i class="icon-bulb font-large-2 blue-grey lighten-3"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="sp-line-total-cost5"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            

                            <div class="card-block card-dashboard">
                                 <div class="row">

                                    <div class="col-md-4">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Concepto</label>
											<asp:TextBox ID="bfolio" CssClass="form-control text-uppercase" placeholder="Concepto" name="bfolio" runat="server" AutoPostBack="true" OnTextChanged="listadoTickets"></asp:TextBox>
										</div>
									</div>

                                     <div class="col-md-2">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Fecha</label>
											<asp:TextBox ID="bfecha" CssClass="form-control pickadate text-uppercase" placeholder="Fecha" name="bfecha" runat="server" AutoPostBack="true" OnTextChanged="listadoTickets" Text="2018-09-26">

											</asp:TextBox>
										</div>
									</div>                                  
                              </div>                              

                            <div class="row">
                                <div class="col-md-12 ">                                   
                                    
                                </div>
                            </div>
                            </div>
                           
                           
                            </div>
                            
                            <div class="card-block card-dashboard">
                            <div style="overflow-x:auto;width:100%"> 
                            <asp:GridView runat="server" ID="lgastos" PageSize="10" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastos" OnSorting="lgastos_Sorting" EnableSortingAndPagingCallbacks="true"
                                AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros">
                                <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="No." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="tipo" HeaderText="Tipo" SortExpression="tipo" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda"/>
                                            <asp:BoundField DataField="sucursal" HeaderText="Sucursal" SortExpression="sucursal" /> 
                                            <asp:BoundField DataField="concepto" HeaderText="Concepto" SortExpression="concepto" ItemStyle-Width="900px"/> 
                                            <asp:BoundField DataField="fecha" HeaderText="Fecha" SortExpression="fecha" ItemStyle-Width="150px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" /> 
                                            <asp:BoundField DataField="hora" HeaderText="Hora" SortExpression="hora" ItemStyle-Width="150px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda"/> 
                                            <asp:BoundField DataField="importe" HeaderText="Importe" SortExpression="importe" ItemStyle-Width="150px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" DataFormatString="{0:c}" HtmlEncode="False"/>
                                                                                                                                                                                                          
                                        </Columns>
                                
                                    </asp:GridView>
                            
                                    <asp:SqlDataSource ID="DsListadoGastos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand=""></asp:SqlDataSource>
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
			        <h3 class="modal-title" id="myModalLabel35">INGRESO</h3>
			        </div>
			   
                       
			        <div class="modal-body">
                    <section class="input-validation inputmask">
	                            <div class="row">
	                                <div class="col-md-12">
	                                    <div class="card">
	                                        <div class="card-header">
	                                            
	                                        </div>
                                            <div class="card-body collapse in">
                                                <div class="card-block">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label>Concepto</label>
                                                                <asp:HiddenField runat="server" ID="idP" />
                                                                <asp:HiddenField runat="server" ID="idS" />
                                                                <asp:TextBox ID="concepto" CssClass="form-control text-uppercase" placeholder="Concepto" name="concepto" runat="server"></asp:TextBox>
                                                                
                                                               
                                                            </div>


                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label>Importe</label>                                                                
                                                                <asp:TextBox ID="importe" CssClass="form-control text-uppercase" name="idtipogasto" placeholder="Importe" runat="server"></asp:TextBox>                                                     </div>


                                                        </div>
                                                    </div>

                                                </div>

                                            </div>
                                            </div>
	                                    </div>
	                                </div>
	                            </div>

                        
                           
                   
			        <div class="modal-footer">
                        <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" style="display:none" CausesValidation="true"/>     
                        <asp:Button runat="server" ID="borrar" OnClick="borrarRegistro" style="display:none" />
                        
				        <button class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false"> 
	                        <i class="fa fa-check-square-o"></i> Aceptar
	                     </button>
                 
	                     <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
	                        <i class="ft-x"></i> Cancelar
	                     </button>
			        </div>
</div>

			       
		        </div>
		        </div>
            
                </section>
	        </div>
            
  
    </ContentTemplate>
    </asp:UpdatePanel> 
              
           
     </asp:Content>      

<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

     <script src="/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.date.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.time.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/legacy.js" type="text/javascript"></script>

    <script src="/app-assets/data/jvector/visitor-data.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/chart.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/unslider-min.js" type="text/javascript"></script>

    <script src="/app-assets/js/scripts/cards/card-statistics.js" type="text/javascript"></script>



    <script>
        
        $(".nav-item>ul>li.active").removeClass("active");
        $("#movimientos").addClass("active");

        

        function abrirModal(idp, ids, concepto, importe) {
                                   
            $("*[id$='idP']").val(idp);
            $("*[id$='idS']").val(ids);
            $("*[id$='concepto']").val(concepto);
            $("*[id$='importe']").val(importe);
        
            $("#bootstrap").modal('show');
        }

        function eliminarRegistro(idp, ids, concepto) {

            $("*[id$='idP']").val(idp);
            $("*[id$='idS']").val(ids);


             swal({
                title: "Se realizará la cancelación de este ingreso, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Si",
                cancelButtonText: "No",
                closeOnConfirm: false,
                closeOnCancel: true
            },
            function (isConfirm) {
                if (isConfirm) {
                    mostrarLoading();
                    $('#<%= borrar.ClientID %>').click();
                    
                   
                } 
            });

        }


        function valida() {
       
            var concepto = $("*[id$='concepto']").val();
            var importe = $("*[id$='importe']").val();

            if (concepto == '' ) {               
                 swal("Atención", "Ingrese el concepto del ingreso", "warning");                             
                return false;
            }

            if (importe == '' || importe == '0') {
                swal("Atención", "Ingrese el importe del ingreso", "warning");
                return false;
            }
                
                mostrarLoading();
                $('#<%= guardar.ClientID %>').click();
                $('#bootstrap').modal('hide');
;                return true;
                               
            
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

                loadJS("/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js");
                loadJS("/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.date.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.time.js");
                loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");

                $('.pickadate').pickadate({
                    format: 'yyyy-mm-dd',
                    formatSubmit: 'yyyy-mm-dd',
                    monthsFull: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                    weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab'],
                    today: 'Hoy',
                    clear: 'Limpiar',
                });
                

                $("#sp-line-total-cost").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                    type: 'line',
                    width: '100%',
                    height: '100px',
                    lineColor: '#16D39A',
                    fillColor: '#16D39A',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });

                $("#sp-line-total-cost2").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                    type: 'line',
                    width: '100%',
                    height: '100px',
                    lineColor: '#FFA87D',
                    fillColor: '#FFA87D',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });

                $("#sp-line-total-cost3").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                    type: 'line',
                    width: '100%',
                    height: '100px',
                    lineColor: '#2DCEE3',
                    fillColor: '#2DCEE3',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });

                $("#sp-line-total-cost4").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                    type: 'line',
                    width: '100%',
                    height: '100px',
                    lineColor: '#FF7588',
                    fillColor: '#FF7588',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });

                $("#sp-line-total-cost5").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                    type: 'line',
                    width: '100%',
                    height: '100px',
                    lineColor: '#FF7588',
                    fillColor: '#FF7588',
                    spotColor: '',
                    minSpotColor: '',
                    maxSpotColor: '',
                    highlightSpotColor: '',
                    highlightLineColor: '',
                    chartRangeMin: 0,
                    chartRangeMax: 20,
                });
                //loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                //loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");

        }
    </script>
</asp:Content>
