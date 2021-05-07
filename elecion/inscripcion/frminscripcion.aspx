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
                        
                         <asp:HiddenField runat="server" ID="idP" Value="0" />
                                                    <asp:HiddenField runat="server" ID="idA" Value="0"/>
                                                    <asp:HiddenField runat="server" ID="idI" />
                                                    <asp:HiddenField runat="server" ID="idOP" />
                                                    <asp:HiddenField runat="server" ID="limite" Value="48" />
                                                    <asp:HiddenField runat="server" ID="idS" />
                                                    <asp:HiddenField runat="server" ID="idF" />
                                                    <asp:HiddenField runat="server" ID="idctr" />
                                                    
                                                    <asp:HiddenField runat="server" ID="idDoc" />
                        <asp:Button runat="server" ID="bbuscacursos" OnClick="listadoAlumnos" Style="display: none"  UseSubmitBehavior="false" />

                        <asp:Button runat="server" ID="bvolver" OnClick="volverCursos" Style="display: none"  UseSubmitBehavior="false" />

                        <asp:Button runat="server" ID="Bconsultar" OnClick="listadoClientes" Style="display: none" UseSubmitBehavior="false" />
                        <asp:Button runat="server" ID="Bnuevo" OnClick="limpiarCampos" Style="display: none" UseSubmitBehavior="false" />
                        <asp:Button runat="server" ID="BnuevoInscripcion" OnClick="limpiarCamposInscripcion" Style="display: none" UseSubmitBehavior="false" />
                        <asp:Button runat="server" ID="Bcancelarcurso" OnClick="cancelaAlumno" Style="display: none" UseSubmitBehavior="false"/>
                        <asp:Button runat="server" ID="Bmodificaalumno" OnClick="modificaAlumno" Style="display: none" UseSubmitBehavior="false"/>
                        

                        <asp:Button runat="server" ID="Button2" OnClick="nuevoRegistro" Style="display: none" UseSubmitBehavior="false" />
                       
                        <span id="gridCursos" runat="server" visible="true" >
                            <div class="content-header row">
                                <div class="col-md-3">
                                    <div class="media-left media-middle">
                                        <i class="icon-pencil primary font-large-2 mr-1"></i>
                                    </div>
                                    <div class="media-body">
                                        <h4 class="font-weight-bold">Inscripción</h4>
                                        <span class="font-small-3">
                                            <asp:Label runat="server" ID="labelConteo">0</asp:Label>
                                            registro(s) encontrado(s)</span>
                                    </div>

                                </div>
                             </div>
                            <div class="row" id="header-styling">
                                <div class="col-md-12">


                                    <div class="media">

                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label class="text-bold-600 font-small-3">Curso</label>
                                                <asp:TextBox ID="bname" CssClass="form-control text-uppercase" placeholder="Búsqueda por Nombre, Clave..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
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


                                        <div class="col-md-2" runat="server">
                                            <div class="form-group">
                                                <label class="text-bold-600 font-small-3">Ciclo escolar</label>
                                                <asp:DropDownList runat="server" ID="bciclo" CssClass="select2 form-control" DataSourceID="DSciclo" DataTextField="cicloescolar" DataValueField="idcicloescolar" onChange="consultaPrincipal()">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="DSciclo" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idcicloescolar, concat('CICLO ',cicloescolar)as cicloescolar FROM cicloescolar UNION select 999999, 'SELECCIONE UN CICLO' ORDER BY idcicloescolar desc"></asp:SqlDataSource>
                                            </div>
                                        </div>
                                        <div class="col-md-2" runat="server">
                                            <div class="form-group">
                                                <label class="text-bold-600 font-small-3">Periodo</label>
                                                <asp:DropDownList runat="server" ID="bperiodo" CssClass="select2 form-control" DataSourceID="DSperiodo" DataTextField="periodo" DataValueField="idperiodo" onChange="consultaPrincipal(1)">
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="DSperiodo" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idperiodo, periodo FROM periodo UNION select 999999, 'SELECCIONE UN PERIODO' ORDER BY idperiodo desc "></asp:SqlDataSource>
                                            </div>
                                        </div>


                                        <div class="col-md-2">
                                            <label class="text-bold-600 font-small-3">Estatus</label>
                                            <asp:DropDownList ID="bestatus" runat="server" CssClass="form-control select2" onChange="consultaPrincipal()">
                                                <asp:ListItem Selected="True" Value="0">SELECCIONE UN ESTATUS</asp:ListItem>
                                                <asp:ListItem Value="EN CAPTURA">EN CAPTURA</asp:ListItem>
                                                <asp:ListItem Value="AUTORIZADO">AUTORIZADO</asp:ListItem>
                                                <asp:ListItem Value="FINALIZADO">FINALIZADO</asp:ListItem>
                                            </asp:DropDownList>

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

                                                                                <h7 class="font-weight-bold"><%# Eval("clave")+ " / "+Eval("nombre")%></h7>
                                                                                <br />
                                                                                <h7 class="font-small-3 font-italic text-bold-600"><i class="fa fa-home"></i> <%# " "+Eval("plantel")%></h7>
                                                                                <br />
                                                                                <h7 class="text-bold-400 font-small-2"><i class="fa fa-user "></i> <%# " "+Eval("instructor")%></h7>
                                                                                <br />
                                                                                <h7 class="text-bold-400 font-small-2"><i class="fa fa-calendar "></i><%# " "+Eval("fechaini") +" al "+ Eval("fechafin")+" / "%></h7>

                                                                                <h7 class="text-bold-400 font-small-2"><i class="fa fa-clock-o "></i><%# " "+Eval("horaini") +" - "+ Eval("horafin")%></h7>
                                                                                <br />

                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>


                                                                        <asp:TemplateField HeaderText="Alumno" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                                            <ItemTemplate>

                                                                                <ul class="list-inline">
                                                                                    <li class="border-right-blue-grey border-right-lighten-2 pr-2">
                                                                                        <h4 class="danger font-weight-bold"><%# Eval("alumnosminimo")%></h4>
                                                                                        <span class="blue-grey darken-1 font-small-3"><i class="icon-user"></i>Requerido</span>
                                                                                    </li>
                                                                                    <li class="pl-2">
                                                                                        <h4 class="danger font-weight-bold"><%# Eval("inscritos")%></h4>
                                                                                        <span class="blue-grey darken-1 font-small-3"><i class="icon-user-follow"></i>Inscritos</span>
                                                                                    </li>
                                                                                </ul>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField HeaderText="Estatus" ItemStyle-Width="20px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                                            <ItemTemplate>

                                                                                <span class="tag bg-<%# Eval("estatus").Equals("EN CAPTURA")?"info":Eval("estatus").Equals("OBSERVADO")?"danger":Eval("estatus").Equals("EN REVISION")?"warning":Eval("estatus").Equals("AUTORIZADO")?"success":Eval("estatus").Equals("RECHAZADO")?"danger":Eval("estatus").Equals("CANCELADO")?"red":"black"%>"><span class="text-bold-700"><%# Eval("estatus")%></span></span>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                                            <ItemTemplate>

                                                                                <button type="button" class="btn btn-icon btn-primary mr-1 btn-sm tooltips" onclick="buscacursos(<%# Eval("idcurso") %>)" value="" data-toggle="tooltip" data-original-title="Ver Alumnos"><i class="ft-user"></i></button>
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
                            <asp:Label runat="server" ID="labelCurso" CssClass="h4 font-weight-bold">ARTE HUICHOL </asp:Label><br />
                            <span class="font-small-3">Alumnos Inscritos</span>
                        </div>

                    </div>
                    <div class="col-md-8 float-md-right">

                                <span class="pull-right">
                                    <label class="text-bold-600 font-small-3"></label>
                                    <button type="button" id="Button3" onclick="volveracursos()" class="btn btn-icon btn-danger mr-1 text-bold-700" data-toggle="modal" runat="server">
                                        Volver a Cursos
                                    </button>
                                    <label class="text-bold-600 font-small-3"></label>
                                    <button type="button" id="nuevo" onclick="abrirModal(0, 0);" class="btn btn-icon btn-primary mr-1 text-bold-700" data-toggle="modal" runat="server">
                                        Nueva inscripción
                                    </button>
                                </span>
                            </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="media">
                            <br />
                            <div class="col-md-4">
                                <div class="form-group" id="barrabus" runat="server">
                                    <label class="text-bold-600 font-small-3">Alumno</label>
                                    <asp:TextBox ID="busnom" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Búsqueda por nombre..." name="busnom" runat="server" onChange="consultaAlumnos()"></asp:TextBox>
                                    
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
                                                    
                                                     <asp:Button runat="server" ID="bsolicitud" OnClick="recuperaSolicitud" Style="display: none" CausesValidation="false"  UseSubmitBehavior="false" />

                                                    <div style="overflow-x: auto; width: 100%">
                                                        <asp:GridView runat="server" ID="GValumnos" PageSize="50" AllowPaging="true" AllowSorting="false" CssClass="table table-striped table-bordered zero-configuration"
                                                            AutoGenerateColumns="False" DataSourceID="DSalumnos" EnableSortingAndPagingCallbacks="true" OnDataBinding="conteoRegistros"
                                                            AlternatingRowStyle-BackColor="#F5F7FA" OnPageIndexChanged="listadoAlumnos">

                                                            <Columns>
                                                                <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda primary">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Alumno" HeaderStyle-CssClass="primary">
                                                                    <ItemTemplate>
                                                                        <h7 class="font-weight-bold"><%# Eval("nombrealumno")%></h7>
                                                                        <br />
                                                                        <h7 class="text-bold-400 font-small-2"> <%# "No. control: "+Eval("nocontrol")%></h7>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                 <asp:TemplateField HeaderText="Pago" HeaderStyle-CssClass="primary">
                                                                    <ItemTemplate>
                                                                        <h7 class="font-weight-bold"><%# "$ "+Eval("costoAlumno")%></h7>
                                                                        <br />
                                                                        <h7 class="text-bold-400 font-small-2"> <%# Eval("folio").ToString().Equals("")?"S/F":"Folio: "+Eval("folio")%></h7>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Fecha de Inscripción" HeaderStyle-CssClass="primary">
                                                                    <ItemTemplate>
                                                                        <h7 class="font-weight-bold"><%# Eval("fecha")%></h7>                                                                        
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                 
                                                                <asp:TemplateField HeaderText="Estatus" ItemStyle-Width="20px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                                    <ItemTemplate>
                                                                        
                                                                            <span class="tag bg-<%# Eval("estatus").Equals("INSCRITO")?"success":Eval("estatus").Equals("CANCELADO")?"danger":Eval("estatus").Equals("DESERCIÓN")?"danger":""%>"><span class="text-bold-700"><%# Eval("estatus")%></span></span>
                                                                        
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="320px" ItemStyle-CssClass="centrarCelda primary" HeaderStyle-CssClass="centrarCelda">
                                                                    <ItemTemplate>

                                                                        <button type="button" onclick="abrirModal(<%# Eval("idsolicitud")%>,<%# Eval("idalumno").ToString() %>)" class="btn btn-icon btn-warning mr-1 btn-sm tooltips"
                                                                            data-toggle="tooltip" data-original-title="Detalles">
                                                                            <i class="ft-edit"></i>
                                                                        </button>

                                                                        <button type="button" onclick="abrirModalCancelacion(<%# Eval("idsolicitud")%>,<%# Eval("idalumno").ToString() %>)" <%# Eval("estatus").Equals("CANCELADO")?"disabled":"" %> class="btn btn-icon btn-danger mr-1 btn-sm tooltips <%# Eval("estatus").Equals("DESERCIÓN")?"ocultar":""%>"
                                                                            data-toggle="tooltip" data-original-title="Eliminar">
                                                                            <i class="ft-delete"></i>
                                                                        </button>

                                                                        <button type="button" onclick="abrirModalModificacion(<%# Eval("idsolicitud")%>,<%# Eval("idalumno").ToString() %>)" <%# Eval("estatus").Equals("CANCELADO")?"disabled":"" %> class="btn btn-icon btn-success mr-1 btn-sm tooltips <%# Eval("estatus").Equals("DESERCIÓN")||Eval("estatus").Equals("CANCELADO")?"":"ocultar"%>"
                                                                            data-toggle="tooltip" data-original-title="Modificar Estatus">
                                                                            <i class="ft-unlock"></i>
                                                                        </button>

                                                                        <button type="button" onclick="imprimirSolicitud(<%# Eval("idsolicitud")%>,<%# Eval("idalumno").ToString() %>,'<%# Eval("nocontrol").ToString() %>')" class="btn btn-icon btn-cyan mr-1 btn-sm tooltips"
                                                                            data-toggle="tooltip" data-original-title="Imprimir Solicitud">
                                                                            <i class="ft-printer"></i>
                                                                        </button>

                                                                        <button type="button" onclick="imprimirCredencial(<%# Eval("idsolicitud")%>,<%# Eval("idalumno").ToString() %>,'<%# Eval("nocontrol").ToString() %>')" <%# Eval("cursoestatus").Equals("AUTORIZADO")?"":"disabled" %> class="btn btn-icon btn-purple mr-1 btn-sm tooltips"
                                                                            data-toggle="tooltip" data-original-title="Imprimir Credencial">
                                                                            <i class="ft-user"></i>
                                                                        </button>



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


    <div class="modal fade text-xs-left" id="detcurso"  role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">


        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title">CURSO</h5>
                </div>

                <asp:HiddenField runat="server" ID="idr" />

                <div class="modal-body">

                    <ul class="nav nav-tabs nav-top-border no-hover-bg">
                        <li class="nav-item">
                            <a class="nav-link active" id="tabgenerales1" data-toggle="tab" href="#generales" aria-controls="tabgenerales" aria-expanded="true"><i class="fa fa-folder"></i>Generales</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabcostos1" data-toggle="tab" href="#costos" aria-controls="tabcostos" aria-expanded="false"><i class="fa fa-check-square-o"></i>Programación</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabhorario1" data-toggle="tab" href="#horario" aria-controls="tabhorario" aria-expanded="false"><i class="fa fa-calendar"></i>Calendario</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" id="tabalumnos" data-toggle="tab" href="#alumnos" aria-controls="tabalumnos" aria-expanded="false"><i class="fa fa-user"></i>Alumnos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabobserv" data-toggle="tab" href="#observ" aria-controls="tabobserv" aria-expanded="false"><i class="fa fa-folder-open-o"></i>Observaciones</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" id="tabanexos" data-toggle="tab" href="#anexos" aria-controls="tabanexos" aria-expanded="false"><i class="fa fa-file-text-o"></i>Anexos</a>
                        </li>
                    </ul>
                    <div class="tab-content px-1 pt-1">
                        <div role="tabpanel" class="tab-pane fade active in" id="generales1" aria-labelledby="tabgenerales" aria-expanded="true">

                            <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                                <ContentTemplate>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-body collapse in">
                                                    <div class="card-block">
                                                        <div class="row">

                                                            <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Nombre del curso</label>
                                                                    <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" placeholder="" name="nombre" runat="server"></asp:TextBox>

                                                                </div>
                                                            </div>

                                                        </div>

                                                        <div class="row">
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Tipo de Curso</label>
                                                                    <asp:DropDownList runat="server" ID="tipocurso" CssClass="select2 form-control" DataSourceID="Dstipocurso" DataTextField="tipocurso" DataValueField="idtipocurso" Style="width: 100%">
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="Dstipocurso" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                                        SelectCommand="SELECT idtipocurso, tipocurso from tipocurso order by tipocurso"></asp:SqlDataSource>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Ofertado a </label>
                                                                    <asp:DropDownList runat="server" ID="tipooferta" CssClass="select2 form-control" DataSourceID="DStipooferta" DataTextField="tipooferta" DataValueField="idtipooferta" Style="width: 100%">
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="DStipooferta" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                                        SelectCommand="SELECT idtipooferta, tipooferta from tipooferta order by tipooferta"></asp:SqlDataSource>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Mínimo de alumnos</label>
                                                                    <asp:TextBox ID="alumnosminimo" type="number" CssClass="form-control text-uppercase" placeholder="Mínimo de alumnos" name="alumnosminimo" runat="server"></asp:TextBox>

                                                                </div>
                                                            </div>

                                                        </div>

                                                        <div class="row">


                                                            <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Conditional">
                                                                <ContentTemplate>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label class="text-bold-600">Área de formación profesional</label>
                                                                            <asp:DropDownList runat="server" ID="area" CssClass="select2 form-control" DataSourceID="Dsareas" DataTextField="area" AutoPostBack="true" DataValueField="idarea" Style="width: 100%">
                                                                            </asp:DropDownList>
                                                                            <asp:SqlDataSource ID="Dsareas" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                                                SelectCommand="SELECT idarea, area from area order by area"></asp:SqlDataSource>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label class="text-bold-600">Especialidad</label>
                                                                            <asp:DropDownList runat="server" ID="especialidad" CssClass="select2 form-control" DataSourceID="Dsespecialidades" DataTextField="especialidad" DataValueField="idespecialidad" Style="width: 100%"></asp:DropDownList>
                                                                            <asp:SqlDataSource ID="Dsespecialidades" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idespecialidad, especialidad FROM especialidad  WHERE idarea =@idcat ORDER BY especialidad">
                                                                                <SelectParameters>
                                                                                    <asp:ControlParameter ControlID="area" Name="idcat" PropertyName="SelectedValue" />

                                                                                </SelectParameters>
                                                                            </asp:SqlDataSource>

                                                                        </div>
                                                                    </div>


                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>


                                                        </div>

                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Instructor</label>
                                                                    <asp:DropDownList runat="server" ID="instructor" CssClass="select2 form-control" DataSourceID="Dsinstructores" DataTextField="nombre" DataValueField="idinstructor" Style="width: 100%">
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="Dsinstructores" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                                        SelectCommand="select idinstructor, nombre
                                                                                    from instructor
                                                                                    order by nombre
                                                                                    "></asp:SqlDataSource>

                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Lugar de Aplicación</label>
                                                                    <asp:DropDownList runat="server" ID="instalacion" CssClass="select2 form-control" DataSourceID="Dsinstalaciones" DataTextField="nombre" DataValueField="idinstalacion" Style="width: 100%" AutoPostBack="true" OnSelectedIndexChanged="instalacion_SelectedIndexChanged"></asp:DropDownList>
                                                                    <asp:SqlDataSource ID="Dsinstalaciones" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idinstalacion, nombre FROM instalacion  WHERE (idsucursal=1 or idinstalacion=9999)  ORDER BY nombre"></asp:SqlDataSource>

                                                                </div>
                                                            </div>





                                                        </div>

                                                        <div class="row" id="extramuros" runat="server" visible="false">

                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Lugar Instalación Extramuros</label>
                                                                    <asp:TextBox ID="instalacionext" CssClass="form-control text-uppercase" placeholder="Instalación Extramuros" name="instalacionext" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Domicilio Instalación Extramuros</label>
                                                                    <asp:TextBox ID="instalaciondomext" CssClass="form-control text-uppercase" placeholder="Domicilio Extramuros" name="instalaciondomext" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>


                                                        <div class="row">

                                                            <div class="col-md-4">
                                                                <div class="form-group">

                                                                    <label class="text-bold-600">Costo del Módulo</label>
                                                                    <asp:TextBox ID="costomodulo" CssClass="form-control decimal-inputmask text-md-left" Style="text-align: left;" placeholder="" name="cotitular" runat="server"></asp:TextBox>


                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">

                                                                    <label class="text-bold-600">Costo por alumno</label>
                                                                    <asp:TextBox ID="costoalumno" CssClass="form-control decimal-inputmask text-md-left" placeholder="" name="cotitular" runat="server"></asp:TextBox>


                                                                </div>
                                                            </div>


                                                            <div class="col-md-4">
                                                                <div class="form-group">

                                                                    <label class="text-bold-600">Pago x hora al Instructor</label>
                                                                    <asp:TextBox ID="pagohora" CssClass="form-control decimal-inputmask text-md-left" placeholder="" name="cotitular" runat="server"></asp:TextBox>


                                                                </div>
                                                            </div>

                                                        </div>





                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Observaciones</label>
                                                                    <asp:TextBox ID="observaciones" CssClass="form-control" MaxLength="0" placeholder="Observaciones" name="telefono" runat="server"></asp:TextBox>

                                                                </div>


                                                            </div>

                                                        </div>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </ContentTemplate>

                            </asp:UpdatePanel>

                        </div>
                        <div role="tabpanel" class="tab-pane fade " id="costos1" aria-labelledby="tabcostos" aria-expanded="true">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                                <ContentTemplate>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-body collapse in">
                                                    <div class="card-block">
                                                        <div class="row">

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Fecha límite de Inscripción</label>
                                                                    <asp:TextBox ID="fechalimite" CssClass="form-control pickadate text-uppercase" placeholder="Inicia en" name="fechalimite" runat="server" Text=""></asp:TextBox>

                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Fecha de inicio</label>
                                                                    <asp:TextBox ID="fechaini" CssClass="form-control pickadate text-uppercase" placeholder="Inicia en" name="fechaini" runat="server" Text="" onchange="calendario()"></asp:TextBox>

                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Fecha de Término</label>
                                                                    <asp:TextBox ID="fechafin" CssClass="form-control pickadate text-uppercase" placeholder="Finaliza en" name="fechafin" runat="server" onchange="calendario()"></asp:TextBox>

                                                                </div>
                                                            </div>




                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-8">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Días hábiles</label>
                                                                    <asp:HiddenField runat="server" ID="hdias" />
                                                                    <select class="select2 form-control" multiple="multiple" id="algo" onchange="ver()" style="width: 100%">
                                                                        <option value="2">Lunes</option>
                                                                        <option value="3">Martes</option>
                                                                        <option value="4">Miércoles</option>
                                                                        <option value="5">Jueves</option>
                                                                        <option value="6">Viernes</option>
                                                                        <option value="7">Sábado</option>
                                                                        <option value="1">Domingo</option>
                                                                    </select>


                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Total de Días</label>
                                                                    <asp:TextBox ID="dias" type="number" CssClass="form-control text-uppercase" placeholder="Días" name="dias" runat="server" disabled></asp:TextBox>

                                                                </div>
                                                            </div>


                                                        </div>


                                                        <div class="row">

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Hora de inicio</label>
                                                                    <asp:TextBox ID="horaini" CssClass="form-control pickatime-button text-uppercase" placeholder="Desde" name="horaini" runat="server"></asp:TextBox>

                                                                </div>
                                                            </div>


                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Hora de término</label>
                                                                    <asp:TextBox ID="horafin" CssClass="form-control pickatime-button text-uppercase" placeholder="Hasta" name="horafin" runat="server"></asp:TextBox>

                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Total de Horas</label>
                                                                    <asp:TextBox ID="horas" type="number" CssClass="form-control text-uppercase" placeholder="Horas" name="cotitular" runat="server" disabled></asp:TextBox>

                                                                </div>
                                                            </div>


                                                        </div>



                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                        <div class="tab-pane fade" id="horario1" role="tabpanel" aria-labelledby="tabhorario" aria-expanded="false">

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-body collapse in">
                                            <div class="card-block">



                                                <div class="row">

                                                    <div class="col-md-12">
                                                        <div class="form-group">

                                                            <asp:UpdatePanel runat="server">
                                                                <ContentTemplate>
                                                                    <asp:Button runat="server" ID="bimprimir" OnClick="imprimeSolicitudAut" UseSubmitBehavior="false" Style="display: none" />
                                                                    <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" style="display:none" UseSubmitBehavior="false"/>
                                                                    <asp:Button runat="server" ID="bautorizacion" OnClick="solicitaAutorizacion" style="display:none" UseSubmitBehavior="false"/>
                                                                    <asp:Button runat="server" ID="Beditar" OnClick="editaRegistro" style="display:none" UseSubmitBehavior="false"/> 

                                                                    <asp:Button runat="server" ID="bfechascurso" OnClick="generaFechasCurso" UseSubmitBehavior="false" Style="display: none" />
                                                                    <asp:Button runat="server" ID="eliminarFechas" OnClick="borraFechas" Style="display: none" CausesValidation="false" UseSubmitBehavior="false" />
                                                                    <asp:Button runat="server" ID="guardarFechas" OnClick="guardaEditaFechas" Style="display: none" CausesValidation="false" UseSubmitBehavior="false" />
                                                                    <asp:Button runat="server" ID="Bfechas" OnClick="listadoFechas" Style="display: none" UseSubmitBehavior="false" />

                                                                    <div id='fc-basic-views'></div>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>

                                                        </div>



                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                    </div>

                                                </div>


                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="alumnos" role="tabpanel" aria-labelledby="tabalumnos" aria-expanded="false">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel4">
                                <ContentTemplate>

                                    <div class="row">
                                        <div class="col-md-12">

                                            
                                            
                                        </div>

                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                        <div class="tab-pane fade" id="anexos" role="tabpanel" aria-labelledby="tabanexos" aria-expanded="false">

                           <div class="row">
                               <div class="col-md-4">
                                   <div class="row">

                                       <div class="col-md-3">
                                           <img src="../../../app-assets/images/elements/pdf.fw.png" onclick="imprimirSolicitudAut()" class="rounded-circle" style="cursor: pointer" />
                                       </div>
                                       <div class="col-md-9">
                                           <p class="text-bold-400" onclick="imprimirSolicitudAut()" style="cursor: pointer">Solicitud de Autorización de Curso</p>
                                       </div>
                                   </div>
                                </div>
                               
                           </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">


                    

                    <button class="btn btn-warning" onclick="solicita()" type="button" data-backdrop="false">
                        <i class="fa fa-check-square-o"></i>Enviar a Autorizar
                    </button>

                    <button class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false">
                        <i class="fa fa-check-square-o"></i>Guardar
                    </button>

                    <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
                        <i class="ft-x"></i>Cancelar
                    </button>
                </div>
            </div>
        </div>


    </div>
		        


    <div class="modal fade" id="wfechas"  role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title">Fecha de Curso</h3>
                        </div>


                        <div class="modal-body">
                            
                                    <div class="row">


                                         <div class="col-md-9">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Fecha</label>
                                                        <asp:TextBox ID="fagenda" CssClass="form-control pickadate text-uppercase" placeholder="Fecha" name="fechafin" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>

                                        </div>        
                                        <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Hora de inicio</label>
                                                        <asp:TextBox ID="horanini" CssClass="form-control pickatime-button" placeholder="Desde" name="horaini" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>


                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Hora de término</label>
                                                        <asp:TextBox ID="horanfin" CssClass="form-control pickatime-button" placeholder="Hasta" name="horafin" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                    </div>

                                                                  
                        </div>

                        <div class="modal-footer">
                        
                        

				        <button class="btn btn-primary" onclick="validaFechas()" type="button" data-backdrop="false" id="bguardaFecha"> 
	                        <i class="fa fa-check-square-o"></i> Aceptar
	                     </button>
                                                                 
	                     <button type="button" class="btn btn-danger mr-1" data-dismiss="modal">
	                        <i class="ft-x"></i> Cerrar
	                     </button>
			        </div>


                    </div>


                </div>

            </div>


     <div class="modal fade text-xs-left" id="winscripcion" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
         

        <div class="modal-dialog modal-lg ps-scrollbar-y" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title">INSCRIPCIÓN</h5>
                </div>

                <asp:HiddenField runat="server" ID="HiddenField1" />

                <div class="modal-body">
                    <asp:Button runat="server" ID="botonDescarga" OnClick="descargaArchivo" Style="display: none" UseSubmitBehavior="false"/>
                    <ul class="nav nav-tabs nav-top-border no-hover-bg">
                        <li class="nav-item">
                            <a class="nav-link active" id="tabgenerales" data-toggle="tab" href="#generales" aria-controls="tabgenerales" aria-expanded="true"><i class="fa fa-folder"></i>Personales</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabadicionales" data-toggle="tab" href="#adicionales" aria-controls="tabadicionales" aria-expanded="true"><i class="fa fa-folder"></i>Adicionales</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabcostos" data-toggle="tab" href="#costos" aria-controls="tabcostos" aria-expanded="false"><i class="fa fa-check-square-o"></i>Generales</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabhorario" data-toggle="tab" href="#horario" aria-controls="tabhorario" aria-expanded="false"><i class="fa fa-calendar"></i>Capacitación</a>
                        </li>

                    </ul>
                    <div class="tab-content px-1 pt-1">
                        
                        
                        <div role="tabpanel" class="tab-pane fade active in" id="generales" aria-labelledby="tabgenerales" aria-expanded="true">


                            <asp:UpdatePanel runat="server" ID="UpdatePanel5">
                                <ContentTemplate>
                                    <asp:Button runat="server" ID="bcursoinscripcion" Style="display: none" UseSubmitBehavior="false" />
                                   
                                    <asp:Button runat="server" ID="bguardarIns" OnClick="guardaEditaIns" Style="display: none" UseSubmitBehavior="false" />

                                
                            <div class="row">

                                <div class="col-md-12">

                                    <div class="row">
                                        <div class="col-md-3">

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <asp:Label ID="eti" runat="server"></asp:Label>
                                                        <asp:Image ID="fotopa" runat="server" Height="280" Width="250" CssClass="img-fluid tooltips" onClick="$('#botonpic').click();" Style="cursor: pointer; border: solid; border-color: lightgray; border-width: thin" data-toggle="tooltip" data-original-title="Click para cambiar foto" />
                                                        <asp:HiddenField ID="hpicture" runat="server" />
                                                        <asp:FileUpload ID="Bfoto" runat="server" accept="image/*" onchange="showpreview(this);" class="ocultar"></asp:FileUpload>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 centrarCelda">


                                                    <button class="btn btn-primary ocultar" onclick="$('#<%= Bfoto.ClientID %>').click();" type="button" id="botonpic">
                                                        <i class="fa fa-camera"></i>Foto
                                                    </button>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="col-md-9">

                                            <div class="row">

                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Núm. de Control</label>
                                                        <asp:TextBox ID="nocontrol" CssClass="form-control text-uppercase" placeholder="NO. DE CONTROL" name="nocontrol" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                                <div class="col-md-3"><br /><br />
                                                    <div class="form-group align-bottom centrarCelda">
                                                        <label class="text-bold-600">&nbsp;</label>
                                                        <button class="btn btn-primary" onclick="abrirModalAlumnos()" type="button" id="BBbuscarcliente" runat="server">
                                                            <i class="fa fa-search"></i>Buscar
                                                        </button>
                                                    </div>
                                                </div>


                                            </div>

                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Primer Apellido</label>
                                                        <asp:TextBox ID="apaterno" CssClass="form-control text-uppercase" placeholder="APELLIDO PATERNO" name="apaterno" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Segundo Apellido</label>
                                                        <asp:TextBox ID="amaterno" CssClass="form-control text-uppercase" placeholder="APELLIDO MATERNO" name="amaterno" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Nombre(s)</label>
                                                        <asp:TextBox ID="nombrealumno" CssClass="form-control text-uppercase" placeholder="NOMBRE" name="nombrealumno" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>


                                            </div>



                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Sexo</label><br />

                                                        <asp:DropDownList ID="sexo" runat="server" CssClass="form-control select2">
                                                            <asp:ListItem Selected="True" Value="H">HOMBRE</asp:ListItem>
                                                            <asp:ListItem Value="M">MUJER</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>

                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Curp</label>
                                                        <asp:TextBox ID="curp" CssClass="form-control text-uppercase" placeholder="CURP" name="curp" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Fecha Nacimiento</label>
                                                        <asp:TextBox ID="fechanacimiento" CssClass="form-control date-inputmask text-uppercase" placeholder="Fecha Nacimiento" name="fechanacimiento" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                                


                                            </div>
                                            

                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">

                                                <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Teléfono</label>
                                                        <asp:TextBox ID="telefono" CssClass="form-control text-uppercase" placeholder="TELEFONO" name="telefono" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Email</label>
                                                        <asp:TextBox ID="email" CssClass="form-control" placeholder="CORREO ELECTRÓNICO" name="email" runat="server"></asp:TextBox>

                                                    </div>
                                                </div>
                                                     </div>
                                                </div>

                                            </div>


                                        <div class="row">
                                            <div class="col-md-12">

                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="text-bold-600">Domicilio</label>
                                                            <asp:TextBox ID="domicilio" CssClass="form-control text-uppercase" placeholder="DOMICILIO" name="domicilio" runat="server"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label class="text-bold-600">Colonia o Localidad</label>
                                                            <asp:TextBox ID="colonia" CssClass="form-control text-uppercase" placeholder="COLONIA" name="colonia" runat="server"></asp:TextBox>

                                                        </div>
                                                    </div>
                                                    <div class="col-md-2">
                                                        <div class="form-group">
                                                            <label class="text-bold-600">CP</label>
                                                            <asp:TextBox ID="cp" CssClass="form-control text-uppercase" placeholder="CP" name="cp" runat="server"></asp:TextBox>

                                                        </div>
                                                    </div>


                                                </div>
                                            </div>

                                        </div>


                                        <div class="row">
                                            <div class="col-md-12">

                                                <div class="row">


                                                    <asp:UpdatePanel runat="server" ID="UpdatePanel6">
                                                        <ContentTemplate>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Estado</label>
                                                                    <asp:DropDownList runat="server" ID="entidad" CssClass="select2 form-control" DataSourceID="DSentidades" DataTextField="entidad" DataValueField="identidad" Style="width: 100%" AutoPostBack="true"></asp:DropDownList>
                                                                    <asp:SqlDataSource ID="DSentidades" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT identidad, entidad FROM entidad ORDER BY entidad"></asp:SqlDataSource>

                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Municipio</label>
                                                                    <asp:DropDownList runat="server" ID="municipio" CssClass="select2 form-control" DataSourceID="DSmunicipios" DataTextField="municipio" DataValueField="idmunicipio" Style="width: 100%"></asp:DropDownList>
                                                                    <asp:SqlDataSource ID="DSmunicipios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idmunicipio, municipio FROM municipio where identidad=@ident  ORDER BY municipio">
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="entidad" Name="ident" PropertyName="SelectedValue" />

                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </div>
                                                            </div>
                                                        </ContentTemplate>

                                                    </asp:UpdatePanel>


                                                </div>
                                            </div>

                                        </div>

                                       


                                    </div>

                                </div>


                            </div>
                                    </ContentTemplate>

                            </asp:UpdatePanel>


                        </div>

                        <div role="tabpanel" class="tab-pane fade" id="adicionales" aria-labelledby="tabadicionales" aria-expanded="true">


                            <asp:UpdatePanel runat="server" ID="UpdatePanel12">
                                <ContentTemplate>
                                     <div class="row">

                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Estado Civil</label>
                                                    <asp:DropDownList runat="server" ID="edocivil" CssClass="select2 form-control" DataSourceID="DSsedocivil" DataTextField="edocivil" DataValueField="idedocivil" Style="width: 100%">
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="DSsedocivil" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                        SelectCommand="SELECT idedocivil, edocivil from edocivil order by edocivil"></asp:SqlDataSource>
                                                </div>



                                            </div>



                                            <div class="col-md-9">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Discapacidad que presenta</label>
                                                    <asp:HiddenField runat="server" ID="tagsdiscap" />
                                                    <asp:DropDownList runat="server" ID="xxdiscapacidad" CssClass="select2 form-control" DataSourceID="DSdiscapacidad" DataTextField="discapacidad" DataValueField="iddiscapacidad" Style="width: 100%" multiple="multiple" onchange=""></asp:DropDownList>
                                                    <asp:SqlDataSource ID="DSdiscapacidad" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT iddiscapacidad, discapacidad FROM discapacidad ORDER BY discapacidad"></asp:SqlDataSource>

                                                </div>
                                            </div>
                                        </div>


                                        <div class="row">

                                            

                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Jefa de Familia</label><br />

                                                    <asp:DropDownList ID="jefafamilia" runat="server" CssClass="form-control select2">
                                                        <asp:ListItem Value="0" Selected="True">NO</asp:ListItem>
                                                        <asp:ListItem Value="1">SI</asp:ListItem>

                                                    </asp:DropDownList>
                                                </div>

                                            </div>

                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Grupo Indígena</label><br />

                                                    <asp:DropDownList ID="indigena" runat="server" CssClass="form-control select2">
                                                        <asp:ListItem Value="0" Selected="True">NO</asp:ListItem>
                                                        <asp:ListItem Value="1">SI</asp:ListItem>

                                                    </asp:DropDownList>
                                                </div>

                                            </div>

                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Condición de Calle</label><br />

                                                    <asp:DropDownList ID="condicioncalle" runat="server" CssClass="form-control select2">
                                                        <asp:ListItem Value="0" Selected="True">NO</asp:ListItem>
                                                        <asp:ListItem Value="1">SI</asp:ListItem>

                                                    </asp:DropDownList>
                                                </div>

                                            </div>




                                        </div>

                                        <asp:UpdatePanel runat="server" ID="UpdatePanel11">
                                                        <ContentTemplate>
                                                            

                                        <div class="row">

                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Apoyo Económico</label><br />

                                                    <asp:DropDownList ID="apoyo" runat="server" CssClass="form-control select2" AutoPostBack="true" OnSelectedIndexChanged="becado_CheckedChanged">
                                                        <asp:ListItem Value="0" Selected="True">NO</asp:ListItem>
                                                        <asp:ListItem Value="1">SI</asp:ListItem>

                                                    </asp:DropDownList>
                                                </div>

                                            </div>

                                            <div id="divConv" runat="server">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Convenio</label>

                                                    <asp:DropDownList runat="server" ID="convenio" CssClass="select2 form-control" DataSourceID="DSconvenios" DataTextField="convenio" DataValueField="idconvenio" Style="width: 100%"></asp:DropDownList>
                                                    <asp:SqlDataSource ID="DSconvenios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idconvenio, convenio FROM convenio where activo=1 ORDER BY convenio"></asp:SqlDataSource>

                                                </div>
                                            </div>

                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label class="text-bold-600">Porcentaje de Apoyo</label>
                                                    <asp:TextBox ID="porcentaje" type="number" CssClass="form-control text-uppercase" placeholder="%" name="porcentaje" runat="server" Text="0" min="0" max="100"></asp:TextBox>

                                                </div>
                                            </div>

                                                </div>


                                        </div>

                                                            </ContentTemplate>

                                                    </asp:UpdatePanel>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    
                        <div role="tabpanel" class="tab-pane fade " id="costos" aria-labelledby="tabcostos" aria-expanded="true">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel7">
                                <ContentTemplate>
                                    <div class="row">
                                        <div class="col-md-12">
                                            
                                                        <div class="row">


                                                            <asp:UpdatePanel runat="server" ID="UpdatePanel8">
                                                                <ContentTemplate>
                                                                    <!--<div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label class="text-bold-600">Especialidad a la que desea inscribirse</label>
                                                                            <asp:DropDownList runat="server" ID="especialidadins" CssClass="select2 form-control" DataSourceID="Dsespecialidadesins" DataTextField="especialidad" DataValueField="idespecialidad" Style="width: 100%" AutoPostBack="false" disabled></asp:DropDownList>
                                                                            <asp:SqlDataSource ID="Dsespecialidadesins" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idespecialidad, especialidad FROM especialidad ORDER BY especialidad"></asp:SqlDataSource>

                                                                        </div>
                                                                    </div>
                                                                    -->
                                                                    <div class="col-md-12">
                                                                        <div class="form-group">
                                                                            <label class="text-bold-600">Curso</label>
                                                                            <asp:DropDownList runat="server" ID="curso" CssClass="select2 form-control" DataSourceID="DScursos" DataTextField="nombre" DataValueField="idcurso" Style="width: 100%" disabled></asp:DropDownList>
                                                                            <asp:SqlDataSource ID="DScursos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idcurso, nombre FROM curso ORDER BY nombre">
                                                                                <SelectParameters>
                                                                                    <asp:ControlParameter ControlID="idS" Name="idS" PropertyName="Value" />

                                                                                </SelectParameters>
                                                                            </asp:SqlDataSource>

                                                                        </div>
                                                                    </div>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>

                                                        </div>


                                                        <div class="row">

                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Último grado de estudios</label>
                                                                    <asp:DropDownList runat="server" ID="escolaridad" CssClass="select2 form-control" DataSourceID="DSescolaridad" DataTextField="escolaridad" DataValueField="idescolaridad" Style="width: 100%" ></asp:DropDownList>
                                                                    <asp:SqlDataSource ID="DSescolaridad" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idescolaridad, escolaridad FROM escolaridad ORDER BY escolaridad"></asp:SqlDataSource>


                                                                </div>
                                                            </div>


                                                        </div>
                                                        <div class="row">



                                                            <div class="col-md-7">

                                                                <label class="text-bold-600">Documentación Entregada</label><br />
                                                                <div class="col-md-12">
                                                                    <div class="form-group">
                                                                        <asp:HiddenField runat="server" ID="tagsdoc" />
                                                                        <asp:GridView runat="server" ID="GVdocumentacion" PageSize="25" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration"
                                                                            AutoGenerateColumns="False" DataSourceID="DSdocumentacion"
                                                                            AlternatingRowStyle-BackColor="#F5F7FA">
                                                                            <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                                                            <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                                                            <Columns>

                                                                                <asp:TemplateField HeaderText="" ItemStyle-Width="10px" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="font-small-2">
                                                                                    <ItemTemplate>

                                                                                        <input id="doc<%#"_"+Eval("iddocumentacion")%>" type="checkbox" class="cks" value="<%# Container.DataItemIndex%>" <%# Eval("entregado").ToString().Equals("1")?"checked":"" %>>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="documentacion" HeaderText="Documentacion" SortExpression="documentacion" ItemStyle-Width="400px" ItemStyle-CssClass="font-small-2" />
                                                                                <asp:TemplateField HeaderText="Archivo"  ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="font-small-2">
                                                                                    <ItemTemplate>
                                                                                        
                                                                                        <button class="btn btn-primary btn-sm tooltips <%#Eval("iddocumentacion").ToString().Equals("4")||Eval("iddocumentacion").ToString().Equals("7")||(Eval("movilidad").ToString().Equals("0") && Eval("enlinea").ToString().Equals("0"))?"ocultar":""%>" onclick="descargarArchivo(<%#Eval("iddocumentacion")%>)" type="button" data-backdrop="false" data-toggle="tooltip" data-original-title="Descargar">
                                                                                            <i class="fa fa-download"></i>
                                                                                        </button>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>

                                                                            </Columns>

                                                                        </asp:GridView>

                                                                        <asp:SqlDataSource ID="DSdocumentacion" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand=""></asp:SqlDataSource>


                                                                    </div>
                                                                </div>
                                                                <br />

                                                            </div>

                                                            <div class="col-md-5">

                                                                
                                                                <div class="col-md-12">
                                                                    <div class="form-group">

                                                                        <div class="col-md-12">
                                                                            <div class="form-group">

                                                                                <label class="text-bold-600">Empresa donde trabaja</label>
                                                                                <asp:TextBox ID="empresa" CssClass="form-control text-uppercase" placeholder="EMPRESA" name="empresa" runat="server"></asp:TextBox>


                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-12">
                                                                            <div class="form-group">

                                                                                <label class="text-bold-600">Puesto</label>
                                                                                <asp:TextBox ID="puesto" CssClass="form-control text-uppercase" placeholder="PUESTO" name="empresa" runat="server"></asp:TextBox>


                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-12">
                                                                            <div class="form-group">

                                                                                <label class="text-bold-600">Antiguedad</label>
                                                                                <asp:TextBox ID="antiguedad" CssClass="form-control text-uppercase" placeholder="ANTIGUEDAD" name="antiguedad" runat="server"></asp:TextBox>


                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-12">
                                                                            <div class="form-group">

                                                                                <label class="text-bold-600">Dirección</label>
                                                                                <asp:TextBox ID="domicilioempresa" CssClass="form-control text-uppercase" placeholder="DOMICILIO" name="domicilioempresa" runat="server"></asp:TextBox>


                                                                            </div>
                                                                        </div>

                                                                        <div class="col-md-12">
                                                                            <div class="form-group">

                                                                                <label class="text-bold-600">Teléfono</label>
                                                                                <asp:TextBox ID="telefonoempresa" CssClass="form-control text-uppercase" placeholder="TELÉFONO" name="telefonoempresa" runat="server"></asp:TextBox>


                                                                            </div>
                                                                        </div>


                                                                    </div>
                                                                </div>
                                                                <br />

                                                            </div>

                                                        </div>

                                                        <div class="row">

                                                            <div class="col-md-12">

                                                                <label class="text-bold-600">A extranjeros anexar</label><br />
                                                                <div class="col-md-12">
                                                                    <div class="form-group">

                                                                        <div class="col-md-12">
                                                                            <div class="form-group">

                                                                                <div class="skin skin-flat">
                                                                                    <asp:CheckBox runat="server" ID="calidadmig" />
                                                                                    Comprobante de Calidad Migratoria con la que se encuentra en Territorio Nacional
                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <br />

                                                            </div>

                                                        </div>

                                        </div>
                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                        <div class="tab-pane fade" id="horario" role="tabpanel" aria-labelledby="tabhorario" aria-expanded="false">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel9">
                                <ContentTemplate>
                                    <div class="row">
                                        <div class="col-md-12">                                            

                                                        <div class="row">


                                                            <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Medio por el que se enteró del sistema</label>
                                                                    <asp:HiddenField runat="server" ID="tagsmed" />
                                                                    <asp:DropDownList runat="server" ID="medio" CssClass="select2 form-control" DataSourceID="DSmedios" DataTextField="medio" DataValueField="idmedio" Style="width: 100%" multiple="multiple" onchange=""></asp:DropDownList>
                                                                    <asp:SqlDataSource ID="DSmedios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idmedio, medio FROM medio ORDER BY medio"></asp:SqlDataSource>

                                                                </div>
                                                            </div>

                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Otro, especifique</label>
                                                                    <asp:TextBox ID="otromed" CssClass="form-control text-uppercase" placeholder="OTRO" name="otromed" runat="server"></asp:TextBox>

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="row">


                                                            <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Motivos de elección del sistema de capacitación</label>
                                                                    <asp:HiddenField runat="server" ID="tagsmot" />

                                                                    <asp:DropDownList runat="server" ID="motivo" CssClass="select2 form-control" DataSourceID="DSmotivos" DataTextField="motivo" DataValueField="idmotivo" Style="width: 100%" multiple="multiple" onchange=""></asp:DropDownList>
                                                                    <asp:SqlDataSource ID="DSmotivos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idmotivo, motivo FROM motivoeleccion ORDER BY motivo"></asp:SqlDataSource>

                                                                </div>
                                                            </div>

                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Otro, especifique</label>
                                                                    <asp:TextBox ID="otromot" CssClass="form-control text-uppercase" placeholder="OTRO" name="otromot" runat="server"></asp:TextBox>

                                                                </div>
                                                            </div>
                                                        </div>

                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>


                    </div>
                </div>

                <div class="modal-footer">
                   

                    <button class="btn btn-primary" onclick="validaIns()" type="button" data-backdrop="false">
                        <i class="fa fa-check-square-o"></i>Guardar
                    </button>

                    <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModalIns">
                        <i class="ft-x"></i>Cerrar
                    </button>
                </div>
            </div>
        </div>


    </div>


    <div class="modal fade" id="walumnos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title" id="myModalLabel35">Consulta de Alumnos</h3>
                        </div>


                        <div class="modal-body">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>

                                    <asp:Button runat="server" ID="Bseleccionar" OnClick="getAlumno" Style="display: none" UseSubmitBehavior="false"/>
                                    <div class="row">


                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="cliente" class="text-bold-600">Nombre</label>
                                                <asp:TextBox ID="bnombre" CssClass="form-control text-uppercase" placeholder="Nombre" name="nombre" runat="server" OnTextChanged="listadoAlumnosBus" AutoPostBack="true">

                                                </asp:TextBox>
                                            </div>
                                        </div>
                                    </div>


                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div style="overflow-x: auto; width: 100%">
                                                <asp:GridView runat="server" ID="GVlistaalumnos" PageSize="10" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered base-style"
                                                    AutoGenerateColumns="False" DataSourceID="DSlistaalumnos" DataKeyNames="idalumno"
                                                    AlternatingRowStyle-BackColor="#F5F7FA"  OnPageIndexChanged="listadoAlumnosBus">
                                                    <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                                    <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <%# Container.DataItemIndex + 1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="nocontrol" HeaderText="No. Control" SortExpression="nocontrol" />

                                                        <asp:BoundField DataField="ncompleto" HeaderText="Nombre" SortExpression="ncompleto" />

                                                        <asp:TemplateField HeaderText="Seleccionar" ItemStyle-Width="80px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda">
                                                            <ItemTemplate>
                                                                
                                                                <button type="button" id="" onclick="seleccionar(<%# Eval("idalumno")%>)" class="btn btn-icon btn-success mr-1 <%# Eval("registrado").ToString().Equals("1")?"ocultar":""%>" data-toggle="tooltip" data-original-title="Seleccionar" >
                                                                    <i class="ft-edit"></i>
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

                                         <div id="divResultados" runat="server" visible="false">
                                            
                                                                                   
                                            <label class="col-md-6 label-control" >No se encontraron registros, desea realizar un registro manual?</label>
                                            <button type="button" class="btn btn-danger" onclick="registroManual()">
                                                        <i class="fa fa-check-square-o"></i>Registro Manual
                                             </button>  

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

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-bold-600">Tipo de Cancelación</label>
                                <asp:DropDownList runat="server" ID="desercion" CssClass="select2 form-control" DataSourceID="DSdesercion" DataTextField="tipodesercion" DataValueField="idtipodesercion" Style="width: 100%">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="Dsdesercion" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                    SelectCommand="SELECT idtipodesercion, tipodesercion from tipodesercion order by tipodesercion"></asp:SqlDataSource>
                            </div>
                        </div>

                    </div>

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

                    <div class="row">

                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-bold-600">Estatus</label>
                                <asp:DropDownList runat="server" ID="tipocambio" CssClass="select2 form-control" DataSourceID="DStipocambio" DataTextField="tipodesercion" DataValueField="idtipodesercion" Style="width: 100%">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="DStipocambio" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                    SelectCommand="select v.* from (SELECT idtipodesercion, tipodesercion from tipodesercion union select  0 as idtipodesercion, 'INSCRITO'as tipodesercion)as v order by v.idtipodesercion"></asp:SqlDataSource>
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-bold-600">Observaciones</label>
                                <asp:TextBox ID="modobserv" CssClass="form-control text-uppercase" MaxLength="0" TextMode="MultiLine" Rows="3" placeholder="Observaciones" name="telefono" runat="server"></asp:TextBox>

                            </div>
                        </div>
                    </div>

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
                
        $('#fc-basic-views').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: ''
            },
            defaultDate: '2017-09-11',
            lang: initialLangCode,
            navLinks: false, // can click day/week names to navigate views
            editable: true,
            eventLimit: true,
            height: 500

        });


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
            
                $("*[id$='bnombre]").focus();

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
            $("*[id$='bnombre']").focus();
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
            
            $('#<%= bguardarIns.ClientID %>').click();
                       
                                           
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
                    $('#<%= bautorizacion.ClientID %>').click();
                  }
                }) 
           
                                           
        }


         function validaFechas() {
       
            
            var fagenda = $("*[id$='fagenda']").val(); 
             
            var horaini = $("*[id$='horanini']").val();                        
            var horafin = $("*[id$='horanfin']").val(); 
           
            
            walert = 1;
            

            if (fagenda == '') {
                alerta('Atención', 'Ingrese la fecha de término del curso', 'warning', $("*[id$='fechafin']"));
                return false;
            }
                       
           

            if (horaini == '') {
                alerta('Atención', 'Ingrese el horario (hora de inicio) del curso', 'warning', $("*[id$='horanini']"));
                return false;
            }


            if (horafin == '') {
                alerta('Atención', 'Ingrese el horario (hora de término) del curso', 'warning', $("*[id$='horanfin']"));
                return false;
            }


                              
            walert = 0;
            //$('#wfechas').modal('hide');
            mostrarLoading();
            
            $('#<%= guardarFechas.ClientID %>').click();
                       
                                           
        }

        function eliminaFechas() {


            swal({
                title: "Se realizará la enajenación sobre esta boleta, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#DD6B55',
                confirmButtonText: 'Si',
                cancelButtonText: "No"
            }).then((result) => {
                if (result.value) {
                    mostrarLoading();
                    $('#<%= eliminarFechas.ClientID %>').click();
                  }
                }) 
         
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


        function seleccionar(idalumno) {
            
            mostrarLoading();
            $("*[id$='idA']").val(idalumno);
            //$("#bootstrap").modal('show');
           
            $('#<%= Bseleccionar.ClientID %>').click();
            
                        
        }

        function abrirModal(idsolicitud, idalumno) {
          
            mostrarLoading();
            $("*[id$='hpicture']").val('');
            $("*[id$='fotopa']").attr('src','');
            $("*[id$='idI']").val(idsolicitud);
            $("*[id$='idA']").val(idalumno);
           
           
            $('#<%= bsolicitud.ClientID %>').click();
            
                        
        }
		
		function abrirModalInscripcion(idcurso, idsucursal) {
            
            mostrarLoading();
            $("*[id$='hpicture']").val('');
            $("*[id$='fotopa']").attr('src','');
            $("*[id$='idP']").val(idcurso);
            $("*[id$='idS']").val(idsucursal);
           
             
            //$("#bootstrap").modal('show');
           
            $('#<%= BnuevoInscripcion.ClientID %>').click();
            
                        
        }

        function abrirModalFechas() {

            //$("*[id$='fagenda']").focus();
            $("*[id$='idF']").val(0);
            $("*[id$='horanini']").val($("*[id$='horaini']").val());
            $("*[id$='horanfin']").val($("*[id$='horafin']").val());
            $("#bguardaFecha").show();
            $("#bborraFecha").hide();
            //$("#divResultados").hide(); 

            $("*[id$='fagenda']").removeAttr('disabled');
            $("*[id$='horanini']").removeAttr('disabled');
            $("*[id$='horanfin']").removeAttr('disabled');
            
            $("#wfechas").modal('show');
        }

        function abrirModal2(idinstructor, idsucursal, idespecialidad, profesion, idescolaridad, rfc, curp, fechanacimiento, domicilio, localidad, email, telefono, celular, observaciones, activo, nombre) {

            
            $("*[id$='idP']").val(idinstructor);

            if(idsucursal>0)
                $("*[id$='idS']").val(idsucursal);

            $("*[id$='nombre']").val(nombre);
            $("*[id$='especialidad']").val(idespecialidad);
            $("*[id$='especialidad']").change();
            $("*[id$='profesion']").val(profesion);
            $("*[id$='escolaridad']").val(idescolaridad);
            $("*[id$='escolaridad']").change();
            $("*[id$='rfc']").val(rfc);
            $("*[id$='curp']").val(curp);            
            $("*[id$='fechanacimiento']").val(fechanacimiento);
            $("*[id$='domicilio']").val(domicilio);
            $("*[id$='localidad']").val(localidad);
            $("*[id$='telefono']").val(telefono);
            $("*[id$='email']").val(email);
            $("*[id$='adicional']").val(celular);

            $("*[id$='observaciones']").val(observaciones);
            // $("*[id$='tiposucursal']").change();

            if (activo == 1)
                $("*[id$='activo']").iCheck('check');
            else
                $("*[id$='activo']").iCheck('uncheck');

            $("#bootstrap").modal('show');
        }

        function editarRegistro(id, ids) {
            
            mostrarLoading();
            $("*[id$='idP']").val(id);
            $("*[id$='idS']").val(ids);
           $('#<%= Beditar.ClientID %>').click();
        }

        function nuevoRegistro() {
            mostrarLoading();
            $("*[id$='idP']").val(0);
            $("*[id$='idA']").val(0);
            $("*[id$='idI']").val(0);
           
            $('#<%= BnuevoInscripcion.ClientID %>').click();
        }

        $('#bootstrap').on('shown.bs.modal', function () {
            $("#fc-basic-views").fullCalendar('render');
        });        


        function ver() {            
            $("*[id$='hdias']").val($("#algo").val());           
        }

        function dar() {            
            var valores = $("*[id$='hdias']").val();           
            var arreglo = valores.split(","); 
            $('#algo').val(arreglo);
            $('#algo').trigger('change');         
        }

        


        function cargatagsInv() {
           
            $("*[id$='tagsdiscap']").val($("*[id$='xxdiscapacidad']").val()); 
            $("*[id$='tagsmot']").val($("*[id$='motivo']").val());  
            $("*[id$='tagsmed']").val($("*[id$='medio']").val());
           


        }

        function registroManual() {
            $("#walumnos").modal('hide');
            $("*[id$='nocontrol']").focus();
        }

        function imprimirSolicitudAut() {
            mostrarLoading();
            $('#<%= bimprimir.ClientID %>').click();
            cerrarLoading();
        }

        function imprimirSolicitud(idsolicitud, idalumno, nocontrol) {

            mostrarLoading();
            $("*[id$='idI']").val(idsolicitud);
            $("*[id$='idA']").val(idalumno);
            $("*[id$='idctr']").val(nocontrol);
           
            $('#<%= BimprimirSolicitud.ClientID %>').click();
            cerrarLoading();
        }

        function imprimirCredencial(idsolicitud, idalumno, nocontrol) {

            mostrarLoading();
            $("*[id$='idI']").val(idsolicitud);
            $("*[id$='idA']").val(idalumno);
            $("*[id$='idctr']").val(nocontrol);
           
            $('#<%= BimprimirCredencial.ClientID %>').click();
            cerrarLoading();
        }

        


        function conteoIds() {
            var ids = "";            
            var aux = "";
            var res = "";
            $('.cks').each(function (id) {
                
                if ($(this).closest("input").attr('checked')) {
                     aux = this.id;
                     res = aux.split("_");
                     ids += res[1]+  ",";                                        
                }
                               
            });         

                $("*[id$='tagsdoc']").val(ids);
        }


        function abrirModalCancelacion(idsolicitud, idalumno) {

             $("*[id$='idI']").val(idsolicitud);
             $("*[id$='idA']").val(idalumno);
             $("*[id$='motcancelacion']").val('');
             $("#wcancelar").modal('show');

         
        }

        function abrirModalModificacion(idsolicitud, idalumno) {

            $("*[id$='idI']").val(idsolicitud);
            $("*[id$='idA']").val(idalumno);
            $("*[id$='modobserv']").val('');
            $("#wmodificar").modal('show');


        }


        function cancelarCurso() {
            swal({
                title: "Se eliminará a este alumno del curso, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#DD6B55',
                confirmButtonText: 'Si',
                cancelButtonText: "No"
            }).then((result) => {
                if (result.value) {
                    mostrarLoading();
                     $('#<%= Bcancelarcurso.ClientID %>').click();
                   
                  }
                }) 
         
        }

        function modificaAlumno() {
            swal({
                title: "Se modificará el estatus de este alumno en el curso, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#DD6B55',
                confirmButtonText: 'Si',
                cancelButtonText: "No"
            }).then((result) => {
                if (result.value) {
                    mostrarLoading();
                    $('#<%= Bmodificaalumno.ClientID %>').click();

                }
            })

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

        function descargarArchivo(iddocumentacion) {            
            
            $("*[id$='idDoc']").val(iddocumentacion);
            $('#<%= botonDescarga.ClientID %>').click();
                                    
        }


        function cargatags() {

            var discap = $("*[id$='tagsdiscap']").val();
            var arreglo = discap.split(",");
            $("*[id$='discapacidad']").val(arreglo);
            $("*[id$='discapacidad']").trigger('change');


            var motivos = $("*[id$='tagsmot']").val();
            var arreglo2 = motivos.split(",");
            $("*[id$='motivo']").val(arreglo2);
            $("*[id$='motivo']").trigger('change');


            var discapm = $("*[id$='tagsmed']").val();
            var arreglo3 = discapm.split(",");

            $("*[id$='medio']").val(arreglo3);
            $("*[id$='medio']").trigger('change');



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
                    $("*[id$='bnombre']").focus();
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

     

          
            //$("#algo").on("select2:select", function (e) { $("#algo").select2('close'); });
            $("#algo").on("select2:select", function (e) { $("*[id$='hdias']").val($("#algo").val()); calendario();  });
            $("#algo").on("select2:unselect", function (e) { $("*[id$='hdias']").val($("#algo").val()); ; calendario(); var self = $(this);
            setTimeout(function() {
                self.select2('close');
                }, 0);
            });

            $('#algo').on('select2:opening select2:closing', function( event ) {
                var $searchfield = $(this).parent().find('.select2-search__field');
                $searchfield.prop('disabled', true);
            });



            $("*[id$='xxdiscapacidad']").on("select2:select", function (e) { cargatagsInv(); });
            $("*[id$='xxdiscapacidad']").on("select2:unselect", function (e) { cargatagsInv(); var self = $(this);
            setTimeout(function() {
                self.select2('close');
                }, 0);
            });

            $("*[id$='xxdiscapacidad']").on('select2:opening select2:closing', function( event ) {
                var $searchfield = $(this).parent().find('.select2-search__field');
                $searchfield.prop('disabled', true);
            });


            $("*[id$='medio']").on("select2:select", function (e) { cargatagsInv(); });
            $("*[id$='medio']").on("select2:unselect", function (e) { cargatagsInv(); var self = $(this);
            setTimeout(function() {
                self.select2('close');
                }, 0);
            });

            $("*[id$='medio']").on('select2:opening select2:closing', function( event ) {
                var $searchfield = $(this).parent().find('.select2-search__field');
                $searchfield.prop('disabled', true);
            });



            $("*[id$='motivo']").on("select2:select", function (e) { cargatagsInv(); });
            $("*[id$='motivo']").on("select2:unselect", function (e) { cargatagsInv(); var self = $(this);
            setTimeout(function() {
                self.select2('close');
                }, 0);
            });

            $("*[id$='motivo']").on('select2:opening select2:closing', function( event ) {
                var $searchfield = $(this).parent().find('.select2-search__field');
                $searchfield.prop('disabled', true);
            });


            $('.cks').on('ifChecked', function (event) {
                 $(this).closest("input").attr('checked', true);
                conteoIds();               

            });

            $('.cks').on('ifUnchecked', function (event) {  
                 $(this).closest("input").attr('checked', false);
                        conteoIds();                       
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

            //Phone mask
                $('.phone-inputmask').inputmask("(999) 999-9999");

                $('.email-inputmask').inputmask({
                    mask: "*{1,20}[.*{1,20}][.*{1,20}][.*{1,20}]@*{1,20}[*{2,6}][*{1,2}].*{1,}[.*{2,6}][.*{1,2}]",
                    greedy: false,
                    onBeforePaste: function (pastedValue, opts) {
                        pastedValue = pastedValue.toLowerCase();
                        return pastedValue.replace("mailto:", "");
                    },
                    definitions: {
                        '*': {
                            validator: "[0-9A-Za-z!#$%&'*+/=?^_`{|}~/-]",
                            cardinality: 1,
                            casing: "lower"
                        }
                    }
                });

            // Date dd/mm/yyyy
            $('.date-inputmask').inputmask("yyyy-mm-dd", { "placeholder": "aaaa-mm-dd" });


                $('.pickadate').pickadate({
                    format: 'yyyy-mm-dd',
                    formatSubmit: 'yyyy-mm-dd',
                    monthsFull: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                    weekdaysShort: ['Dom', 'Lun', 'Mar', 'Mier', 'Jue', 'Vie', 'Sab'],                   
                    today: 'Hoy',
                    minDate: '',
                    maxDate: '',
                    clear: 'Limpiar',
                    

                });


            $("*[id$='horaini']").pickatime({
                format: ' HH:i ',
                formatLabel: 'HH:i ',
                clear: '',
                onSet: function (context) {
                    calendario();
                }
            });

            $("*[id$='horafin']").pickatime({
                format: ' HH:i ',
                formatLabel: 'HH:i ',
                clear: '',
                onSet: function (context) {
                    calendario();
                }
            });


            $("*[id$='horanini']").pickatime({
                format: ' HH:i ',
                formatLabel: 'HH:i ',
                clear: '',
            });

            $("*[id$='horanfin']").pickatime({
                format: ' HH:i ',
                formatLabel: 'HH:i ',
                clear: '',
            });


            
        }
     </script>
</asp:Content>
