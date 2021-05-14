<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="catmunicipios.aspx.cs" Inherits="elecion.catalogos.geograficos.catmunicipios" %>
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
    
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
   
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>
            <div class="content-header row">

                   <div class="col-md-3">
                       <div class="media-left media-middle">
                           <i class="fa fa-map primary font-large-2 mr-1"></i>
                       </div>
                       <div class="media-body">
                           <h4 class="font-weight-bold">Municipios</h4>
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
                                   <button type="button" id="nuevo" onclick="abrirModal(0,'',1)" class="btn btn-icon btn-primary mr-1 text-bold-700" data-toggle="modal">
                                  
                                       Nuevo Registro 
                                   </button>
                               </span>
                           </div>
               </div>    <br />

            <div class="row" id="header-styling">
                <div class="col-md-12">

                    <div class="media">

                        <div class="col-md-4" id="datiende" runat="server">
                            <div class="form-group">
                                <label for="atiende" class="text-bold-600 font-small-3">Entidad</label>
                                <asp:DropDownList runat="server" ID="bcategoria" CssClass="select2 form-control" DataSourceID="Dsusuarios" DataTextField="entidad" OnSelectedIndexChanged="listadoGrid" AutoPostBack="true" DataValueField="identidad" Style="width: 100%" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0">Seleccione una entidad</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="Dsusuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                    SelectCommand="SELECT identidad, entidad from entidad order by entidad"></asp:SqlDataSource>

                            </div>
                        </div>


                        <div class="col-md-4" id="Div1" runat="server">
                            <div class="form-group">
                                <label class="text-bold-600 font-small-3">Municipio</label>
                                <asp:TextBox ID="bmunicipio" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Municipio" name="nombre" runat="server" AutoPostBack="true" OnTextChanged="listadoGrid"></asp:TextBox>
                            </div>
                        </div>


                    </div>

                </div>
            </div>

            <div class="row" >
                <div class="col-xs-12">
                    <div class="card">
                       
                            <div class="card-block card-dashboard">
                            <div style="overflow-x:auto;width:100%"> 
                            <asp:GridView runat="server" ID="lgastos" PageSize="50" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastos" OnSorting="lgastos_Sorting" EnableSortingAndPagingCallbacks="true"
                                AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros">
                                <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="No." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px" ItemStyle-CssClass="centrarCelda font-small-3" HeaderStyle-CssClass="centrarCelda primary">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                              <asp:TemplateField HeaderText="Generales" HeaderStyle-CssClass="primary">
                                                    <ItemTemplate>

                                                        <h7 class="font-weight-bold"><%# Eval("municipio")%></h7><br />
                                                        <h7 class="font-small-2 text-bold-400"><i class="fa fa-map-marker"></i> <%# " "+Eval("entidad")%></h7>
                                                        
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            
                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px"  HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                <ItemTemplate>

                                                    <button type="button" onclick="abrirModal(<%# Eval("idmunicipio")%>,'<%# Eval("municipio").ToString() %>',<%# Eval("identidad")%>)" class="btn btn-icon btn-warning mr-1 btn-sm"
                                                        data-toggle="tooltip" data-original-title="Editar" >
                                                         <i class="ft-edit"></i>
                                                    </button>

                                                    
                                                                                               
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        
                                        <PagerSettings FirstPageText="INICIO" LastPageText="FIN" FirstPageImageUrl="" LastPageImageUrl="" Mode="NumericFirstLast" />
                                
                                    </asp:GridView>
                            
                                    <asp:SqlDataSource ID="DsListadoGastos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>
                                
                               </div>

                                
                            </div>
                        
                    </div>
                </div>
            </div>

     
    <div class="modal fade text-xs-left" id="bootstrap" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
        
		        <div class="modal-dialog" role="document">
		        <div class="modal-content">
			        <div class="modal-header bg-primary white">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				        <span aria-hidden="true">&times;</span>
			        </button>
			        <h5 class="modal-title" id="myModalLabel35">MUNICIPIO</h5>                                                                               
                                                       
                                                    
			        </div>
			   
                       
			        <div class="modal-body">
                    <section class="input-validation inputmask">
	                            <div class="row">
	                                <div class="col-md-12">
	                                    <div class="card">
	                                        
                                            <div class="card-body collapse in">
                                                <div class="card-block">
                                                  <div class="row">
                                                                
                                                      <div class="form-group">
                                                                        <div class="col-md-12">
                                                                        <label class="text-bold-600">Entidad</label>
                                                                        <asp:DropDownList runat="server" ID="identidad" CssClass="select2 form-control" DataSourceID="DsAreas" DataTextField="entidad" DataValueField="identidad" AutoPostBack="false" style="width:100%"></asp:DropDownList>
                                         <asp:SqlDataSource ID="DsAreas" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT identidad, entidad FROM entidad ORDER BY entidad"></asp:SqlDataSource>
                                                                    </div>
                                                          </div>
                                                      </div>
                                                    <div class="row">

                                                                    <div class="form-group">
                                                                        <div class="col-md-12">
                                                                        <label class="text-bold-600">Municipio</label>

                                                                                                                                              
                                                                        <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Municipio" name="nombre" runat="server"></asp:TextBox>
                                                                        <div class="help-block"></div>
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
                        <asp:Button runat="server" ID="borrar" OnClick="borrarRegistro" style="display:none" UseSubmitBehavior="false"/>
                        
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
        $("#catmunicipios").addClass("active");

        function abrirModal(idtipogasto, tipogasto, idcategoria) {
            $("*[id$='idS']").val(idtipogasto);
                        
            $("*[id$='nombre']").val(tipogasto);
            $("*[id$='identidad']").val(idcategoria);
            $("*[id$='identidad']").change();
                             
            $("#bootstrap").modal('show');
        }


        function SetSelectedIndex(dropdownlist, sVal) {
            
            var a = document.getElementById(dropdownlist);
            
            for (i = 0; i < a.length; i++) {
               
                if (a.options[i].value == sVal) {
                    a.selectedIndex = i;
                    
                }

            }

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
       
            var nombre = $("*[id$='nombre']").val();
           

            if (nombre == '') {
                walert = 1;
                alerta('Atención', 'Ingrese el nombre del municipio', 'warning', $("*[id$='tipogasto']"));
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
