<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="listacasas.aspx.cs" Inherits="elecion.prep.listacasas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Casas Amigas</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Casas Amigas</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
     <asp:HiddenField runat="server" ID="hentidad" />
    <asp:ScriptManager runat="server" ID="sc"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>
            <asp:HiddenField ID="hent" runat="server" />
            <div class="row" id="header-styling">
                <div class="col-xs-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">LISTADO CASAS AMIGAS</h4>
                            <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                            <div class="heading-elements">
                                <ul class="list-inline mb-0">
                                    <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                                    <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-body collapse in">
                            <div class="card-block card-dashboard">
                                <p class="card-text">

                                    <asp:Button runat="server" ID="Beditar" OnClick="Beditar_Click" Style="display: none" />
                                    <asp:Button runat="server" ID="Bborrar" OnClick="Bborrar_Click" Style="display: none" />
                                    <asp:HiddenField runat="server" ID="idP" />


                                    <asp:Button runat="server" ID="Bnuevo" OnClick="Bnuevo_Click" Style="display: none" />
                                    <button type="button" id="nuevo" onclick="nuevoRegistro();" class="btn btn-icon btn-success mr-1" data-toggle="modal">
                                        <i class="ft-file"></i>Nuevo Registro 
                                    </button>
                                </p>
                                <p class="card-text">
                                    <div class="row">
                                        <div class="col-md-2">
                                            <label for="municipio">Municipio</label>
                                            <asp:DropDownList runat="server" ID="municipio" CssClass="select2 form-control" DataSourceID="DsMunicipios"
                                                 DataTextField="municipio" DataValueField="idMunicipio" AutoPostBack="true"></asp:DropDownList>
                                            <asp:SqlDataSource ID="DsMunicipios" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [idMunicipio], [municipio] FROM [municipios] WHERE [entidad] = @ent ORDER BY [municipio]">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hentidad" Name="ent" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="seccionbus">Sección</label>
                                            <asp:DropDownList runat="server" ID="seccionbus" CssClass="select2 form-control" DataSourceID="DsSeccionBus" 
                                                DataTextField="seccion" DataValueField="seccion" AutoPostBack="true" OnDataBound="seccion_DataBound"
                                                name="seccionbus"></asp:DropDownList>
                                            <asp:SqlDataSource ID="DsSeccionBus" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                SelectCommand="SELECT seccion from secciones WHERE entidad = @ent and idMunicipio = @idm ">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hentidad" Name="ent" PropertyName="Value" />
                                                    <asp:ControlParameter ControlID="municipio" Name="idm" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </div>
                                        <div class="col-md-7"></div>
                                        <div class="col-xl-3 col-lg-6 col-xs-12">
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="card-block">
                                                        <div class="media">
                                                            <div class="media-left media-middle">
                                                                <i class="icon-folder primary font-large-2 float-xs-left"></i>
                                                            </div>
                                                            <div class="media-body text-xs-right">
                                                                <h3>
                                                                    <asp:Label runat="server" ID="labelConteo"></asp:Label></h3>
                                                                <span>Casas Registradas</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <p>
                                    </p>

                                    <p>
                                    </p>

                                </p>
                            </div>
                            <div class="card-block card-dashboard">
                                <div style="overflow-x: auto; width: 100%">
                                    <asp:GridView runat="server" ID="gCasas" AutoGenerateColumns="False" DataSourceID="DsCasas" AllowSorting="True" CssClass="table table-striped table-bordered base-style">
                                        <Columns>
                                            <asp:BoundField DataField="MUNICIPIO" HeaderText="Municipio" SortExpression="MUNICIPIO" />
                                            <asp:BoundField DataField="seccion" HeaderText="Seccional" SortExpression="seccion" />
                                            <asp:BoundField DataField="ACTIVACION" HeaderText="Activa" SortExpression="ACTIVACION" />
                                            <asp:BoundField DataField="META_OP" HeaderText="Meta" SortExpression="META_OP" />
                                            <asp:BoundField DataField="op_activos" HeaderText="Operadores Activos" SortExpression="op_activos" />
                                            <asp:TemplateField HeaderText="Acciones">
                                                <ItemTemplate>
                                                    <button type="button" id="editar" onclick="editarRegistro(<%# Eval("id")%>)" class="btn btn-icon btn-success mr-1" data-toggle="tooltip" data-original-title="Editar">
                                                        <i class="ft-edit"></i>
                                                    </button>
                                                    <button type="button" id="borrar" onclick="eliminarRegistro(<%# Eval("id")%>)" class="btn btn-icon btn-danger mr-1" data-toggle="tooltip" data-original-title="Borrar">
                                                        <i class="ft-delete"></i>
                                                    </button>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="DsCasas" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" 
                                        SelectCommand="SELECT [id], [seccion], [ACTIVACION], [MUNICIPIO], [COLONIAS], [META_OP], [op_activos] FROM [casas_amigas] WHERE [seccion] like @secc and idmunicipio = @idm">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="seccionbus" Name="secc" PropertyName="SelectedValue" />
                                            <asp:ControlParameter ControlID="municipio" Name="idm" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script>
        function nuevoRegistro() {
            window.location.href = '/casas-amigas/agregar';
        }

          function editarRegistro(id) {
           $("*[id$='idP']").val(id);
           $('#<%= Beditar.ClientID %>').click();
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

            loadJS("/app-assets/js/scripts/forms/select/form-select2.js");

        }
    </script>
</asp:Content>
