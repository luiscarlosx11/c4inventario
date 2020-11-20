<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" 
    CodeBehind="frmcurso.aspx.cs" Inherits="elecion.catalogos.oferta.frmcurso" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/forms/checkboxes-radios.css">


    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/raty/jquery.raty.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/daterange/daterangepicker.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/datetime/bootstrap-datetimepicker.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/pickadate/pickadate.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/pickers/daterange/daterange.css">


    <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />



    <style>
div.sticky2 {
    position: -webkit-sticky;
    position: sticky;
    top: 0;
    background-color: white;
    padding: 50px;
    font-size: 20px;
    z-index:29999;
}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-12 col-xs-12 mb-1">
            <h3 class="content-header-title centrarCelda">CURSO</h3>
          </div>
          
    </div>
</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">        
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    
   
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h2 class="text-bold-500">
                        <asp:Label ID="folio" runat="server"></asp:Label></h2>
                    <h5 class="">
                        <asp:Label ID="fempeno" runat="server"></asp:Label></h5>
                    <h5 class="">
                        <asp:Label ID="frefrendo" runat="server"></asp:Label></h5>
                    <h5 class="">
                        <asp:Label ID="fenajenado" runat="server"></asp:Label></h5>
                    <h5 class="">
                        <asp:Label ID="fventa" runat="server"></asp:Label></h5>

                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                    <div class="heading-elements">
                        <ul class="list-inline mb-0">
                            <asp:HiddenField runat="server" ID="idP" Value="0" />
                            <asp:HiddenField runat="server" ID="idS" Value="0" />
                            <asp:HiddenField runat="server" ID="idC" Value="0" />
                            <asp:HiddenField runat="server" ID="idA" Value="0" />
                            <asp:HiddenField runat="server" ID="porcavaluo" Value="0" />
                            <asp:HiddenField runat="server" ID="porcventa" Value="0" />
                            <asp:HiddenField runat="server" ID="idPlz" Value="0" />
                            <asp:HiddenField runat="server" ID="idCfg" Value="0" />
                            <asp:HiddenField runat="server" ID="dventa" Value="0" />
                            <asp:HiddenField runat="server" ID="dtolerancia" Value="0" />
                            <asp:HiddenField runat="server" ID="dapartado" Value="0" />
                            <asp:HiddenField runat="server" ID="idiario" Value="0" />
                            

                            <asp:Button runat="server" ID="bguardar" OnClick="guardaEdita" Style="display: none" CausesValidation="true" UseSubmitBehavior="false" />
                            <asp:Button runat="server" ID="volver" OnClick="volverListado" class="ocultar" UseSubmitBehavior="false"/>


                        </ul>
                    </div>

                   
                </div>
                
                    
                <div class="card-body collapse in">
                    <div class="card-block">

                        <div class="form-body">
                            
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title centrarCelda"><span class="text-bold-700">DATOS GENERALES</span></h4>
                                    
                                </div>
                                <div class="card-body collapse in">
                                    <div class="row">

                                          <div class="col-md-12">

                                            

                                            <div class="row">
                                                    <asp:UpdatePanel ID="categ" runat="server">
                                                    <ContentTemplate>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Área de formación profesional</label>
                                                        <asp:DropDownList runat="server" ID="area" CssClass="select2 form-control" DataSourceID="Dsareas" DataTextField="area"  AutoPostBack="true" DataValueField="idarea" Style="width: 100%" OnDataBound="area_DataBound">                                                            
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="Dsareas" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                            SelectCommand="SELECT idarea, area from area order by area" ></asp:SqlDataSource>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Especialidad</label>
                                                        <asp:DropDownList runat="server" ID="especialidad" CssClass="select2 form-control" DataSourceID="Dsespecialidades" DataTextField="especialidad" DataValueField="idespecialidad" AutoPostBack="false"></asp:DropDownList>
                                                                <asp:SqlDataSource ID="Dsespecialidades" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idespecialidad, especialidad FROM especialidad  WHERE idarea =@idcat ORDER BY especialidad">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="area" Name="idcat" PropertyName="SelectedValue" />

                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>

                                                    </div>
                                                </div>


                                                        <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Nombre del curso</label>
                                                        <asp:TextBox ID="TextBox2" CssClass="form-control text-uppercase" placeholder="" name="cotitular" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>    

                                                </ContentTemplate>
                                                </asp:UpdatePanel>                                     

                                            </div>

                                        </div>

                                    </div>


                                    <div class="row">

                                          <div class="col-md-12">
                                                                                          
                                              <div class="row">
                                                  
                                                  <div class="col-md-4">
                                                      <div class="form-group">
                                                          <label class="text-bold-600">Instructor</label>
                                                          <asp:DropDownList runat="server" ID="instructor" CssClass="select2 form-control" DataSourceID="Dsinstructores" DataTextField="nombre" DataValueField="idinstructor" Style="width: 100%" >                                                            
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="Dsinstructores" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                            SelectCommand="select idinstructor, nombre
from instructor
where idsucursal=1
order by nombre
" ></asp:SqlDataSource>

                                                      </div>
                                                  </div>
                                                  <div class="col-md-4">
                                                      <div class="form-group">
                                                          <label class="text-bold-600">Lugar de Aplicación</label>
                                                          <asp:DropDownList runat="server" ID="instalacion" CssClass="select2 form-control" DataSourceID="Dsinstalaciones" DataTextField="nombre" DataValueField="idinstalacion" Style="width: 100%" AutoPostBack="false"></asp:DropDownList>
                                                                <asp:SqlDataSource ID="Dsinstalaciones" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idinstalacion, nombre FROM instalacion  WHERE idsucursal=1 ORDER BY nombre">                                                                   
                                                                </asp:SqlDataSource>

                                                      </div>
                                                  </div>
                                                  <div class="col-md-2">
                                                      <div class="form-group">
                                                          <label class="text-bold-600">Tipo de Curso</label>
                                                           <asp:DropDownList runat="server" ID="tipocurso" CssClass="select2 form-control" DataSourceID="Dstipocurso" DataTextField="tipocurso" DataValueField="idtipocurso" Style="width: 100%" >                                                            
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="Dstipocurso" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                            SelectCommand="SELECT idtipocurso, tipocurso from tipocurso order by tipocurso" ></asp:SqlDataSource>
                                                      </div>
                                                  </div>


                                              </div>
                                                                                                                                         
                                        </div>

                                    </div>
                                </div>
                                
                            </div>


                             <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title centrarCelda"><span class="text-bold-700">HORARIO / COSTOS</span></h4>
                                    
                                </div>
                                <div class="card-body collapse in">
                                   
                                    <div class="row">

                                          <div class="col-md-12">

                                         
                                            <div class="row">

                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Fecha de inicio</label>
                                                        <asp:TextBox ID="fechaini" CssClass="form-control pickadate text-uppercase" placeholder="Inicia en" name="fechaini" runat="server" Text=""></asp:TextBox>

                                                    </div>
                                                </div>

                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Fecha de Término</label>
                                                        <asp:TextBox ID="fechafin" CssClass="form-control pickadate text-uppercase" placeholder="Finaliza en" name="fechafin" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Días</label>
                                                        <asp:TextBox ID="TextBox3" type="number" CssClass="form-control" placeholder="Días" name="dias" runat="server"></asp:TextBox>
                                                        
                                                    </div>
                                                </div>

                                                

                                                
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Hora de inicio</label>
                                                        <asp:TextBox ID="horaini" CssClass="form-control pickatime-button" placeholder="Desde" name="horaini" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>


                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Hora de término</label>
                                                        <asp:TextBox ID="horafin" CssClass="form-control pickatime-button" placeholder="Hasta" name="horafin" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Total de Horas</label>
                                                        <asp:TextBox ID="horas" type="number" CssClass="form-control text-uppercase" placeholder="Horas" name="cotitular" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                                


                                            </div>



                                        </div>

                                    </div>
                                    <div class="row">


                                        


                                    </div>
                                     
                                    <div class="row">

                                        <div class="col-md-12">

                                            <div class="row">

                                                <div class="col-md-6">


                                                    <label class="text-bold-600">Fechas de impartición</label><br />
                                                    <div class="col-md-12">
                                                        <div class="form-group">


                                                            
                                                                <button type="button" id="nuevo" runat="server" onclick="abrirModal(0,'',1)" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                                    <i class="ft-file"></i>Agregar fecha 
                                                                </button>
                                                            <br />

                                                            <br />
                                                            <asp:GridView runat="server" ID="gridFechas" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration"
                                                                AutoGenerateColumns="False" DataSourceID="Dslistadofechas"
                                                                AlternatingRowStyle-BackColor="#F5F7FA">
                                                                <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                                                <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />

                                                                <Columns>
                                                                    <asp:BoundField DataField="fecha" HeaderText="Fecha" ItemStyle-Width="80px" ControlStyle-CssClass="centrarCelda" />
                                                                    <asp:BoundField DataField="horario" HeaderText="Horario" ItemStyle-Width="300px" ControlStyle-CssClass="centrarCelda" />
                                                                    <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="60px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                                        <ItemTemplate>

                                                                            <button type="button" id="editar" onclick="abrirModal(<%# Eval("idfecha")%>)" class="btn btn-icon btn-danger mr-1 btn-sm"
                                                                                data-toggle="tooltip" data-original-title="Eliminar">
                                                                                <i class="ft-edit"></i>
                                                                            </button>

                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>

                                                            </asp:GridView>

                                                            <asp:SqlDataSource ID="Dslistadofechas" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" ProviderName="MySql.Data.MySqlClient" SelectCommand="select idfecha, cast(fecha as char)as fecha, cast(TIME_FORMAT(horaini, '%h:%i %p')as char)as horaini, cast(TIME_FORMAT(horafin, '%h:%i %p')as char)as horafin, concat(cast(TIME_FORMAT(horaini, '%h:%i %p')as char),' - ', cast(TIME_FORMAT(horafin, '%h:%i %p')as char)) as horario
                            from fechascurso
                            where idcurso=1
                            and idsucursal=1
                               order by fecha"></asp:SqlDataSource>





                                                        </div>
                                                    </div>


                                                </div>

                                                <div class="col-md-6">

                                                    <label class="text-bold-600">Costo</label><br />
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <div class="form-group">

                                                                        <label class="text-bold-600">Módulo</label>
                                                                        <asp:TextBox ID="TextBox6" CssClass="form-control text-uppercase" placeholder="" name="cotitular" runat="server"></asp:TextBox>


                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <div class="form-group">

                                                                        <label class="text-bold-600">Por alumno</label>
                                                                        <asp:TextBox ID="TextBox17" CssClass="form-control text-uppercase" placeholder="" name="cotitular" runat="server"></asp:TextBox>


                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="row">
                                                                <div class="col-md-4">
                                                                    <div class="form-group">

                                                                        <label class="text-bold-600">Pago x hora al Instructor</label>
                                                                        <asp:TextBox ID="TextBox18" CssClass="form-control text-uppercase" placeholder="" name="cotitular" runat="server"></asp:TextBox>


                                                                    </div>
                                                                </div>
                                                            </div>



                                                        </div>
                                                    </div>

                                                </div>

                                            </div>

                                            <div class="row">

                                                <div class="col-md-12">

                                                    
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
        </div>
    </div>
    
                                               
   
            <div class="modal fade" id="bootstrap" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title" id="myModalLabel35">Fecha de Curso</h3>
                        </div>


                        <div class="modal-body">
                            
                                    <div class="row">


                                         <div class="col-md-9">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Fecha</label>
                                                        <asp:TextBox ID="TextBox1" CssClass="form-control pickadate text-uppercase" placeholder="Fecha" name="fechafin" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                        </div>        
                                        <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Hora de inicio</label>
                                                        <asp:TextBox ID="TextBox4" CssClass="form-control pickatime-button" placeholder="Desde" name="horaini" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>


                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Hora de término</label>
                                                        <asp:TextBox ID="TextBox5" CssClass="form-control pickatime-button" placeholder="Hasta" name="horafin" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                    </div>

                                                                  
                        </div>

                        <div class="modal-footer">
                        
                        
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

<asp:Content ID="Content6" ContentPlaceHolderID="pie" runat="server">
    <div class="form-inline" runat="server">
        <button class="btn btn-primary" onclick="valida()" type="button" id="Button1">
            <i class="fa fa-check-square-o"></i>Guardar
        </button>

        <button type="button" class="btn btn-danger mr-1" onclick="regresar()" id="cancelar">
            <i class="ft-x"></i>Volver
        </button>
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

    <script src="/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.date.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.time.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/legacy.js" type="text/javascript"></script>


    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/jquery.raty.js" type="text/javascript"></script>






    
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
        $("#catcursos").addClass("active");
        $(document).ready(function () {
            $('textarea').keypress(function (event) {
                if (event.keyCode == 13) {
                    event.preventDefault();
                }
            });
        });

         function regresar() {
           
             swal({
                title: "Los datos no guardados se perderán, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Si",
                cancelButtonText: "No",
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

        function seleccionar(id,ids) {
          mostrarLoading();
          $("*[id$='idC']").val(id);
          $("*[id$='idS']").val(ids);
          $("*[id$='bnombre']").val('');
            cerrarModal();
           
        }


        function calcMontos() {
          
            var prestamo = $("*[id$='prestamo']").val();
            var aval = parseFloat($("*[id$='porcavaluo']").val());
            var venta = parseFloat($("*[id$='porcventa']").val());
            var avaluof = 0;
            var ventaf = 0;
           
            if (prestamo != '') {

                prestamo = parseFloat(prestamo);                
                avaluof = prestamo * (1 + aval / 100);
                
                ventaf = prestamo * (1 + venta / 100);

                $("*[id$='reem']").val(avaluof.toFixed(2));
                $("*[id$='precio']").val(ventaf.toFixed(2));

            }

            
        }

        function dialogCliente() {
            
        }

        function dialogArticulo() {
            
        }
        function showpreview(input) {

            if (input.files && input.files[0]) {

                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#fotop').attr('src', e.target.result);
                    $("*[id$='fotopa']").attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }

        }

        function showpreviewart(input) {

            if (input.files && input.files[0]) {

                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#fotoarticulo').attr('src', e.target.result);
                    $("*[id$='fotoarticulo']").attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }

        }

        function valida() {

            var clave = $("*[id$='clave']").val();
            var nombre = $("*[id$='nombre']").val();
            var calle = $("*[id$='calle']").val();
            var colonia = $("*[id$='colonia']").val();
            var localidad = $("*[id$='localidad']").val();
            var celular = $("*[id$='celular']").val();

            var descripcion = $("*[id$='descripcion']").val();
            var prestamo = $("*[id$='prestamo']").val();

            if (clave == '') {
                swal("Atención", "Ingrese la clave del cliente", "warning");
                return false;
            }
            if (nombre == '') {
                swal("Atención", "Ingrese el nombre completo del cliente", "warning");
                return false;
            }
            if (calle == '') {
                swal("Atención", "Ingrese el domicilio del cliente", "warning");
                return false;
            }
            if (colonia == '') {
                swal("Atención", "Ingrese la colonia del domicilio", "warning");
                return false;
            }
            if (localidad == '') {
                swal("Atención", "Ingrese la localidad del domicilio", "warning");
                return false;
            }
            if (celular == '') {
                swal("Atención", "Ingrese el número celular del cliente", "warning");
                return false;
            }
            
            if (descripcion == '') {
                swal("Atención", "Ingrese la descripción del artículo", "warning");
                return false;
            }
            if (prestamo == '' || prestamo=='0') {
                swal("Atención", "Ingrese la cantidad del préstamo", "warning");
                return false;
            }

            
            swal({
                title: "Se generará el préstamo con los datos indicados, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Si",
                cancelButtonText: "No",
                closeOnConfirm: true,
                closeOnCancel: true
            },
            function (isConfirm) {
                if (isConfirm) {
                    mostrarLoading();                    
                    $('#<%= bguardar.ClientID %>').click();                
                } 
            });

       }


        $('#audience-list-scroll, #goal-list-scroll').perfectScrollbar({
            wheelPropagation: true
        });

        function abrirModal() {            
            //$(".modal-backdrop").remove();

            $("*[id$='bnombre']").focus();
            $("#divResultados").hide();
            $("#bootstrap").modal('show');

                      
        }

        $('#bootstrap').on('shown.bs.modal', function () {
            $("*[id$='bnombre']").val('');
            $("*[id$='bnombre']").focus();
        })

        function cerrarModal() {
            $("#bootstrap").modal('hide');
        }

        function registroManual() {
            $("*[id$='idC']").val(0);
            $("#bootstrap").modal('hide');
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
           
                $("*[id$='prestamo']").ForceNumericOnly();
            
                //$("*[id$='volver']").jqBootstrapValidation("destroy");
               // $("*[id$='cp']").ForceNumericOnly(); 
                //$("*[id$='seccion']").ForceNumericOnly();
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
               // loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
               // loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                loadJS("/app-assets/js/scripts/extensions/rating.js");
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

                loadJS("/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js");
                loadJS("/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.date.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.time.js");
                loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");

                $('.pickadate').pickadate({
                    format: 'yyyy-mm-dd',
                    formatSubmit: 'yyyy-mm-dd',
                    monthsFull: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                    weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab'],
                    today: 'Hoy',
                    clear: 'Limpiar',
                });

                $('.pickatime-button').pickatime({
                    format: ' HH:i ',
                    formatLabel: 'HH:i ',
                    clear: '',
                });
                

        }
    </script>
</asp:Content>