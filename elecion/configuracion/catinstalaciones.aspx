<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="catinstalaciones.aspx.cs" Inherits="elecion.catalogos.configuracion.catinstalaciones" %>
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

    <div class="content-header row">

        <div class="col-md-3">
            <div class="media-left media-middle">
                <i class="fa fa-home primary font-large-2 mr-1"></i>
            </div>
            <div class="media-body">
                <h4 class="font-weight-bold">Instalaciones</h4>
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
                <button type="button" id="nuevo" runat="server" onclick="abrirModal(0,'',1)" class="btn btn-icon btn-primary mr-1 text-bold-700" data-toggle="modal">
                    Nuevo registro 
                </button>
            </span>
        </div>
    </div>    <br />

    <div class="row">
        <div class="col-md-12">
            <div class="media">
                <div class="col-md-4" id="datiende" runat="server">
                    <div class="form-group">
                        <label for="atiende" class="text-bold-600 font-small-3">Unidad Educativa</label>
                        <asp:DropDownList runat="server" ID="bcategoria" CssClass="select2 form-control" DataSourceID="Dsusuarios" DataTextField="nombre" OnSelectedIndexChanged="listadoClientes" AutoPostBack="true" DataValueField="idsucursal" Style="width: 100%" AppendDataBoundItems="true">
                            <asp:ListItem Value="0">Seleccione una unidad</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="Dsusuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                            SelectCommand="SELECT idsucursal, nombre from sucursal order by nombre"></asp:SqlDataSource>

                    </div>
                </div>

                <div class="col-md-4" id="Div1" runat="server">
                    <div class="form-group">
                        <label class="text-bold-600 font-small-3">Aula</label>
                        <asp:TextBox ID="bmunicipio" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Nombre del Aula..." name="nombre" runat="server" AutoPostBack="true" OnTextChanged="listadoClientes"></asp:TextBox>
                    </div>
                </div>


            </div>

        </div>
    </div>
    
        <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>
            <div class="row" id="header-styling">
                <div class="col-xs-12">
                            
                            <div class="card-block card-dashboard">
                            <div style="overflow-x:auto;width:100%"> 

                                <asp:Button runat="server" ID="Bconsultar" OnClick="listadoClientes" Style="display: none" CausesValidation="false" UseSubmitBehavior="false" />
                                <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" style="display:none" CausesValidation="false" UseSubmitBehavior="false"/>     
                                <asp:Button runat="server" ID="borrar" OnClick="borrarRegistro" style="display:none" CausesValidation="false" UseSubmitBehavior="false"/>

                             <asp:GridView runat="server" ID="lgastos" PageSize="50" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastos" OnSorting="listadoClientes" EnableSortingAndPagingCallbacks="true"
                                AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros" OnPageIndexChanged="listadoClientes">
                                <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="No." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-CssClass="primary" ItemStyle-CssClass="centrarCelda font-small-3">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="Instalación" HeaderStyle-CssClass="primary">
                                                    <ItemTemplate>

                                                        <h7 class="font-weight-bold"><%# Eval("nombre")%></h7><br />
                                                        <h7 class="font-small-2  text-bold-400"><i class="fa fa-home"></i> <%# " "+Eval("sucursal")%></h7>                                                        

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                                  
                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px">
                                                <ItemTemplate>

                                                    <button type="button" id="editar" onclick="abrirModal(<%# Eval("idinstalacion")%>,'<%# Eval("nombre").ToString() %>',<%# Eval("idsucursal")%>)" class="btn btn-icon btn-warning mr-1 btn-sm"
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
            
             </ContentTemplate>
    </asp:UpdatePanel>  

           
            
     
    <div class="modal fade text-xs-left" id="bootstrap"  role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">


        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title" id="myModalLabel35">AULA</h5>


                </div>


                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">

                                <div class="card-body collapse in">
                                    <div class="card-block">
                                        <div class="row">

                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="text-bold-600">Unidad Educativa</label>
                                                    <asp:DropDownList runat="server" ID="identidad" CssClass="select2 form-control" DataSourceID="DsAreas" DataTextField="nombre" DataValueField="idsucursal" AutoPostBack="false" Style="width: 100%"></asp:DropDownList>
                                                    <asp:SqlDataSource ID="DsAreas" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idsucursal, nombre FROM sucursal ORDER BY nombre"></asp:SqlDataSource>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">

                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <label class="text-bold-600">Aula</label>


                                                    <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Aula" name="nombre" runat="server"></asp:TextBox>
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


                    <button class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false">
                        <i class="fa fa-check-square-o"></i>Aceptar
                    </button>

                    <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
                        <i class="ft-x"></i>Cancelar
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
        var id = 1;
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catinstalaciones").addClass("active");

        document.body.addEventListener('keydown', function (e) {
            if (// Allow: Ctrl+A,Ctrl+C,Ctrl+V, Command+A
                ((e.keyCode == 73 || e.keyCode == 105) && (e.ctrlKey === true || e.metaKey === true))) {              
                $("#nuevo").click();

                if ($("*[id$='bcategoria']").val()>0)
                    id = $("*[id$='bcategoria']").val();
                else
                    id=1;

                
                abrirModal(0, '', id);
            
                                
            }
        });

        function abrirModal(idtipogasto, tipogasto, idcategoria) {
            
            $("*[id$='idS']").val(idtipogasto);
                        
            $("*[id$='nombre']").val(tipogasto);

            var bcategoria = $("*[id$='bcategoria']").val();

            if(bcategoria!=0 && bcategoria!="")
                $("*[id$='identidad']").val(bcategoria);
            else
                $("*[id$='identidad']").val(idcategoria);

            $("*[id$='identidad']").change();
                             
            $("#bootstrap").modal('show');

            /*var now2 = new Date().toLocaleString();
            var tiempo = new Date().toLocaleTimeString();             
            var parts = now2.split('/');            
            var parts3 = tiempo.split(':');
            var now = new Date(2018, parts[1] - 1, parts[0], parts3[0], parts3[1], parts3[2]);  */       
            
            
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
                alerta('Atención', 'Ingrese el nombre del aula', 'warning', $("*[id$='tipogasto']"));
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
