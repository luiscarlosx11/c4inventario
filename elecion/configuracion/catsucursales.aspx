<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="catsucursales.aspx.cs" Inherits="elecion.catalogos.configuracion.catsucursales" %>
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


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Configuración</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Catálogos</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Configuración</a>
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
                            <h4 class="card-title">LISTADO DE SUCURSALES</h4>
                            <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                            <div class="heading-elements">
                                <ul class="list-inline mb-0">
                                  <asp:HiddenField ID="idS" runat="server" />
                                </ul>
                            </div>
                        </div>
                        <div class="card-body collapse in">
                            <div class="col-md-12">
                                <div class="card overflow-hidden">
                                    <div class="card-body">
                                        <div class="card-block cleartfix">
                                            <div class="media">
                                                <div class="media-left media-middle">
                                                    <i class="icon-speech primary font-large-2 mr-2"></i>
                                                </div>
                                                <div class="media-body">
                                                    <h4>Elementos registrados</h4>
                                                    <span>
                                                        <asp:Label runat="server" ID="labelConteo"></asp:Label>
                                                        actualmente</span>
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
                                AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros">
                                <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="No." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="nombre" HeaderText="Nombre" SortExpression="nombre" /> 
                                            <asp:BoundField DataField="abreviado" HeaderText="Abreviado" SortExpression="abreviado" /> 
                                            <asp:BoundField DataField="direccion" HeaderText="Dirección" SortExpression="direccion" />                          
                                            <asp:BoundField DataField="telefono" HeaderText="Teléfono" SortExpression="telefono" />                          
                                            <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />                          
                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                <ItemTemplate>

                                                    <button type="button" id="editar" onclick="abrirModal(<%# Eval("idsucursal")%>,'<%# Eval("nombre").ToString() %>')" class="btn btn-icon btn-success mr-1"
                                                        data-toggle="tooltip" data-original-title="Editar" >
                                                         <i class="ft-edit"></i>
                                                    </button>
                                                                                                                                                             
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            
                                    <asp:SqlDataSource ID="DsListadoGastos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="select s.idsucursal, s.nombre, s.abreviado,  s.calle, s.colonia, s.cp, s.telefono, s.email, concat(s.calle,' Col. ',(s.colonia),' CP ',coalesce(s.cp,''))as direccion
                                        from sucursal s
                                        where s.idsucursal>0">

                                    </asp:SqlDataSource>
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
			        <h3 class="modal-title" id="myModalLabel35">SUCURSAL</h3>
			        </div>
			   
                       
			        <div class="modal-body">
                   
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header">
                                    </div>
                                    <div class="card-body collapse in">
                                        <div class="card-block">
                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <label>Nombre</label>
                                                        <asp:TextBox ID="tipogasto" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Tipo de venta" name="tipogasto" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label>Abreviado</label>                                                       
                                                        <asp:TextBox ID="abreviado" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Abreviado" name="tipogasto" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-9">
                                                    <div class="form-group">
                                                        <label>Calle</label>
                                                        
                                                        <asp:TextBox ID="calle" CssClass="form-control" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Calle" name="tipogasto" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>
                                                 <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>Num. Ext</label>

                                                        <asp:TextBox ID="numext" CssClass="form-control" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Num" name="tipogasto" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>
                                                </div>


                                            <div class="row">
                                                <div class="col-md-9">
                                                    <div class="form-group">
                                                        <label>Colonia</label>
                                                        <asp:TextBox ID="colonia" CssClass="form-control" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Colonia" name="tipogasto" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>

                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>CP</label>

                                                        <asp:TextBox ID="cp" CssClass="form-control" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="CP" name="tipogasto" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <label>Email</label>

                                                        <asp:HiddenField runat="server" ID="HiddenField6" />
                                                        <asp:TextBox ID="email" CssClass="form-control" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Email" name="tipogasto" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label>Teléfono</label>
                                                        <asp:TextBox ID="TextBox7" CssClass="form-control" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Teléfono" name="tlefono" runat="server"></asp:TextBox>

                                                    </div>


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



    <script>
        
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catsucursales").addClass("active");

        function abrirModal(idtipogasto, tipogasto) {
            
           
            
            $("*[id$='idg']").val(idtipogasto);

            if (idtipogasto > 0)
                $("*[id$='idtipog']").val(idtipogasto);

           

            $("*[id$='tipogasto']").val(tipogasto);
        
            $("#bootstrap").modal('show');
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

                //loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                //loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");

        }
    </script>
</asp:Content>
