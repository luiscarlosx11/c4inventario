<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="agenda.aspx.cs" Inherits="elecion.promocion.agenda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/calendars/fullcalendar.min.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/calendars/fullcalendar.css">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Agenda</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Campaña</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Agenda</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
<div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Eventos</h4>
                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                    <div class="heading-elements">
                        <ul class="list-inline mb-0">
                            <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                            <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                            <li><a data-action="close"><i class="ft-x"></i></a></li>
                        </ul>
                    </div>
                </div>
                <div class="card-block card-dashboard">
                                <p class="card-text">

                                    <asp:Button runat="server" ID="Beditar" OnClick="editaRegistro" Style="display: none" />                                    
                                    <asp:HiddenField runat="server" ID="idP" />
                                    <asp:Button runat="server" ID="Button1" OnClick="editaRegistro" Style="display: none" />
                                    <asp:Button runat="server" ID="Bnuevo" OnClick="nuevoRegistro" Style="display: none" />
                                    <button type="button" id="nuevo" onclick="nuevoRegistro();" class="btn btn-icon btn-success mr-1" data-toggle="modal">
                                        <i class="ft-file"></i>Nuevo Registro 
                                    </button>
                                </p>

                               
                            </div>
                <div class="card-body collapse in">
                    <div class="card-block">
                        <p class="card-text"></p>
                        <div id='fc-basic-views'></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script>
        $(document).prop('title', 'PLACEL - Agenda');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#agenda").addClass("active");
        var initialLangCode = 'es';
        var dataEvent;

        $(document).ready(function () {


            $('#fc-basic-views').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,basicWeek,basicDay'
                },               
                defaultDate: '2017-09-11',                
                lang: initialLangCode,
                navLinks: true, // can click day/week names to navigate views
                editable: true,
                eventLimit: true, // allow "more" link when too many events
                events: dataEvent,
                eventClick: function (event) {
                    // opens events in a popup window
                    //window.open(event.url, 'gcalevent', 'width=700,height=600');
                     $("*[id$='idP']").val(event.id);
                    mostrarLoading();
                    $('#<%= Beditar.ClientID %>').click();
                    return false;
                },

            });
         

        });


        function nuevoRegistro() {
            mostrarLoading();
           $('#<%= Bnuevo.ClientID %>').click();
        }

     </script>
    

<script src="/app-assets/vendors/js/extensions/moment.min.js" type="text/javascript"></script>
<script src="/app-assets/vendors/js/extensions/fullcalendar.min.js" type="text/javascript"></script>
<script src="/app-assets/vendors/js/extensions/lang-all.js" type="text/javascript"></script>

    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN STACK JS-->

    <!-- END STACK JS-->
    <!-- BEGIN PAGE LEVEL JS-->
<script src="/app-assets/js/scripts/extensions/fullcalendar.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
</asp:Content>
