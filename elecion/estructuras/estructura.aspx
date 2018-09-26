<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="estructura.aspx.cs" Inherits="elecion.estructuras.estructura" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title"><asp:Label runat="server" ID="nombrEstructura"></asp:Label></h3>
        </div>
        <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">Inicio</a>
                    </li>
                    <li class="breadcrumb-item"><a href="#">Estructuras</a>
                    </li>
                    <li class="breadcrumb-item active"><a href="#"><asp:Label runat="server" ID="nombrEstructura2"></asp:Label></a>
                    </li>
                </ol>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
    <section id="html56">
        <div class="row" id="header-styling">
            <div class="col-xs-12">

                <div class="card">
                    <br />
                    <button type="button" class="btn btn-success btn-min-width mr-1 mb-1" onclick="$('#<%=irCoord.ClientID %>').click()">Agregar Coordinador</button>
                    <asp:Button runat="server" ID="irCoord" OnClick="irCoord_Click" Style="display: none" />
                    <br />
                    &nbsp;
                    <div class="card-body collapse in">
                        <h5>Coordinadores</h5>
                        <asp:GridView runat="server" ID="gEstructura" AutoGenerateColumns="False" CssClass="table table-striped table-bordered zero-configuration"
                            DataSourceID="DsEstructura" DataKeyNames="idCoordinador">
                            <RowStyle CssClass="item" />
                            <Columns>
                                <asp:BoundField DataField="nombre" HeaderText="Nombre" SortExpression="nombre" />
                                <asp:BoundField DataField="email" HeaderText="E-mail" SortExpression="email" />
                                <asp:BoundField DataField="telefono" HeaderText="Teléfono" SortExpression="telefono" />
                                <asp:BoundField DataField="coordinacion" HeaderText="Coordinación" SortExpression="coordinacion" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="DsEstructura" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>
                        <br />
                        &nbsp;
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/tables/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/datatable/dataTables.bootstrap4.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/datatable/dataTables.buttons.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/datatable/buttons.bootstrap4.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/jszip.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/pdfmake.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/vfs_fonts.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/buttons.html5.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/buttons.print.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/tables/buttons.colVis.min.js" type="text/javascript"></script>
    <script>
        $(document).prop('title', 'PLACEL - Estructura');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#cestructura").addClass("active");
    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
    <script src="/app-assets/js/scripts/tables/datatables-extensions/datatable-button/datatable-html5.js" type="text/javascript"></script>
</asp:Content>
