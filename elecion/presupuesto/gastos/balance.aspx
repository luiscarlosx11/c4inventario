<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="balance.aspx.cs" Inherits="elecion.presupuesto.gastos.balance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server" enableEventValidation="false">
    <script type="text/javascript">
        var chartDataUser;
        var chartDataUserMun;
    </script>


    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/simple-line-icons/style.min.css">
    <!-- END VENDOR CSS-->


    <!-- END Custom CSS-->
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Presupuesto</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Presupuesto</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Gastos</a>
                </li>
                  <li class="breadcrumb-item active"><a href="#">Balance</a>
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
                <h4 class="card-title">Balance de Gastos</h4>
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

            <div class="col-lg-12 col-xs-12">
            <div class="card no-border">
                <div class="card-body">
                    <div class="card-block">
                        <div class="media">
                            <div class="media-body">
                                <h1 class="display-4"><asp:Label runat="server" ID="lTotalGral">$0.00</asp:Label></h1>
                                <span class="text-muted">Total</span>
                            </div>
                            <div class="media-right media-middle">
                                <i class="icon-bulb font-large-2 blue-grey lighten-3"></i>
                            </div>
                        </div>
                    </div>
                    <div id="sp-line-total-cost"></div>
                </div>
            </div>
        </div>
                    
                </div>
            </div>
        </div>
    </div>
</div>


<div class="row">
    

    <div class="row">
        <div class="col-xs-12 col-md-12 col-xs-12">
            <div class="card">
                <div class="card-header no-border-bottom">
                <h4 class="card-title">Conceptos con Mayor Gasto</h4>
                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                        <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                        <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                    </ul>
                </div>
            </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                            <div class="card-block text-xs-center">
                                <div class="card-header mb-2">
                                    <span class="success"><asp:Label runat="server" ID="lconcepto1"></asp:Label></span>
                                    <h3 class="display-4 blue-grey darken-1"><asp:Label runat="server" ID="ltotal1"></asp:Label></h3>
                                </div>
                                <div class="card-body">
                                    <input type="text" value="56" class="knob hide-value responsive angle-offset" data-angleOffset="0" data-thickness=".15" data-linecap="round" data-width="150" data-height="150" data-inputColor="#e1e1e1" data-readOnly="true" data-fgColor="#16D39A" data-knob-icon="icon-notebook">
                                    <ul class="list-inline clearfix mt-2">
                                        <li>
                                            
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                            <div class="card-block text-xs-center">
                                <div class="card-header mb-2">
                                    <span class="warning darken-2"><asp:Label runat="server" ID="lconcepto2"></asp:Label></span>
                                    <h3 class="display-4 blue-grey darken-1"><asp:Label runat="server" ID="ltotal2"></asp:Label></h3>
                                </div>
                                <div class="card-body">
                                    <input type="text" value="35" class="knob hide-value responsive angle-offset" data-angleOffset="0" data-thickness=".15" data-linecap="round" data-width="150" data-height="150" data-inputColor="#e1e1e1" data-readOnly="true" data-fgColor="#FFA87D" data-knob-icon="icon-users">
                                    <ul class="list-inline clearfix mt-2">
                                        <li>
                                                                                      
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-12 col-sm-12 border-right-blue-grey border-right-lighten-5">
                            <div class="card-block text-xs-center">
                                <div class="card-header mb-2">
                                    <span class="danger"><asp:Label runat="server" ID="lconcepto3"></asp:Label></span>
                                    <h3 class="display-4 blue-grey darken-1"><asp:Label runat="server" ID="ltotal3"></asp:Label></h3>
                                </div>
                                <div class="card-body">
                                    <input type="text" value="15" class="knob hide-value responsive angle-offset" data-angleOffset="20" data-thickness=".15" data-linecap="round" data-width="150" data-height="150" data-inputColor="#e1e1e1" data-readOnly="true" data-fgColor="#FF7588" data-knob-icon="icon-wallet">
                                    <ul class="list-inline clearfix mt-2">
                                        <li class="border-right-blue-grey border-right-lighten-2 pr-2">
                                                                                 
                                        </li>
                                       
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>






    
<!-- Audience by country & users visit-->
<div class="row match-height">
    
    <div class="col-xl-6 col-lg-12">
        <div class="card">
            <div class="card-header no-border">
                <h4 class="card-title">Seccionales con Mayor Gasto</h4>
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
                                            <asp:BoundField DataField="seccion" HeaderText="Seccion" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center"/>                                                                      
                                            <asp:BoundField DataField="monto" HeaderText="Monto" ItemStyle-Width="150px"/>                                            
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
                                    <asp:SqlDataSource ID="DsListadoGastosTop" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="select top 10 g.seccion, '$ '+ REPLACE(CONVERT(VARCHAR(20), CAST(sum(d.monto) AS MONEY), 1), '.00', '')as monto , cast(sum(d.monto)*100/(select sum(d.monto) from detalleGasto d)as decimal(20,2))as porcentaje from gasto g  left join detalleGasto d on d.idgasto = g.idgasto group by g.seccion order by sum(d.monto)desc"></asp:SqlDataSource>
                </ContentTemplate>
                </asp:UpdatePanel> 
                    
                <!--
                <div id="goal-list-scroll" class="table-responsive height-250 position-relative">
                    <table class="table mb-0">
                        <thead>
                            <tr>
                                <th>Sección</th>
                                <th>Cantidad</th>
                                <th>Porcentaje</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>102</td>
                                <td>5,369</td>
                                <td class="text-xs-center font-small-2">85% <progress class="progress progress-sm progress-success mb-0" value="80" max="100"></progress></td>
                            </tr>
                            <tr>
                                <td>106</td>
                                <td>4,985</td>
                                <td class="text-xs-center font-small-2">75% <progress class="progress progress-sm progress-success mb-0" value="79.16" max="100"></progress></td>
                            </tr>
                            <tr>
                                <td>215</td>
                                <td>4,536</td>
                                <td class="text-xs-center font-small-2">65% <progress class="progress progress-sm progress-success mb-0" value="70.68" max="100"></progress></td>
                            </tr>
                            <tr>
                                <td>60</td>
                                <td>3,200</td>
                                <td class="text-xs-center font-small-2">35% <progress class="progress progress-sm progress-success mb-0" value="60.35" max="100"></progress></td>
                            </tr>
                            <tr>
                                <td>96</td>
                                <td>3002</td>
                                <td class="text-xs-center font-small-2">25% <progress class="progress progress-sm progress-success mb-0" value="25" max="100"></progress></td>
                            </tr>
                            <tr>
                                <td>15</td>
                                <td>2,890</td>
                                <td class="text-xs-center font-small-2">15% <progress class="progress progress-sm progress-success mb-0" value="22.57" max="100"></progress></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                    -->
            </div>
        </div>
    </div>

    <div class="col-xl-6 col-lg-12">
        <div class="card">
            <div class="card-header no-border">
                <h4 class="card-title">Seccionales con Menor Gasto</h4>
                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                    <ul class="list-inline mb-0">
                        <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                    </ul>
                </div>
            </div>
            <div class="card-body">

                <asp:UpdatePanel runat="server" ID="PU2">
               <ContentTemplate>
                   <div id="goal-list-scroll" class="table-responsive height-250 position-relative" style="border-style:none">
                                <asp:GridView runat="server" ID="lgastosNoTop" CssClass="table mb-0" 
                                AutoGenerateColumns="False" DataSourceID="DsListadoGastosNoTop" 
                                AlternatingRowStyle-BackColor="#F5F7FA" BorderColor="#e1e1e1">
                               
                                        <Columns>                                            
                                            <asp:BoundField DataField="seccion" HeaderText="Seccion" ItemStyle-Width="60px" ItemStyle-HorizontalAlign="Center" />                                                                      
                                            <asp:BoundField DataField="monto" HeaderText="Monto" ItemStyle-Width="150px"/> 
                                            <asp:TemplateField HeaderText="">
                                                <ItemTemplate>
                                                    <div class="text-xs-center font-small-2"><%# Eval("porcentaje")%> %
                                                    <progress class="progress progress-sm progress-success mb-0" value="<%# Eval("porcentaje")%>" max="100"></progress>
                                                         </div>                                                
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            </div>
                                    <asp:SqlDataSource ID="DsListadoGastosNoTop" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="select top 10 g.seccion, '$ '+ REPLACE(CONVERT(VARCHAR(20), CAST(sum(d.monto) AS MONEY), 1), '.00', '')as monto , cast(sum(d.monto)*100/(select sum(d.monto) from detalleGasto d)as decimal(20,2))as porcentaje from gasto g  left join detalleGasto d on d.idgasto = g.idgasto group by g.seccion order by sum(d.monto)asc"></asp:SqlDataSource>
                </ContentTemplate>
                </asp:UpdatePanel> 
                <!--<div id="goal-list-scroll" class="table-responsive height-250 position-relative">
                    <table class="table mb-1">
                        <thead>
                            <tr>
                                <th>Sección</th>
                                <th>Cantidad</th>
                                <th>Porcentaje</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>115</td>
                                <td>1,500</td>
                                <td class="text-xs-center font-small-2">12.30% <progress class="progress progress-sm progress-warning mb-1" value="12.30" max="100"></progress></td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>1,493</td>
                                <td class="text-xs-center font-small-2">11.75% <progress class="progress progress-sm progress-warning mb-1" value="11.75" max="100"></progress></td>
                            </tr>
                            <tr>
                                <td>21</td>
                                <td>1,230</td>
                                <td class="text-xs-center font-small-2">9.61% <progress class="progress progress-sm progress-warning mb-1" value="9.61" max="100"></progress></td>
                            </tr>
                            <tr>
                                <td>64</td>
                                <td>1,016</td>
                                <td class="text-xs-center font-small-2">8.62% <progress class="progress progress-sm progress-warning mb-1" value="8.62" max="100"></progress></td>
                            </tr>
                            <tr>
                                <td>9</td>
                                <td>820</td>
                                <td class="text-xs-center font-small-2">5.19% <progress class="progress progress-sm progress-warning mb-1" value="5.19" max="100"></progress></td>
                            </tr>
                            <tr>
                                <td>153</td>
                                <td>650</td>
                                <td class="text-xs-center font-small-2">5.03% <progress class="progress progress-sm progress-warning mb-1" value="5.03" max="100"></progress></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                -->
            </div>
        </div>
    </div>

    

</div>
    

    <div class="row">
        <!-- Simple Pie Chart -->
        <div class="col-md-6 col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Distribución por Municipio</h4>
                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                    <div class="heading-elements">
                        <ul class="list-inline mb-0">
                            <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                            <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                            <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                            <li><a data-action="close"><i class="ft-x"></i></a></li>
                        </ul>
                    </div>
                </div>
                <div class="card-body collapse in">
                    <div class="card-block">
                        <canvas id="simple-pie-chart" height="400"></canvas>
                       
                    </div>
                </div>
            </div>
        </div>

        <!-- Simple Doughnut Chart -->
        <div class="col-md-6 col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Distribución de Conceptos</h4>
                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                    <div class="heading-elements">
                        <ul class="list-inline mb-0">
                            <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                            <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                            <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                            <li><a data-action="close"><i class="ft-x"></i></a></li>
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
    </div>
<!-- Analytics map based session -->
    


<!-- Analytics map based session -->

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    

    <script src="/app-assets/vendors/js/extensions/jquery.knob.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/extensions/knob.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/raphael-min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/morris.min.js" type="text/javascript"></script>

    <script src="/app-assets/data/jvector/visitor-data.js" type="text/javascript"></script>
    <<script src="/app-assets/vendors/js/charts/chart.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/unslider-min.js" type="text/javascript"></script>

    <script src="/app-assets/js/scripts/cards/card-statistics.js" type="text/javascript"></script>

    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN STACK JS-->

    <!-- END STACK JS-->
    <!-- BEGIN PAGE LEVEL JS-->



    <script>
        $(document).prop('title', 'PLACEL - Balance de Gastos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#balancegasto").addClass("active");
       
        
        $("#sp-line-total-cost").sparkline([14, 12, 4, 9, 3, 6, 11, 10, 13, 9, 14, 11, 16, 20, 15], {
            type: 'line',
            width: '100%',
            height: '100px',
            lineColor: '#FFA87D',
            fillColor: '#FFA87D',
            spotColor: '',
            minSpotColor: '',
            maxSpotColor: '',
            highlightSpotColor: '',
            highlightLineColor: '',
            chartRangeMin: 0,
            chartRangeMax: 20,
        });
       
       
        // Chart Options
        var chartOptions = {
            responsive: true,
            maintainAspectRatio: false,
            responsiveAnimationDuration: 500                      
        };

        var ctx = $("#simple-doughnut-chart");
        var config = {
            type: 'doughnut',
            options: chartOptions,
            data: chartDataUser          
        };
        
        // Create the chart
        
        var doughnutSimpleChart = new Chart(ctx, config);

        
        var ctx2 = $("#simple-pie-chart");
        var config2 = {
            type: 'pie',
            options: chartOptions,
            data: chartDataUserMun
        };

        
        var SimpleChart = new Chart(ctx2, config2);
        

     

    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
</asp:Content>
