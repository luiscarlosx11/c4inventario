<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="frminscripcion2.aspx.cs" Inherits="elecion.inscripcion.frminscripcion2" EnableEventValidation="false" %>
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

    <style>

body { padding-right: 0 !important }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">CAPACITACIÓN</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Capacitación</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Inscripción</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cuerpo" runat="server">
 <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    
        

       <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>
        <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">INSCRIPCIÓN</h4>
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
                                                    
                                                   
                                                    <asp:HiddenField runat="server" ID="idP" /> 
													<asp:HiddenField runat="server" ID="idA" /> 
													<asp:HiddenField runat="server" ID="idI" /> 
                                                    <asp:HiddenField runat="server" ID="limite" Value="48" /> 
                                                    <asp:HiddenField runat="server" ID="idS" /> 
                                                    <asp:HiddenField runat="server" ID="idF" />
                                                    <asp:Button runat="server" ID="Bconsultar" OnClick="listadoClientes" Style="display: none" UseSubmitBehavior="false"/>
                                                                                                                                                                  
                                                    <asp:Button runat="server" ID="Bnuevo" OnClick="limpiarCampos" style="display:none" UseSubmitBehavior="false"/> 
													<asp:Button runat="server" ID="BnuevoInscripcion" OnClick="limpiarCamposInscripcion" style="display:none" UseSubmitBehavior="false"/>  													
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
											<asp:TextBox ID="bname" CssClass="form-control text-uppercase"  placeholder="Nombre" name="bname" runat="server" OnTextChanged="listadoClientes" AutoPostBack="true"></asp:TextBox>
										</div>
									</div>
                              </div>
                            </div>
                            
                           

                                    

                        </div>
                        


                </div>
            </div>
        </div>



            <div class="row">
                
                <asp:DataList ID="lusuarios" runat="server" DataSourceID="DsUsuarios" RepeatLayout="Flow" RepeatDirection="Horizontal" OnDataBinding="conteoRegistros">
                    <ItemTemplate>
                        
                        <div class="col-xl-3 col-md-6 col-xs-12">
                            
			
		

                            <div class="card box-shadow-1 height-400">
                                <div class="card-header">

                                    
                                    
                                    <span class="float-xs-right">
                                        <span class="tag bg-<%# Eval("estatus").Equals("EN CAPTURA")?"info":Eval("estatus").Equals("OFERTADO")?"primary":Eval("estatus").Equals("EN REVISION")?"warning":Eval("estatus").Equals("AUTORIZADO")?"success":Eval("estatus").Equals("RECHAZADO")?"danger":""%>"><%# Eval("estatus")%></span>
                                    </span>

                                    
                                </div>

                                <div class="text-xs-center">
                                    
                                    <img src="../../../app-assets/images/portrait/medium/avatar-m-4.png" class="rounded-circle height-75"><br />
                                    <h6 class="text-bold-700"><%# Eval("nombre")%></h6>
                                    <h6 class="text-bold-600"><i class="fa fa-usd font-medium-1"></i><%# " "+Eval("costo") %></h6>
                                    <ul class="list-inline clearfix">
                                        <li class="border-right-blue-grey border-right-lighten-2 pr-2">
                                            <h1 class="danger text-bold-400"><%# Eval("alumnosminimo")%></h1>
                                            <span class="blue-grey darken-1"><i class="icon-user"></i> Requerido</span>
                                        </li>
                                        <li class="pl-2">
                                            <h1 class="danger text-bold-400"><%# Eval("inscritos")%></h1>
                                            <span class="blue-grey darken-1"><i class="icon-user-follow"></i> Inscritos</span>
                                        </li>
                                    </ul>
                                     
                                        <h7 class="text-bold-400"><i class="fa fa-user font-medium-1"></i> <%# " "+Eval("instructor")%></h7><br />
                                        <h7 class="text-bold-400"><i class="fa fa-calendar font-medium-1"></i><%# " "+Eval("fechaini") +" al "+ Eval("fechafin")%></h7><br />
                                        <h7 class="text-bold-400"><i class="fa fa-clock-o font-medium-1"></i><%# " "+Eval("horaini") +" - "+ Eval("horafin")%></h7><br />
                                        <button type="button" class="btn btn-icon btn-primary mr-1 btn-sm"  onclick="abrirModalInscripcion(<%# Eval("idcurso") %>,<%# Eval("idsucursal") %>)" value=""><i class="ft-edit"> </i> Inscribir</button>                                            
                                        

                                </div>
                            </div>

                        </div>
                        
                    </ItemTemplate>
                    

                </asp:DataList>
                <asp:SqlDataSource ID="DsUsuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>
                

            </div>

            <div class="row">
                <div class="col-md-12 ">

                    <div class="text-xs-center">
                        <nav aria-label="Page navigation">
                            <h5 class="text-xs-center"></h5>
                            <asp:HiddenField ID="pagina" runat="server" Value="1" />
                            <ul class="pagination pagination-lg mb-1">
                                <% 
                                    int totalreg = Convert.ToInt32(labelConteo.Text);
                                    int nreg = Convert.ToInt32(limite.Value);
                                    double total = Math.Ceiling((double)totalreg / nreg);
                                    int i;

                                    if (totalreg > nreg)
                                    {
                                        for (i = 0; i < Convert.ToInt32(total); i++)
                                        { %>
                                <li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="paging(<%=i + 1%>)"><%=i + 1%></a></li>
                                <%}
                                    } %>
                            </ul>
                        </nav>

                    </div>
                </div>
            </div>

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
                                                                                    where idsucursal=1
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
                                                                    <asp:Button runat="server" ID="bimprimir" OnClick="bimprimir_Click" UseSubmitBehavior="false" Style="display: none" />
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

                                            
                                            <asp:GridView runat="server" ID="GValumnos" PageSize="10" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                                AutoGenerateColumns="False" DataSourceID="DSalumnos" EnableSortingAndPagingCallbacks="true"
                                                AlternatingRowStyle-BackColor="#F5F7FA" OnPageIndexChanged="listadoAlumnos">
                                                
                                                <Columns>
                                                    <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="nombrealumno" HeaderText="Nombre" SortExpression="nombre" ItemStyle-Font-Size="Small" />
                                                    <asp:BoundField DataField="costoAlumno" HeaderText="Cantidad" SortExpression="costoAlumno" ItemStyle-Width="50px" ItemStyle-Font-Size="Small" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" DataFormatString="{0:c}" HtmlEncode="False"/>
                                                    <asp:BoundField DataField="folio" HeaderText="Folio" SortExpression="folio"  ItemStyle-Width="150px" ItemStyle-Font-Size="Small" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda"/>
                                                    <asp:BoundField DataField="fecha" HeaderText="Fecha" SortExpression="fecha" ItemStyle-Width="150px" ItemStyle-Font-Size="Small"  ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda"/>
                                                </Columns>

                                            </asp:GridView>
                                               
                                            <asp:SqlDataSource ID="DSalumnos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>

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


        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title">INSCRIPCIÓN</h5>
                </div>

                <asp:HiddenField runat="server" ID="HiddenField1" />

                <div class="modal-body">

                    <ul class="nav nav-tabs nav-top-border no-hover-bg">
                        <li class="nav-item">
                            <a class="nav-link active" id="tabgenerales" data-toggle="tab" href="#generales" aria-controls="tabgenerales" aria-expanded="true"><i class="fa fa-folder"></i>Personales</a>
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


                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-body collapse in">
                                                    <div class="card-block">
                                                        <div class="row">

                                                            <div class="col-md-12">


                                                                <div class="row">

                                                                    <div class="col-md-12">

                                                                        <div class="row">
                                                                            <div class="col-md-4">
                                                                                <div class="form-group">
                                                                                    <label class="text-bold-600">Núm. de Control</label>
                                                                                    <asp:TextBox ID="nocontrol" CssClass="form-control text-uppercase" placeholder="NO. DE CONTROL" name="nocontrol" runat="server" disabled></asp:TextBox>

                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                            <div class="form-group align-bottom">
                                                                                <br />
                                                                                <button class="btn btn-primary" onclick="abrirModalAlumnos()" type="button" id="BBbuscarcliente" runat="server">
                                                                                    <i class="fa fa-check-square-o"></i>Buscar Alumno
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

                                                                    </div>

                                                                </div>


                                                                <div class="row">

                                                                    <div class="col-md-12">

                                                                        <div class="row">
                                                                            <div class="col-md-2">
                                                                                <div class="form-group">
                                                                                    <label class="text-bold-600">Sexo</label><br />

                                                                                    <asp:DropDownList ID="sexo" runat="server" CssClass="form-control select2">
                                                                                        <asp:ListItem Selected="True">HOMBRE</asp:ListItem>
                                                                                        <asp:ListItem>MUJER</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>

                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <div class="form-group">
                                                                                    <label class="text-bold-600">Curp</label>
                                                                                    <asp:TextBox ID="curp" CssClass="form-control text-uppercase" placeholder="CURP" name="curp" runat="server"></asp:TextBox>

                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-2">
                                                                                <div class="form-group">
                                                                                    <label class="text-bold-600">Fecha Nacimiento</label>
                                                                                    <asp:TextBox ID="fechanacimiento" CssClass="form-control pickadate text-uppercase" placeholder="Fecha Nacimiento" name="fechanacimiento" runat="server"></asp:TextBox>

                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-4">
                                                                                <div class="form-group">
                                                                                    <label class="text-bold-600">Teléfono</label>
                                                                                    <asp:TextBox ID="telefono" CssClass="form-control text-uppercase" placeholder="TELEFONO" name="telefono" runat="server"></asp:TextBox>

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
                                                                                    <asp:DropDownList runat="server" ID="discapacidad" CssClass="select2 form-control" DataSourceID="DSdiscapacidad" DataTextField="discapacidad" DataValueField="iddiscapacidad" Style="width: 100%" multiple="multiple" onchange=""></asp:DropDownList>
                                                                                    <asp:SqlDataSource ID="DSdiscapacidad" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT iddiscapacidad, discapacidad FROM discapacidad ORDER BY discapacidad"></asp:SqlDataSource>

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
                                    </div>

                                </ContentTemplate>

                            </asp:UpdatePanel>

                        </div>
                        <div role="tabpanel" class="tab-pane fade " id="costos" aria-labelledby="tabcostos" aria-expanded="true">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel7">
                                <ContentTemplate>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-body collapse in">
                                                    <div class="card-block">
                                                        <div class="row">


                                                            <asp:UpdatePanel runat="server" ID="UpdatePanel8">
                                                                <ContentTemplate>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label class="text-bold-600">Especialidad a la que desea inscribirse</label>
                                                                            <asp:DropDownList runat="server" ID="especialidadins" CssClass="select2 form-control" DataSourceID="Dsespecialidadesins" DataTextField="especialidad" DataValueField="idespecialidad" Style="width: 100%" AutoPostBack="true"></asp:DropDownList>
                                                                            <asp:SqlDataSource ID="Dsespecialidadesins" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idespecialidad, especialidad FROM especialidad ORDER BY especialidad"></asp:SqlDataSource>

                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label class="text-bold-600">Curso</label>
                                                                            <asp:DropDownList runat="server" ID="curso" CssClass="select2 form-control" DataSourceID="DScursos" DataTextField="nombre" DataValueField="idcurso" Style="width: 100%"></asp:DropDownList>
                                                                            <asp:SqlDataSource ID="DScursos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idcurso, nombre FROM curso where idespecialidad=@idcat ORDER BY nombre">
                                                                                <SelectParameters>
                                                                                    <asp:ControlParameter ControlID="especialidadins" Name="idcat" PropertyName="SelectedValue" />

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



                                                            <div class="col-md-6">

                                                                <label class="text-bold-600">Documentación Entregada</label><br />
                                                                <div class="col-md-12">
                                                                    <div class="form-group">

                                                                        <asp:GridView runat="server" ID="GVdocumentacion" PageSize="25" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration"
                                                                            AutoGenerateColumns="False" DataSourceID="DSdocumentacion"
                                                                            AlternatingRowStyle-BackColor="#F5F7FA">
                                                                            <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                                                            <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                                                            <Columns>

                                                                                <asp:TemplateField HeaderText="" ItemStyle-Width="10px" ItemStyle-HorizontalAlign="Center">
                                                                                    <ItemTemplate>

                                                                                        <input id="<%# Eval("iddocumentacion")+"_"+Eval("documentacion") %>" type="checkbox" class="cks" value="<%# Container.DataItemIndex%>" <%# Eval("entregado").ToString().Equals("1")?"checked":"" %>>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="documentacion" HeaderText="Documentacion" SortExpression="documentacion" ItemStyle-Width="400px" ItemStyle-Font-Size="Small" />

                                                                            </Columns>

                                                                        </asp:GridView>

                                                                        <asp:SqlDataSource ID="DSdocumentacion" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand=""></asp:SqlDataSource>


                                                                    </div>
                                                                </div>
                                                                <br />

                                                            </div>

                                                            <div class="col-md-6">

                                                                <label class="text-bold-600">Empresa donde trabaja</label><br />
                                                                <div class="col-md-12">
                                                                    <div class="form-group">

                                                                        <div class="col-md-12">
                                                                            <div class="form-group">

                                                                                <label class="text-bold-600">Puesto</label>
                                                                                <asp:TextBox ID="empresa" CssClass="form-control text-uppercase" placeholder="EMPRESA" name="empresa" runat="server"></asp:TextBox>


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
                                            <div class="card">
                                                <div class="card-body collapse in">
                                                    <div class="card-block">

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
                                                                    <asp:TextBox ID="otromed" CssClass="form-control text-uppercase" placeholder="OTRO" name="otromedio" runat="server"></asp:TextBox>

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
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>


                    </div>
                </div>

                <div class="modal-footer">




                    <button class="btn btn-warning" onclick="solicita()" type="button" data-backdrop="false">
                        <i class="fa fa-check-square-o"></i>Imprimir
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

                                                        <asp:TemplateField HeaderText="Seleccionar" ItemStyle-Width="80px" ItemStyle-CssClass="centrarCelda" HeaderStyle-CssClass="centrarCelda">
                                                            <ItemTemplate>

                                                                <button type="button" id="" onclick="seleccionar(<%# Eval("idalumno")%>)" class="btn btn-icon btn-success mr-1" data-toggle="tooltip" data-original-title="Seleccionar">
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
                            <asp:Button runat="server" ID="Button1" Style="display: none" CausesValidation="false" />
                            <asp:Button runat="server" ID="borrar" Style="display: none" />

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


        $('#wfechas').on('shown.bs.modal', function () {
            //alert($("*[id$='idF']").val());
            if ($("*[id$='idF']").val() == "0")
                $("*[id$='fagenda']").focus();

        })


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

        function abrirModal(idcurso, idsucursal) {
            
            mostrarLoading();
            $("*[id$='idP']").val(idcurso);
            $("*[id$='idS']").val(idsucursal);
            //$("#bootstrap").modal('show');
           
            $('#<%= Bfechas.ClientID %>').click();
            
                        
        }
		
		function abrirModalInscripcion(idcurso, idsucursal) {
            
            mostrarLoading();
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
            
           
            $('#<%= Bnuevo.ClientID %>').click();
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

        function imprimirSolicitudAut() {
            mostrarLoading();
            $('#<%= bimprimir.ClientID %>').click();
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
                loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.min.js");
                
                loadJS("/app-assets/js/scripts/pages/dashboard-analytics.js");

         
            
                walert = 0;
                fecha = $("*[id$='fechaini']").val();                
                $('#bootstrap').on('shown.bs.modal', function () {
                    $("*[id$='nombre']").focus();
                });

            
            $(document).ready(function () {
            $('.cks').iCheck({
                checkboxClass: 'icheckbox_flat-green',
                increaseArea: '20%' // optional
            });

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


                $('#fc-basic-views').fullCalendar({
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right:''
                    },
                    eventRender: function (eventObj, $el) {
                        $el.popover({
                            title: 'Horario',
                            content: eventObj.description,
                            trigger: 'hover',
                            placement: 'top',
                            container: 'body'
                        });
                    },
                    defaultDate: '2017-09-11',
                    defaultView: 'month',
                    duration: { days: 15 },
                    locale: 'es',
                    events: dataEvent,                   
                    eventClick: function(event) {
                        
                        $("*[id$='idF']").val(event.id);
                        $("*[id$='fagenda']").val(event.fecha);
                        $("*[id$='horanini']").val(event.horaini);
                        $("*[id$='horanfin']").val(event.horafin);
                        //$("#bguardaFecha").show();
                        //$("#bborraFecha").hide();

                        //$("*[id$='fagenda']").attr('disabled', 'disabled');
                       // $("*[id$='horanini']").attr('disabled', 'disabled');
                        //$("*[id$='horanfin']").attr('disabled','disabled');

                        $("#wfechas").modal('show');

                    },
                    navLinks: false, // can click day/week names to navigate views
                    editable: true,
                    
                    height: 500
                });


                $('#fc-basic-views').fullCalendar('today');
                                           

        }
    </script>
</asp:Content>
