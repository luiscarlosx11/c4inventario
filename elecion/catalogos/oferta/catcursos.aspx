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
    
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
 <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    
        

       <asp:UpdatePanel runat="server" ID="pU">
           <ContentTemplate>

               <div class="content-header row">

                   <div class="col-md-3">
                       <div class="media-left media-middle">
                           <i class="fa fa-cube primary font-large-2 mr-1"></i>
                       </div>
                       <div class="media-body">
                           <h4 class="font-weight-bold">Inventario</h4>
                           <span class="font-small-3">
                               <asp:Label runat="server" ID="labelConteo">0</asp:Label>
                               registro(s) encontrado(s)</span>
                       </div>

                   </div>
                    <div class="col-md-9 float-md-right">
                               <asp:HiddenField runat="server" ID="idP" />
                                <asp:HiddenField runat="server" ID="idOP" />
                               <asp:HiddenField runat="server" ID="limite" Value="48" />
                               <asp:HiddenField runat="server" ID="idS" />
                               <asp:HiddenField runat="server" ID="idSU" />
                               <asp:HiddenField runat="server" ID="idF" />
                               <asp:HiddenField runat="server" ID="finhabil" />
                               <asp:HiddenField runat="server" ID="cve" />
                               <asp:HiddenField runat="server" ID="idOE" />


                               <asp:Button runat="server" ID="Bconsultar" OnClick="listadoClientes" Style="display: none" UseSubmitBehavior="false" />
                               <asp:Button runat="server" ID="Bcancelarcurso" OnClick="cancelaCurso" Style="display: none" UseSubmitBehavior="false" />
                               <asp:Button runat="server" ID="Bguardaobjetivo" OnClick="guardaObjetivo" Style="display: none" UseSubmitBehavior="false" />
                               <asp:Button runat="server" ID="Beliminaobjetivo" OnClick="eliminaObjetivo" Style="display: none" UseSubmitBehavior="false" />

                               <asp:Button runat="server" ID="Bnuevo" OnClick="limpiarCampos" Style="display: none" UseSubmitBehavior="false" />
                               <span class="pull-right">
                                   <label class="text-bold-600 font-small-3"></label>
                                   <button type="button" id="nuevo" onclick="nuevoRegistro();" class="btn btn-icon btn-primary mr-1 text-bold-700" data-toggle="modal">
                                       Nuevo Bien 
                                   </button>
                               </span>
                           </div>
               </div>    <br />

               <div class="row" id="header-styling">
                   <div class="col-md-12">

                       <div class="media">
                           <div class="progress">
							<div class="progress-bar" role="progressbar" aria-valuenow="25" aria-valuemin="25" aria-valuemax="100" style="width:25%"  aria-describedby="example-caption-2"></div>
						</div>
                           
                           <div class="col-md-2">
                               <div class="form-group">      
                                   <label class="text-bold-600 font-small-3">No. inventario</label>
                                   <asp:TextBox ID="bname" CssClass="form-control text-uppercase" placeholder="Búsqueda por número inventario..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                               </div>
                           </div>

                            <div class="col-md-4">
                               <div class="form-group">      
                                   <label class="text-bold-600 font-small-3">Descripción</label>
                                   <asp:TextBox ID="bdescripcion" CssClass="form-control text-uppercase" placeholder="Búsqueda por descripción..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                               </div>
                           </div>

                           <div class="col-md-2">
                               <div class="form-group">      
                                   <label class="text-bold-600 font-small-3">Marca - Modelo - No. serie</label>
                                   <asp:TextBox ID="TextBox1" CssClass="form-control text-uppercase" placeholder="Búsqueda por marca, modelo o número de serie..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                               </div>
                           </div>

                                                      
                           <div class="col-md-2" runat="server">
                               <div class="form-group">
                                   <label class="text-bold-600 font-small-3">Estado</label>
                                   <asp:DropDownList runat="server" ID="bcentro" CssClass="select2 form-control" DataSourceID="DScentro" DataTextField="centro" DataValueField="idcentro" AppendDataBoundItems="true" onChange="consultaPrincipal()">
                                       <asp:ListItem Value="0" Text="SELECCIONE UN CENTRO"></asp:ListItem>
                                   </asp:DropDownList>
                                   <asp:SqlDataSource ID="DScentro" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idcentro, centro FROM centro ORDER BY idcentro"></asp:SqlDataSource>
                               </div>
                           </div>

                           <div class="col-md-2" id="busplantel" runat="server">
                               <div class="form-group">
                                   <label class="text-bold-600 font-small-3">Estado</label>
                                   <asp:DropDownList runat="server" ID="bplantel" CssClass="select2 form-control" DataSourceID="DSplantel" DataTextField="estado" DataValueField="idestado" AppendDataBoundItems="true" onChange="consultaPrincipal()">
                                       <asp:ListItem Value="0" Text="SELECCIONE UN ESTADO"></asp:ListItem>
                                   </asp:DropDownList>
                                   <asp:SqlDataSource ID="DSplantel" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idestado, estado FROM estado ORDER BY idestado"></asp:SqlDataSource>
                               </div>
                           </div>



                           
                                  
                               
                          
                          
                       </div>

                   </div>
               </div>
        

        <div class="row" >
                <div class="col-md-12">
                    <div class="">
                       
                        <div class="card-body collapse in">

                            <div class="row">

                                <div class="card-block">
                                    <div style="overflow-x: auto; width: 100%; background-color:white">
                                        <asp:GridView runat="server" ID="lGeneral" PageSize="50" AllowPaging="true" AllowSorting="true" CssClass="table table-striped lGeneral"
                                            AutoGenerateColumns="False" DataSourceID="DsUsuarios" EnableSortingAndPagingCallbacks="true"
                                              OnPageIndexChanged="listadoClientes" GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static">
                                            <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                            <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                            <Columns>
                                               

                                                <asp:TemplateField HeaderText="Generales" HeaderStyle-CssClass="primary">
                                                    <ItemTemplate>

                                                        <h7 class="font-weight-bold"><%# Eval("noinventario")%></h7><br />
                                                        <h7 class="font-small-3 font-italic text-bold-600"><%# " "+Eval("descripcion")%></h7>
                                                        <br />
                                                        <h7 class="text-bold-400 font-small-2"> <%# " MARCA "+Eval("marca")+ ", MODELO "+Eval("modelo")%></h7>
                                                        <br />
                                                        <h7 class="text-bold-400 font-small-2"><%# " NO SERIE. "+Eval("noserie") +", COSTO $"+ Eval("costo")+" "%></h7>
                                                        

                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Ubicación" HeaderStyle-CssClass="primary" ItemStyle-Width="300px">
                                                    <ItemTemplate>

                                                        <h7 class="font-weight-bold"><%# Eval("adscripcion") + " "+Eval("centro") %></h7><br />
                                                        <h7 class="font-small-3 font-italic text-bold-600"> <%# "  "+Eval("usuario")%></h7>
                                                        <br />                                                        
                                                        <h7 class="text-bold-400 font-small-2"><%# " FECHA ALTA "+Eval("fechaaltatext") %></h7>
                                                        

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                               

                                                <asp:TemplateField HeaderText="Estatus" ItemStyle-Width="20px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                    <ItemTemplate>

                                                            <span class="tag bg-<%# Eval("estado").Equals("NO LOCALIZADO")?"warning":Eval("estado").Equals("LOCALIZADO")?"success":Eval("estado").Equals("DADO DE BAJA")?"danger":""%>"><span class="text-bold-700"><%# Eval("estado")%></span></span>                                                        
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                                <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                    <ItemTemplate>

                                                        <button type="button" class="btn btn-icon btn-warning mr-1 btn-sm tooltips" onclick="abrirModal(<%# Eval("idbien") %>)" value="" data-toggle="tooltip" data-original-title="Detalles"><i class="ft-edit"></i></button>
                                                        <button type="button" class="btn btn-icon btn-danger mr-1 btn-sm tooltips" onclick="abrirModalCancelacion(<%# Eval("idbien") %>)" value="" data-toggle="tooltip" data-original-title="Cancelar" ><i class="ft-delete"></i></button>


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



            

           

            </ContentTemplate>
        </asp:UpdatePanel>


    <div class="modal fade text-xs-left" id="bootstrap"  role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">


        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title">BIEN</h5>
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
                            <a class="nav-link" id="tabalumnos" data-toggle="tab" href="#alumnos" aria-controls="tabalumnos" aria-expanded="false"><i class="fa fa-user"></i>Alumnos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="tabobserv" data-toggle="tab" href="#observ" aria-controls="tabobserv" aria-expanded="false"><i class="fa fa-folder-open-o"></i>Observaciones</a>
                        </li>

                         
                    </ul>
                    <div class="tab-content px-1 pt-1">
                        <div role="tabpanel" class="tab-pane fade active in" id="generales" aria-labelledby="tabgenerales" aria-expanded="true">

                             <asp:UpdatePanel runat="server">
                                                                <ContentTemplate>
                                                                    
                                                                    <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" style="display:none" UseSubmitBehavior="false"/>
                                                                    <asp:Button runat="server" ID="bautorizacion" OnClick="solicitaAutorizacion" style="display:none" UseSubmitBehavior="false"/>                                                                    
                                                                    <asp:Button runat="server" ID="Beditar" OnClick="editaRegistro" style="display:none" UseSubmitBehavior="false"/>
                                                                    <asp:Button runat="server" ID="Bfechas" OnClick="listadoFechas" Style="display: none" UseSubmitBehavior="false" />

                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>

                            <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                                <ContentTemplate>
                                    <div class="row" id="tbgenerales">
                                        <div class="col-md-12">
                                           
                                                        <div class="row">                                                                                                                                                                                    
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

                    

                        <div class="tab-pane fade" id="alumnos" role="tabpanel" aria-labelledby="tabalumnos" aria-expanded="false">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel4">
                                <ContentTemplate>

                                    <div class="row">
                                        <div class="col-md-12">

                                            
                                            <asp:GridView runat="server" ID="GValumnos" PageSize="10" AllowPaging="true"  CssClass="table table-striped lGeneral" 
                                                AutoGenerateColumns="False" DataSourceID="DSalumnos" EnableSortingAndPagingCallbacks="true" 
                                                GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static" OnPageIndexChanged="listadoAlumnos">
                                                
                                                <Columns>
                                                    <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-CssClass="centrarCelda font-small-2" HeaderStyle-CssClass="centrarCelda primary">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="nombrealumno" HeaderText="Nombre" SortExpression="nombre" ItemStyle-Font-Size="Small" HeaderStyle-CssClass="primary"/>
                                                    <asp:BoundField DataField="costoAlumno" HeaderText="Cantidad" SortExpression="costoAlumno" ItemStyle-Width="50px" ItemStyle-Font-Size="Small" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda primary" DataFormatString="{0:c}" HtmlEncode="False"/>
                                                    <asp:BoundField DataField="folio" HeaderText="Folio Pago" SortExpression="folio"  ItemStyle-Width="150px" ItemStyle-Font-Size="Small" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda primary"/>
                                                    <asp:BoundField DataField="fecha" HeaderText="Fecha Ins." SortExpression="fecha" ItemStyle-Width="150px" ItemStyle-Font-Size="Small"  ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda primary"/>
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

                                            
                                            <asp:GridView runat="server" ID="GVhistorial" PageSize="10" AllowPaging="true" AllowSorting="false" CssClass="table table-striped lGeneral" 
                                                AutoGenerateColumns="False" DataSourceID="DShistorial" EnableSortingAndPagingCallbacks="true" 
                                                GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static" OnPageIndexChanged="listadoHistorial">
                                                
                                                <Columns>
                                                    <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-CssClass="centrarCelda Small" HeaderStyle-CssClass="centrarCelda primary">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="fecha" HeaderText="Fecha" SortExpression="fecha"  ItemStyle-Width="150px" ItemStyle-Font-Size="Small" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda primary"/>
                                                    <asp:BoundField DataField="hora" HeaderText="Hora" SortExpression="hora" ItemStyle-Width="100px" ItemStyle-Font-Size="Small"  ItemStyle-CssClass="centrarCelda  " HeaderStyle-CssClass="centrarCelda primary"/>
                                                    <asp:BoundField DataField="usuario" HeaderText="Usuario" SortExpression="usuario" ItemStyle-Width="150px" ItemStyle-Font-Size="Small"  ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda primary" />
                                                    <asp:BoundField DataField="observacion" HeaderText="Observación" SortExpression="observacion" ItemStyle-Font-Size="Small" HeaderStyle-CssClass="primary" />
                                                    
                                                    
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
                                           <button type="button" id="nuevo" onclick="abrirModalObjetivo(0,'','');" class="btn btn-icon btn-primary mr-1" data-toggle="modal" >
                                                         <i class="ft-file"></i> Nuevo Registro 
                                           </button><br /><br />

                                            
                                            <asp:GridView runat="server" ID="GVobjetivos" PageSize="10" AllowPaging="true" AllowSorting="false" CssClass="table table-striped lGeneral" 
                                                AutoGenerateColumns="False" DataSourceID="DSobjetivos" EnableSortingAndPagingCallbacks="true"
                                                OnPageIndexChanged="listadoObjetivos" GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static">                                                
                                                <Columns>
                                                    <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-CssClass="centrarCelda Small" HeaderStyle-CssClass="centrarCelda primary">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                     <asp:BoundField DataField="clave" HeaderText="Clave" SortExpression="clave" ItemStyle-Font-Size="Small" ItemStyle-Width="80px" HeaderStyle-CssClass="primary"/>
                                                    <asp:BoundField DataField="objetivo" HeaderText="Objetivo" SortExpression="objetivo" ItemStyle-Font-Size="Small" ItemStyle-Width="420px"  HeaderStyle-CssClass="primary"/>
                                                    <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="180px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda" >
                                                        <ItemTemplate>
                                                            <button type="button" class="btn btn-icon btn-warning mr-1 btn-sm tooltips" onclick="abrirModalObjetivo(<%# Eval("idobjetivo") %>,'<%# Eval("objetivo") %>','<%# Eval("clave") %>')" value="" data-toggle="tooltip" data-original-title="Detalles"><i class="ft-edit"></i></button>
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

                       
                    </div>
                </div>

                <div class="modal-footer">
                                               
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
                        
                        <button class="btn btn-danger" onclick="eliminaFechas()" type="button" data-backdrop="false" id="beliminaFecha"> 
	                        <i class="fa fa-check-square-o"></i> Eliminar Fecha
	                     </button>

                                                                 
	                     <button type="button" class="btn btn-warning mr-1" data-dismiss="modal">
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
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="text-bold-600">Clave</label>
                                <asp:TextBox ID="objetcl" CssClass="form-control text-uppercase"  placeholder="Clave objetivo" name="clave" runat="server"></asp:TextBox>

                            </div>
                        </div>
                    </div>

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
         

    <div class="modal fade" id="winhabiles"  role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">

                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header bg-primary white">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title">Fecha inhábil</h3>

                            

                        </div>
                       
                        <div class="modal-footer">
                        
                        
				        <button class="btn btn-primary" onclick="habilitaFechas()" type="button" data-backdrop="false" id="bguardaFecha"> 
	                        <i class="fa fa-check-square-o"></i> Habilitar fecha
	                     </button>
                                                                 
	                     <button type="button" class="btn btn-danger mr-1" data-dismiss="modal">
	                        <i class="ft-x"></i> Cerrar
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
            var alumnosmaximo = $("*[id$='alumnosmaximo']").val();
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

            if (alumnosmaximo == '' || alumnosmaximo == '0') {
                alerta('Atención', 'Ingrese la cantidad máxima de alumnos inscritos', 'warning', $("*[id$='alumnosmaximo']"));
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

            var alumnosmaximo = $("*[id$='alumnosmaximo']").val();

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

            if (alumnosmaximo == '' || alumnosmaximo == '0') {
                alerta('Atención', 'Ingrese la cantidad máxima de alumnos inscritos', 'warning', $("*[id$='alumnosmaximo']"));
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
                    
                  }
                }) 
           
                                           
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
           
            cerrarLoading();
        }

        function imprimirLista() {
            mostrarLoading();
           
            cerrarLoading();
        }

        function imprimirRiadc() {
            mostrarLoading();
          
            cerrarLoading();
        }


        function imprimirRiadcAcred() {
            mostrarLoading();
            
            cerrarLoading();
        }


        function imprimirSubObjetivos() {
            mostrarLoading();
            
             cerrarLoading();
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

        function abrirModalObjetivo(idobjetivo, objetivo, clave) {
            $("*[id$='idobj']").val(idobjetivo);
            $("*[id$='objetcl']").val(clave); 
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
                    defaultDate: fecha!=''?fecha:'2020-01-01',
                    defaultView: 'month',
                    duration: { days: 15 },
                    locale: 'es',
                    events: dataEvent,                   
                    eventClick: function(event) {
                        
                        if (event.id >= 0) {

                            if ($("*[id$='fechaini']").is(':enabled')) {
                                $("*[id$='idF']").val(event.id);
                                $("*[id$='fagenda']").val(event.fecha);
                                $("*[id$='horanini']").val(event.horaini);
                                $("*[id$='horanfin']").val(event.horafin);

                                $("#wfechas").modal('show');
                            }
                            
                        } else {
                            
                            if ($("*[id$='fechaini']").is(':enabled')) {
                                
                                $("*[id$='idF']").val(0);
                                $("*[id$='finhabil']").val(event.fecha);
                                $("#winhabiles").modal('show');
                            }
                                
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
