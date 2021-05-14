<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="control.aspx.cs" 
    Inherits="elecion.usuarios.control" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/datatable/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/extensions/buttons.dataTables.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/tables/datatable/buttons.bootstrap4.min.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/forms/checkboxes-radios.css" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
 <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>

             <div class="content-header row">

                <div class="col-md-3">
                    <div class="media-left media-middle">
                        <i class="fa fa-user primary font-large-2 mr-1"></i>
                    </div>
                    <div class="media-body">
                        <h4 class="font-weight-bold">Usuarios</h4>
                        <span class="font-small-3">
                            <asp:Label runat="server" ID="labelConteo">0</asp:Label>
                            registro(s) encontrado(s)</span>
                    </div>

                </div>
                <div class="col-md-9 float-md-right">
                    <asp:HiddenField runat="server" ID="idP" />
                    <asp:HiddenField runat="server" ID="idS" />
                    <span class="pull-right">
                        <label class="text-bold-600 font-small-3"></label>
                        <asp:Button runat="server" ID="Beditar" OnClick="editaRegistro" style="display:none"/> 
                                                    <asp:Button runat="server" ID="Bborrar" OnClick="borrarRegistro" style="display:none"/> 
                                                   
                                                                                                                                                                  
                                                    <asp:Button runat="server" ID="Bnuevo" OnClick="nuevoRegistro" style="display:none"/>                                            
                                                    <button type="button" id="nuevo" onclick="nuevoRegistro();" class="btn btn-icon btn-primary mr-1  text-bold-700" data-toggle="modal" >
                                                        Nuevo Registro 
                                                    </button>
                    </span>
                </div>
            </div>    <br />
             <div class="row" id="header-styling">
                   <div class="col-md-12">

                       <div class="media">
                           
                           <div class="col-md-4">
                               <div class="form-group">      
                                   <label class="text-bold-600 font-small-3">Usuario</label>
                                   <asp:TextBox ID="bname" CssClass="form-control text-uppercase" placeholder="Búsqueda por Nombre" name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                               </div>
                           </div>

                           <div class="col-md-2" id="busplantel" runat="server">
                               <div class="form-group">
                                   <label class="text-bold-600 font-small-3">Plantel</label>
                                   <asp:DropDownList runat="server" ID="bplantel" CssClass="select2 form-control" DataSourceID="DSplantel" DataTextField="nombre" DataValueField="idsucursal" AppendDataBoundItems="true" onChange="consultaPrincipal()">
                                       <asp:ListItem Value="0" Text="SELECCIONE UN PLANTEL"></asp:ListItem>
                                   </asp:DropDownList>
                                   <asp:SqlDataSource ID="DSplantel" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idsucursal, nombre FROM sucursal ORDER BY nombre"></asp:SqlDataSource>
                               </div>
                           </div>
                                                                                                               
                       </div>

                   </div>
               </div>
        
        <div class="row" id="header-styling">
                <div class="col-xs-12">
                    <div class="card">
                   
                        <div class="card-block card-dashboard"> 
                        <div style="overflow-x:auto;width:100%"> 
                        <asp:GridView runat="server" ID="lusuarios" PageSize="25" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered base-style" 
                             AutoGenerateColumns="False" DataSourceID="DsUsuarios" DataKeyNames="idusuario"
                            OnDataBinding="conteoRegistros">    
                                                 
                            <Columns>
                                <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center"  HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda font-small-3"> 
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                </asp:TemplateField>         
                                
                                 <asp:TemplateField HeaderText="Usuario" HeaderStyle-CssClass="primary">
                                                    <ItemTemplate>

                                                        <h7 class="font-weight-bold"><%# Eval("nombre")%></h7><br />
                                                        <h7 class="font-small-3 font-italic text-bold-600"><i class="fa fa-home"></i> <%# " "+Eval("sucursal")%></h7>
                                                        <br />
                                                        <h7 class="text-bold-400 font-small-2"><i class="fa fa-user "></i> <%# " "+Eval("rol")%></h7>
                                                       

                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                                                      
                                <asp:TemplateField HeaderText="Activo" ItemStyle-Width="20px"  ItemStyle-HorizontalAlign="Center"  HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda font-small-3">
                                     <ItemTemplate>  
                                         <div class="row skin skin-flat">
                                            <div class="state icheckbox_flat-green <%# Eval("activo")%> mr-1"></div>
                                         </div>
                                     </ItemTemplate>
                                </asp:TemplateField>                                                               
                                <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="100px"  HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda font-small-3">
                                     <ItemTemplate>                                                                                                      

                                                    <button type="button" id="editar" onclick="editarRegistro(<%# Eval("idusuario")%>)" class="btn btn-icon btn-warning mr-1 btn-sm" data-toggle="tooltip" data-original-title="Editar">
                                                         <i class="ft-edit"></i>
                                                    </button>

                                                     
                                                                                                         
                                    </ItemTemplate>
                                 </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="DsUsuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" 
                            SelectCommand="SELECT u.idusuario, (CONCAT(COALESCE(u.nombre,''),' ',COALESCE(u.apaterno,''),' ',COALESCE(u.amaterno,'')))as nombre, u.email, u.telefono,  CASE WHEN u.activo=1 THEN 'checked' ELSE '' END as activo, t.TIPOUSUARIO, s.nombre as sucursal, 
                                                (
                                            select GROUP_CONCAT(t.tipousuario) from tipousuario t where FIND_IN_SET (cast(t.idtipousuario as char) , replace(u.roles,'|',','))
                                            )  as rol
                                                from usuario u
                                                left join tipousuario t on u.idtipousuario = t.idtipousuario
                                                left join sucursal s on s.idsucursal = u.idsucursal
                                                order by sucursal, u.nombre"></asp:SqlDataSource>
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

    <script src="/app-assets/js/scripts/forms/select/form-select2.js"></script>
    <script>
        //$(document).prop('title', 'PLACEL - Promovidos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catusuarios").addClass("active");

        function editarRegistro(id) {
            mostrarLoading();
           $("*[id$='idP']").val(id);
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
