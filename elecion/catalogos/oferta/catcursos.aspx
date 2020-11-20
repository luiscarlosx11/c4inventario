<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false"
     CodeBehind="catcursos.aspx.cs"  Inherits="elecion.catalogos.oferta.catcursos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
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
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">OFERTA EDUCATIVA</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Catálogos</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Oferta Educativa</a>
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
        <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">CURSOS</h4>
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
                                                    <asp:HiddenField runat="server" ID="limite" Value="48" /> 
                                                    <asp:HiddenField runat="server" ID="idS" /> 
                                                    <asp:HiddenField runat="server" ID="idSU" />
                                                    <asp:HiddenField runat="server" ID="idF" />
                                                    <asp:HiddenField runat="server" ID="cve" />
                                                    <asp:HiddenField runat="server" ID="idOE" />


                                                    <asp:Button runat="server" ID="Bconsultar" OnClick="listadoClientes" Style="display: none" UseSubmitBehavior="false"/>
                                                    <asp:Button runat="server" ID="Bcancelarcurso" OnClick="cancelaCurso" Style="display: none" UseSubmitBehavior="false"/>
                                                    <asp:Button runat="server" ID="Bguardaobjetivo" OnClick="guardaObjetivo" Style="display: none" UseSubmitBehavior="false"/>
                                                    <asp:Button runat="server" ID="Beliminaobjetivo" OnClick="eliminaObjetivo" Style="display: none" UseSubmitBehavior="false"/>
                                                                                                                                                                  
                                                    <asp:Button runat="server" ID="Bnuevo" OnClick="limpiarCampos" style="display:none" UseSubmitBehavior="false"/>                                            
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
											<asp:TextBox ID="bname" CssClass="form-control text-uppercase"  placeholder="Búsqueda por Nombre, Clave" name="bname" runat="server"  AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
										</div>
									</div>

                                     <div class="col-md-4" id="busplantel" runat="server">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Plantel</label>
											<asp:DropDownList runat="server" ID="bplantel" CssClass="select2 form-control" DataSourceID="DSplantel" DataTextField="nombre" DataValueField="idsucursal" AppendDataBoundItems="true" onChange="consultaPrincipal()">
                                                <asp:ListItem Value="0" Text="SELECCIONE UN PLANTEL"></asp:ListItem>
											</asp:DropDownList>
                                         <asp:SqlDataSource ID="DSplantel" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idsucursal, nombre FROM sucursal ORDER BY nombre">
                                             
                                         </asp:SqlDataSource>                                          
										</div>
									</div>
                              </div>
                            </div>
                            
                           
                            <div class="row">
                
               

                <div class="card-block card-dashboard">
                 <div style="overflow-x:auto;width:100%"> 
                            <asp:GridView runat="server" ID="lusuarios" PageSize="50" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                AutoGenerateColumns="False" DataSourceID="DsUsuarios" EnableSortingAndPagingCallbacks="true"
                                AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros" OnPageIndexChanged="listadoClientes">
                                <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White"/>
                                        <Columns>
                                            <asp:TemplateField HeaderText="No." HeaderStyle-CssClass="centrarCelda" ItemStyle-Width="20px" ItemStyle-CssClass="centrarCelda">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            
                                            
                                            <asp:TemplateField HeaderText="Generales" >
                                                <ItemTemplate>
                                                   
                                                    <h6 class="text-bold-700"><%# Eval("clave")+ " / "+Eval("nombre")%></h6>
                                                    <h7 class="text-bold-400 font-small-3 font-italic text-bold-600"><i class="fa fa-home"></i> <%# " "+Eval("plantel")%></h7><br />
                                                    <h7 class="text-bold-400 font-small-3"><i class="fa fa-user "></i> <%# " "+Eval("instructor")%></h7><br />
                                                    <h7 class="text-bold-400 font-small-3"><i class="fa fa-calendar "></i><%# " "+Eval("fechaini") +" al "+ Eval("fechafin")%></h7><br />
                                                    <h7 class="text-bold-400 font-small-3"><i class="fa fa-clock-o "></i><%# " "+Eval("horaini") +" - "+ Eval("horafin")%></h7><br />     
                                                       
                                                </ItemTemplate>
                                            </asp:TemplateField>


                                            <asp:TemplateField HeaderText="Alumno" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                <ItemTemplate>
                                                   
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
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Estatus" ItemStyle-Width="20px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                <ItemTemplate>
 
                                                    <span class="float-xs-right">
                                                        <span class="tag bg-<%# Eval("estatus").Equals("EN CAPTURA")?"info":Eval("estatus").Equals("OBSERVADO")?"danger":Eval("estatus").Equals("EN REVISION")?"warning":Eval("estatus").Equals("AUTORIZADO")?"success":Eval("estatus").Equals("RECHAZADO")?"danger":Eval("estatus").Equals("CANCELADO")?"red":"black"%> font-weight-bold"><%# Eval("estatus")%></span>
                                                    </span>                                                                                                
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                           
                                            <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                <ItemTemplate>

                                                    <button type="button" class="btn btn-icon btn-warning mr-1 btn-sm tooltips"  onclick="abrirModal(<%# Eval("idcurso") %>,<%# Eval("idsucursal") %>)" value="" data-toggle="tooltip" data-original-title="Detalles"><i class="ft-edit"> </i> </button>                                            
                                                    <button type="button" class="btn btn-icon btn-danger mr-1 btn-sm tooltips"  onclick="abrirModalCancelacion(<%# Eval("idcurso") %>)" value="" data-toggle="tooltip" data-original-title="Cancelar" <%# Eval("estatus").Equals("CANCELADO")?"disabled":"" %> ><i class="ft-delete"> </i> </button>                                            
                                        
                                                                                                                                                             
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                
                                    </asp:GridView>
                            
                                   <asp:SqlDataSource ID="DsUsuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>
                
                               </div>
                    </div>

                

            </div>
                                    

                        </div>
                        


                </div>
            </div>
        </div>



            

           

            </ContentTemplate>
        </asp:UpdatePanel>


    <div class="modal fade text-xs-left" id="bootstrap"  role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">


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
                            <a class="nav-link active" id="tabgenerales" data-toggle="tab" href="#generales" aria-controls="tabgenerales" aria-expanded="true"><i class="fa fa-folder"></i>Generales</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabcostos" data-toggle="tab" href="#costos" aria-controls="tabcostos" aria-expanded="false"><i class="fa fa-check-square-o"></i>Programación</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabhorario" data-toggle="tab" href="#horario" aria-controls="tabhorario" aria-expanded="false"><i class="fa fa-calendar"></i>Calendario</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" id="tabalumnos" data-toggle="tab" href="#alumnos" aria-controls="tabalumnos" aria-expanded="false"><i class="fa fa-user"></i>Alumnos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabobserv" data-toggle="tab" href="#observ" aria-controls="tabobserv" aria-expanded="false"><i class="fa fa-folder-open-o"></i>Observaciones</a>
                        </li>

                         <li class="nav-item">
                            <a class="nav-link" id="tabobjetivos" data-toggle="tab" href="#objetivos" aria-controls="tabobjetivos" aria-expanded="false"><i class="fa fa-check-circle"></i>Objetivos</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" id="tabanexos" data-toggle="tab" href="#anexos" aria-controls="tabanexos" aria-expanded="false"><i class="fa fa-file-text-o"></i>Anexos</a>
                        </li>
                    </ul>
                    <div class="tab-content px-1 pt-1">
                        <div role="tabpanel" class="tab-pane fade active in" id="generales" aria-labelledby="tabgenerales" aria-expanded="true">

                            <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                                <ContentTemplate>
                                    <div class="row" id="tbgenerales">
                                        <div class="col-md-12">
                                           
                                                        <div class="row">
                                                            
                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Tipo de Curso</label>
                                                                    <asp:DropDownList runat="server" ID="tipocurso" CssClass="select2 form-control" DataSourceID="Dstipocurso" DataTextField="tipocurso" DataValueField="idtipocurso" Style="width: 100%" AutoPostBack="true" OnSelectedIndexChanged="ocultaCursos">
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="Dstipocurso" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                                        SelectCommand="SELECT idtipocurso, tipocurso from tipocurso order by tipocurso"></asp:SqlDataSource>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Ofertado a </label>
                                                                    <asp:DropDownList runat="server" ID="tipooferta" CssClass="select2 form-control" DataSourceID="DStipooferta" DataTextField="tipooferta" DataValueField="idtipooferta" Style="width: 100%">
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="DStipooferta" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                                        SelectCommand="SELECT idtipooferta, tipooferta from tipooferta order by tipooferta"></asp:SqlDataSource>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Mínimo de alumnos</label>
                                                                    <asp:TextBox ID="alumnosminimo" type="number" CssClass="form-control text-uppercase" placeholder="Mínimo de alumnos" name="alumnosminimo" runat="server" Min="0"></asp:TextBox>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Máximo de alumnos</label>
                                                                    <asp:TextBox ID="alumnosmaximo" type="number" CssClass="form-control text-uppercase" placeholder="Máximo de alumnos" name="alumnosmaximo" runat="server" Min="0"></asp:TextBox>
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
                                                                                SelectCommand="SELECT idarea, area from area where idofertaeducativa=@idoferta order by area">
                                                                                <SelectParameters>
                                                                                    <asp:ControlParameter ControlID="idOE" Name="idoferta" PropertyName="Value" />
                                                                                </SelectParameters>
                                                                            </asp:SqlDataSource>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label class="text-bold-600">Especialidad</label>
                                                                            <asp:DropDownList runat="server" ID="especialidad" CssClass="select2 form-control" DataSourceID="Dsespecialidades" DataTextField="especialidad" DataValueField="idespecialidad" Style="width: 100%" AutoPostBack="true"></asp:DropDownList>
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


                                                        <div class="row" id="divreg" runat="server" visible="false"> 


                                                            <asp:UpdatePanel runat="server" ID="UpdatePanel6" UpdateMode="Conditional">
                                                                <ContentTemplate>
                                                                    
                                                                    <div class="col-md-12">
                                                                        <div class="form-group">
                                                                            <label class="text-bold-600">Curso Regular</label>
                                                                            <asp:DropDownList runat="server" ID="regular" CssClass="select2 form-control" DataSourceID="DSregulares" DataTextField="nombre" DataValueField="idcursoregular" Style="width: 100%" OnDataBound="regular_DataBound" OnSelectedIndexChanged="regular_DataBound" AutoPostBack="true"></asp:DropDownList>
                                                                            <asp:SqlDataSource ID="DSregulares" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idcursoregular, concat(clave,' / ', nombre)as nombre FROM cursoregular WHERE idarea =@idcat and idespecialidad=@idesp ORDER BY nombre">
                                                                               <SelectParameters>
                                                                                    <asp:ControlParameter ControlID="area" Name="idcat" PropertyName="SelectedValue" />
                                                                                   <asp:ControlParameter ControlID="especialidad" Name="idesp" PropertyName="SelectedValue" />

                                                                                </SelectParameters>
                                                                           
                                                                            </asp:SqlDataSource>

                                                                        </div>
                                                                    </div>


                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>


                                                        </div>
                                                        
                                                        <div class="row">

                                                            <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Clave del curso</label>
                                                                    <asp:TextBox ID="clave" CssClass="form-control text-uppercase" placeholder="Clave" name="clave" runat="server"></asp:TextBox>

                                                                </div>
                                                            </div>

                                                            <div class="col-md-9">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Nombre del curso</label>
                                                                    <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" placeholder="Nombre del Curso" name="nombre" runat="server"></asp:TextBox>

                                                                </div>
                                                            </div>

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
                                                                                    ">
                                                                        
                                                                    </asp:SqlDataSource>

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
                                                                    <asp:TextBox ID="costomodulo" CssClass="form-control decimal-inputmask text-md-left text-uppercase" Style="text-align: left;" placeholder="Costo Modulo" name="cotitular" runat="server"></asp:TextBox>


                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">

                                                                    <label class="text-bold-600">Costo por alumno</label>
                                                                    <asp:TextBox ID="costoalumno" CssClass="form-control decimal-inputmask text-md-left text-uppercase" placeholder="Costo Alumno" name="cotitular" runat="server"></asp:TextBox>


                                                                </div>
                                                            </div>


                                                            <div class="col-md-4">
                                                                <div class="form-group">

                                                                    <label class="text-bold-600">Pago x hora al Instructor</label>
                                                                    <asp:TextBox ID="pagohora" CssClass="form-control decimal-inputmask text-md-left text-uppercase" placeholder="Pago" name="cotitular" runat="server"></asp:TextBox>


                                                                </div>
                                                            </div>

                                                        </div>





                                                        <div class="row">
                                                            <div class="col-md-8">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Observaciones</label>
                                                                    <asp:TextBox ID="observaciones" CssClass="form-control text-uppercase" MaxLength="0" placeholder="Observaciones" name="telefono" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>

                                                                </div>


                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="activo">Es de Movilidad?</label>

                                                                    <div class="skin skin-flat">
                                                                        <asp:CheckBox runat="server" ID="movilidad" CssClass="cksmovilidad" />
                                                                    </div>

                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="activo">Es Curso en Linea?</label>

                                                                    <div class="skin skin-flat">
                                                                        <asp:CheckBox runat="server" ID="enlinea"  CssClass="cksenlinea" />
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
                            <asp:UpdatePanel runat="server" ID="UpdatePanel3">
                                <ContentTemplate>
                                    
                                    <div class="row" id="tbcostos">
                                        <div class="col-md-12">
                                            
                                                        <div class="row">

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Fecha límite de Inscripción</label>
                                                                    <asp:TextBox ID="fechalimite" CssClass="form-control pickadate text-uppercase" placeholder="Inicia en" name="fechalimite" runat="server" Text="" disabled></asp:TextBox>

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
                                   
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                        <div class="tab-pane fade" id="horario" role="tabpanel" aria-labelledby="tabhorario" aria-expanded="false">
                            <asp:Button runat="server" ID="bimprimir" OnClick="bimprimir_Click" UseSubmitBehavior="false" Style="display: none" />
                            <asp:Button runat="server" ID="bimprimirlista" OnClick="imprimirListaAsistencia" UseSubmitBehavior="false" Style="display: none" />
                            <asp:Button runat="server" ID="bimprimirriadc" OnClick="imprimirRIADC" UseSubmitBehavior="false" Style="display: none" />
                             
                            <div class="row" id="tbhorario">
                                <div class="col-md-12">
                                    



                                                <div class="row">

                                                    <div class="col-md-12">
                                                        <div class="form-group">

                                                            <asp:UpdatePanel runat="server">
                                                                <ContentTemplate>
                                                                    
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

                        <div class="tab-pane fade" id="observ" role="tabpanel" aria-labelledby="tabobserv" aria-expanded="false">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel5">
                                <ContentTemplate>

                                    <div class="row">
                                        <div class="col-md-12">

                                            
                                            <asp:GridView runat="server" ID="GVhistorial" PageSize="10" AllowPaging="true" AllowSorting="false" CssClass="table table-striped table-bordered zero-configuration" 
                                                AutoGenerateColumns="False" DataSourceID="DShistorial" EnableSortingAndPagingCallbacks="true" 
                                                AlternatingRowStyle-BackColor="#F5F7FA" OnPageIndexChanged="listadoHistorial">
                                                
                                                <Columns>
                                                    <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="fecha" HeaderText="Fecha" SortExpression="fecha"  ItemStyle-Width="150px" ItemStyle-Font-Size="Small" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda"/>
                                                    <asp:BoundField DataField="hora" HeaderText="Hora" SortExpression="hora" ItemStyle-Width="100px" ItemStyle-Font-Size="Small"  ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda"/>
                                                    <asp:BoundField DataField="usuario" HeaderText="Usuario" SortExpression="usuario" ItemStyle-Width="150px" ItemStyle-Font-Size="Small"  ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda" />
                                                    <asp:BoundField DataField="observacion" HeaderText="Observación" SortExpression="observacion" ItemStyle-Font-Size="Small" />
                                                    
                                                    
                                                </Columns>

                                            </asp:GridView>
                                               
                                            <asp:SqlDataSource ID="DShistorial" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>

                                        </div>

                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>


                          <div class="tab-pane fade" id="objetivos" role="tabpanel" aria-labelledby="tabobjetivos" aria-expanded="false">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel8">
                                <ContentTemplate>

                                    <div class="row">
                                        <div class="col-md-12">
                                           <button type="button" id="nuevo" onclick="abrirModalObjetivo(0,'');" class="btn btn-icon btn-primary mr-1" data-toggle="modal" >
                                                         <i class="ft-file"></i> Nuevo Registro 
                                           </button><br /><br />

                                            
                                            <asp:GridView runat="server" ID="GVobjetivos" PageSize="10" AllowPaging="true" AllowSorting="false" CssClass="table table-striped table-bordered zero-configuration" 
                                                AutoGenerateColumns="False" DataSourceID="DSobjetivos" EnableSortingAndPagingCallbacks="true"
                                                AlternatingRowStyle-BackColor="#F5F7FA" OnPageIndexChanged="listadoObjetivos">
                                                
                                                <Columns>
                                                    <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="objetivo" HeaderText="Objetivo" SortExpression="objetivo" ItemStyle-Font-Size="Small" />
                                                    <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                        <ItemTemplate>
                                                            <button type="button" class="btn btn-icon btn-warning mr-1 btn-sm tooltips" onclick="abrirModalObjetivo(<%# Eval("idobjetivo") %>,'<%# Eval("objetivo") %>')" value="" data-toggle="tooltip" data-original-title="Detalles"><i class="ft-edit"></i></button>
                                                            <button type="button" class="btn btn-icon btn-danger mr-1 btn-sm tooltips" onclick="eliminarObjetivo(<%# Eval("idobjetivo") %>)" value="" data-toggle="tooltip" data-original-title="Eliminar"><i class="ft-delete"></i></button>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>

                                            </asp:GridView>
                                               
                                            <asp:SqlDataSource ID="DSobjetivos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>

                                        </div>

                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                        <div class="tab-pane fade" id="anexos" role="tabpanel" aria-labelledby="tabanexos" aria-expanded="false">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel7">
                                <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12" id="accesoenlinea">
                                    <h4>Link para registro en linea</h4>
                                    <asp:Label ID="llinks" runat="server" Text="" CssClass="primary font-weight-bold"></asp:Label>
                                </div>
                           </div>
                           <div class="row" id="documentos" runat="server">
                               <!--<div class="col-md-4">
                                   <div class="row">

                                       <div class="col-md-3">
                                           <img src="/app-assets/images/elements/pdf.fw.png" onclick="imprimirSolicitudAut()"  style="cursor: pointer" />
                                       </div>
                                       <div class="col-md-9">
                                           <p class="text-bold-400" onclick="imprimirSolicitudAut()" style="cursor: pointer">Solicitud de Autorización de Curso</p>
                                       </div>
                                   </div>
                                </div>
                               -->
                               <div class="col-md-4"><br />
                                <div class="card overflow-hidden">
                                    <div class="card-body">
                                        <div class="card-block cleartfix">
                                            <div class="media">
                                                <div class="media-left media-middle">
                                                    <i class="fa fa-file-pdf-o primary font-large-2 mr-2"></i>
                                                </div>
                                                <div class="media-body">
                                                    <h4>Solicitud</h4>
                                                    <span>Autorización de Curso</span>
                                                </div>
                                                
                                                </div><br />

                                                <button type="button" id="bsolicitud" onclick="imprimirSolicitudAut();" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                    <i class="ft-file"></i>Imprimir 
                                                </button>
                                            </div>
                                        
                                                   
                                        </div>
                                        
                                    </div>
                                </div>


                               <div class="col-md-4">
                                <div class="card overflow-hidden">
                                    <div class="card-body">
                                        <div class="card-block cleartfix">
                                            <div class="media">
                                                <div class="media-left media-middle">
                                                    <i class="fa fa-file-pdf-o primary font-large-2 mr-2"></i>
                                                </div>
                                                <div class="media-body">
                                                    <h4>Lista</h4>
                                                    <span>Asistencia</span>
                                                </div>
                                                
                                                </div><br />
                                                <div class="form-group">
                                                                    
                                                                    <asp:DropDownList runat="server" ID="mes" CssClass="select2 form-control" DataSourceID="DSmes" DataTextField="mesTexto" DataValueField="mesc" Style="width: 100%">
                                                                    </asp:DropDownList>
                                                                    <asp:SqlDataSource ID="DSmes" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                                        SelectCommand="SELECT distinct(month(fecha)) as mes, concat(month(fecha),'|',year(fecha)) as mesc,  
                                                                                        case(month(fecha))
                                                                                        when 1 then 'ENERO'
                                                                                        when 2 then 'FEBRERO'
                                                                                        when 3 then 'MARZO'
                                                                                        when 4 then 'ABRIL'
                                                                                        when 5 then 'MAYO'
                                                                                        when 6 then 'JUNIO'
                                                                                        when 7 then 'JULIO'
                                                                                        when 8 then 'AGOSTO'
                                                                                        when 9 then 'SEPTIEMBRE'
                                                                                        when 10 then 'OCTUBRE'
                                                                                        when 11 then 'NOVIEMBRE'
                                                                                        when 12 then 'DICIEMBRE'
                                                                                        else ''
                                                                                        end as mesTexto
                                                                                        from fechascurso
                                                                                        where idcurso=@idP
                                                                                        order by mes">
                                                                        <SelectParameters>
                                                                              <asp:ControlParameter ControlID="idP" Name="idP" PropertyName="Value" />
                                                                         </SelectParameters>
                                                                        
                                                                    </asp:SqlDataSource>

                                                                </div>
                                                <button type="button" id="blistaasistencia" onclick="imprimirLista();" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                    <i class="ft-file"></i>Imprimir 
                                                </button>
                                            </div>
                                        
                                                   
                                        </div>
                                        
                                    </div>
                                </div>

                                 <div class="col-md-4">
                                <div class="card overflow-hidden">
                                    <div class="card-body">
                                        <div class="card-block cleartfix">
                                            <div class="media">
                                                <div class="media-left media-middle">
                                                    <i class="fa fa-file-pdf-o primary font-large-2 mr-2"></i>
                                                </div>
                                                <div class="media-body">
                                                    <h4>Formato</h4>
                                                    <span>RIADC-02</span>
                                                </div>
                                                
                                                </div><br />

                                                <button type="button" id="bsolicitud" onclick="imprimirRiadc();" class="btn btn-icon btn-primary mr-1" data-toggle="modal">
                                                    <i class="ft-file"></i>Imprimir 
                                                </button>
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

                    
                            <button id="baprobar" class="btn btn-primary" onclick="aprobar()" type="button" data-backdrop="false" style="display:none" >
                                <i class="fa fa-check-square-o"></i>Autorizar
                            </button>

                            <button id="brechazar" class="btn btn-danger" onclick="rechazar()" type="button" data-backdrop="false" style="display:none">
                                <i class="fa fa-check-square-o"></i>Rechazar
                            </button>

                            <button id="bproponer" class="btn btn-warning" onclick="solicita()" type="button" data-backdrop="false" >
                                <i class="fa fa-check-square-o"></i>Solicitar Autorización
                            </button>

                            <button id="bguardar" class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false" >
                                <i class="fa fa-check-square-o"></i>Guardar
                            </button>

                            <button id="bcerrar" type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
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


    <div class="modal fade" id="wcancelar" tabindex="-1" role="dialog" aria-labelledby="myModalLabel40" aria-hidden="true">

        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 class="modal-title">Cancelar Curso</h3>
                </div>


                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-bold-600">Motivo de la cancelación</label>
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

    <div class="modal fade" id="wobjetivo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel40" aria-hidden="true">

        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 class="modal-title">Objetivo del Curso</h3>
                </div>


                <div class="modal-body">
                     <asp:HiddenField runat="server" ID="idobj" Value="0"/>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="text-bold-600">Objetivo</label>
                                <asp:TextBox ID="objetivo" CssClass="form-control text-uppercase" MaxLength="0" TextMode="MultiLine" Rows="3" placeholder="Descripción del objetivo" name="telefono" runat="server"></asp:TextBox>

                            </div>
                        </div>
                    </div>

                </div>

                <div class="modal-footer">

                    <button class="btn btn-primary" onclick="guardarObjetivo()" type="button" data-backdrop="false">
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


<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    
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
        $("#catcursos").addClass("active");
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

        function valida() {

            var clave = $("*[id$='clave']").val();
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

            if (clave == '') {                
                alerta('Atención', 'Ingrese la clave del curso', 'warning', $("*[id$='clave']"));
                return false;                
            }

            if (nombre == '') {                
                alerta('Atención', 'Ingrese el nombre del curso', 'warning', $("*[id$='nombre']"));
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
            /*
            if (costomodulo == '' || costomodulo == '0') {                
                alerta('Atención', 'Ingrese el costo por módulo del curso', 'warning', $("*[id$='costomodulo']"));
                return false;                
            }

            if (costoalumno == '' || costoalumno == '0') {                
                alerta('Atención', 'Ingrese el costo por alumno del curso', 'warning', $("*[id$='costoalumno']"));
                return false;                
            }
            */
            if (pagohora == '' || pagohora == '0') {                
                alerta('Atención', 'Ingrese el pago por hora del curso', 'warning', $("*[id$='pagohora']"));
                return false;                
            }
            
            /*if (fechalimite == '') {
                alerta('Atención', 'Ingrese la fecha límite de inscripción al curso', 'warning', $("*[id$='fechalimite']"));
                return false;
            }*/

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
                alerta('Atención', 'No se han generado fechas válidas de impartición del curso, revise las fechas y horarios establecidos', 'warning', $("*[id$='horas']"));
                return false;
            }

                              
            walert = 0;
            //$('#bootstrap').modal('hide');
            mostrarLoading();
            
            $('#<%= guardar.ClientID %>').click();
                       
                                           
        }


        function solicita() {
            var clave = $("*[id$='clave']").val();
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

            if (clave == '') {                
                alerta('Atención', 'Ingrese la clave del curso', 'warning', $("*[id$='clave']"));
                return false;                
            }

            if (nombre == '') {                
                alerta('Atención', 'Ingrese el nombre del curso', 'warning', $("*[id$='nombre']"));
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

            /*
             if (costomodulo == '' || costomodulo == '0') {                
                alerta('Atención', 'Ingrese el costo por módulo del curso', 'warning', $("*[id$='costomodulo']"));
                return false;                
            }

            if (costoalumno == '' || costoalumno == '0') {                
                alerta('Atención', 'Ingrese el costo por alumno del curso', 'warning', $("*[id$='costoalumno']"));
                return false;                
            }*/

            if (pagohora == '' || pagohora == '0') {                
                alerta('Atención', 'Ingrese el pago por hora del curso', 'warning', $("*[id$='pagohora']"));
                return false;                
            }

           /* if (fechalimite == '') {
                alerta('Atención', 'Ingrese la fecha límite de inscripción al curso', 'warning', $("*[id$='fechalimite']"));
                return false;
            }
            */
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

         function abrirModalCancelacion(idcurso) {

             $("*[id$='idP']").val(idcurso);
             $("*[id$='motcancelacion']").val('');
             $("#wcancelar").modal('show');

         
         }


        function cancelarCurso() {
            swal({
                title: "Se realizará la cancelación de este curso, ¿Desea continuar?",
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

        function abrirModal(idcurso, idsucursal, estatus) {                        
           mostrarLoading();
            $("*[id$='idP']").val(idcurso);
            $("*[id$='idS']").val(idsucursal);
            $("#bootstrap").modal('show');                                   
            $('#<%= Bfechas.ClientID %>').click();                                                            
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

        function imprimirLista() {
            mostrarLoading();
            $('#<%= bimprimirlista.ClientID %>').click();
            cerrarLoading();
        }

        function imprimirRiadc() {
            mostrarLoading();
            $('#<%= bimprimirriadc.ClientID %>').click();
            cerrarLoading();
        }

        function consultaPrincipal() {
            mostrarLoading();
            $('#<%= Bconsultar.ClientID %>').click();
            cerrarLoading();
        }

        function abrirModalObjetivo(idobjetivo, objetivo) {
            $("*[id$='idobj']").val(idobjetivo);
            $("*[id$='objetivo']").val(objetivo);                       
            $("#wobjetivo").modal('show');
        }

        function guardarObjetivo() {
            mostrarLoading();
            $('#<%= Bguardaobjetivo.ClientID %>').click();
        }

        function eliminarObjetivo(idobjetivo) {
            swal({
                title: "Se eliminará el objetivo del curso, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#DD6B55',
                confirmButtonText: 'Si',
                cancelButtonText: "No"
            }).then((result) => {
                if (result.value) {
                    $("*[id$='idobj']").val(idobjetivo);
                    mostrarLoading();
                    $('#<%= Beliminaobjetivo.ClientID %>').click();
                  }
                }) 
         
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
                    $("*[id$='clave']").focus();
            });


             $(document).ready(function () {
                $('.tooltips').tooltip();
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
                    defaultDate: fecha!=''?fecha:'2019-01-01',
                    defaultView: 'month',
                    duration: { days: 15 },
                    locale: 'es',
                    events: dataEvent,                   
                    eventClick: function(event) {


                        if (event.id > 0) {

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

                        }
                       

                    },
                    navLinks: false, // can click day/week names to navigate views
                    editable: true,
                    
                    height: 500
                });

            
            if (fecha == '') {
                $('#fc-basic-views').fullCalendar('today');                
            }
            
            
            $("*[id$='dias']").attr('disabled', true);
            $("*[id$='horas']").attr('disabled', true);

            $('.cksmovilidad').on('ifChecked', function (event) {  
                $("#accesoenlinea").hide();
                $('.cksenlinea').iCheck('uncheck');  
                
            });

            $('.cksenlinea').on('ifChecked', function (event) {  
                $("#accesoenlinea").show();
                $('.cksmovilidad').iCheck('uncheck');  
                                              
            });

            $('.cksenlinea').on('ifUnchecked', function (event) {
                $("#accesoenlinea").hide();
                                   
            });

           

        }
     </script>
</asp:Content>
