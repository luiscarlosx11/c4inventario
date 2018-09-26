<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="general.aspx.cs" Inherits="elecion.general" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var dataClientes;
        var datosBar;      
    </script> 
    
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/charts/jquery-jvectormap-2.0.3.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/charts/morris.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/unslider.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/weather-icons/climacons.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Estadísticas Generales</h3>
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
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="row">
    <div class="col-lg-12 col-md-12 col-xs-12">
        <div class="card">
            <div class="card-header no-border-bottom">
                <h4 class="card-title">Panorama de Atención</h4>
                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                        <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                        <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                    </ul>
                </div>
            </div>
            <div class="card-body collapse in">
                <div class="card-block">
                   <div class="row">
                            <div class="col-xl-3 col-lg-6 col-xs-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="p-2 text-xs-center bg-primary bg-darken-2 media-left media-middle">
                                                <i class="icon-camera font-large-2 white"></i>
                                            </div>
                                            <div class="p-2 bg-primary white media-body">
                                                <h5>Atendidos</h5>
                                                <h5 class="text-bold-400"><asp:Label runat="server" ID="atendidos"></asp:Label></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                             <div class="col-xl-3 col-lg-6 col-xs-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="p-2 text-xs-center bg-success bg-darken-2 media-left media-middle">
                                                <i class="icon-basket-loaded font-large-2 white"></i>
                                            </div>
                                            <div class="p-2 bg-success white media-body">
                                                <h5>Activos</h5>
                                                <h5 class="text-bold-400"><asp:Label runat="server" ID="activos"></asp:Label></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-lg-6 col-xs-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="p-2 text-xs-center bg-danger bg-darken-2 media-left media-middle">
                                                <i class="icon-user font-large-2 white"></i>
                                            </div>
                                            <div class="p-2 bg-danger white media-body">
                                                <h5>Cancelados</h5>
                                                <h5 class="text-bold-400"><asp:Label runat="server" ID="cancelados"></asp:Label></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
        
                            <div class="col-xl-3 col-lg-6 col-xs-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="media">
                                            <div class="p-2 text-xs-center bg-warning bg-darken-2 media-left media-middle">
                                                <i class="icon-wallet font-large-2 white"></i>
                                            </div>
                                            <div class="p-2 bg-warning white media-body">
                                                <h5>Notas</h5>
                                                <h5 class="text-bold-400"><asp:Label runat="server" ID="notas"></asp:Label></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title"></h4>
                                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>                                    
                                </div>
                                <div class="card-body collapse in">
                                    <div class="card-block">
                                        <canvas id="column-chart" height="400"></canvas>
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
<!--/ Analytics spakline & chartjs  -->



<!-- Audience by country & users visit-->
<div class="row match-height">
    <div class="col-xl-6 col-lg-12">
        <div class="card">
            <div class="card-header no-border">
                <h4 class="card-title">Clientes más frecuentes</h4>
                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                        <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                    </ul>
                </div>
            </div>
            <div class="card-body collapse in">
                <div class="card-block">
                    <canvas id="simple-doughnut-chart" height="400"></canvas>
                </div>
            </div>
        </div>
    </div>
    <div class="col-xl-6 col-lg-12">
        <div class="card">
            <div class="card-header no-border">
                <h4 class="card-title"></h4>
                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                       
                    </ul>
                </div>
            </div>
            <div class="card-body">
                <asp:UpdatePanel runat="server" ID="PU2">
               <ContentTemplate>
                   <div id="goal-list-scroll" class="table-responsive height-500 position-relative" style="border-style:none">
                                <asp:GridView runat="server" ID="lgastosNoTop" CssClass="table mb-0" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastosNoTop" 
                                AlternatingRowStyle-BackColor="#F5F7FA" BorderColor="#e1e1e1">
                               
                                        <Columns>                                            
                                            <asp:BoundField DataField="cliente" HeaderText="Cliente" ItemStyle-Width="250px"  />                                                                      
                                            <asp:BoundField DataField="total" HeaderText="Cantidad" ItemStyle-Width="40px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"/> 
                                            <asp:TemplateField HeaderText="" ItemStyle-Width="80px">
                                                <ItemTemplate>
                                                    <div class="text-xs-center font-small-2"><%# Eval("porcentaje")%> %
                                                    <progress class="progress progress-sm progress-success mb-0" value="<%# Eval("porcentaje")%>" max="100"></progress>
                                                         </div>                                                
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            </div>
                                    <asp:SqlDataSource ID="DsListadoGastosNoTop" ProviderName="MySql.Data.MySqlClient"  runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="
                                        select c.NOMBRE as cliente,  ( 
                                        select coalesce(count(t2.idticket), 0) 
                                        from ticket t2 
                                        where t2.IDCLIENTE = c.idcliente 
                                        ) as total ,
                                        (
                                          select round(coalesce(count(t2.idticket), 0)/
                                            (
                                            select 
                                            coalesce(count(t2.idticket), 0) 
                                                from ticket t2
                                            )    
                                            *100,2 )   
                                          from ticket t2 
                                          where t2.IDCLIENTE = c.idcliente 
                                        )as porcentaje
                                        from cliente c 
                                        order by total desc
                                        limit 0,10"></asp:SqlDataSource>
                </ContentTemplate>
                </asp:UpdatePanel> 
            </div>
        </div>
    </div>
</div>
<!--/ Audience by country  & users visit -->



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
    
    <script>

        $(".nav-item>ul>li.active").removeClass("active");
        $("#egeneral").addClass("active");

        // Column chart
        // ------------------------------
        $(window).on("load", function () {

            //Get the context of the Chart canvas element we want to select
            var ctx = $("#column-chart");

            // Chart Options
            var chartOptions = {
                // Elements options apply to all of the options unless overridden in a dataset
                // In this case, we are setting the border of each bar to be 2px wide and green
                elements: {
                    rectangle: {
                        borderWidth: 2,
                        borderColor: 'rgb(0, 255, 0)',
                        borderSkipped: 'bottom'
                    }
                },
                responsive: true,
                maintainAspectRatio: false,
                responsiveAnimationDuration: 500,
                legend: {
                    position: 'top',
                },
                scales: {
                    xAxes: [{
                        display: true,
                        gridLines: {
                            color: "#f3f3f3",
                            drawTicks: false,
                        },
                        scaleLabel: {
                            display: true,
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
                        }
                    }]
                },
                title: {
                    display: true,
                    text: ''
                }
            };

            // Chart Data
            var chartData = {
                labels: ["Enero", "Febrero", "Marzo", "Abril", "Mayo"],
                datasets: [{
                    label: "Atendidos",
                    data: [65, 59, 80, 81, 56],
                    backgroundColor: "#16D39A",
                    hoverBackgroundColor: "rgba(22,211,154,.9)",
                    borderColor: "transparent"
                }, {
                    label: "Cancelados",
                    data: [8, 11, 25, 9, 6],
                    backgroundColor: "#F98E76",
                    hoverBackgroundColor: "rgba(249,142,118,.9)",
                    borderColor: "transparent"
                }]
            };

            var config = {
                type: 'bar',
                options: chartOptions,
                data: datosBar
            };

            // Create the chart
            var lineChart = new Chart(ctx, config);



            //Get the context of the Chart canvas element we want to select
            var ctxD = $("#simple-doughnut-chart");

            // Chart Options
            var chartOptionsD = {
                responsive: true,               
                maintainAspectRatio: false,
                responsiveAnimationDuration: 500,
                legend: {
                    display: false,
                 
                }
            };
        

            var configD = {
                type: 'doughnut',

                // Chart Options
                options: chartOptionsD,

                data: dataClientes
            };

            // Create the chart
            var doughnutChart = new Chart(ctxD, configD);
        });
    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
</asp:Content>
