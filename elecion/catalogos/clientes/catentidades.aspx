﻿<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="catentidades.aspx.cs" Inherits="elecion.catalogos.sistema.catentidades" %>
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



</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Catálogos Sistema</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
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
   
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>
            <div class="row" id="header-styling">
                <div class="col-xs-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">LISTADO DE CLIENTES</h4>
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
                            <div class="card-block card-dashboard">
                                <p class="card-text"></p>
                            </div>
                             
                            <div class="col-md-9">
                                <asp:HiddenField runat="server" ID="idP" />
                                <asp:Button runat="server" ID="Beditar" OnClick="editaRegistro" style="display:none"/> 

                                <asp:Button runat="server" ID="Bnuevo" OnClick="nuevoRegistro" style="display:none"/> 
                            <button type="button" id="nuevo" onclick="nuevoRegistro();" class="btn btn-icon btn-success mr-1" data-toggle="modal" >
                                                 <i class="ft-file"></i> Nuevo Registro 
                                            </button>
                             </div>


                            <div class="col-xl-3 col-lg-6 col-xs-12">
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <div class="card-block">
                                                                <div class="media">
                                                                    <div class="media-left media-middle">
                                                                        <i class="icon-folder primary font-large-2 float-xs-left"></i>
                                                                    </div>
                                                                    <div class="media-body text-xs-right">
                                                                        <h3><asp:Label runat="server" ID="labelConteo"></asp:Label></h3>
                                                                        <span>Registros encontrados</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                              </div>
                           
                            </div>
                            
                            <div class="card-block card-dashboard">
                            <div style="overflow-x:auto;width:100%"> 

                            
                            <asp:GridView runat="server" ID="lgastos" PageSize="10" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastos" OnSorting="lgastos_Sorting" EnableSortingAndPagingCallbacks="true"
                                AlternatingRowStyle-BackColor="#F5F7FA">
                                <SortedAscendingHeaderStyle CssClass="ascending" BackColor="#16D39A" ForeColor="White" />
                                <SortedDescendingHeaderStyle CssClass="descending" BackColor="#16D39A" ForeColor="White"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="No." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="nombre" HeaderText="Cliente" SortExpression="nombre" />                           
                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px">
                                                <ItemTemplate>

                                                    <button type="button" id="editar" onclick="editarRegistro(<%# Eval("idcliente")%>);" class="btn btn-icon btn-success mr-1"
                                                        data-toggle="tooltip" data-original-title="Editar" >
                                                         <i class="ft-edit"></i>
                                                    </button>

                                                     <button type="button" id="borrar" onclick="eliminarRegistro(<%# Eval("idcliente")%>,'<%# Eval("nombre").ToString() %>');" class="btn btn-icon btn-danger mr-1"
                                                        data-toggle="tooltip" data-original-title="Borrar" >
                                                         <i class="ft-delete"></i>
                                                    </button>
                                                                                                         
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            
                                    <asp:SqlDataSource ID="DsListadoGastos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="select idcliente, nombre from cliente order by nombre"></asp:SqlDataSource>
                               </div>
                            </div>
                        
                    </div>
                </div>
            </div>
</ContentTemplate>
    </asp:UpdatePanel>
     
    <div class="modal fade text-xs-left" id="bootstrap" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
        
		        <div class="modal-dialog" role="document">
		        <div class="modal-content">
			        <div class="modal-header bg-primary white">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				        <span aria-hidden="true">&times;</span>
			        </button>
			        <h3 class="modal-title" id="myModalLabel35">CLIENTE</h3>
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
	                            	                                <label class="col-md-3 label-control" for="tipogasto">Nombre</label>
		                                                            <div class="col-md-9">
                                                                        <asp:HiddenField runat="server" ID="idg" />
                                                                        <asp:TextBox ID="idtipog" CssClass="ocultar" name="idtipogasto" runat="server" ReadOnly="true"></asp:TextBox>
                                                                        <asp:TextBox ID="tipogasto" CssClass="form-control"  maxlength="60" placeholder="Área Técnica" name="tipogasto" runat="server" ></asp:TextBox>
                                                                        
		                                                            </div>
		                                                        </div>	

                                                                <div class="row">
                                                                  
                                                                    
                                                                    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                                                                        <ContentTemplate>  
                                                                <asp:GridView runat="server" ID="lcontratos" PageSize="10" AllowPaging="false" AllowSorting="false" CssClass="table table-striped table-bordered zero-configuration" 
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
                                                                                    <asp:BoundField DataField="nombre" HeaderText="Contrato" SortExpression="area" />                                                                      
                                                                                </Columns>
                                
                                                                            </asp:GridView>
                            
                                                                            <asp:SqlDataSource ID="DScontratos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>

                                                                        </ContentTemplate>
                                                                        </asp:UpdatePanel>
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
            
  
     
              
           
     </asp:Content>      

<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>


    <script>
        
        $(".nav-item>ul>li.active").removeClass("active");
        $("#centidades").addClass("active");

        function editarRegistro(idP) {
            mostrarLoading();
            $("*[id$='idP']").val(idP);            
            $('#<%= Beditar.ClientID %>').click();
        }

        function nuevoRegistro() {
           mostrarLoading();
            $("*[id$='idP']").val(0);
           $('#<%= Bnuevo.ClientID %>').click();
        }

        function eliminarRegistro(idtipogasto, tipogasto) {

            $("*[id$='idg']").val(idtipogasto);
            $("*[id$='tipogasto']").val(tipogasto);


             swal({
                title: "Desea eliminar este registro?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Aceptar",
                cancelButtonText: "Cancelar",
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
       
            var tipogasto = $("*[id$='tipogasto']").val();

            if (tipogasto == '' ) {

                if (tipogasto == '')
                    swal("Atención", "Ingrese el tipo de gasto", "warning");
              
               
                return false;
            } else {
                
                mostrarLoading();
                $('#<%= guardar.ClientID %>').click();
                $('#bootstrap').modal('hide');
;                return true;
            }                    
            
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

        }
    </script>
</asp:Content>
