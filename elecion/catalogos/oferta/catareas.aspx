<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="catareas.aspx.cs" Inherits="elecion.catalogos.oferta.catareas" %>
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
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

      

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/forms/checkboxes-radios.css"/>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Oferta Educativa</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Catálogos</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Oferta Educativa</a>
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
                            <h4 class="card-title">ÁREAS DE FORMACIÓN PROFESIONAL</h4>
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
                                                    <div class="row">
                                                        <div class="col-md-8">
                                                            <div class="form-group">
                                                                <h4>Elementos registrados</h4>
                                                                <span>
                                                                    <asp:Label runat="server" ID="labelConteo"></asp:Label>
                                                                    actualmente</span>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">

                                                            <div class="media-right media-middle pull-right">
                                                                <button type="button" id="nuevo" runat="server" onclick="abrirModal(0,'','','','','','','',1,0);" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                                    <i class="ft-file"></i>Nuevo registro 
                                                                </button>
                                                            </div>



                                                        </div>

                                                    </div>                                                    
                                                </div>

                                                
                                               
                                            </div>
                                        </div>

                                         <div class="card-block card-dashboard">
                                            <div class="row">

                                                <div class="col-md-2" id="datiende" runat="server">
                                                    <div class="form-group">
                                                        <label for="atiende" class="text-bold-600">Oferta Educativa</label>
                                                        <asp:DropDownList runat="server" ID="boferta" CssClass="select2 form-control" DataSourceID="DSofertas" DataTextField="ofertaeducativa"  DataValueField="idofertaeducativa" Style="width: 100%" AutoPostBack="true" OnSelectedIndexChanged="listadoGrid">                                                            
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="DSofertas" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                            SelectCommand="SELECT idofertaeducativa, ofertaeducativa from ofertaeducativa order by vigente desc" ></asp:SqlDataSource>

                                                    </div>
                                                </div>


                                                <div class="col-md-4" id="Div1" runat="server">
                                                    <div class="form-group">                                                        
                                                        <label class="text-bold-600">Área</label>
                                                           <asp:TextBox ID="barea" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="area" name="nombre" runat="server" AutoPostBack="true" OnTextChanged="listadoGrid"></asp:TextBox>
                                                    </div>
                                                </div>



                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>
                           
                           
                            </div>
                            
                            <div class="card-block card-dashboard">
                            <div style="overflow-x:auto;width:100%"> 
                                <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" style="display:none" UseSubmitBehavior="false"/>     
                                <asp:Button runat="server" ID="borrar" OnClick="borrarRegistro" style="display:none" UseSubmitBehavior="false" />

                            <asp:GridView runat="server" ID="lgastos" PageSize="50" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastos" OnSorting="listadoGrid" EnableSortingAndPagingCallbacks="true" 
                                AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros" OnPageIndexChanged="listadoGrid">
                                <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="No." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="area" HeaderText="Área" SortExpression="area" /> 
                                           
                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="20px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                <ItemTemplate>

                                                    <button type="button" id="editar" onclick="abrirModal(<%# Eval("idarea")%>,'<%# Eval("area").ToString() %>')" class="btn btn-icon btn-warning mr-1 btn-sm"
                                                        data-toggle="tooltip" data-original-title="Editar" >
                                                         <i class="ft-edit"></i>
                                                    </button>
                                                                                                                                                             
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            
                                    <asp:SqlDataSource ID="DsListadoGastos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>">

                                    </asp:SqlDataSource>
                               </div>
                            </div>
                        
                    </div>
                </div>
            </div>

     
   
            
                </section>
	        </div>
            
  
    </ContentTemplate>
    </asp:UpdatePanel> 

     <div class="modal fade text-xs-left" id="bootstrap"  role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
         <asp:UpdatePanel runat="server" ID="UpdatePanel1">
         <ContentTemplate>
		        <div class="modal-dialog" role="document">
		        <div class="modal-content">
			        <div class="modal-header bg-primary white">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				        <span aria-hidden="true">&times;</span>
			        </button>
			        <h5 class="modal-title" id="myModalLabel35">ÁREA</h5>                                                                               
                                                       
                                                    
			        </div>
			   
                       <asp:HiddenField runat="server" ID="idr" />
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">

                                    <div class="card-body collapse in">
                                        <div class="card-block">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Nombre</label>
                                                        <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Nombre" name="nombre" runat="server"></asp:TextBox>

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
                        
                        
				        <button class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false" onsubmit=""> 
	                        <i class="fa fa-check-square-o"></i> Aceptar
	                     </button>
                 
	                     <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
	                        <i class="ft-x"></i> Cancelar
	                     </button>
			        </div>
</div>

			       
		        </div>
         </ContentTemplate>
         </asp:UpdatePanel>
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

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>


    <script>
        var walert = 0;
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catareas").addClass("active");


        function abrirModal(idsucursal, nombre) {
                      
            $("*[id$='idS']").val(idsucursal);           
            $("*[id$='nombre']").val(nombre);                  
            $("#bootstrap").modal('show');
        }
     

        function valida() {
            
           var nombre = $("*[id$='nombre']").val();
           

            if (nombre == '') {
                walert = 1;
                alerta('Atención', 'Ingrese el nombre del´área', 'warning', $("*[id$='nombre']"));
                return false;
                
            }

            walert = 0;
            mostrarLoading();
            
            $('#<%= guardar.ClientID %>').click();
            $('#bootstrap').modal('hide');
                                                                              
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

                $('#bootstrap').on('keypress', function (e) {
                    if (e.keyCode === 13) {
                        if (walert == 0) {
                            valida();
                            return false;
                        }
                        else {                            
                            swal.close();
                        }
                    }
                });
                                                    
        }
    </script>
</asp:Content>
