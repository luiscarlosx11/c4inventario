<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="frminscripcion.aspx.cs" Inherits="elecion.inscripcion.frminscripcion" EnableEventValidation="false" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

        <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css"/>

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/daterange/daterangepicker.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/datetime/bootstrap-datetimepicker.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/pickers/pickadate/pickadate.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/pickers/daterange/daterange.css"/>

    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/calendars/fullcalendar.min.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/calendars/fullcalendar.css"/>

    <link rel="stylesheet" type="text/css" href="/app-assets/css/pages/email-application.css"/>

    <style>

body { padding-right: 0 !important }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="titulobreads" runat="server">
    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cuerpo" runat="server">
 <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>            
    <asp:Button runat="server" ID="BimprimirSolicitud" OnClick="imprimeSolicitud" Style="display: none" UseSubmitBehavior="false"/>
    <asp:Button runat="server" ID="BimprimirCredencial" OnClick="imprimeCredencial" Style="display: none" UseSubmitBehavior="false"/>
                              
   
    <asp:UpdatePanel runat="server" ID="UpdatePanel10" UpdateMode="Conditional">
        <ContentTemplate>


            <asp:HiddenField runat="server" ID="idA" Value="0" />
            <asp:HiddenField runat="server" ID="idI" />
            <asp:HiddenField runat="server" ID="idUbicacion" />
            <asp:HiddenField runat="server" ID="idOP" />
            <asp:HiddenField runat="server" ID="limite" Value="48" />
            <asp:HiddenField runat="server" ID="idS" />
            <asp:HiddenField runat="server" ID="idF" />
            <asp:HiddenField runat="server" ID="idctr" />

            <asp:HiddenField runat="server" ID="idDoc" />
            <asp:HiddenField runat="server" ID="idP" />

            <asp:Button runat="server" ID="bbuscacursos" OnClick="listadoAlumnos" Style="display: none" UseSubmitBehavior="false" />
            <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" Style="display: none" UseSubmitBehavior="false" />

            <asp:Button runat="server" ID="Bseleccionar" OnClick="getBien" Style="display: none" UseSubmitBehavior="false"/>
            <asp:Button runat="server" ID="bvolver" OnClick="volverCursos" Style="display: none" UseSubmitBehavior="false" />
            <asp:Button runat="server" ID="Bconsultar" OnClick="listadoClientes" Style="display: none" UseSubmitBehavior="false" />
            <asp:Button runat="server" ID="Bnuevo" OnClick="limpiarCampos" Style="display: none" UseSubmitBehavior="false" />
            <asp:Button runat="server" ID="BnuevoInscripcion" OnClick="limpiarCamposInscripcion" Style="display: none" UseSubmitBehavior="false" />
            <asp:Button runat="server" ID="Bcancelarcurso" OnClick="cancelaAlumno" Style="display: none" UseSubmitBehavior="false" />
            <asp:Button runat="server" ID="Bmodificaalumno" OnClick="modificaAlumno" Style="display: none" UseSubmitBehavior="false" />
            
            <asp:Button runat="server" ID="bimprimir" OnClick="imprimeSalida" UseSubmitBehavior="false" Style="display: none" />           
            <asp:Button runat="server" ID="bautorizacion" OnClick="solicitaAutorizacion" Style="display: none" UseSubmitBehavior="false" />
            <asp:Button runat="server" ID="Beditar" OnClick="editaRegistro" Style="display: none" UseSubmitBehavior="false" />
            <asp:Button runat="server" ID="bfechascurso" OnClick="generaFechasCurso" UseSubmitBehavior="false" Style="display: none" />
            <asp:Button runat="server" ID="eliminarFechas" OnClick="borraFechas" Style="display: none" CausesValidation="false" UseSubmitBehavior="false" />
            <asp:Button runat="server" ID="guardarFechas" OnClick="guardaEditaFechas" Style="display: none" CausesValidation="false" UseSubmitBehavior="false" />
            <asp:Button runat="server" ID="Bfechas" OnClick="listadoFechas" Style="display: none" UseSubmitBehavior="false" />



            <span id="gridCursos" runat="server" visible="true">
                <div class="content-header row">
                    <div class="col-md-3">
                        <div class="media-left media-middle">
                            <i class="icon-pencil primary font-large-2 mr-1"></i>
                        </div>
                        <div class="media-body">
                            <h4 class="font-weight-bold">Salidas</h4>
                            <span class="font-small-3">
                                <asp:Label runat="server" ID="labelConteo">0</asp:Label>
                                registro(s) encontrado(s)</span>
                        </div>

                    </div>
                    <div class="col-md-9 float-md-right">

                        <span class="pull-right">
                            <label class="text-bold-600 font-small-3"></label>
                            <button type="button" id="nuevo" onclick="nuevaSalida()" class="btn btn-icon btn-primary mr-1 text-bold-700">
                                Nueva salida 
                            </button>
                        </span>
                    </div>
                </div>
                <br />
                <div class="row" id="header-styling">
                    <div class="col-md-12">


                        <div class="media">

                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="text-bold-600 font-small-3">Folio</label>
                                    <asp:TextBox ID="bfolio" CssClass="form-control text-uppercase" placeholder="Búsqueda por folio..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="text-bold-600 font-small-3">Descripción</label>
                                    <asp:TextBox ID="bdescripcion" CssClass="form-control text-uppercase" placeholder="Búsqueda por descripción..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="text-bold-600 font-small-3">Recibe</label>
                                    <asp:TextBox ID="brecibe" CssClass="form-control text-uppercase" placeholder="Búsqueda por persona que recibe..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label class="text-bold-600 font-small-3">Centro</label>
                                    <asp:DropDownList runat="server" ID="bcentro" CssClass="select2 form-control" DataSourceID="DSBuscentro" DataTextField="centro" DataValueField="idcentro" AppendDataBoundItems="true" onChange="consultaPrincipal()">
                                        <asp:ListItem Value="-1" Text="SELECCIONE UN CENTRO"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="DSBuscentro" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idcentro, centro FROM centro ORDER BY idcentro"></asp:SqlDataSource>
                                </div>
                            </div>

                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="">

                                    <div class="card-body collapse in">

                                        <div class="row">

                                            <div class="card-block">
                                                <div style="overflow-x: auto; width: 100%; background-color: white">
                                                    <asp:GridView runat="server" ID="lGeneral" PageSize="50" AllowPaging="true" AllowSorting="true" CssClass="table table-striped lGeneral"
                                                        AutoGenerateColumns="False" DataSourceID="DsUsuarios" EnableSortingAndPagingCallbacks="true"
                                                        OnPageIndexChanged="listadoClientes" GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static">
                                                        <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                                        <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                                        <Columns>

                                                            <asp:TemplateField HeaderText="Generales" HeaderStyle-CssClass="primary">
                                                                <ItemTemplate>
                                                                    <h7 class="font-weight-bold"><%# "FOLIO "+Eval("folio")%></h7>
                                                                    <br />
                                                                    <h7 class="font-small-3 font-italic text-bold-600"><%# Eval("descripcion")%></h7>
                                                                    <br />
                                                                    <h7 class="text-bold-400 font-small-2"> <%# Eval("fechatext")%></h7>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Recibe" HeaderStyle-CssClass="primary" ItemStyle-Width="300px">
                                                                <ItemTemplate>
                                                                    <h7 class="font-weight-bold"><%# Eval("cargo")%></h7>
                                                                    <br />
                                                                    <h7 class="font-small-3 font-italic text-bold-600"><%# Eval("usuario")%></h7>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                                <ItemTemplate>
                                                                    <button type="button" class="btn btn-icon btn-warning mr-1 btn-sm tooltips" onclick="buscacursos(<%# Eval("idsalida") %>)" value="" data-toggle="tooltip" data-original-title="Ver Detalle"><i class="ft-edit"></i></button>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>

                                                    </asp:GridView>

                                                    <asp:SqlDataSource ID="DsUsuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>

                                                </div>

                                                <div id="divNoRegistros" runat="server" visible="false" class="centrarCelda">
                                                    <div class="col-md-12">
                                                        <div class="row align-items-center justify-content-center" style="padding-top: 100px">
                                                            <span class="h2 text-center">NO HAY REGISTROS QUE MOSTRAR</span>
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


                </div>
            </span>

        </ContentTemplate>
    </asp:UpdatePanel>
               
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>
                                                              
            <span id="gridAlumnos" runat="server" visible="false">
                <div class="content-header row">
                    <div class="col-md-4">
                        <div class="media-left media-middle">
                            <i class="icon-pencil primary font-large-2 mr-1"></i>
                        </div>
                        <div class="media-body">
                            <asp:Label runat="server" ID="labeltitulo" CssClass="h4 font-weight-bold">Salidas</asp:Label><br />
                            <span class="font-small-3 text-bold-600"><asp:Label runat="server" ID="labelCurso" ></asp:Label></span>
                            <span class="font-small-3 text-bold-600"> *** FECHA <asp:Label runat="server" ID="labelfecha" CssClass="font-small-3" >2021-01-01</asp:Label></span>
                        </div>

                    </div>
                    <div class="col-md-8 float-md-right">

                                <span class="pull-right">
                                    <label class="text-bold-600 font-small-3"></label>
                                    <button type="button" id="Button3" onclick="volveracursos()" class="btn btn-icon btn-danger mr-1 text-bold-700" data-toggle="modal" runat="server">
                                        Volver a Salidas
                                    </button>
                                    
                                    <label class="text-bold-600 font-small-3"></label>
                                    <button type="button" id="nuevo" onclick="abrirModalAlumnos();" class="btn btn-icon btn-primary mr-1 text-bold-700" data-toggle="modal" runat="server">
                                        Añadir bienes
                                    </button>
                                    <br /><br />
                                    <div class="btn-group btn-group-sm" role="group" aria-label="">
                                        <button type="button" class="btn btn-secondary" onclick="guardarEditar()" ><i class="fa fa-save"></i> Guardar</button>                                        
                                        <button type="button" class="btn btn-secondary" onclick="imprimirSalida()"><i class="fa fa-print"></i> Imprimir</button>                                        
                                    </div>
                                </span>
                            </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="media">
                            <br />
                            <div class="col-md-3">
                                <div class="form-group" id="barrabus" runat="server">
                                    <label class="text-bold-600 font-small-3">Descripción</label>
                                    <asp:TextBox ID="descripcion" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Ingrese una descripción para la salida" name="busnom" runat="server" ></asp:TextBox>
                                    
                                </div>
                            </div> 
                            <div class="col-md-3">
                                <div class="form-group" id="Div2" runat="server">
                                    <label class="text-bold-600 font-small-3">Cargo</label>
                                    <asp:TextBox ID="cargo" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Ingrese el cargo de quien recibe" name="busnom" runat="server" ></asp:TextBox>
                                    
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group" id="Div1" runat="server">
                                    <label class="text-bold-600 font-small-3">Recibe</label>
                                    <asp:TextBox ID="usuario" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Ingrese el nombre de la persona que recibe" name="busnom" runat="server" ></asp:TextBox>
                                    
                                </div>
                            </div>
                            
                            <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="text-bold-600 font-small-3">Centro</label>
                                                <asp:DropDownList runat="server" ID="scentro" CssClass="select2 form-control" DataSourceID="DSscentro" DataTextField="centro" DataValueField="idcentro">                                                   
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="DSscentro" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idcentro, centro FROM centro where idcentro>0 ORDER BY idcentro"></asp:SqlDataSource>
                                            </div>
                                        </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="">

                                    <div class="card-body collapse in">

                                        <div class="row">

                                            <div class="card-block">
                                                <div style="overflow-x: auto; width: 100%; background-color: white">
                                                    
                                                     <asp:Button runat="server" ID="bsolicitud" OnClick="eliminaBien" Style="display: none" CausesValidation="false"  UseSubmitBehavior="false" />

                                                    <div style="overflow-x: auto; width: 100%">
                                                        <asp:GridView runat="server" ID="GValumnos" PageSize="50" AllowPaging="true" AllowSorting="false" CssClass="table table-striped lGeneral"
                                                            AutoGenerateColumns="False" DataSourceID="DSalumnos" OnDataBinding="conteoRegistros" 
                                                           OnPageIndexChanged="listadoAlumnos" GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static">

                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Generales" HeaderStyle-CssClass="primary">
                                                                    <ItemTemplate>
                                                                        <h7 class="font-weight-bold"><%# Eval("noinventario")%></h7>
                                                                        <br />
                                                                        <h7 class="font-small-3 font-italic text-bold-600"><%# " "+Eval("descripcion")%></h7>
                                                                        <br />
                                                                        <h7 class="text-bold-400 font-small-2"> <%# " MARCA "+Eval("marca")+ ", MODELO "+Eval("modelo")+ ", NO SERIE. "+Eval("noserie") %></h7>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Ubicación" HeaderStyle-CssClass="primary" ItemStyle-Width="300px">
                                                                    <ItemTemplate>
                                                                        <h7 class="font-weight-bold"><%# Eval("ubicacionsalida") %></h7>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="80px" ItemStyle-CssClass="centrarCelda primary" HeaderStyle-CssClass="centrarCelda primary">
                                                                    <ItemTemplate>                                                                        
                                                                        <button type="button" class="btn btn-icon btn-pure btn-sm mr-1 danger tooltips" onclick="borraBien(<%# Eval("idbien") %>)" value="" data-toggle="tooltip" data-original-title="Eliminar"><i class="fa fa-trash"></i></button>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>

                                                        </asp:GridView>

                                                        <asp:SqlDataSource ID="DSalumnos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>

                                                    </div>

                                                </div>

                                                <div id="divNoRegistrosAlumnos" runat="server" visible="false" class="centrarCelda">
                                                    <div class="col-md-12">
                                                        <div class="row align-items-center justify-content-center" style="padding-top: 100px">
                                                            <span class="h2 text-center">NO HAY REGISTROS QUE MOSTRAR</span>
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
                </div>
            </span>

            </ContentTemplate>
        </asp:UpdatePanel>
  
    <div class="modal fade" id="walumnos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title" id="myModalLabel35">Listado de bienes</h3>
                        </div>


                        <div class="modal-body">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>

                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Consulta</label>
                                                <asp:TextBox ID="bbiendescripcion" CssClass="form-control text-uppercase" placeholder="Búsqueda por no. inventario, no. de serie, descripción..." name="nombre" runat="server" OnTextChanged="listadoAlumnosBus" AutoPostBack="true">

                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div style="overflow-x: auto; width: 100%">
                                                <asp:GridView runat="server" ID="GVlistaalumnos" PageSize="5" AllowPaging="true" AllowSorting="true" CssClass="table table-striped lGeneral"
                                                    AutoGenerateColumns="False" DataSourceID="DSlistaalumnos" DataKeyNames="idbien" GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static"
                                                     OnPageIndexChanged="listadoAlumnosBus">                                                    
                                                    <Columns>                                                       
                                                        <asp:TemplateField HeaderText="Generales" HeaderStyle-CssClass="primary">
                                                            <ItemTemplate>
                                                                <h7 class="font-weight-bold"><%# Eval("noinventario")%></h7>
                                                                <br />
                                                                <h7 class="font-small-3 font-italic text-bold-600"><%# " "+Eval("descripcion")%></h7>
                                                                <br />
                                                                <h7 class="text-bold-400 font-small-2"> <%# " MARCA "+Eval("marca")+ ", MODELO "+Eval("modelo")+ ", "+" NO SERIE. "+Eval("noserie")%></h7>
                                                                
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField ItemStyle-Width="300px" HeaderText="Ubicación" HeaderStyle-CssClass="primary">
                                                            <ItemTemplate>
                                                                <input type="text" id="<%# "bien_"+Eval("idbien")%>" class="form-control  text-uppercase">
                                                                
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Seleccionar" ItemStyle-Width="80px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda">
                                                            <ItemTemplate>
                                                                <button type="button" onclick="seleccionar(<%# Eval("idbien")%>)" class="btn btn-icon btn-pure btn-sm mr-1 primary tooltips" data-toggle="tooltip" data-original-title="Seleccionar">
                                                                    <i class="fa fa-hand-pointer-o"></i>
                                                                </button>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>

                                                    <PagerSettings Mode="NumericFirstLast"
                                                        
                                                        Position="Bottom" />
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="DSlistaalumnos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>
                                            </div>
                                        </div>
                                         <div id="divResultados" runat="server" visible="false" class="centrarCelda">                                                                                                                               
                                             <div class="col-md-12">
                                                 <div class="row align-items-center justify-content-center" style="padding-top: 20px">
                                                     <span class="h2 text-center">NO HAY REGISTROS QUE MOSTRAR</span>
                                                 </div>
                                             </div>
                                        </div>
                                    </div>
                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                        <div class="modal-footer">
                            <asp:Button runat="server" ID="Button1" Style="display: none" CausesValidation="false" UseSubmitBehavior="false"/>
                            <asp:Button runat="server" ID="borrar" Style="display: none" UseSubmitBehavior="false"/>
                        </div>
                    </div>
                </div>
            </div>
            

    <div class="modal fade" id="wcancelar" tabindex="-1" role="dialog" aria-labelledby="myModalLabel40" aria-hidden="true">

        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 class="modal-title">Eliminar Alumno</h3>
                </div>


                <div class="modal-body">

                   

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-bold-600">Observaciones</label>
                                <asp:TextBox ID="motcancelacion" CssClass="form-control text-uppercase" MaxLength="0" TextMode="MultiLine" Rows="3" placeholder="Observaciones" name="telefono" runat="server"></asp:TextBox>

                            </div>
                        </div>
                    </div>

                </div>

                <div class="modal-footer">

                    <button class="btn btn-primary" onclick="cancelarCurso()" type="button" data-backdrop="false">
                        <i class="fa fa-check-square-o"></i>Aceptar
                    </button>

                    <button type="button" class="btn btn-danger mr-1" data-dismiss="modal">
                        <i class="ft-x"></i>Cerrar
                    </button>
                </div>


            </div>


        </div>

    </div>


     <div class="modal fade" id="wmodificar" tabindex="-1" role="dialog" aria-labelledby="myModalLabel40" aria-hidden="true">

        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 class="modal-title">Modificar Alumno</h3>
                </div>


                <div class="modal-body">

                   

                </div>

                <div class="modal-footer">

                    <button class="btn btn-primary" onclick="modificaAlumno()" type="button" data-backdrop="false">
                        <i class="fa fa-check-square-o"></i>Aceptar
                    </button>

                    <button type="button" class="btn btn-danger mr-1" data-dismiss="modal">
                        <i class="ft-x"></i>Cerrar
                    </button>
                </div>


            </div>


        </div>

    </div>



    <div class="modal fade" id="wfoto" tabindex="-1" role="dialog" aria-labelledby="myModalLabel40" aria-hidden="true">

        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 class="modal-title">Eliminar Alumno</h3>
                </div>


                <div class="modal-body">

                    <div class="row">

                        <div class="col-md-12">
                            <div id="my_camera"></div>
                        </div>

                    </div>

                   

                </div>

                <div class="modal-footer">

                    <button class="btn btn-primary" onclick="cancelarCurso()" type="button" data-backdrop="false">
                        <i class="fa fa-check-square-o"></i>Aceptar
                    </button>

                    <button type="button" class="btn btn-danger mr-1" data-dismiss="modal">
                        <i class="ft-x"></i>Cerrar
                    </button>
                </div>


            </div>


        </div>

    </div>
   
    
</asp:Content>


<asp:Content ID="Content5" ContentPlaceHolderID="JavaScript" runat="server">
    
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.date.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/picker.time.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/pickers/pickadate/legacy.js" type="text/javascript"></script>


    <script src="/app-assets/vendors/js/extensions/moment.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/fullcalendar.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/lang-all.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/locale-all.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/forms/extended/form-inputmask.min.js" type="text/javascript"></script>
  
    <script src="/app-assets/js/scripts/ui/scrollable.js"></script>

  
    <script type="text/javascript" src="/assets/js/webcam/webcam.min.js"></script>
    <script>
        //$(document).prop('title', 'PLACEL - Promovidos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#frminscripcion").addClass("active");
        var walert = 0;
        var fecha = '';
        
        var initialLangCode = 'es';
        var dataEvent;                               
                
       

        function showpreview(input) {

            if (input.files && input.files[0]) {
                
                var reader = new FileReader();
                reader.onload = function (e) {                  
                   // $('#fotop').attr('src', e.target.result);
                    $("*[id$='fotopa']").attr('src', e.target.result);
                    $("*[id$='hpicture']").val(e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }

        }

        $('#walumnos').on('shown.bs.modal', function () {
            //alert($("*[id$='idF']").val());
            
                $("*[id$='bbiendescripcion]").focus();

        })


        function buscacursos(idgrupo) {
            $("*[id$='idP']").val(idgrupo);
                
            mostrarLoading();            
            $('#<%= bbuscacursos.ClientID %>').click();
                                                                 
        }

        function volveracursos() {
            mostrarLoading();
            $("*[id$='idP']").val(0);
            
            $('#<%= bvolver.ClientID %>').click();         
        }


        function paging(pagina) {
            $("*[id$='pagina']").val(pagina);
            $('#<%= Bconsultar.ClientID %>').click();
        }

        function isValidDate(dateString) {
            var regEx = /^\d{4}-\d{2}-\d{2}$/;
            if (!dateString.match(regEx)) return false;  // Invalid format
            var d = new Date(dateString);
            if (Number.isNaN(d.getTime())) return false; // Invalid date
            return d.toISOString().slice(0, 10) === dateString;

        }


        function abrirModalAlumnos() {            
            //$(".modal-backdrop").remove();
            //$("#bootstrap").modal('hide');
            $("*[id$='bbiendescripcion']").focus();
            $("#divResultados").hide();
            $("#walumnos").modal('show');
            //$("#wfoto").modal('show');

                      
        }

        function valida() {
       
            var nombre = $("*[id$='nombre']").val();
            var fechaini = $("*[id$='fechaini']").val();
            var fechafin = $("*[id$='fechafin']").val(); 
            var dias = $("*[id$='dias']").val(); 
            var horaini = $("*[id$='horaini']").val();                        
            var horafin = $("*[id$='horafin']").val(); 
            var horas = $("*[id$='horas']").val(); 
            var diascurso = $("*[id$='hdias']").val();

            var costomodulo = $("*[id$='costomodulo']").val(); 
            var costoalumno = $("*[id$='costoalumno']").val(); 
            var pagohora = $("*[id$='pagohora']").val();

            var instalacion = $("*[id$='instalacion']").val();
            var instalacionext = $("*[id$='instalacionext']").val();
            var instalaciondomext = $("*[id$='instalaciondomext']").val();
            var alumnosminimo = $("*[id$='alumnosminimo']").val();
            var fechalimite = $("*[id$='fechalimite']").val();
            
            walert = 1;
            if (nombre == '') {                
                alerta('Atención', 'Ingrese el nombre del curso', 'warning', $("*[id$='nombre']"));
                return false;                
            }


            if (fechalimite == '') {
                alerta('Atención', 'Ingrese la fecha límite de inscripción al curso', 'warning', $("*[id$='fechalimite']"));
                return false;
            }

            if (alumnosminimo == '' || alumnosminimo == '0') {                
                alerta('Atención', 'Ingrese la cantidad mínima necesaria de alumnos inscritos', 'warning', $("*[id$='alumnosminimo']"));
                return false;                
            }

            if (instalacion == '9999' && instalacionext == '') {                
                alerta('Atención', 'Ingrese el nombre de la instalación extramuros', 'warning', $("*[id$='instalacionext']"));
                return false;                
            }

            if (instalacion == '9999' && instalaciondomext == '') {                
                alerta('Atención', 'Ingrese la dirección de la instalación extramuros', 'warning', $("*[id$='instalaciondomext']"));
                return false;                
            }


            if (fechaini == '') {
                alerta('Atención', 'Ingrese la fecha de inicio del curso', 'warning', $("*[id$='fechaini']"));
                return false;
            }

            if (fechafin == '') {
                alerta('Atención', 'Ingrese la fecha de término del curso', 'warning', $("*[id$='fechafin']"));
                return false;
            }
                       
            if (dias == '' || dias=='0') {
                alerta('Atención', 'Ingrese la duración en días del curso', 'warning', $("*[id$='dias']"));
                return false;
            }

            if (horaini == '') {
                alerta('Atención', 'Ingrese el horario (hora de inicio) del curso', 'warning', $("*[id$='horaini']"));
                return false;
            }


            if (horafin == '') {
                alerta('Atención', 'Ingrese el horario (hora de término) del curso', 'warning', $("*[id$='horafin']"));
                return false;
            }

            if (diascurso == '') {
                alerta('Atención', 'Indique los días de la semana en los cuales se impartirá el curso', 'warning', $("*[id$='hdias']"));
                return false;
            }


            if (horas == '' || horas =='0') {
                alerta('Atención', 'Ingrese la duración en horas del curso', 'warning', $("*[id$='horas']"));
                return false;
            }

                              
            walert = 0;
            //$('#bootstrap').modal('hide');
            mostrarLoading();
            
            $('#<%= guardar.ClientID %>').click();
                       
                                           
        }


        function validaIns() {
       
           
            var nocontrol = $("*[id$='nocontrol']").val();
            var nombrealumno = $("*[id$='nombrealumno']").val();

            var apaterno = $("*[id$='apaterno']").val(); 
            var amaterno = $("*[id$='amaterno']").val(); 
            var curp = $("*[id$='curp']").val();  
            var fechanacimiento = $("*[id$='fechanacimiento']").val();
            var telefono = $("*[id$='telefono']").val(); 
            var domicilio = $("*[id$='domicilio']").val(); 
            var colonia = $("*[id$='colonia']").val();

            var tagsmed = $("*[id$='tagsmed']").val(); 
            var tagsmot = $("*[id$='tagsmot']").val(); 
            var tagsdiscap = $("*[id$='tagsdiscap']").val();

            var apoyo = $("*[id$='apoyo']").val();
            var porcentaje = $("*[id$='porcentaje']").val();

                      
            walert = 1;

            if (nocontrol == '') {                
                alerta('Atención', 'Ingrese el número de control del alumno', 'warning', $("*[id$='nocontrol']"));
                return false;                
            }

            if (nombrealumno == '') {                
                alerta('Atención', 'Ingrese el nombre del alumno', 'warning', $("*[id$='nombrealumno']"));
                return false;                
            }


            if (apaterno == '') {
                alerta('Atención', 'Ingrese el nombre(apellido paterno) del alumno', 'warning', $("*[id$='apaterno']"));
                return false;
            }

            if (amaterno == '') {
                alerta('Atención', 'Ingrese el nombre(apellido materno) del alumno', 'warning', $("*[id$='amaterno']"));
                return false;
            }
                                    
            if (fechanacimiento == '') {
                alerta('Atención', 'Ingrese la fecha de nacimiento del alumno', 'warning', $("*[id$='fechanacimiento']"));
                return false;
            }

            if (!isValidDate(fechanacimiento)) {
                alerta('Atención', 'Ingrese una fecha válida de nacimiento', 'warning', $("*[id$='fechanacimiento']"));
                return false;
            }

            if (domicilio == '') {
                alerta('Atención', 'Ingrese el domicilio(calle y número) del alumno', 'warning', $("*[id$='domicilio']"));
                return false;
            }

            if (colonia == '') {
                alerta('Atención', 'Ingrese el domicilio(colonia) del alumno', 'warning', $("*[id$='colonia']"));
                return false;
            }

            if (apoyo == 1 && porcentaje=="0" ) {

                alerta('Atención', 'Ingrese el porcentaje de apoyo económico que recibe el alumno', 'warning', $("*[id$='porcentaje']"));
                return false;
            }
                                   
            if (tagsmed == '') {
                alerta('Atención', 'Indique el(los) medio(s) por el que se enteró del sistema de capacitación', 'warning', $("*[id$='medio']"));
                return false;
            }

            if (tagsmot == '') {
                alerta('Atención', 'Indique el(los) motivo(s) para la elección del sistema de capacitación', 'warning', $("*[id$='motivo']"));
                return false;
            }


                                         
            walert = 0;
            //$('#bootstrap').modal('hide');
            mostrarLoading();
            
            
                       
                                           
        }


        function solicita() {
            
            var nombre = $("*[id$='nombre']").val();
            var fechaini = $("*[id$='fechaini']").val();
            var fechafin = $("*[id$='fechafin']").val(); 
            var dias = $("*[id$='dias']").val(); 
            var horaini = $("*[id$='horaini']").val();                        
            var horafin = $("*[id$='horafin']").val(); 
            var horas = $("*[id$='horas']").val(); 
            var diascurso = $("*[id$='hdias']").val();

            var costomodulo = $("*[id$='costomodulo']").val(); 
            var costoalumno = $("*[id$='costoalumno']").val(); 
            var pagohora = $("*[id$='pagohora']").val(); 
            
            walert = 1;
            if (nombre == '') {                
                alerta('Atención', 'Ingrese el nombre del curso', 'warning', $("*[id$='nombre']"));
                return false;                
            }

            if (fechaini == '') {
                alerta('Atención', 'Ingrese la fecha de inicio del curso', 'warning', $("*[id$='fechaini']"));
                return false;
            }

            if (fechafin == '') {
                alerta('Atención', 'Ingrese la fecha de término del curso', 'warning', $("*[id$='fechafin']"));
                return false;
            }
                       
            if (dias == '' || dias=='0') {
                alerta('Atención', 'Ingrese la duración en días del curso', 'warning', $("*[id$='dias']"));
                return false;
            }

            if (horaini == '') {
                alerta('Atención', 'Ingrese el horario (hora de inicio) del curso', 'warning', $("*[id$='horaini']"));
                return false;
            }


            if (horafin == '') {
                alerta('Atención', 'Ingrese el horario (hora de término) del curso', 'warning', $("*[id$='horafin']"));
                return false;
            }


            if (horas == '' || horas =='0') {
                alerta('Atención', 'Ingrese la duración en horas del curso', 'warning', $("*[id$='horas']"));
                return false;
            }


            if (costomodulo == '' || costomodulo == '0') {
                $("#tabcostos").click();
                alerta('Atención', 'Ingrese el costo del módulo del curso', 'warning', $("*[id$='costomodulo']"));
                return false;
            }


            if (costoalumno == '' || costoalumno == '0') {
                $("#tabcostos").click();
                alerta('Atención', 'Ingrese el costo por alumno del curso', 'warning', $("*[id$='costoalumno']"));
                return false;
            }


            if (pagohora == '' || pagohora == '0') {
                $("#tabcostos").click();
                alerta('Atención', 'Ingrese el pago por hora al instructor del curso', 'warning', $("*[id$='pagohora']"));
                return false;
            }

            if (diascurso == '') {
                alerta('Atención', 'Indique los días de la semana en los cuales se impartirá el curso', 'warning', $("*[id$='algo']"));
                return false;
            }
                              
            walert = 0;
            
            mostrarLoading();
            
            swal({
                title: "Se solicitará la autorización para este curso, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#DD6B55',
                confirmButtonText: 'Si',
                cancelButtonText: "No"
            }).then((result) => {
                if (result.value) {
                    mostrarLoading();
                    
                  }
                }) 
           
                                           
        }


        function guardarEditar() {

            var usuario = $("*[id$='usuario']").val();
            var cargo = $("*[id$='cargo']").val();
            var descripcion = $("*[id$='descripcion']").val();

            walert = 1;
            if (descripcion == '') {
                alerta('Atención', 'Ingrese una descripción para la salida', 'warning', $("*[id$='descripcion']"));
                return false;
            }
            if (cargo == '') {
                alerta('Atención', 'Ingrese el cargo de la persona que recibe', 'warning', $("*[id$='cargo']"));
                return false;
            }
            if (usuario == '') {
                alerta('Atención', 'Ingrese el nombre de la persona que recibe', 'warning', $("*[id$='usuario']"));
                return false;
            }

            

            walert = 0;

            mostrarLoading();            
            $('#<%= guardar.ClientID %>').click();                                                                  
        }

        


        function calendario() {


            var fechaini = $("*[id$='fechaini']").val();
            var fechafin = $("*[id$='fechafin']").val();             
            var horaini = $("*[id$='horaini']").val();                        
            var horafin = $("*[id$='horafin']").val(); 
            var diascurso = $("*[id$='hdias']").val();

            if (fechaini == '' || fechafin == ''|| horaini == '' || horafin == '' || diascurso == '') {                
                return false;
            }
            
           mostrarLoading();
            $('#<%= bfechascurso.ClientID %>').click();
                     
        }


        function seleccionar(idbien) {

            var ubicacion = $("#bien_" + idbien).val();
            if (ubicacion == '') {
                alerta('Atención', 'Ingrese la ubicación o destino del bien', 'warning', $("#bien_" + idbien));
                return false;
            }

            mostrarLoading();
            $("*[id$='idA']").val(idbien);
            $("*[id$='idUbicacion']").val(ubicacion);

            $('#<%= Bseleccionar.ClientID %>').click();
                                    
        }

        function borraBien(idbien) { 

            swal({
                title: "Se eliminará el bien de la salida, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#DD6B55',
                confirmButtonText: 'Si',
                cancelButtonText: "No"
            }).then((result) => {
                if (result.value) {
                    mostrarLoading();
                    $("*[id$='idA']").val(idbien);
                    $('#<%= bsolicitud.ClientID %>').click();
                }
            }) 
                                                
        }
		
		
       
        function editarRegistro(id, ids) {
            
            mostrarLoading();
            $("*[id$='idP']").val(id);
            $("*[id$='idS']").val(ids);
           $('#<%= Beditar.ClientID %>').click();
        }

        function nuevaSalida() {
            mostrarLoading();
            $("*[id$='idP']").val(0);
            $("*[id$='idA']").val(0);
            $("*[id$='idI']").val(0);
           
            $('#<%= BnuevoInscripcion.ClientID %>').click();
        }


        function consultaPrincipal(op) {
            mostrarLoading();

            if (op)
                $("*[id$='idOP']").val(op);
            else
                $("*[id$='idOP']").val(2);

            $('#<%= Bconsultar.ClientID %>').click();
             cerrarLoading();
        }


         function consultaAlumnos() {
            mostrarLoading();
            $('#<%= bbuscacursos.ClientID %>').click();
            cerrarLoading();
        }

       

             
    </script>
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="PageLevelJS" runat="server">
   

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

               // $("*[id$='cp']").ForceNumericOnly(); 
               // $("*[id$='seccion']").ForceNumericOnly();
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
                loadJS("/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js");
                loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                

                loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");

                loadJS("/app-assets/vendors/js/pickers/dateTime/moment-with-locales.min.js");
                loadJS("/app-assets/vendors/js/pickers/dateTime/bootstrap-datetimepicker.min.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.date.js");
                loadJS("/app-assets/vendors/js/pickers/pickadate/picker.time.js");
                loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");
            
                loadJS("/app-assets/vendors/js/extensions/moment.min.js");
                loadJS("/app-assets/vendors/js/extensions/fullcalendar.min.js");
                loadJS("/app-assets/vendors/js/extensions/lang-all.js");

                loadJS("/app-assets/vendors/js/extensions/locale-all.js");
                loadJS("/app-assets/js/scripts/ui/scrollable.js");

               // loadJS("/assets/js/webcam/webcam.min.js");

              
            
                walert = 0;
                fecha = $("*[id$='fechaini']").val();                
                $('#walumnos').on('shown.bs.modal', function () {
                    $("*[id$='bbiendescripcion']").focus();
                });

            
            $(document).ready(function () {
                $('.cks').iCheck({
                    checkboxClass: 'icheckbox_flat-green',
                    increaseArea: '20%' // optional
                });

                $('.tooltips').tooltip();
                                              
                if ($("*[id$='hpicture']").val() != '') {                    
                    $("*[id$='fotopa']").attr('src', $("*[id$='hpicture']").val());
                } 
               
		       });

     

          
           

            // init Tagify script on the above inputs
           
                $('#bootstrap').on('keypress', function (e) {
                    if (e.keyCode === 13) {
                        
                        if (walert == 0) {
                            valida();
                            return false;
                        }
                        else {
                            //swal.close();
                        }
                    }
                });

            
        }
     </script>
</asp:Content>
