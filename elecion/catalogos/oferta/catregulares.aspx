<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="catregulares.aspx.cs" Inherits="elecion.catalogos.oferta.catregulares" %>
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
            <h3 class="content-header-title">Oferta Educativa</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Catálogos</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Oferta</a>
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
                            <h4 class="card-title">REGULARES</h4>
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
                                                <div class="media-right media-middle">
                                                    <button type="button" id="nuevo" runat="server" onclick="abrirModalNuevo()" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                        <i class="ft-file"></i>Nuevo registro 
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-block card-dashboard">
                                            <div class="row">
                                                <div class="col-md-2" id="Div2" runat="server">
                                                    <div class="form-group">
                                                        <label for="atiende" class="text-bold-600">Oferta Educativa</label>
                                                        <asp:DropDownList runat="server" ID="boferta" CssClass="select2 form-control" DataSourceID="DSofertas" DataTextField="ofertaeducativa"  DataValueField="idofertaeducativa" Style="width: 100%" AutoPostBack="true">                                                            
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="DSofertas" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                            SelectCommand="SELECT idofertaeducativa, ofertaeducativa from ofertaeducativa order by vigente desc" ></asp:SqlDataSource>

                                                    </div>
                                                </div>

                                                <div class="col-md-3" id="datiende" runat="server">
                                                    <div class="form-group">
                                                        <label for="atiende" class="text-bold-600">Área</label>
                                                        <asp:DropDownList runat="server" ID="bcategoria" CssClass="select2 form-control" DataSourceID="Dsusuarios" DataTextField="area"  AutoPostBack="true" DataValueField="idarea" Style="width: 100%" OnDataBound="refrescaCombos" OnSelectedIndexChanged="refrescaCombos">
                                                            
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="Dsusuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                            SelectCommand="SELECT idarea, area from area where idofertaeducativa=@idofertaeducativa order by area" >
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="boferta" Name="idofertaeducativa" PropertyName="SelectedValue" />
                                                            </SelectParameters>

                                                        </asp:SqlDataSource>

                                                    </div>
                                                </div>


                                                <div class="col-md-4" id="Div1" runat="server">
                                                    <div class="form-group">                                                        
                                                        <label class="text-bold-600">Especialidad</label>
                                                        <asp:DropDownList runat="server" ID="bespecialidad" CssClass="select2 form-control" DataSourceID="Dsespecialidades" DataTextField="especialidad" DataValueField="idespecialidad" Style="width: 100%" AutoPostBack="true" OnSelectedIndexChanged="listadoGrid" OnDataBound="listadoGrid"></asp:DropDownList>
                                                             <asp:SqlDataSource ID="Dsespecialidades" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                                 SelectCommand="SELECT idespecialidad, especialidad FROM especialidad  WHERE idarea =@idcat ORDER BY especialidad">
                                                                <SelectParameters>
                                                                      <asp:ControlParameter ControlID="bcategoria" Name="idcat" PropertyName="SelectedValue" />
                                                                </SelectParameters>
                                                             </asp:SqlDataSource>               
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
                                            <asp:BoundField DataField="clave" HeaderText="Clave" ItemStyle-Width="300px" SortExpression="clave" /> 
                                            <asp:BoundField DataField="nombre" HeaderText="Nombre" ItemStyle-Width="300px" SortExpression="nombre" /> 
                                            <asp:BoundField DataField="area" HeaderText="Area" ItemStyle-Width="300px" SortExpression="area" /> 
                                            <asp:BoundField DataField="especialidad" HeaderText="Especialidad" SortExpression="especialidad" />                           
                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px">
                                                <ItemTemplate>

                                                    <button type="button" id="editar" onclick="abrirModal(<%# Eval("idcursoregular")%>,<%# Eval("idespecialidad")%>,'<%# Eval("especialidad").ToString() %>',<%# Eval("idarea")%>, '<%# Eval("clave").ToString() %>', '<%# Eval("nombre").ToString() %>')" class="btn btn-icon btn-warning mr-1 btn-sm"
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
			        <h5 class="modal-title" id="myModalLabel35">ESPECIALIDAD</h5>                                                                               
                                                       
                                                    
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
                                                                <label class="text-bold-600">Área</label>
                                                                <asp:DropDownList runat="server" ID="identidad" CssClass="select2 form-control" DataSourceID="DsAreas" DataTextField="area" DataValueField="idarea" AutoPostBack="false" Style="width: 100%" disabled></asp:DropDownList>
                                                                <asp:SqlDataSource ID="DsAreas" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idarea, area FROM area ORDER BY area"></asp:SqlDataSource>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    

                                                    <div class="row">

                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <label class="text-bold-600">Especialidad</label>
                                                                 <asp:DropDownList runat="server" ID="idespecialidad" CssClass="select2 form-control" DataSourceID="Dsespecialidad" DataTextField="especialidad" DataValueField="idespecialidad" AutoPostBack="false" Style="width: 100%" disabled></asp:DropDownList>
                                                                <asp:SqlDataSource ID="Dsespecialidad" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idespecialidad, especialidad FROM especialidad ORDER BY especialidad"></asp:SqlDataSource>
                                                            
                                                            </div>


                                                        </div>
                                                    </div>                                                                                                                       
                                                        

                                                    <div class="row">

                                                        <div class="form-group">
                                                            <div class="col-md-6">
                                                                <label class="text-bold-600">Clave</label>
                                                                <asp:TextBox ID="clave" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="45" placeholder="Clave" name="nombre" runat="server"></asp:TextBox>
                                                                <div class="help-block"></div>
                                                            </div>


                                                        </div>
                                                    </div>  

                                                     <div class="row">

                                                        <div class="form-group">
                                                            <div class="col-md-12">
                                                                <label class="text-bold-600">Nombre del curso</label>
                                                                <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" placeholder="Curso" name="nombre" runat="server"></asp:TextBox>
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
        $("#catcursosregulares").addClass("active");

        function abrirModal(idcurso, idespecialidad, tipogasto, idarea, clave, nombre) {
            $("*[id$='idS']").val(idcurso);

            $("*[id$='clave']").val(clave);
            $("*[id$='nombre']").val(nombre);

            $("*[id$='identidad']").val(idarea);
            $("*[id$='identidad']").change();

            $("*[id$='idespecialidad']").val(idespecialidad);
            $("*[id$='idespecialidad']").change();
                             
            $("#bootstrap").modal('show');
        }

        function abrirModalNuevo() {
	    $("*[id$='idS']").val(0);
            var categoria = $("*[id$='bcategoria']").val();
            var especialidad = $("*[id$='bespecialidad']").val();

            $("*[id$='identidad']").val(categoria);
            $("*[id$='identidad']").change();

            $("*[id$='idespecialidad']").val(especialidad);
            $("*[id$='idespecialidad']").change();

            $("*[id$='clave']").val('');
            $("*[id$='nombre']").val('');
           
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
            var clave = $("*[id$='clave']").val();

            if (clave == '') {
                walert = 1;
                alerta('Atención', 'Ingrese la clave de la especialidad', 'warning', $("*[id$='clave']"));
                return false;
                
            }


            if (nombre == '') {
                walert = 1;
                alerta('Atención', 'Ingrese el nombre de la especialidad', 'warning', $("*[id$='tipogasto']"));
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
