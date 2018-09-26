<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="listadomunicipios.aspx.cs" 
    Inherits="elecion.catalogos.geograficos.listadomunicipios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .ascending a {
	        background:url(/images/descending.png) right no-repeat;
	        display:block;
        }

        .descending a {
	        background:url(/images/ascending.png) right no-repeat;
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
            <h3 class="content-header-title">Catálogos Geográficos</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Municipios</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Listado</a>
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
                            <h4 class="card-title">LISTADO DE MUNICIPIOS</h4>
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
                
                            <button type="button" id="editar" onclick="abrirModal(0,'','');" class="btn btn-icon btn-success mr-1" data-toggle="modal" >
                                 <i class="ft-file"></i> Nuevo Registro 
                            </button>
                           
                            
                            <br /><br />
                 
                            <asp:GridView runat="server" ID="lmunicipios" PageSize="10" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoMunicipios">
                                <SortedAscendingHeaderStyle CssClass="ascending" BackColor="#16D39A" ForeColor="White" />
                                <SortedDescendingHeaderStyle CssClass="descending" BackColor="#16D39A" ForeColor="White"/>
                                        <Columns>
                                            <asp:BoundField DataField="cvomun" HeaderText="Clave" SortExpression="cvomun" />
                                            <asp:BoundField DataField="municipio" HeaderText="Municipio" SortExpression="municipio" />                           
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <button type="button" id="editar" onclick="abrirModal(<%# Eval("idMunicipio")%>,'<%# Eval("cvomun").ToString() %>','<%# Eval("municipio").ToString() %>');" class="btn btn-icon btn-success mr-1"
                                                        data-toggle="modal" >
                                                         <i class="ft-edit"></i>
                                                    </button>

                                                     <button type="button" id="borrar" onclick="eliminarRegistro(<%# Eval("idMunicipio")%>,'<%# Eval("cvomun").ToString() %>','<%# Eval("municipio").ToString() %>');" class="btn btn-icon btn-danger mr-1"
                                                        data-toggle="modal" >
                                                         <i class="ft-delete"></i>
                                                    </button>
                                                                                                         
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            
                                    <asp:SqlDataSource ID="DsListadoMunicipios" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                        SelectCommand="SELECT [cvomun], [idMunicipio], [municipio]  FROM [municipios] WHERE entidad=18 ORDER BY [municipio] asc"></asp:SqlDataSource>
               
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
			        <h3 class="modal-title" id="myModalLabel35">DETALLE DE MUNICIPIO</h3>
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
						                                              
	                    	                            <div class="form-body">
	                    		                            <asp:HiddenField runat="server" ID="idm" />

                                                            <div class="form-group row">
	                            	                            <label class="col-md-3 label-control" for="cvomun">Clave</label>
		                                                        <div class="col-md-9">
                                                                    <asp:TextBox ID="cvomun" CssClass="form-control" required="required" data-validation-required-message="Campo requerido" maxlength="18" placeholder="Clave" name="cvomun" runat="server"></asp:TextBox>
                                                                    <div class="help-block"></div>
		                                                        </div>
		                                                    </div>
                                                            <div class="form-group row">
	                            	                            <label class="col-md-3 label-control" for="municipio">Municipio</label>
		                                                        <div class="col-md-9">
                                                                    <asp:TextBox ID="municipio" CssClass="form-control" required="required" data-validation-required-message="Campo requerido" maxlength="18" placeholder="Municipio" name="municipio" runat="server"></asp:TextBox>
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
                        <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" style="display:none" />     
                        <asp:Button runat="server" ID="borrar" OnClick="borrarRegistro" style="display:none" />
                        
				        <button class="btn btn-primary"  onclick="$('#<%= guardar.ClientID %>').click();"> 
	                        <i class="fa fa-check-square-o"></i> Guardar
	                     </button>
                 
	                     <button type="button" onclick="alerta();" class="btn btn-warning mr-1" data-dismiss="modal" id="cerrarModal">
	                        <i class="ft-x"></i> Cancelar
	                     </button>
			        </div>
			       
		        </div>
		        </div>
            
               
	        </div>
       </section>

           
           
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
        $(document).prop('title', 'PLACEL - Listado de Municipios');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#listadosm").addClass("active");

        function abrirModal(idmunicipio, cvomun, municipio) {
            $("*[id$='idm']").val(idmunicipio);
            $("*[id$='cvomun']").val(cvomun);
            $("*[id$='municipio']").val(municipio);
            $("#bootstrap").modal('show');
        }

        function eliminarRegistro(idmunicipio, cvomun, municipio) {
            $("*[id$='idm']").val(idmunicipio);
            $("*[id$='cvomun']").val(cvomun);
            $("*[id$='municipio']").val(municipio);


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
                    
                    $('#<%= borrar.ClientID %>').click();
                    swal.close();
                   
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

               // $("*[id$='cp']").ForceNumericOnly(); 
               // $("*[id$='seccion']").ForceNumericOnly();
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
                loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
                loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

        }
    </script>
</asp:Content>
