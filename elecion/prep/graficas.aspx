<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="graficas.aspx.cs" Inherits="elecion.prep.graficas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/charts/jquery-jvectormap-2.0.3.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/charts/morris.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/unslider.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/weather-icons/climacons.min.css" />
     <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">PREP</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Programa de Resultados Electorales Preeliminares</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
    <div class="row" id="header-styling">
        <div class="col-xs-12">
            <div class="card">
                <asp:ScriptManager runat="server" ID="sc"></asp:ScriptManager>
                <asp:UpdatePanel ID="uPanel" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList runat="server" ID="municipos" CssClass="form-control select2" AutoPostBack="true"
                            OnSelectedIndexChanged="municipos_SelectedIndexChanged"
                            DataSourceID="DsMunicipio" DataTextField="municipio" DataValueField="idMunicipio" AppendDataBoundItems="true">
                            <asp:ListItem Value="%">Estado</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DsMunicipio" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                            SelectCommand="SELECT [idMunicipio], [municipio] FROM [municipios] WHERE ([entidad] = 18)"></asp:SqlDataSource>
                        <div id="simple-pie-chart" class="height-400"></div>
                    </ContentTemplate>
                </asp:UpdatePanel>
               
                
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/charts/flot/jquery.flot.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/flot/jquery.flot.pie.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/flot/jquery.flot.resize.js" type="text/javascript"></script>

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
                        threshold: 0.1
                    }
                }
            },
            legend: {
                show: true
            },
            colors: ['#FFC400', '#FF7D4D', '#FF4558', '#626E82', '#16D39A', '#00A5A8', '#FFC400', '#FF4558', '#626E82']
        };

        /*var data = [
            { label: "Series1", data: 50 },
            { label: "Series2", data: 70 },
            { label: "Series3", data: 60 },
            { label: "Series4", data: 90 },
            { label: "Series5", data: 80 },
            { label: "Series6", data: 110 }
        ];*/


        $(window).on("load", function () {


            //$.plot("#simple-pie-chart", data, options);

            // $.plot("#simple-pie-chart", data, options);
        });
    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
    <script>

        function pageLoad(sender, args) {
            console.log("ENTRO 1");
            $.plot("#simple-pie-chart", data, options);
        }

    </script>
</asp:Content>
