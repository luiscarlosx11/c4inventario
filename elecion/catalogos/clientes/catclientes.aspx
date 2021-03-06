<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="catclientes.aspx.cs" 
    Inherits="elecion.catalogos.catclientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/datatable/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/extensions/buttons.dataTables.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/datatable/buttons.bootstrap4.min.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/forms/checkboxes-radios.css" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Directorio</h3>


          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Catálogos</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Clientes</a>
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
        
        <div class="row" id="header-styling">
                <div class="col-xs-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">LISTADO DE CLIENTES</h4>
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
                                                   <asp:Button runat="server" ID="Beditar" OnClick="editaRegistro" style="display:none"/> 
                                                   
                                                    <asp:HiddenField runat="server" ID="idP" /> 
                                                    <asp:HiddenField runat="server" ID="idS" /> 
                                                                                                                                                                  
                                                    <asp:Button runat="server" ID="Bnuevo" OnClick="nuevoRegistro" style="display:none"/>                                            
                                                    <button type="button" id="nuevo" onclick="nuevoRegistro();" class="btn btn-icon btn-primary mr-1" data-toggle="modal" >
                                                         <i class="ft-file"></i> Nuevo Registro 
                                                    </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                    </div>
                                </div>

                                <div class="card-block card-dashboard">
                                 <div class="row">
                                                                        

                                   <div class="col-md-4">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Nombre</label>
											<asp:TextBox ID="bnombre" CssClass="form-control text-uppercase"  placeholder="Nombre" name="nombre" runat="server" OnTextChanged="listadoClientes" AutoPostBack="true"></asp:TextBox>
										</div>
									</div>
                              </div>
                            </div>
                            
                           

                                    

                        </div>

                        </div>
                        <div class="card">
                        <div class="card-block card-dashboard"> 
                        <div style="overflow-x:auto;width:100%"> 
                        <asp:GridView runat="server" ID="lusuarios" PageSize="25" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered base-style" 
                             AutoGenerateColumns="False" DataSourceID="DsUsuarios" DataKeyNames="idcliente"
                            AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros">    
                            <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White"/>                    
                            <Columns>
                                <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                </asp:TemplateField>                                                                
                                <asp:BoundField DataField="ncompleto" HeaderText="Nombre" SortExpression="ncompleto" /> 
                                <asp:BoundField DataField="fecharegistro" HeaderText="Alta en" ItemStyle-Width="150px" SortExpression="fecharegistro" />                                 
                                <asp:BoundField DataField="celular" HeaderText="Celular" ItemStyle-Width="100px" SortExpression="celular" />
                                <asp:BoundField DataField="domicilio" HeaderText="Domicilio" SortExpression="domicilio" />                                                               
                                <asp:TemplateField HeaderText="Activo" ItemStyle-Width="20px"  ItemStyle-HorizontalAlign="Center">
                                     <ItemTemplate>  
                                         <div class="row skin skin-flat">
                                         <div class="state icheckbox_flat-green <%# Eval("activo")%> mr-1"></div>
                                             </div>
                                     </ItemTemplate>
                                </asp:TemplateField>                                                               
                                <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="100px">
                                     <ItemTemplate>                                                                                                      

                                                    <button type="button" id="editar" onclick="editarRegistro(<%# Eval("idcliente")%>,<%# Eval("idsucursal")%>)" class="btn btn-icon btn-success mr-1" data-toggle="tooltip" data-original-title="Editar">
                                                         <i class="ft-edit"></i>
                                                    </button>

                                                     
                                                                                                         
                                    </ItemTemplate>
                                 </asp:TemplateField>
                            </Columns>

                            <pagersettings mode="NumericFirstLast"
                                firstpagetext="Inicio"
                                lastpagetext="Fin"
                                Position ="Bottom"/>
                        </asp:GridView>
                        <asp:SqlDataSource ID="DsUsuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" ></asp:SqlDataSource>
                        </div>
                        </div>
                        </div>

                
            </div>
        </div>
         </ContentTemplate>
        </asp:UpdatePanel>
   
    
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

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>
    <script>
        //$(document).prop('title', 'PLACEL - Promovidos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catclientes").addClass("active");

        function editarRegistro(id, ids) {
            
            mostrarLoading();
            $("*[id$='idP']").val(id);
            $("*[id$='idS']").val(ids);
           $('#<%= Beditar.ClientID %>').click();
        }

        function nuevoRegistro() {
            mostrarLoading();
           $('#<%= Bnuevo.ClientID %>').click();
        }

    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
    <script src="/app-assets/js/scripts/tables/datatables-extensions/datatable-button/datatable-html5.js" type="text/javascript"></script>
</asp:Content>
