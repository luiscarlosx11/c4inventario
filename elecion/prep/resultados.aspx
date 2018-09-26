<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="resultados.aspx.cs" Inherits="elecion.prep.resultados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/charts/jquery-jvectormap-2.0.3.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/charts/morris.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/unslider.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/weather-icons/climacons.min.css" />
    <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">RESULTADOS</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Resultados de Programa de Resultados Electorales Preeliminares</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
    <asp:ScriptManager runat="server" ID="sc"></asp:ScriptManager>

    <div class="row" id="header-styling">
        <!-- Multiple Doughnut Chart -->
    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Multiple Doughnut Chart</h4>
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
                        <div class="overflow-scroll">
                            <div id="multiple-doughnut" class="height-400 echart-container" style="min-width:600px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <!-- Simple Pie Chart -->
        <div class="col-md-12 col-sm-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Resultados Gobernatura Estado</h4>
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
                        <asp:UpdatePanel runat="server" ID="up">
                            <ContentTemplate>
                                <asp:DropDownList runat="server" ID="municipos" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="municipos_SelectedIndexChanged"
                                    DataSourceID="DsMunicipio" DataTextField="municipio" DataValueField="idMunicipio" AppendDataBoundItems="true">
                                    <asp:ListItem Value="%">Estado</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="DsMunicipio" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                    SelectCommand="SELECT [idMunicipio], [municipio] FROM [municipios] WHERE ([entidad] = 18)"></asp:SqlDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <br />
                        <hr />
                        <div id="simple-pie-chart" class="height-400"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Simple Pie Chart -->
        <div class="col-xl-12 col-lg-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">Basic Pie Chart</h4>
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
                        <div id="basic-pie" class="height-400 echart-container"></div>
                    </div>
                </div>
            </div>
        </div>

    </div>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/flot/jquery.flot.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/flot/jquery.flot.pie.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/flot/jquery.flot.resize.js" type="text/javascript"></script>
    <script src="../../../app-assets/vendors/js/charts/echarts/echarts.js" type="text/javascript"></script>
    <script>
        $(document).prop('title', 'PLACEL - PREP RESULTADOS');
        $("#mprepr").addClass("active");

        function labelFormatter(label, series) {
            return "<div style='font-size:8pt; text-align:center; padding:2px; color:white;'>" + Math.round(series.percent) + "%</div>";
        }

        var options = {
            series: {
                pie: {
                    show: true,
                    radius: 1,
                    label: {
                        show: true,
                        radius: 2 / 3,
                        formatter: labelFormatter,
                        threshold: 0.1
                    }
                }
            },
            legend: {
                show: true
            },
            colors: ['#FFC400', '#FF7D4D', '#FF4558', '#626E82', '#16D39A', '#00A5A8', '#FFC400', '#FF4558', '#626E82']
        };
       
    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
    <script>
        var datos;
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

            loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
            $(window).on("load", function () {

              

                /* var data = [
                     { label: "Series1", data: 50 },
                     { label: "Series2", data: 70 },
                     { label: "Series3", data: 60 },
                     { label: "Series4", data: 90 },
                     { label: "Series5", data: 80 },
                     { label: "Series6", data: 110 }
                 ];*/

               //
            });

            $.plot("#simple-pie-chart", data, options);


            // Basic pie chart
            // ------------------------------

            $(window).on("load", function () {

                // Set paths
                // ------------------------------

                require.config({
                    paths: {
                        echarts: '/app-assets/vendors/js/charts/echarts'
                    }
                });

                //var datos = ['IE', 'Opera', 'Safari', 'Firefox', 'Chrome'];
                // Configuration
                // ------------------------------

                require(
                    [
                        'echarts',
                        'echarts/chart/pie',
                        'echarts/chart/funnel'
                    ],


                    // Charts setup
                    function (ec) {
                        // Initialize chart
                        // ------------------------------
                        var myChart = ec.init(document.getElementById('basic-pie'));

                        // Chart Options
                        // ------------------------------
                        chartOptions = {

                            // Add title
                            title: {
                                text: 'Resultados Gobernador',
                                x: 'center'
                            },

                            // Add tooltip
                            tooltip: {
                                trigger: 'item',
                                formatter: "{a} <br/>{b}: {c} ({d}%)"
                            },

                            // Add legend
                            legend: {
                                orient: 'vertical',
                                x: 'left',
                                data: datos
                            },

                            // Add custom colors
                            color: ['#00A5A8', '#626E82', '#FF7D4D', '#FF4558', '#16D39A'],

                            // Display toolbox
                            toolbox: {
                                show: true,
                                orient: 'vertical',
                                feature: {
                                    mark: {
                                        show: true,
                                        title: {
                                            mark: 'Markline switch',
                                            markUndo: 'Undo markline',
                                            markClear: 'Clear markline'
                                        }
                                    },
                                    dataView: {
                                        show: true,
                                        readOnly: false,
                                        title: 'View data',
                                        lang: ['View chart data', 'Close', 'Update']
                                    },
                                    magicType: {
                                        show: true,
                                        title: {
                                            pie: 'Switch to pies',
                                            funnel: 'Switch to funnel',
                                        },
                                        type: ['pie', 'funnel'],
                                        option: {
                                            funnel: {
                                                x: '25%',
                                                y: '20%',
                                                width: '50%',
                                                height: '70%',
                                                funnelAlign: 'left',
                                                max: 1548
                                            }
                                        }
                                    },
                                    restore: {
                                        show: true,
                                        title: 'Restore'
                                    },
                                    saveAsImage: {
                                        show: true,
                                        title: 'Same as image',
                                        lang: ['Save']
                                    }
                                }
                            },

                            // Enable drag recalculate
                            calculable: true,

                            // Add series
                            series: [{
                                name: 'Browsers',
                                type: 'pie',
                                radius: '70%',
                                center: ['50%', '57.5%'],
                                data: data2/*[
                                    { value: 335, name: 'IE' },
                                    { value: 310, name: 'Opera' },
                                    { value: 234, name: 'Safari' },
                                    { value: 135, name: 'Firefox' },
                                    { value: 1548, name: 'Chrome' }
                                ]*/
                            }]
                        };

                        // Apply options
                        // ------------------------------

                        myChart.setOption(chartOptions);


                        // Resize chart
                        // ------------------------------

                        $(function () {

                            // Resize chart on menu width change and window resize
                            $(window).on('resize', resize);
                            $(".menu-toggle").on('click', resize);

                            // Resize function
                            function resize() {
                                setTimeout(function () {

                                    // Resize chart
                                    myChart.resize();
                                }, 200);
                            }
                        });
                    }
                );
            });


            // Multiple doughnut chart
            // ------------------------------

            $(window).on("load", function () {

                // Set paths
                // ------------------------------

                require.config({
                    paths: {
                        echarts: '../../../app-assets/vendors/js/charts/echarts'
                    }
                });


                // Configuration
                // ------------------------------

                require(
                    [
                        'echarts',
                        'echarts/chart/pie',
                        'echarts/chart/funnel'
                    ],


                    // Charts setup
                    function (ec) {
                        // Initialize chart
                        // ------------------------------
                        var myChart = ec.init(document.getElementById('multiple-doughnut'));

                        // Top text label
                        var labelTop = {
                            normal: {
                                label: {
                                    show: true,
                                    position: 'center',
                                    formatter: '{b}\n',
                                    textStyle: {
                                        baseline: 'middle',
                                        fontWeight: 300,
                                        fontSize: 15
                                    }
                                },
                                labelLine: {
                                    show: false
                                }
                            }
                        };

                        // Format bottom label
                        var labelFromatter = {
                            normal: {
                                label: {
                                    formatter: function (params) {
                                        return '\n\n' + (100 - params.value) + '%';
                                    }
                                }
                            }
                        };

                        // Bottom text label
                        var labelBottom = {
                            normal: {
                                color: '#eee',
                                label: {
                                    show: true,
                                    position: 'center',
                                    textStyle: {
                                        baseline: 'middle'
                                    }
                                },
                                labelLine: {
                                    show: false
                                }
                            },
                            emphasis: {
                                color: 'rgba(0,0,0,0)'
                            }
                        };

                        // Set inner and outer radius
                        // var radius = [60, 75];
                        var radius = [45, 60];
                        // Chart Options
                        // ------------------------------
                        chartOptions = {

                            // Add title
                            title: {
                                text: 'Resultados Gobernador',
                                x: 'center'
                            },

                            // Add legend
                            legend: {
                                x: 'center',
                                y: '56%',
                                data: datos
                            },

                            // Add custom colors
                            color: ['#20A464', '#4A66A0', '#DE2925', '#DD5044', '#99B898', '#4B9CD8', '#50A5E6', '#FF6024', '#50CA5F'],

                            // Add series
                            series: [
                                {
                                    type: 'pie',
                                    center: ['10%', '32.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 46, itemStyle: labelBottom },
                                        { name: 'ANTONIO ECHEVARRÍA GARCÍA', value: 54, itemStyle: labelTop }
                                    ]
                                },
                                {
                                    type: 'pie',
                                    center: ['30%', '32.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 56, itemStyle: labelBottom },
                                        { name: 'Facebook', value: 44, itemStyle: labelTop }
                                    ]
                                },
                                {
                                    type: 'pie',
                                    center: ['50%', '32.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 65, itemStyle: labelBottom },
                                        { name: 'Youtube', value: 35, itemStyle: labelTop }
                                    ]
                                },
                                {
                                    type: 'pie',
                                    center: ['70%', '32.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 70, itemStyle: labelBottom },
                                        { name: 'Google+', value: 30, itemStyle: labelTop }
                                    ]
                                },
                                {
                                    type: 'pie',
                                    center: ['90%', '32.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 73, itemStyle: labelBottom },
                                        { name: 'Weixin', value: 27, itemStyle: labelTop }
                                    ]
                                },
                                {
                                    type: 'pie',
                                    center: ['10%', '82.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 78, itemStyle: labelBottom },
                                        { name: 'Twitter', value: 22, itemStyle: labelTop }
                                    ]
                                },
                                {
                                    type: 'pie',
                                    center: ['30%', '82.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 78, itemStyle: labelBottom },
                                        { name: 'Skype', value: 22, itemStyle: labelTop }
                                    ]
                                },
                                {
                                    type: 'pie',
                                    center: ['50%', '82.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 78, itemStyle: labelBottom },
                                        { name: 'Messenger', value: 22, itemStyle: labelTop }
                                    ]
                                },
                                {
                                    type: 'pie',
                                    center: ['70%', '82.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 83, itemStyle: labelBottom },
                                        { name: 'Whatsapp', value: 17, itemStyle: labelTop }
                                    ]
                                },
                                {
                                    type: 'pie',
                                    center: ['90%', '82.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 89, itemStyle: labelBottom },
                                        { name: 'Instagram', value: 11, itemStyle: labelTop }
                                    ]
                                }
                            ]
                        };

                        // Apply options
                        // ------------------------------

                        myChart.setOption(chartOptions);


                        // Resize chart
                        // ------------------------------

                        $(function () {

                            // Resize chart on menu width change and window resize
                            $(window).on('resize', resize);
                            $(".menu-toggle").on('click', resize);

                            // Resize function
                            function resize() {
                                setTimeout(function () {

                                    // Resize chart
                                    myChart.resize();
                                }, 200);
                            }
                        });
                    }
                );
            });

        }
    </script>
    <script>

    </script>
</asp:Content>
