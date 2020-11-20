<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" 
    CodeBehind="catciclos.aspx.cs" Inherits="elecion.catalogos.ciclo.catciclos" %>
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

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/daterange/daterangepicker.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/datetime/bootstrap-datetimepicker.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/pickadate/pickadate.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/pickers/daterange/daterange.css"/>


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">CICLO ESCOLAR</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Catálogos</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Ciclo Escolar</a>
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
                            <h4 class="card-title">CICLOS</h4>
                            <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                            <div class="heading-elements">
                                <ul class="list-inline mb-0">
                                  <asp:HiddenField ID="idS" runat="server" Value="0"/>
                                  <asp:HiddenField ID="idP" runat="server" Value="0"/>
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

                                    </div>
                                </div>
                            </div>


                        </div>
                            <asp:Button runat="server" ID="Bperiodos" OnClick="recuperaPeriodos" Style="display: none" UseSubmitBehavior="false" />
                            <div class="card-block card-dashboard">
                            <div style="overflow-x:auto;width:100%"> 
                            <asp:GridView runat="server" ID="lgastos" PageSize="50" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
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
                                            <asp:BoundField DataField="cicloescolar" HeaderText="Ciclo Escolar" SortExpression="cicloescolar" /> 
                                            <asp:BoundField DataField="fechaini" HeaderText="Inicia" SortExpression="fechaini" ItemStyle-Width="100px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda"/>
                                            <asp:BoundField DataField="fechafin" HeaderText="Termina" SortExpression="fechafin" ItemStyle-Width="100px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda"/>
                                            <asp:BoundField DataField="periodos" HeaderText="Periodos" SortExpression="periodos" ItemStyle-Width="100px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda"/>
                                           
                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="250px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                <ItemTemplate>

                                                    <button type="button" id="periodos" onclick="abrirModalPeriodos(<%# Eval("idcicloescolar")%>)" class="btn btn-icon btn-cyan mr-1 btn-sm"
                                                        data-toggle="tooltip" data-original-title="Periodos" >
                                                         <i class="fa fa-cog"></i>
                                                    </button>

                                                    <button type="button" id="editar" onclick="abrirModal(<%# Eval("idcicloescolar")%>,'<%# Eval("cicloescolar").ToString() %>','<%# Eval("fechaini").ToString() %>','<%# Eval("fechafin").ToString() %>')" class="btn btn-icon btn-warning mr-1 btn-sm"
                                                        data-toggle="tooltip" data-original-title="Editar" >
                                                         <i class="ft-edit"></i>
                                                    </button>
                                                                                                                                                             
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            
                                    <asp:SqlDataSource ID="DsListadoGastos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="select c.idcicloescolar, c.cicloescolar, cast(c.fechaini as char)as fechaini, cast(c.fechafin as char)as fechafin,  (select count(p.idperiodo) from periodo p where p.idcicloescolar = c.idcicloescolar)as periodos from cicloescolar c order by idcicloescolar desc">

                                    </asp:SqlDataSource>
                               </div>
                            </div>
                        
                    </div>
                </div>
            </div>

     
            
  
    </ContentTemplate>
    </asp:UpdatePanel> 

    
            <div class="modal fade text-xs-left" id="bootstrap" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
                <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                <ContentTemplate>
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title" id="myModalLabel35">Ciclo Escolar</h5>
                        </div>
                        <asp:HiddenField runat="server" ID="idr" />
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-md-12">
                                    
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label class="text-bold-600">Ciclo</label>
                                                            <asp:TextBox ID="cicloescolar" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Nombre" name="nombre" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="text-bold-600">Inicia</label>
                                                            <asp:TextBox ID="fechaini" CssClass="form-control pickadate text-uppercase" placeholder="Fecha" name="fechaini" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="text-bold-600">Termina</label>
                                                            <asp:TextBox ID="fechafin" CssClass="form-control pickadate text-uppercase" placeholder="Fecha" name="fechafin" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                           
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                           
                            <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" Style="display: none" UseSubmitBehavior="false" />
                            <button class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false" onsubmit="">
                                <i class="fa fa-check-square-o"></i>Aceptar
                            </button>

                            <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
                                <i class="ft-x"></i>Cancelar
                            </button>
                        </div>
                    </div>


                </div>
                    </ContentTemplate>
                    </asp:UpdatePanel>
            </div>

            <div class="modal fade text-xs-left" id="bootstrapPeriodo" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <ContentTemplate>
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title">Periodo</h5>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-md-12">
                                    
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label class="text-bold-600">Periodo</label>
                                                            <asp:TextBox ID="periodo" CssClass="form-control text-uppercase" required="required" data-validation-required-message="Campo requerido" MaxLength="60" placeholder="Nombre" name="nombre" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="text-bold-600">Inicia</label>
                                                            <asp:TextBox ID="Pfini" CssClass="form-control pickadate text-uppercase" placeholder="Fecha" name="fechaini" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="text-bold-600">Termina</label>
                                                            <asp:TextBox ID="Pffin" CssClass="form-control pickadate text-uppercase" placeholder="Fecha" name="fechafin" runat="server"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                           
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            
   
                            <button class="btn btn-primary" onclick="validaPeriodo()" type="button" data-backdrop="false" onsubmit="">
                                <i class="fa fa-check-square-o"></i>Aceptar
                            </button>

                            <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModalb">
                                <i class="ft-x"></i>Cancelar
                            </button>
                        </div>
                    </div>


                </div>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                    
            </div>

             <div class="modal fade text-xs-left" id="wperiodos" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h5 class="modal-title" id="titlePeriodos">Periodos</h5>
                        </div>
                        
                        <div class="modal-body">
                            <div class="row">
                                <div class="media-right media-middle pull-right">
                                                                <button type="button" id="Button3" runat="server" onclick="abrirModalPeriodo(0,'','','','','','','',1,0);" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                                    <i class="ft-file"></i>Nuevo registro 
                                                                </button>
                                                            </div>

                            </div><br />
                            <div class="row">
                                <div class="col-md-12">

                                   

                                    
                                    <div style="overflow-x: auto; width: 100%">
                                        <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                                        <ContentTemplate>
                                            <asp:Button runat="server" ID="BeliminaPeriodo" OnClick="borrarPeriodo" Style="display: none" UseSubmitBehavior="false"/>
                                             <asp:Button runat="server" ID="guardarPeriodo" OnClick="guardaEditaPeriodo" Style="display: none" UseSubmitBehavior="false" />
                                        <asp:GridView runat="server" ID="GVperiodos" PageSize="50" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration"
                                            AutoGenerateColumns="False" DataSourceID="DSperiodos" OnSorting="lgastos_Sorting" EnableSortingAndPagingCallbacks="true"
                                            AlternatingRowStyle-BackColor="#F5F7FA">
                                            <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                            <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="No." HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="20px">
                                                    <ItemTemplate>
                                                        <%# Container.DataItemIndex + 1 %>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="periodo" HeaderText="Periodo" SortExpression="periodo" />
                                                <asp:BoundField DataField="fechaini" HeaderText="Inicia" SortExpression="fechaini" ItemStyle-Width="100px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda" />
                                                <asp:BoundField DataField="fechafin" HeaderText="Termina" SortExpression="fechafin" ItemStyle-Width="100px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda" />
                                                
                                                <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="250px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                    <ItemTemplate>
                                                        <button type="button" id="editar" onclick="abrirModalPeriodo(<%# Eval("idperiodo")%>,'<%# Eval("periodo").ToString() %>','<%# Eval("fechaini").ToString() %>','<%# Eval("fechafin").ToString() %>')" class="btn btn-icon btn-warning mr-1 btn-sm"
                                                            data-toggle="tooltip" data-original-title="Editar">
                                                            <i class="ft-edit"></i>
                                                        </button>

                                                        <button type="button" onclick="eliminaPeriodo(<%# Eval("idperiodo")%>)" class="btn btn-icon btn-danger mr-1 btn-sm tooltips"
                                                                data-toggle="tooltip" data-original-title="Eliminar">
                                                                <i class="ft-delete"></i>
                                                         </button>

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>

                                        </asp:GridView>
                                        </ContentTemplate>
                                            </asp:UpdatePanel>
                                        <asp:SqlDataSource ID="DSperiodos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand=""></asp:SqlDataSource>
                                    </div>
           


                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                           
                           
                            <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
                                <i class="ft-x"></i>Volver
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

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.date.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.time.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/legacy.js" type="text/javascript"></script>



    <script>
        var walert = 0;
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catciclos").addClass("active");


        function abrirModal(idcicloescolar, cicloescolar, fechaini, fechafin) {
                      
            $("*[id$='idS']").val(idcicloescolar);           
            $("*[id$='cicloescolar']").val(cicloescolar);                  
            $("*[id$='fechaini']").val(fechaini); 
            $("*[id$='fechafin']").val(fechafin); 
            $("#bootstrap").modal('show');
        }

        function abrirModalPeriodo(idperiodo, periodo, fechaini, fechafin) {
                      
              
            $("*[id$='idP']").val(idperiodo);           
            $("*[id$='periodo']").val(periodo);                  
            $("*[id$='Pfini']").val(fechaini); 
            $("*[id$='Pffin']").val(fechafin); 
            $("#bootstrapPeriodo").modal('show');
        }
     

        function valida() {
            
            var nombre = $("*[id$='cicloescolar']").val();
            var fechaini = $("*[id$='fechaini']").val();
            var fechafin = $("*[id$='fechafin']").val();
        
            if (nombre == '') {
                walert = 1;
                alerta('Atención', 'Ingrese el nombre del ciclo escolar', 'warning', $("*[id$='cicloescolar']"));
                return false;
                
            }
            if (fechaini == '') {
                walert = 1;
                alerta('Atención', 'Ingrese la fecha de inicio del ciclo escolar', 'warning', $("*[id$='fechaini']"));
                return false;
                
            }
            if (fechafin == '') {
                walert = 1;
                alerta('Atención', 'Ingrese la fecha de término del ciclo escolar', 'warning', $("*[id$='fechafin']"));
                return false;
                
            }

            walert = 0;
            mostrarLoading();
            
            $('#<%= guardar.ClientID %>').click();
            $('#bootstrap').modal('hide');
                                                                              
        }

        function validaPeriodo() {
            
            var nombre = $("*[id$='periodo']").val();
            var fechaini = $("*[id$='Pfini']").val();
            var fechafin = $("*[id$='Pffin']").val();
        
            if (nombre == '') {
                walert = 1;
                alerta('Atención', 'Ingrese el nombre del periodo', 'warning', $("*[id$='periodo']"));
                return false;
                
            }
            if (fechaini == '') {
                walert = 1;
                alerta('Atención', 'Ingrese la fecha de inicio del periodo', 'warning', $("*[id$='Pfini']"));
                return false;
                
            }
            if (fechafin == '') {
                walert = 1;
                alerta('Atención', 'Ingrese la fecha de término del periodo', 'warning', $("*[id$='Pffin']"));
                return false;
                
            }

            walert = 0;
            mostrarLoading();
            
            $('#<%= guardarPeriodo.ClientID %>').click();
            $('#bootstrapPeriodo').modal('hide');
                                                                              
        }

        function abrirModalPeriodos(idcicloescolar) {
           $("*[id$='idS']").val(idcicloescolar);     
            mostrarLoading();
                      
            $('#<%= Bperiodos.ClientID %>').click();
            
                        
        }

        function eliminaPeriodo(idperiodo) {
            swal({
                title: "Se eliminará el periodo, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#DD6B55',
                confirmButtonText: 'Si',
                cancelButtonText: "No"
            }).then((result) => {
                if (result.value) {
                    $("*[id$='idP']").val(idperiodo);
                    mostrarLoading();
                    $('#<%= BeliminaPeriodo.ClientID %>').click();
                  }
                }) 
         
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

                 $('.pickadate').pickadate({
                        format: 'yyyy-mm-dd',
                        formatSubmit: 'yyyy-mm-dd',
                        monthsFull: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                        weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab'],                   
                        today: 'Hoy',
                        minDate: '',
                        maxDate: '',
                        clear: 'Limpiar',
                    

                 });
                                                    
        }
    </script>
</asp:Content>
