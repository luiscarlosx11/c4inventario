 <%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false"
     CodeBehind="depositos.aspx.cs"  Inherits="elecion.caja.depositos" %>
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
                           <i class="icon-speech primary font-large-2 mr-1"></i>
                       </div>
                       <div class="media-body">
                           <h4 class="font-weight-bold">Depósitos</h4>
                           <span class="font-small-3">
                               <asp:Label runat="server" ID="labelConteo"></asp:Label>
                               registro(s) encontrado(s)</span>
                       </div>

                   </div>
                <div class="col-md-9 float-md-right">
                    <asp:HiddenField runat="server" ID="idP" />
                    <asp:HiddenField runat="server" ID="limite" Value="48" />
                    <asp:HiddenField runat="server" ID="idS" />
                    <asp:HiddenField runat="server" ID="idSU" />
                    <asp:HiddenField runat="server" ID="idF" />
                    <asp:HiddenField runat="server" ID="cve" />
                    <asp:HiddenField runat="server" ID="idOE" />


                    <asp:HiddenField runat="server" ID="idI" />
                    <asp:HiddenField runat="server" ID="iPago" />


                    <asp:Button runat="server" ID="Bconsultar" OnClick="listadoClientes" Style="display: none" UseSubmitBehavior="false" />
                    <asp:Button runat="server" ID="Bcancelarcurso" OnClick="cancelaCurso" Style="display: none" UseSubmitBehavior="false" />
                    <asp:Button runat="server" ID="Bguardaobjetivo" OnClick="guardaObjetivo" Style="display: none" UseSubmitBehavior="false" />
                    <asp:Button runat="server" ID="Beliminaobjetivo" OnClick="eliminaObjetivo" Style="display: none" UseSubmitBehavior="false" />



                    <asp:Button runat="server" ID="Bguardadeposito" OnClick="guardaDeposito" Style="display: none" UseSubmitBehavior="false" />

                    <asp:Button runat="server" ID="Bnuevo" OnClick="limpiarCampos" Style="display: none" UseSubmitBehavior="false" />
                     <span class="pull-right">
                                   <label class="text-bold-600 font-small-3"></label>
                                   <button type="button" id="nuevo" onclick="nuevoRegistro();" class="btn btn-icon btn-primary mr-1 text-bold-700" data-toggle="modal">
                                       Nuevo Registro 
                                   </button>
                               </span>
                </div>
               </div>    <br />

            <div class="row" id="header-styling">
                   <div class="col-md-12">

                       <div class="">
                           
                           <div class="col-md-4">
                               <div class="form-group">      
                                   <label class="text-bold-600 font-small-3">Depósito</label>
                                   <asp:TextBox ID="bname" CssClass="form-control text-uppercase" placeholder="Búsqueda por Nombre, Folio..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
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

                           
                                   <div class="col-md-2">
                                       <div class="form-group">
                                           <label class="text-bold-600 font-small-3">Desde</label>
                                          <asp:TextBox ID="bfechaini" CssClass="form-control pickadate text-uppercase" placeholder="Inicia en" name="fechaini" runat="server" onChange="consultaPrincipal()"></asp:TextBox>
                                        </div>
                                   </div>
                                   <div class="col-md-2">
                                       <div class="form-group">
                                           <label class="text-bold-600 font-small-3">Hasta</label>
                                           <asp:TextBox ID="bfechafin" CssClass="form-control pickadate" placeholder="FIN" name="fechafin" runat="server" onChange="consultaPrincipal()"></asp:TextBox>
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
                                        <asp:GridView runat="server" ID="lusuarios" PageSize="50" AllowPaging="true" AllowSorting="true" CssClass="table table-striped lGeneral"
                                            AutoGenerateColumns="False" DataSourceID="DsUsuarios" EnableSortingAndPagingCallbacks="true"
                                              OnPageIndexChanged="listadoClientes" GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static">
                                            <SortedAscendingHeaderStyle CssClass="ascending rendila-color" ForeColor="White" />
                                            <SortedDescendingHeaderStyle CssClass="descending rendila-color" ForeColor="White" />
                                            <Columns>
                                               

                                                <asp:TemplateField HeaderText="Depósito" HeaderStyle-CssClass="primary">
                                                    <ItemTemplate>

                                                        <h7 class="font-weight-bold"><%# "Folio "+Eval("Folio")+ " / "+Eval("nombre")%></h7><br />
                                                        <h7 class="font-small-3 font-italic text-bold-600"><i class="fa fa-home"></i> <%# " "+Eval("sucursal")%></h7>
                                                        <br />
                                                        <h7 class="text-bold-400 font-small-2"><i class="fa fa-usd "></i> <%# " "+Eval("monto")%></h7>
                                                        <br />
                                                        <h7 class="text-bold-400 font-small-2"><i class="fa fa-calendar "></i><%# " "+Eval("fecha") %></h7>                                                       
                                                        <br />

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                                                               

                                                <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="300px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                    <ItemTemplate>

                                                        <button type="button" class="btn btn-icon btn-warning mr-1 btn-sm tooltips"  onclick="abrirModal(<%# Eval("iddeposito") %>,<%# Eval("idsucursal") %>)" value="" data-toggle="tooltip" data-original-title="Detalles"><i class="ft-edit"> </i> </button>                                            

                                                        <button type="button" class="btn btn-icon btn-success mr-1 btn-sm tooltips" onclick="imprimirCaratulaid(<%#Eval("iddeposito")%>)"
                                                            data-toggle="tooltip" data-original-title="Imprimir Carátula">
                                                            <i class="ft-file"></i>
                                                        </button>

                                                        <button type="button" onclick="imprimirSolicitudAutid(<%#Eval("iddeposito")%>)" class="btn btn-icon btn-cyan mr-1 btn-sm tooltips"
                                                            data-toggle="tooltip" data-original-title="Imprimir Póliza">
                                                            <i class="ft-printer"></i>
                                                        </button>
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
                    <h5 class="modal-title">DEPÓSITO</h5>
                </div>

                <asp:HiddenField runat="server" ID="idr" />

                <div class="modal-body">
                    <asp:Button runat="server" ID="bimprimir" OnClick="bimprimir_Click" UseSubmitBehavior="false" Style="display: none" />
                    <asp:Button runat="server" ID="bimprimircaratula" OnClick="bimprimirCaratula" UseSubmitBehavior="false" Style="display: none" />
                    <ul class="nav nav-tabs nav-top-border no-hover-bg">
                        <li class="nav-item">
                            <a class="nav-link active" id="tabgenerales" data-toggle="tab" href="#generales" aria-controls="tabgenerales" aria-expanded="true"><i class="fa fa-folder"></i>Generales</a>
                        </li>
                         <li class="nav-item">
                            <a class="nav-link" id="tabalumnos" data-toggle="tab" href="#alumnos" aria-controls="tabalumnos" aria-expanded="false"><i class="fa fa-usd"></i>Recibos</a>
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
                                                                    <label class="text-bold-600">Folio</label>
                                                                    <asp:TextBox ID="folio" CssClass="form-control text-uppercase" placeholder="folio" name="clave" runat="server" disabled></asp:TextBox>

                                                                </div>
                                                            </div>

                                                            <div class="col-md-9">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Nombre o descripción</label>
                                                                    <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" placeholder="Nombre del depósito" name="nombre" runat="server"></asp:TextBox>

                                                                </div>
                                                            </div>

                                                        </div>

                                                                                                                                                                   
                                                        <div class="row">
                                                            <div class="col-md-4">
                                                                <div class="form-group">

                                                                    <label class="text-bold-600">Fecha</label>
                                                                    <asp:TextBox ID="fecha" CssClass="form-control pickadate text-uppercase" Style="text-align: left;" placeholder="Fecha" name="cotitular" runat="server"></asp:TextBox>


                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">

                                                                    <label class="text-bold-600">Monto</label>
                                                                    <asp:TextBox ID="monto" CssClass="form-control decimal-inputmask text-md-left text-uppercase" placeholder="Monto" name="cotitular" runat="server" disabled></asp:TextBox>


                                                                </div>
                                                            </div>
                                                        </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <label class="text-bold-600">Observaciones</label>
                                                                    <asp:TextBox ID="observaciones" CssClass="form-control text-uppercase" MaxLength="0" placeholder="Observaciones" runat="server" TextMode="MultiLine" Rows="5"></asp:TextBox>

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

                                    <asp:Button runat="server" ID="Bfechas" OnClick="listadoFechas" Style="display: none" UseSubmitBehavior="false" />
                                    <asp:Button runat="server" ID="Beliminarecibo" OnClick="eliminarRecibo" Style="display: none" UseSubmitBehavior="false"/>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <button type="button" onclick="abrirModalRecibos();" class="btn btn-icon btn-primary mr-1" data-toggle="modal" >
                                                         <i class="ft-file"></i> Añadir recibos
                                            </button><br /><br />   

                                            
                                            <asp:GridView runat="server" ID="GValumnos" PageSize="10" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                                AutoGenerateColumns="False" DataSourceID="DSalumnos" EnableSortingAndPagingCallbacks="true"
                                                AlternatingRowStyle-BackColor="#F5F7FA" OnPageIndexChanged="listadoAlumnos">
                                                
                                                <Columns>
                                                    <asp:TemplateField HeaderText="No." ItemStyle-Width="20px" ItemStyle-CssClass="centrarCelda " HeaderStyle-CssClass="centrarCelda primary">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex + 1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderText="Alumno" HeaderStyle-CssClass="primary">
                                                <ItemTemplate>                                                   
                                                    <h7 class="text-bold-700"><%# Eval("alumno")%></h7><br />
                                                    <h7 class="text-bold-400 font-small-3"><%# Eval("nombre")%></h7><br />
                                                                                                                                                          
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                               
                                                <asp:TemplateField HeaderText="Recibo" HeaderStyle-CssClass="primary">
                                                <ItemTemplate>                                                   
                                                    <h7 class="text-bold-700"><%# "Folio "+ Eval("Folio")+ " / "+Eval("Concepto")%></h7><br />
                                                    <h7 class="text-bold-400 font-small-3"> <%# " "+Eval("fecha")%></h7><br />
                                                    <h7 class="text-bold-400 font-small-3"><i class="fa fa-usd "></i> <%# " "+Eval("Importe")%></h7><br />                                                    
                                                       
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                                                                      
                                                    <asp:TemplateField HeaderText="Eliminar" ItemStyle-Width="80px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                    <ItemTemplate>

                                                        <button type="button" class="btn btn-icon btn-danger mr-1 btn-sm tooltips"  onclick="eliminarRecibo(<%# Eval("idsolicitud") %>,<%# Eval("idpago") %>)" value="" data-toggle="tooltip" data-original-title="Eliminar Recibo"><i class="ft-delete"> </i> </button>                                                        
                                                                                                                                                             
                                                    </ItemTemplate>
                                                </asp:TemplateField>    
                                                </Columns>

                                            </asp:GridView>
                                               
                                            <asp:SqlDataSource ID="DSalumnos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>

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

                            <button id="impri" class="btn btn-warning" onclick="imprimirSolicitudAut()" type="button" data-backdrop="false" >
                                <i class="fa fa-check-square-o"></i>Imprimir Póliza
                            </button>

                            <button id="impri" class="btn btn-info" onclick="imprimirCaratula()" type="button" data-backdrop="false" >
                                <i class="fa fa-check-square-o"></i>Imprimir Carátula
                            </button>

                            <button id="bcerrar" type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
                                <i class="ft-x"></i>Cerrar
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


     <div class="modal fade" id="wrecibos"  role="dialog" aria-labelledby="myModalLabel40" aria-hidden="true">

        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-primary white">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h3 class="modal-title">Recibos</h3>
                </div>


                <div class="modal-body">

                     <asp:UpdatePanel runat="server" ID="UpdatePanel8">
                                <ContentTemplate>
                                    <div class="row">

                                        <div class="col-md-6">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Curso</label>
											<asp:TextBox ID="bnamecurso" CssClass="form-control text-uppercase"  placeholder="Búsqueda por Nombre, Clave" name="bname" runat="server" OnTextChanged="listadoRecibos" AutoPostBack="true"></asp:TextBox>
										</div>
									</div>

                                        <div class="col-md-6">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Alumno</label>
											<asp:TextBox ID="balumno" CssClass="form-control text-uppercase"  placeholder="Búsqueda por Nombre" name="bname" runat="server" OnTextChanged="listadoRecibos" AutoPostBack="true"></asp:TextBox>
										</div>
									</div>


                                     
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">

                                            <asp:Button runat="server" ID="Brecibos" OnClick="listadoRecibos" style="display:none" UseSubmitBehavior="false"/>
                                            <asp:Button runat="server" ID="BseleccionarRecibo" OnClick="seleccionarRecibo" style="display:none" UseSubmitBehavior="false"/>
                                            
                                            <asp:GridView runat="server" ID="GVrecibos" PageSize="5" AllowPaging="true" AllowSorting="true" CssClass="table table-striped table-bordered zero-configuration" 
                                                AutoGenerateColumns="False" DataSourceID="Dsrecibos" EnableSortingAndPagingCallbacks="true"
                                                AlternatingRowStyle-BackColor="#F5F7FA" OnPageIndexChanged="listadoRecibos">                                                 
                                                <Columns>                      
                                                    
                                                <asp:TemplateField HeaderText="Alumno" >
                                                <ItemTemplate>                                                   
                                                    <h7 class="text-bold-700"><%# Eval("alumno")%></h7><br />
                                                    <h7 class="text-bold-400 font-small-3"><%# Eval("nombre")%></h7><br />
                                                    <h7 class="text-bold-400 font-small-3 font-italic text-bold-600"><i class="fa fa-home"></i> <%# " "+Eval("plantel")%></h7><br />
                                                                                                                                                           
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                               
                                                <asp:TemplateField HeaderText="Recibo" >
                                                <ItemTemplate>                                                   
                                                    <h7 class="text-bold-700"><%# "Folio "+ Eval("Folio")+ " / "+Eval("Fecha")%></h7><br />
                                                    <h7 class="text-bold-400 font-small-3"> <%# " "+Eval("Concepto")%></h7><br />
                                                    <h7 class="text-bold-400 font-small-3"><i class="fa fa-usd "></i> <%# " "+Eval("Importe")%></h7><br />                                                    
                                                       
                                                </ItemTemplate>
                                                </asp:TemplateField>
                                                                                      
                                                    <asp:TemplateField HeaderText="Seleccionar" ItemStyle-Width="100px" HeaderStyle-CssClass="centrarCelda" ItemStyle-CssClass="centrarCelda">
                                                    <ItemTemplate>

                                                        <button type="button" class="btn btn-icon btn-success mr-1 btn-sm tooltips"  onclick="seleccionarRecibo(<%# Eval("idsolicitud") %>,<%# Eval("idpago") %>)" value="" data-toggle="tooltip" data-original-title="Imprimir Recibo"><i class="fa fa-save"> </i> </button>                                                        
                                                                                                                                                             
                                                    </ItemTemplate>
                                                </asp:TemplateField>                                                                                                                                        
                                                    
                                                </Columns>

                                            </asp:GridView>
                                               
                                            <asp:SqlDataSource ID="Dsrecibos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>

                                        </div>

                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>


                </div>

                <div class="modal-footer">

                  

                    <button type="button" class="btn btn-danger mr-1" data-dismiss="modal">
                        <i class="ft-x"></i>Volver
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
        $("#depositos").addClass("active");
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
            
            var nombre = $("*[id$='nombre']").val();
            var fecha = $("*[id$='fecha']").val();           
            walert = 1;
           
            if (nombre == '') {                
                alerta('Atención', 'Ingrese un nombre o descripción para el depósito', 'warning', $("*[id$='nombre']"));
                return false;                
            }
            
            if (fecha == '' ) {                
                alerta('Atención', 'Ingrese la fecha en la que se realiza el depósito', 'warning', $("*[id$='fecha']"));
                return false;                
            }
                                         
            walert = 0;
            //$('#bootstrap').modal('hide');
            mostrarLoading();
            $('#<%= Bguardadeposito.ClientID %>').click();
                                              
                                           
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


             if (costomodulo == '' || costomodulo == '0') {                
                alerta('Atención', 'Ingrese el costo por módulo del curso', 'warning', $("*[id$='costomodulo']"));
                return false;                
            }

            if (costoalumno == '' || costoalumno == '0') {                
                alerta('Atención', 'Ingrese el costo por alumno del curso', 'warning', $("*[id$='costoalumno']"));
                return false;                
            }

            if (pagohora == '' || pagohora == '0') {                
                alerta('Atención', 'Ingrese el pago por hora del curso', 'warning', $("*[id$='pagohora']"));
                return false;                
            }

            if (fechalimite == '') {
                alerta('Atención', 'Ingrese la fecha límite de inscripción al curso', 'warning', $("*[id$='fechalimite']"));
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
           
                     
        }

        function abrirModal(idcurso, idsucursal) {                        
           mostrarLoading();
            $("*[id$='idP']").val(idcurso);
            $("*[id$='idS']").val(idsucursal);
            $("#bootstrap").modal('show');   
            $('#<%= Bfechas.ClientID %>').click(); 
                                                                        
        }

        function seleccionarRecibo(idsolicitud, idpago) {
            mostrarLoading();
            $("*[id$='idI']").val(idsolicitud);
            $("*[id$='iPago']").val(idpago);
            
            $('#<%= BseleccionarRecibo.ClientID %>').click();

        }

        function eliminarRecibo(idsolicitud, idpago) {


            swal({
                title: "El recibo será eliminado del depósito, ¿Desea continuar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: '#DD6B55',
                confirmButtonText: 'Si',
                cancelButtonText: "No"
            }).then((result) => {
                if (result.value) {
                    mostrarLoading();
                    $("*[id$='idI']").val(idsolicitud);
                    $("*[id$='iPago']").val(idpago);

                    $('#<%= Beliminarecibo.ClientID %>').click();

                }
            }) 

            

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

        function imprimirCaratula() {
            mostrarLoading();
            $('#<%= bimprimircaratula.ClientID %>').click();
            cerrarLoading();
        }


        function imprimirSolicitudAutid(id) {
            $("*[id$='idP']").val(id);
            mostrarLoading();
            $('#<%= bimprimir.ClientID %>').click();
            cerrarLoading();
        }

        function imprimirCaratulaid(id) {
            $("*[id$='idP']").val(id);
            mostrarLoading();
            $('#<%= bimprimircaratula.ClientID %>').click();
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

        function consultaPrincipal() {
            mostrarLoading();
            $('#<%= Bconsultar.ClientID %>').click();
           
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

        function abrirModalRecibos(idsolicitud, idsucursal) {
            mostrarLoading();

             $("#wrecibos").modal('show');     
            $('#<%= Brecibos.ClientID %>').click();

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
                //alert(123);
                 $('.cksenlinea').iCheck('uncheck');                       
            });

            $('.cksenlinea').on('ifChecked', function (event) {  
                 $('.cksmovilidad').iCheck('uncheck');  
                        //conteoIds();                       
                });

        }
    </script>
</asp:Content>
