<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="graficasforo.aspx.cs" Inherits="elecion.foro.graficasforo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var userPageVisitData;
    </script>


    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/charts/jquery-jvectormap-2.0.3.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/charts/morris.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/unslider.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/weather-icons/climacons.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />
    <!-- END VENDOR CSS-->


    <!-- END Custom CSS-->
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Estadísticas Promoción del Voto</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Promoción del Voto</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Graficas</a>
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
                <h4 class="card-title">Promovidos</h4>
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
                    <div class="row my-1">
                        <div class="col-lg-4 col-xs-12">
                            <div class="text-xs-center">
                                <h3><asp:Label runat="server" ID="ltotalfavor">0</asp:Label></h3>
                                <p class="text-muted">Promovidos<span class="success"><i class="ft-arrow-up"></i><asp:Label runat="server" ID="lporcentajefavor">0 %</asp:Label></span></p>
                                <div id="sp-tristate-bar-total-revenue"></div>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 col-xs-12">
                            <div class="text-xs-center">
                                <h3><asp:Label runat="server" ID="ltotalindecisos">0</asp:Label></h3>
                                <p class="text-muted">Indecisos<span class="warning"><i class="ft-arrow-up"></i> <asp:Label runat="server" ID="lporcentajeindecisos">0 %</asp:Label></span></p>
                                <div id="sp-bar-total-cost"></div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-xs-12">
                            <div class="text-xs-center">
                                <h3><asp:Label runat="server" ID="ltotalcontra">0</asp:Label></h3>
                                <p class="text-muted">En contra <span class="danger"><i class="ft-arrow-down"></i> <asp:Label runat="server" ID="lporcentajecontra">0 %</asp:Label></span></p>
                                <div id="sp-stacked-bar-total-sales"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="chartjs">
                                <canvas id="line-stacked-area" height="300"></canvas>
                            </div>
                            <ul class="list-inline text-xs-center mt-1">
                                <li class="mr-1">
                                    <h6><i class="fa fa-circle success"></i> <span>Promovidos</span></h6>
                                </li>
                                <li class="mr-1">
                                    <h6><i class="fa fa-circle warning"></i> <span>Indecisos</span></h6>
                                </li>
                                <li class="mr-1">
                                    <h6><i class="fa fa-circle danger"></i> <span>En contra</span></h6>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--/ Analytics spakline & chartjs  -->
<div class="row">
      
    <asp:DataList ID="dlCustomers" runat="server" DataSourceID="SqlDataSource1" RepeatLayout = "Flow" RepeatDirection="Horizontal">
    <ItemTemplate>        
        <div class="col-xl-3 col-lg-6 col-xs-12">
            <div class="card">
                <div class="card-body">
                    <div class="card-block">
                        <div class="media">
                            <div class="media-left media-middle">
                                
                                <i class="icon-graph success font-large-2 float-xs-right"></i>
                               
                            </div>
                            <div class="media-body text-xs-right">
                                <h3><%# Eval("total")%></h3>
                                <span><%# Eval("municipio")%></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        </ItemTemplate>
</asp:DataList>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT m.municipio,(select count(p.idP) from promovidos p where p.idMunicipio = m.idMunicipio and p.estado='FAVOR')as total from municipios m where m.entidad=18 order by m.municipio"></asp:SqlDataSource>
  
</div>

    <div class="row">

    </div>
<!-- Audience by country & users visit-->
<div class="row match-height">
    
    <div class="col-xl-6 col-lg-12">
        <div class="card">
            <div class="card-header no-border">
                <h4 class="card-title">Seccionales con Mayor Avance</h4>
                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                        <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                    </ul>
                </div>
            </div>
            <div class="card-body">
                <asp:UpdatePanel runat="server" ID="pU">
               <ContentTemplate>
                   <div id="goal-list-scroll" class="table-responsive height-250 position-relative" style="border-style:none">
                                <asp:GridView runat="server" ID="lgastosTop" CssClass="table mb-0" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastosTop" 
                                AlternatingRowStyle-BackColor="#F5F7FA" BorderColor="#e1e1e1">
                               
                                        <Columns>                                            
                                            <asp:BoundField DataField="seccion" HeaderText="Seccion" ItemStyle-Width="60px" ControlStyle-CssClass="centrarCelda"/>                                                                      
                                            <asp:BoundField DataField="total" HeaderText="Total" ItemStyle-Width="100px" ControlStyle-CssClass="centrarCelda"/> 
                                            <asp:BoundField DataField="listanominal" HeaderText="L. Nominal" ItemStyle-Width="100px" ControlStyle-CssClass="centrarCelda"/>                                            
                                            <asp:TemplateField HeaderText="Porcentaje">
                                                <ItemTemplate>
                                                    <div class="text-xs-center font-small-2"><%# Eval("porcentaje")%> %
                                                    <progress class="progress progress-sm progress-success mb-0" value="<%# Eval("porcentaje")%>" max="100"></progress>
                                                    </div>                                                
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            </div>
                                    <asp:SqlDataSource ID="DsListadoGastosTop" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="select top 10 p.seccion, count(p.idP)as total, s.listanominal, cast( count(p.idP)*100/s.listanominal as decimal(20,2))as porcentaje from promovidos p  left join secciones s on s.seccion = p.seccion where s.entidad=18 and p.entidad=18 group by p.seccion, s.listanominal order by (porcentaje) desc"></asp:SqlDataSource>
                </ContentTemplate>
                </asp:UpdatePanel> 
                

            </div>
        </div>
    </div>

    <div class="col-xl-6 col-lg-12">
        <div class="card">
            <div class="card-header no-border">
                <h4 class="card-title">Seccionales con Menor Avance</h4>
                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                        <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                    </ul>
                </div>
            </div>
            <div class="card-body">
                
                <asp:UpdatePanel runat="server" ID="pU2">
               <ContentTemplate>
                   <div id="goal-list-scroll" class="table-responsive height-250 position-relative" style="border-style:none">
                                <asp:GridView runat="server" ID="lgastosNoTop" CssClass="table mb-0" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastosNoTop" 
                                AlternatingRowStyle-BackColor="#F5F7FA" BorderColor="#e1e1e1">
                               
                                        <Columns>                                            
                                            <asp:BoundField DataField="seccion" HeaderText="Seccion" ItemStyle-Width="60px" ControlStyle-CssClass="centrarCelda"/>                                                                      
                                            <asp:BoundField DataField="total" HeaderText="Total" ItemStyle-Width="100px" ControlStyle-CssClass="centrarCelda"/> 
                                            <asp:BoundField DataField="listanominal" HeaderText="L. Nominal" ItemStyle-Width="100px" ControlStyle-CssClass="centrarCelda"/>                                            
                                            <asp:TemplateField HeaderText="Porcentaje">
                                                <ItemTemplate>
                                                    <div class="text-xs-center font-small-2"><%# Eval("porcentaje")%> %
                                                    <progress class="progress progress-sm progress-warning mb-0" value="<%# Eval("porcentaje")%>" max="100"></progress>
                                                    </div>                                                
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            </div>
                                    <asp:SqlDataSource ID="DsListadoGastosNoTop" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="select top 10 p.seccion, count(p.idP)as total, s.listanominal, cast( count(p.idP)*100/s.listanominal as decimal(20,2))as porcentaje from promovidos p  left join secciones s on s.seccion = p.seccion where s.entidad=18 and p.entidad=18 group by p.seccion, s.listanominal order by (porcentaje) asc"></asp:SqlDataSource>
                </ContentTemplate>
                </asp:UpdatePanel> 

            </div>
        </div>
    </div>

    

</div>
    

    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Distribución Municipal</h4>
                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                    <div class="heading-elements">
                        <ul class="list-inline mb-0">
                           
                            <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                           
                        </ul>
                    </div>
                </div>
                <div class="card-body collapse in">
                    <div class="card-block">
                        <canvas id="line-stacked-areaB" height="400"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- Analytics map based session -->
    


<!-- Analytics map based session -->

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    

    <script src="/app-assets/vendors/js/charts/chart.min.js" type="text/javascript"></script> 
    


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
    <link rel="stylesheet" type="text/css" href="/app-assets/css/core/colors/palette-climacon.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/simple-line-icons/style.min.css">
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN STACK JS-->

    <!-- END STACK JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    <script src="/app-assets/js/scripts/pages/dashboard-analytics.js" type="text/javascript"></script>


    <script>
        $(document).prop('title', 'PLACEL - Graficas promovidos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#graficasforo").addClass("active");

        var ctx = document.getElementById('line-stacked-areaB').getContext('2d');

        var userPageVisitOptions = {
            responsive: true,
            maintainAspectRatio: false,
            pointDotStrokeWidth: 4,
            legend: {
                display: true,
                labels: {
                    fontColor: '#404e67',
                    boxWidth: 10,
                },
                position: 'bottom',
            },
            hover: {
                mode: 'label'
            },
          
            title: {
                display: false,
                text: 'Chart.js Line Chart - Legend'
            },
            scales: {
                xAxes: [{
                    display: true,
                    gridLines: {
                        color: "rgba(255,255,255, 0.3)",
                        drawTicks: true,
                        drawBorder: false,
                        zeroLineColor: '#FFF'
                    },
                    ticks: {
                        display: true,
                    },
                }],
                yAxes: [{
                    display: true,
                    gridLines: {
                        color: "rgba(0,0,0, 0.07)",
                        drawTicks: false,
                        drawBorder: false,
                        drawOnChartArea: true
                    },
                    ticks: {
                        display: true,
                        maxTicksLimit: 5
                    },
                }]
            }
        };

        /*var userPageVisitData = {
            labels: ["Distrito 1"],
            datasets: [ {
                label: "Page Views",
                data: [2000],
                backgroundColor: "rgba(22,211,154,0.7)",
                borderColor: "transparent",
                pointBorderColor: "transparent",
                pointBackgroundColor: "transparent",
                pointRadius: 2,
                pointBorderWidth: 2,
                pointHoverBorderWidth: 2,
            }, {
                label: "Page Views",
                data: [47600],
                backgroundColor: "rgba(22,211,465,0.7)",
                borderColor: "transparent",
                pointBorderColor: "transparent",
                pointBackgroundColor: "transparent",
                pointRadius: 2,
                pointBorderWidth: 2,
                pointHoverBorderWidth: 2,
            }]
        };*/



        var userPageVisitConfig = {
            type: 'bar',
            // Chart Options
            options : userPageVisitOptions,
            // Chart Data
            data : userPageVisitData
        };

        var chart = new Chart(ctx, userPageVisitConfig)

    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
</asp:Content>
