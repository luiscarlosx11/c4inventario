<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false"
     CodeBehind="calendario.aspx.cs"  Inherits="elecion.catalogos.ciclo.calendario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

        <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css"/>

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/daterange/daterangepicker.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/datetime/bootstrap-datetimepicker.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/pickadate/pickadate.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/pickers/daterange/daterange.css"/>

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/calendars/fullcalendar.min.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/calendars/fullcalendar.css"/>


    <style>

body { padding-right: 0 !important }
    </style>
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
 <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    
        

    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">CALENDARIO</h4>
                            <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                            <div class="heading-elements">
                                <ul class="list-inline mb-0">
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

                                                    <asp:HiddenField runat="server" ID="idP" />
                                                    <asp:HiddenField runat="server" ID="limite" Value="48" />
                                                    <asp:HiddenField runat="server" ID="idS" />
                                                    <asp:HiddenField runat="server" ID="idF" />
   
                                                    <button type="button" id="nuevo" onclick="nuevoRegistro();" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                        <i class="ft-file"></i>Nuevo Registro 
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>


                            <div class="row" id="tbhorario">
                                <div class="col-md-12">


                                    <div class="row">

                                        <div class="col-md-12">
                                            <div class="form-group">

                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <asp:Button runat="server" ID="Bfechas" OnClick="getCalendario" Style="display: none" UseSubmitBehavior="false" />
                                                        <asp:Button runat="server" ID="guardarFechas" OnClick="generaFechasCurso" Style="display: none" CausesValidation="false" UseSubmitBehavior="false" />
                                                        <asp:Button runat="server" ID="borrarFechas" OnClick="borraFechasCurso" Style="display: none" CausesValidation="false" UseSubmitBehavior="false" />
                                                        <div id='fc-basic-views'></div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>

                                            </div>



                                        </div>
                                    </div>



                                </div>
                            </div>


                        </div>



                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>


       <div class="modal fade" id="wfechas"  role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title">Fechas Inhábiles</h3>
                        </div>


                        <div class="modal-body">
                            
                                    <div class="row">


                                         <div class="col-md-9">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Desde</label>
                                                        <asp:TextBox ID="fechaini" CssClass="form-control pickadate text-uppercase" placeholder="Fecha" name="fechafin" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                         <div class="col-md-9">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Hasta</label>
                                                        <asp:TextBox ID="fechafin" CssClass="form-control pickadate text-uppercase" placeholder="Fecha" name="fechafin" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                        </div>        
                                       

                                                                  
                        </div>

                        <div class="modal-footer">
                        
                        

				        <button class="btn btn-primary" onclick="validaFechas()" type="button" data-backdrop="false" id="bguardaFecha"> 
	                        <i class="fa fa-check-square-o"></i> Aceptar
	                     </button>
                                                                 
	                     <button type="button" class="btn btn-danger mr-1" data-dismiss="modal">
	                        <i class="ft-x"></i> Cerrar
	                     </button>
			        </div>


                    </div>


                </div>

            </div>


    
</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.date.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.time.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/legacy.js" type="text/javascript"></script>


    <script src="/app-assets/vendors/js/extensions/moment.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/fullcalendar.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/lang-all.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/locale-all.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/forms/extended/form-inputmask.min.js" type="text/javascript"></script>

  

    <script>
        //$(document).prop('title', 'PLACEL - Promovidos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#calendario").addClass("active");
        var walert = 0;
        var fecha = '';
        
        var initialLangCode = 'es';
        var dataEvent;

          $(document).ready(function () {
              $('#<%= Bfechas.ClientID %>').click();
         });

                
        $('#fc-basic-views').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: ''
            },
            defaultDate: '2017-09-11',
            locale: 'es',
            events: dataEvent,                   
                    eventClick: function(event) {

                        swal({
                            title: "Se eliminará esta fecha, ¿Desea continuar?",
                            text: "",
                            type: "warning",
                            showCancelButton: true,
                            confirmButtonColor: '#DD6B55',
                            confirmButtonText: 'Si',
                            cancelButtonText: "No"
                        }).then((result) => {
                            if (result.value) {
                                mostrarLoading();
                                $("*[id$='idP']").val(event.id);
                                 $('#<%= borrarFechas.ClientID %>').click();

                            }
                        }); 
                       

                    },
            navLinks: false, // can click day/week names to navigate views
            editable: false,
            eventLimit: false,
            height: 700

        });

        $('#fc-basic-views').fullCalendar('today');


        $('#wfechas').on('shown.bs.modal', function () {
            //alert($("*[id$='idF']").val());
            if ($("*[id$='idF']").val() == "0")
                $("*[id$='fagenda']").focus();

        })


        function isValidDate(dateString) {
            var regEx = /^\d{4}-\d{2}-\d{2}$/;
            if (!dateString.match(regEx)) return false;  // Invalid format
            var d = new Date(dateString);
            if (Number.isNaN(d.getTime())) return false; // Invalid date
            return d.toISOString().slice(0, 10) === dateString;

        }

        function valida() {

            var clave = $("*[id$='clave']").val();
            var nombre = $("*[id$='nombre']").val();
            var fechaini = $("*[id$='fechaini']").val();
            var fechafin = $("*[id$='fechafin']").val(); 
            var dias = $("*[id$='dias']").val(); 
            var horaini = $("*[id$='horaini']").val();                        
            var horafin = $("*[id$='horafin']").val(); 
            var horas = $("*[id$='horas']").val(); 
            var diascurso = $("*[id$='hdias']").val();

            var costomodulo = $("*[id$='costomodulo']").val(); 
            var costoalumno = $("*[id$='costoalumno']").val(); 
            var pagohora = $("*[id$='pagohora']").val();

            var instalacion = $("*[id$='instalacion']").val();
            var instalacionext = $("*[id$='instalacionext']").val();
            var instalaciondomext = $("*[id$='instalaciondomext']").val();
            var alumnosminimo = $("*[id$='alumnosminimo']").val();
            var fechalimite = $("*[id$='fechalimite']").val();
            
            walert = 1;

            if (clave == '') {                
                alerta('Atención', 'Ingrese la clave del curso', 'warning', $("*[id$='clave']"));
                return false;                
            }

            if (nombre == '') {                
                alerta('Atención', 'Ingrese el nombre del curso', 'warning', $("*[id$='nombre']"));
                return false;                
            }

            
            if (alumnosminimo == '' || alumnosminimo == '0') {                
                alerta('Atención', 'Ingrese la cantidad mínima necesaria de alumnos inscritos', 'warning', $("*[id$='alumnosminimo']"));
                return false;                
            }

            if (instalacion == '9999' && instalacionext == '') {                
                alerta('Atención', 'Ingrese el nombre de la instalación extramuros', 'warning', $("*[id$='instalacionext']"));
                return false;                
            }

            if (instalacion == '9999' && instalaciondomext == '') {                
                alerta('Atención', 'Ingrese la dirección de la instalación extramuros', 'warning', $("*[id$='instalaciondomext']"));
                return false;                
            }

            if (costomodulo == '' || costomodulo == '0') {                
                alerta('Atención', 'Ingrese el costo por módulo del curso', 'warning', $("*[id$='costomodulo']"));
                return false;                
            }

            if (costoalumno == '' || costoalumno == '0') {                
                alerta('Atención', 'Ingrese el costo por alumno del curso', 'warning', $("*[id$='costoalumno']"));
                return false;                
            }

            if (pagohora == '' || pagohora == '0') {                
                alerta('Atención', 'Ingrese el pago por hora del curso', 'warning', $("*[id$='pagohora']"));
                return false;                
            }

            if (fechalimite == '') {
                alerta('Atención', 'Ingrese la fecha límite de inscripción al curso', 'warning', $("*[id$='fechalimite']"));
                return false;
            }

            if (fechaini == '') {
                alerta('Atención', 'Ingrese la fecha de inicio del curso', 'warning', $("*[id$='fechaini']"));
                return false;
            }

            if (fechafin == '') {
                alerta('Atención', 'Ingrese la fecha de término del curso', 'warning', $("*[id$='fechafin']"));
                return false;
            }
                       
            if (dias == '' || dias=='0') {
                alerta('Atención', 'Ingrese la duración en días del curso', 'warning', $("*[id$='dias']"));
                return false;
            }

            if (horaini == '') {
                alerta('Atención', 'Ingrese el horario (hora de inicio) del curso', 'warning', $("*[id$='horaini']"));
                return false;
            }


            if (horafin == '') {
                alerta('Atención', 'Ingrese el horario (hora de término) del curso', 'warning', $("*[id$='horafin']"));
                return false;
            }

            if (diascurso == '') {
                alerta('Atención', 'Indique los días de la semana en los cuales se impartirá el curso', 'warning', $("*[id$='hdias']"));
                return false;
            }


            if (horas == '' || horas =='0') {
                alerta('Atención', 'Ingrese la duración en horas del curso', 'warning', $("*[id$='horas']"));
                return false;
            }

                              
            walert = 0;
            //$('#bootstrap').modal('hide');
            mostrarLoading();
            
         
                       
                                           
        }


         function validaFechas() {                   
            var fechaini = $("*[id$='fechaini']").val();              
            var fechafin = $("*[id$='fechafin']").val();                        
           
            
            walert = 1;
            

            if (fechaini == '') {
                alerta('Atención', 'Ingrese la fecha de inicio a marcar como inhábil', 'warning', $("*[id$='fechaini']"));
                return false;
             }

             if (fechafin == '') {
                alerta('Atención', 'Ingrese la fecha de fin a marcar como inhábil', 'warning', $("*[id$='fechafin']"));
                return false;
            }
                                  
                              
             walert = 0;
             $('#<%= guardarFechas.ClientID %>').click();
            //$('#wfechas').modal('hide');
            mostrarLoading();
            
          
                       
                                           
        }

        function eliminaFechas() {


            swal({
                title: "Se realizará la enajenación sobre esta boleta, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#DD6B55',
                confirmButtonText: 'Si',
                cancelButtonText: "No"
            }).then((result) => {
                if (result.value) {
                    mostrarLoading();
                  
                  }
                }) 
         
        }


        function calendario() {


            var fechaini = $("*[id$='fechaini']").val();
            var fechafin = $("*[id$='fechafin']").val();             
            var horaini = $("*[id$='horaini']").val();                        
            var horafin = $("*[id$='horafin']").val(); 
            var diascurso = $("*[id$='hdias']").val();

            if (fechaini == '' || fechafin == ''|| horaini == '' || horafin == '' || diascurso == '') {                
                return false;
            }
            
           mostrarLoading();
           
                     
        }

        function abrirModal(idcurso, idsucursal, estatus) {
                        
           mostrarLoading();
            $("*[id$='idP']").val(idcurso);
            $("*[id$='idS']").val(idsucursal);
            $("#bootstrap").modal('show');
                                              
        }

        function abrirModalFechas() {

            //$("*[id$='fagenda']").focus();
            $("*[id$='idF']").val(0);
            $("*[id$='horanini']").val($("*[id$='horaini']").val());
            $("*[id$='horanfin']").val($("*[id$='horafin']").val());
            $("#bguardaFecha").show();
            $("#bborraFecha").hide();
            //$("#divResultados").hide(); 

            $("*[id$='fagenda']").removeAttr('disabled');
            $("*[id$='horanini']").removeAttr('disabled');
            $("*[id$='horanfin']").removeAttr('disabled');
            
            $("#wfechas").modal('show');
        }

    
        function editarRegistro(id, ids) {
            
            mostrarLoading();
            $("*[id$='idP']").val(id);
            $("*[id$='idS']").val(ids);
          
        }

        function nuevoRegistro() {
           
            $("*[id$='fechaini']").val('');
            $("*[id$='fechafin']").val('');
            $("#wfechas").modal('show');                     
        }

        $('#bootstrap').on('shown.bs.modal', function () {
            $("#fc-basic-views").fullCalendar('render');
        });        


        function ver() {            
            $("*[id$='hdias']").val($("#algo").val());           
        }

        function dar() {            
            var valores = $("*[id$='hdias']").val();           
            var arreglo = valores.split(","); 
            $('#algo').val(arreglo);
            $('#algo').trigger('change');         
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
                loadJS("/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js");
                loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                

                loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");

                loadJS("/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js");
                loadJS("/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.date.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.time.js");
                loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");
            
                loadJS("/app-assets/vendors/js/extensions/moment.min.js");
                loadJS("/app-assets/vendors/js/extensions/fullcalendar.min.js");
                loadJS("/app-assets/vendors/js/extensions/lang-all.js");

                loadJS("/app-assets/vendors/js/extensions/locale-all.js");
                loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.min.js");
                
                loadJS("/app-assets/js/scripts/pages/dashboard-analytics.js");

         
            
                walert = 0;
                fecha = $("*[id$='fechaini']").val();                
                $('#bootstrap').on('shown.bs.modal', function () {
                    $("*[id$='clave']").focus();
                });


             $(document).ready(function () {
                $('.tooltips').tooltip();
            });

          
            //Phone mask
                $('.phone-inputmask').inputmask("(999) 999-9999");

                $('.email-inputmask').inputmask({
                    mask: "*{1,20}[.*{1,20}][.*{1,20}][.*{1,20}]@*{1,20}[*{2,6}][*{1,2}].*{1,}[.*{2,6}][.*{1,2}]",
                    greedy: false,
                    onBeforePaste: function (pastedValue, opts) {
                        pastedValue = pastedValue.toLowerCase();
                        return pastedValue.replace("mailto:", "");
                    },
                    definitions: {
                        '*': {
                            validator: "[0-9A-Za-z!#$%&'*+/=?^_`{|}~/-]",
                            cardinality: 1,
                            casing: "lower"
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



            // Date dd/mm/yyyy
            
            
                $('#fc-basic-views').fullCalendar({
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right:''
                    },
                    defaultDate: '2017-09-11',
                    defaultView: 'month',
                    duration: { days: 15 },
                    locale: 'es',
                    events: dataEvent,                   
                    eventClick: function(event) {

                        swal({
                            title: "Se eliminará esta fecha, ¿Desea continuar?",
                            text: "",
                            type: "warning",
                            showCancelButton: true,
                            confirmButtonColor: '#DD6B55',
                            confirmButtonText: 'Si',
                            cancelButtonText: "No"
                        }).then((result) => {
                            if (result.value) {
                                mostrarLoading();
                                $("*[id$='idP']").val(event.id);
                                 $('#<%= borrarFechas.ClientID %>').click();

                            }
                        }); 
                       

                    },

                    navLinks: false, // can click day/week names to navigate views
                    editable: false,
                    
                    height: 700
                });

                $('#fc-basic-views').fullCalendar('today');

            


        }
    </script>
</asp:Content>
