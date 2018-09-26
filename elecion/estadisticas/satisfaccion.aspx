<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="satisfaccion.aspx.cs" Inherits="elecion.satisfaccion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var dataCalif;
        var datosBar;      
    </script> 

     <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/charts/jquery-jvectormap-2.0.3.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/charts/morris.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/unslider.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/weather-icons/climacons.min.css">
     <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/raty/jquery.raty.css" />
    <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Estadísticas de Satisfacción</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Inicio</a>
                </li>

              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
     <div class="row">
           
                <div class="col-md-6">
                    <div class="card no-border">
                        <div class="card-body">
                            <div class="card-block">
                                <div class="media">
                                    <div class="media-body">
                                        <h1 class="display-4"><asp:Label runat="server" ID="ltotalGral"></asp:Label></h1>
                                        <span class="text-muted">promedio histórico</span>
                                    </div>
                                    <div class="media-right media-middle">
                                        <i class="icon-star font-large-2 blue-grey lighten-3"></i>
                                    </div>
                                </div>
                            </div>
                            <div id="sp-line-total-cost"></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card no-border">
                        <div class="card-body">
                            <div class="card-block">
                                <div class="media">
                                    <div class="media-body">
                                        <h1 class="display-4"><asp:Label runat="server" ID="ltotalMes"></asp:Label></h1>
                                        <span class="text-muted">en el último mes</span>
                                    </div>
                                    <div class="media-right media-middle">
                                        <i class="icon-star font-large-2 blue-grey lighten-3"></i>
                                    </div>
                                </div>
                            </div>
                            <div id="sp-line-total-cost2"></div>
                        </div>
                    </div>
                </div>
          
        </div>

        
    <!--/ Audience by country  & users visit -->
    <div class="row">
                    <div class="card">
                        <div class="card-header no-border-bottom">
                            <h4 class="card-title">Satisfacción por Área</h4>
                            <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                            <div class="heading-elements">
                                <ul class="list-inline mb-0">
                                    
                                </ul>
                            </div>
                        </div>
                        <div class="card-body collapse in">
                            
                    <asp:DataList ID="DataListArea" runat="server" DataSourceID="DSCalifArea" RepeatLayout = "Flow" RepeatDirection="Horizontal">
                    <ItemTemplate>
                            
                       <div class="col-xl-3 col-md-6 col-xs-12">
                            <div class="card box-shadow-2 height-350">
                                <div class="text-xs-center">
                                    <div class="card-block">
                                        <img src="../../../app-assets/images/portrait/medium/avatar-m-2.png" class="rounded-circle  height-150" alt="Card image">
                                    </div>
                                    <div class="card-block">
                                        <h4 class="card-title"><%# Eval("area")%></h4>
                                        <h6 class="card-subtitle text-muted"><%# Eval("idcalificacion")%></h6>
                                    </div>
                                    <div class="text-xs-center">                                    
						              <section id="star-ratings">
                                              <!--<div id='' class="estrellas"></div>-->
                                            <div id='interesa_<%#Eval("idarea") %>' class="estrellas2"></div>
                                            <input type="hidden" id='ninteresa_<%#Eval("idarea") %>' value="<%#Eval("idcalificacion") %>"/>
                                       </section> 
                                    </div>
                                </div>
                            </div>
                        </div>                                             

                         </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="DSCalifArea" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="
                                        SELECT a.IDAREA, a.AREA,
                                        (
	                                        select coalesce(round(AVG(t.idcalificacion),1),0)
                                            from ticket t
                                            left join usuario u on u.IDUSUARIO = t.ATIENDE
                                            where u.idarea  = a.IDAREA 
                                            
   
                                        )as idcalificacion
                                        from area a    
                                        where a.ATENCION=1
                                        order by a.AREA">

                        </asp:SqlDataSource>
 
                    
                        </div>
                    </div>
    </div>


        <div class="row">
                    <div class="card">
                        <div class="card-header no-border-bottom">
                            <h4 class="card-title">Satisfacción por Empleado</h4>
                            <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                            <div class="heading-elements">
                                <ul class="list-inline mb-0">
                                    
                                </ul>
                            </div>
                        </div>
                        <div class="card-body collapse in">
                            <div class="card-block">
                                <asp:DataList ID="dlCustomers" runat="server" DataSourceID="DSTickets" RepeatLayout = "Flow" RepeatDirection="Horizontal">
                                <ItemTemplate>
                            
                                   <div class="col-xl-3 col-md-6 col-xs-12">
                                        <div class="card box-shadow-2 height-400">
                                            <div class="text-xs-center">
                                                <div class="card-block">
                                                    <img src="../../../app-assets/images/portrait/medium/avatar-m-1.png" class="rounded-circle  height-150" alt="Card image">
                                                </div>
                                                <div class="card-block">
                                                    <h4 class="card-title"><%# Eval("nombre")%></h4>
                                                    <h6 class="card-subtitle text-muted"><%# Eval("area")%></h6><br />
                                                    <h6 class="card-subtitle text-muted"><%# Eval("idcalificacion")%></h6>
                                                </div>
                                                <div class="text-xs-center">                                    
						                          <section id="star-ratings">
                                                          <!--<div id='' class="estrellas"></div>-->
                                                        <div id='interes_<%#Eval("idusuario") %>' class="estrellas"></div>
                                                        <input type="hidden" id='ninteres_<%#Eval("idusuario") %>' value="<%#Eval("idcalificacion") %>"/>
                                                   </section> 
                                                </div>
                                            </div>
                                        </div>
                                    </div>                                             

                                     </ItemTemplate>
                                    </asp:DataList>
                                    <asp:SqlDataSource ID="DSTickets" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="
                                                    SELECT u.IDUSUARIO, (CONCAT(COALESCE(u.nombre,''),' ',COALESCE(u.apaterno,''),' ',COALESCE(u.amaterno,'')))as nombre, 
                                                    (
	                                                    select coalesce(round(AVG(t.idcalificacion),1),0)
                                                        from ticket t
                                                        where t.atiende  = u.IDUSUARIO
   
                                                    )as idcalificacion, a.area
                                                    from usuario u
                                                    left join area a on a.IDAREA = u.IDAREA
                                                    where u.idtipousuario=4
                                                    order by u.IDUSUARIO">

                                    </asp:SqlDataSource>
 
                </div>
                        </div>
                    </div>
            </div>
    
<!--/ Analytics spakline & chartjs  -->



<!-- Audience by country & users visit-->
<div class="row">
    <div class="col-xl-12 col-lg-12">
        <div class="card">
            <div class="card-header no-border">
                <h4 class="card-title">A través del tiempo</h4>
                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                        
                    </ul>
                </div>
            </div>
            <div class="card-body collapse in">
                <div class="card-block">
                    <canvas id="line-chart" height="500"></canvas>
                </div>
            </div>
        </div>
    </div>
    
</div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
     <script src="/app-assets/vendors/js/extensions/jquery.knob.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/extensions/knob.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/raphael-min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/morris.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/jvector/jquery-jvectormap-2.0.3.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/jvector/jquery-jvectormap-world-mill.js" type="text/javascript"></script>
    <script src="/app-assets/data/jvector/visitor-data.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/chart.min.js" type="text/javascript"></script>    
    <script src="/app-assets/vendors/js/charts/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/unslider-min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/pages/dashboard-analytics.js" type="text/javascript"></script>


    <link rel="stylesheet" type="text/css" href="/app-assets/css/core/colors/palette-climacon.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/simple-line-icons/style.min.css" />
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/jquery.raty.js" type="text/javascript"></script>

    
    <script>
        $(".nav-item>ul>li.active").removeClass("active");
        $("#esatisfaccion").addClass("active");
        // Column chart
        // ------------------------------
        $(window).on("load", function () {

            $.fn.raty.defaults.path = '/app-assets/images/raty/';

            $('.estrellas').each(function () {

                var ide = ($(this).attr('id')).split('_');

                $(this).raty();
                $(this).raty('score', $("#ninteres_" + ide[1]).val());
                $(this).raty('readOnly', true);

            });

            $('.estrellas2').each(function () {

                var ide = ($(this).attr('id')).split('_');

                $(this).raty();
                $(this).raty('score', $("#ninteresa_" + ide[1]).val());
                $(this).raty('readOnly', true);

            });

            //Get the context of the Chart canvas element we want to select
            $("#sp-line-total-cost").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                type: 'line',
                width: '100%',
                height: '100px',
                lineColor: '#00A5A8',
                fillColor: '#00A5A8',
                spotColor: '',
                minSpotColor: '',
                maxSpotColor: '',
                highlightSpotColor: '',
                highlightLineColor: '',
                chartRangeMin: 0,
                chartRangeMax: 20,
            });

            $("#sp-line-total-cost2").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
                type: 'line',
                width: '100%',
                height: '100px',
                lineColor: '#FF4558',
                fillColor: '#FF4558',
                spotColor: '',
                minSpotColor: '',
                maxSpotColor: '',
                highlightSpotColor: '',
                highlightLineColor: '',
                chartRangeMin: 0,
                chartRangeMax: 20,
            });

            

            //Get the context of the Chart canvas element we want to select
            var ctx = $("#line-chart");

            // Chart Options
            var chartOptions = {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    position: 'bottom',
                },
                hover: {
                    mode: 'label'
                },
                scales: {
                    xAxes: [{
                        display: true,
                        gridLines: {
                            color: "#f3f3f3",
                            drawTicks: false,
                        },
                        scaleLabel: {
                            display: false,
                            labelString: ''
                        }
                    }],
                    yAxes: [{
                        display: true,
                        gridLines: {
                            color: "#f3f3f3",
                            drawTicks: false,
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Value'
                        }
                    }]
                },
                title: {
                    display: false,
                    text: 'Chart.js Line Chart - Legend'
                }
            };

            // Chart Data
            /*var chartData = {
                labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo"],
                datasets: [{
                    label: "Satisfacción ",
                    data: [4.9, 4.3, 3.9, 4.6, 3.8],
                    fill: false,
                    borderDash: [5, 5],
                    borderColor: "#00A5A8",
                    pointBorderColor: "#00A5A8",
                    pointBackgroundColor: "#FFF",
                    pointBorderWidth: 2,
                    pointHoverBorderWidth: 2,
                    pointRadius: 4,
                }]
            };*/

            var config = {
                type: 'line',

                // Chart Options
                options: chartOptions,

                data: dataCalif
            };

            // Create the chart
            var lineChart = new Chart(ctx, config);
        });
   </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
</asp:Content>
