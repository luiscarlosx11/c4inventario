<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="registroclientes.aspx.cs" Inherits="elecion.catalogos.sistema.registroclientes" EnableEventValidation="false" %>
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
            <h3 class="content-header-title">Catálogos Sistema </h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Catálogos</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Clientes</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server">
        
    </asp:ScriptManager>


    
        
		
					
                                <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header">
                                                <h4 class="text-bold-700" style="width:90%"><asp:Label runat="server" ID="lticket"></asp:Label></h4>
                                                <h6><asp:Label runat="server" ID="lfechahora"></asp:Label></h6>
                                                <asp:HiddenField runat="server" ID="idP" Value="0"/> 
                                                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                                                <div class="heading-elements">
                                                    <ul class="list-inline mb-0">
                                
                                                    </ul>
                                                </div>
                                                <span class="float-xs-left">								                                                                                                                                                                                                                                                              
                 
						                        </span>

                                        </div>
                       <asp:UpdatePanel runat="server" ID="PUDatos">
                       <ContentTemplate>

                            <div class="card-body collapse in">
                            <div class="card-block">
                            
                                <div class="form-body">                           
                               
                              
                                                                                                 

                                    <div class="row">

                                        <div class="col-md-6">
										    <div class="form-group">
											    <label for="cliente" class="text-bold-600">Nombre</label>
											    <asp:TextBox ID="nombre" CssClass="form-control"  placeholder="Nombre" MaxLength="50" name="nombre" runat="server" ></asp:TextBox>
										    </div>
									    </div>
									
                                    
                                                                                                        
                                     </div>
                                

                                    <div class="row">                                    

                                        <div class="col-md-3">
                                            <div class="form-group">
											    <label for="telefono" class="text-bold-600">Teléfono</label>
											    <asp:TextBox ID="telefono" CssClass="form-control"  placeholder="Teléfono" MaxLength="50" name="nombre" runat="server" ></asp:TextBox>
										    </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
											    <label for="email" class="text-bold-600">Email</label>
											    <asp:TextBox ID="email" CssClass="form-control"  placeholder="Email" MaxLength="50" name="nombre" runat="server" ></asp:TextBox>
										    </div> 
                                        </div>
                                                                    
                                     </div>

                                    

                                    <div class="card-block card-dashboard">
                                        

                                            <button class="btn btn-primary" onclick="abrirModal(0,'')" type="button" data-backdrop="false"> 
	                                        <i class="fa fa-plus"></i>  Contrato
	                                     </button>
                                        <br /><br />
                                        
                                    <div style="overflow-x:auto;width:100%"> 
                                        
                                        
                                         <asp:GridView runat="server" ID="lcontratos" PageSize="10" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                                                        AutoGenerateColumns="False" DataSourceID="DScontratos" 
                                                                        AlternatingRowStyle-BackColor="#F5F7FA">
                                                                        <SortedAscendingHeaderStyle CssClass="ascending" BackColor="#16D39A" ForeColor="White" />
                                                                        <SortedDescendingHeaderStyle CssClass="descending" BackColor="#16D39A" ForeColor="White"/>
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="No." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px">
                                                                                        <ItemTemplate>
                                                                                            <%# Container.DataItemIndex + 1 %>
                                                                                        </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField DataField="nombre" HeaderText="Contrato" SortExpression="nombre" /> 
                                                                                    <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>

                                                    <button type="button" id="editar" onclick="abrirModal(<%# Eval("idcontrato")%>,'<%# Eval("nombre").ToString() %>');" class="btn btn-icon btn-success mr-1"
                                                        data-toggle="tooltip" data-original-title="Editar" >
                                                         <i class="ft-edit"></i>
                                                    </button>
                                                                                            
                                                </ItemTemplate>
                                            </asp:TemplateField>                                                                     
                                                                                </Columns>
                                
                                                                            </asp:GridView>
                            
                                                                            <asp:SqlDataSource ID="DScontratos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="select idcontrato, nombre from contrato where idcliente= @idcliente order by nombre ">
                                                                                <SelectParameters>
                                         <asp:ControlParameter ControlID="idP" Name="idcliente" PropertyName="Value" />
                                    </SelectParameters>
                                                                            </asp:SqlDataSource>


                                    
                                        </div>
                                        </div>
                                    
                                                                                                                                                                                                     <div class="form-actions right">
                                                          
                                                                                                                                                                                                               <asp:Button runat="server" ID="guardarE" OnClick="guardaEdita" class="ocultar" />
                                            <asp:Button runat="server" ID="volver" OnClick="regresarListado"  class="ocultar" />
                                                                                                                                                                                                                       
                                            <button class="btn btn-primary" onclick="validaCliente()" type="button"> 
	                                            <i class="fa fa-check-square-o"></i> Guardar
	                                         </button>
                 
	                                         <button type="button" class="btn btn-danger mr-1" onclick="regresar()" id="cancelar">
	                                            <i class="ft-x"></i> Volver
	                                         </button>  
	                                    </div>
                                
                                </div>
                            
                            </div>
                        </div>

                           
                           
                    </ContentTemplate>
                      </asp:UpdatePanel>
                                    
                                        

                                    </div>
                                    
                                 </div>

                                    
                                </div>
                    

    <div class="modal fade text-xs-left" id="frmContrato" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
        
		        <div class="modal-dialog" role="document">
		        <div class="modal-content">
			        <div class="modal-header bg-primary white">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				        <span aria-hidden="true">&times;</span>
			        </button>
			        <h3 class="modal-title" id="myModalLabel35">CONTRATO</h3>
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
	                    		                            <form id="formaRegistro" method="get">
                                                                
                                                                <div class="form-group row">
	                            	                                <label class="col-md-3 label-control" for="nombrec">Nombre</label>
		                                                            <div class="col-md-9">
                                                                        <asp:HiddenField runat="server" ID="idg" />
                                                                       
                                                                        <asp:TextBox ID="nombrec" CssClass="form-control" maxlength="60" placeholder="Nombre" name="nombrec" runat="server" ></asp:TextBox>
                                                                       
		                                                            </div>
		                                                        </div>	
                                                                </form>		                                                		                                                   
							                            </div>    	                                                   
	                       
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>

                        </div>
                           
                   
			        <div class="modal-footer">
                        <asp:Button runat="server" ID="guardarC" OnClick="guardaContrato" class="ocultar" />
                                            
				        <button class="btn btn-primary" onclick="validaContrato()" type="button" data-backdrop="false"> 
	                        <i class="fa fa-check-square-o"></i> Aceptar
	                     </button>
                 
	                     <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
	                        <i class="ft-x"></i> Cancelar
	                     </button>
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
        $("#centidades").addClass("active");
        $(document).ready(function () {

           

        });
        

        function guardaRating() {
            //alert($("[id*=interes]").raty('score'));
            $("*[id$='nestrellas']").val($("[id*=calificacion]").raty('score'));
        }

        function abrirModal(idtipogasto, tipogasto) {
            $("*[id$='idg']").val(idtipogasto);
           
            $("*[id$='nombrec']").val(tipogasto);
            
            $("#frmContrato").modal('show');
        }


        function validaCliente() {
            var nombre = $("*[id$='nombre']").val();
           
            if (nombre == '') {
                swal("Atención", "Ingrese un nombre para el cliente", "warning");
                return false;
            } else {
                
                mostrarLoading();
                $('#<%= guardarE.ClientID %>').click();                              
                //return true;
            }
        }

        function validaContrato() {
            var nombre = $("*[id$='nombrec']").val();
           
            if (nombre == '') {
                swal("Atención", "Ingrese un nombre de contrato para el cliente", "warning");
                return false;
            } else {
                
                mostrarLoading();
                $('#<%= guardarC.ClientID %>').click();                              
                return true;
            }
        }


        function finalizarModal() {            
            $('#frmFinalizar').modal('show');
        }

        function finalizar() {
           mostrarLoading();                
          
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
           
                $.fn.raty.defaults.path = '/app-assets/images/raty/';

                $("*[id$='calificacion']").raty();
                $("*[id$='calificacion']").raty({ mouseout: guardaRating });

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