<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="catedocivil.aspx.cs" Inherits="elecion.catalogos.personales.catedocivil" %>
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
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
   
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>

              <div class="content-header row">

                   <div class="col-md-3">
                       <div class="media-left media-middle">
                           <i class="fa fa-user primary font-large-2 mr-1"></i>
                       </div>
                       <div class="media-body">
                           <h4 class="font-weight-bold">Estado Civil</h4>
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
                                   <button type="button" id="nuevo"  onclick="abrirModal(0,'','','','','','','',1,0);" class="btn btn-icon btn-primary mr-1 text-bold-700" data-toggle="modal">
                                  
                                       Nuevo Registro 
                                   </button>
                               </span>
                           </div>
               </div>    <br />

            <div class="row" id="header-styling">
                <div class="col-xs-12">
                    
                            
                            <div class="">
                            <div style="overflow-x:auto;width:100%"> 
                            <asp:GridView runat="server" ID="lgastos" PageSize="10" AllowPaging="true" CssClass="table table-striped lGeneral" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastos" OnSorting="lgastos_Sorting" EnableSortingAndPagingCallbacks="true"
                               GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static" OnDataBinding="conteoRegistros">
                               
                                        <Columns>
                                            
                                            <asp:BoundField DataField="clave" HeaderText="Clave" SortExpression="clave" ItemStyle-Width="20px" ItemStyle-CssClass="font-small-3 centrarCelda" HeaderStyle-CssClass="primary centrarCelda"/> 

                                            <asp:BoundField DataField="edocivil" HeaderText="Nombre" SortExpression="edocivil" ItemStyle-CssClass="font-small-3 font-weight-bold" HeaderStyle-CssClass="primary"/> 
                                           
                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="20px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                <ItemTemplate>

                                                    <button type="button" id="editar" onclick="abrirModal(<%# Eval("idedocivil")%>,'<%# Eval("clave").ToString() %>','<%# Eval("edocivil").ToString() %>')" class="btn btn-icon btn-warning mr-1 btn-sm"
                                                        data-toggle="tooltip" data-original-title="Editar" >
                                                         <i class="ft-edit"></i>
                                                    </button>
                                                                                                                                                             
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            
                                    <asp:SqlDataSource ID="DsListadoGastos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="select idedocivil, clave, edocivil from edocivil ">

                                    </asp:SqlDataSource>
                               </div>
                            </div>
                        
                    </div>
                </div>
            </div>

     
    <div class="modal fade text-xs-left" id="bootstrap"  role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
        
		        <div class="modal-dialog" role="document">
		        <div class="modal-content">
			        <div class="modal-header bg-primary white">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				        <span aria-hidden="true">&times;</span>
			        </button>
			        <h5 class="modal-title" id="myModalLabel35">ESTADO CIVIL</h5>                                                                               
                                                       
                                                    
			        </div>
			   
                       <asp:HiddenField runat="server" ID="idr" />
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">

                                    <div class="card-body collapse in">
                                        <div class="card-block">

                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Clave</label>
                                                        <asp:TextBox ID="clave" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Clave" name="nombre" runat="server"></asp:TextBox>

                                                    </div>

                                                </div>

                                            </div>

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
                        <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" style="display:none" UseSubmitBehavior="false"/>     
                        <asp:Button runat="server" ID="borrar" OnClick="borrarRegistro" style="display:none" UseSubmitBehavior="false" />
                        
				        <button class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false" onsubmit=""> 
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

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>


    <script>
        var walert = 0;
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catedocivil").addClass("active");


        function abrirModal(idsucursal, clave, nombre) {
                      
            $("*[id$='idS']").val(idsucursal); 
            $("*[id$='clave']").val(clave);
            $("*[id$='nombre']").val(nombre);                  
            $("#bootstrap").modal('show');
        }
     

        function valida() {
            
            var nombre = $("*[id$='nombre']").val();
            var clave = $("*[id$='clave']").val();
           

            if (clave == '') {
                walert = 1;
                alerta('Atención', 'Ingrese la clave para el estado civil', 'warning', $("*[id$='clave']"));                
                return false;
                
            }

            if (nombre == '') {
                walert = 1;
                alerta('Atención', 'Ingrese el nombre para el estado civil', 'warning', $("*[id$='nombre']"));                
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
                    $("*[id$='clave']").focus();
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
