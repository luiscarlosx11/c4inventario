<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false"
     CodeBehind="catinventario.aspx.cs"  Inherits="elecion.catalogos.oferta.catinventario" %>
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

                            <asp:HiddenField runat="server" ID="idestadoant" />
                            <asp:HiddenField runat="server" ID="idcentroant" />
                            <asp:HiddenField runat="server" ID="usuarioant" />
                            <asp:HiddenField runat="server" ID="ubicacionant" />



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
                           
                           
                           <div class="col-md-2">
                               <div class="form-group">      
                                   <label class="text-bold-600 font-small-3">No. inventario</label>
                                   <asp:TextBox ID="bnoinventario" CssClass="form-control text-uppercase" placeholder="Búsqueda por número inventario..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                               </div>
                           </div>

                            <div class="col-md-4">
                               <div class="form-group">      
                                   <label class="text-bold-600 font-small-3">Descripción</label>
                                   <asp:TextBox ID="busdescrip" CssClass="form-control text-uppercase" placeholder="Búsqueda por descripción..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                               </div>
                           </div>

                           <div class="col-md-2">
                               <div class="form-group">      
                                   <label class="text-bold-600 font-small-3">Marca - Modelo - No. serie</label>
                                   <asp:TextBox ID="busmarc" CssClass="form-control text-uppercase" placeholder="Búsqueda por marca, modelo o número de serie..." name="bname" runat="server" AutoPostBack="false" onChange="consultaPrincipal()"></asp:TextBox>
                               </div>
                           </div>

                                                      
                           <div class="col-md-2" runat="server">
                               <div class="form-group">
                                   <label class="text-bold-600 font-small-3">Centro</label>
                                   <asp:DropDownList runat="server" ID="buscent" CssClass="select2 form-control" DataSourceID="DSBuscentro" DataTextField="centro" DataValueField="idcentro" AppendDataBoundItems="true" onChange="consultaPrincipal()">
                                       <asp:ListItem Value="-1" Text="SELECCIONE UN CENTRO"></asp:ListItem>
                                   </asp:DropDownList>
                                   <asp:SqlDataSource ID="DSBuscentro" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idcentro, centro FROM centro ORDER BY idcentro"></asp:SqlDataSource>
                               </div>
                           </div>

                           <div class="col-md-2" id="busplantel" runat="server">
                               <div class="form-group">
                                   <label class="text-bold-600 font-small-3">Estado</label>
                                   <asp:DropDownList runat="server" ID="busestad" CssClass="select2 form-control" DataSourceID="DSplantel" DataTextField="estado" DataValueField="idestado" AppendDataBoundItems="true" onChange="consultaPrincipal()">
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
                                            
                                            <Columns>
                                               

                                                <asp:TemplateField HeaderText="Generales" HeaderStyle-CssClass="primary">
                                                    <ItemTemplate>

                                                        <h7 class="font-weight-bold"><%# Eval("noinventario")%></h7><br />
                                                        <h7 class="font-small-3 font-italic text-bold-600"><%# " "+Eval("descripcion")%></h7>
                                                        <br />
                                                        <h7 class="text-bold-400 font-small-2"> <%# " MARCA "+Eval("marca")+ ", MODELO "+Eval("modelo")+ ", NO SERIE. "+Eval("noserie")%></h7>
                                                        
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Ubicación" HeaderStyle-CssClass="primary" ItemStyle-Width="300px">
                                                    <ItemTemplate>

                                                        <h7 class="font-weight-bold"><%# Eval("adscripcion") + " "+Eval("centro") %></h7><br />
                                                        <h7 class="font-small-3 font-italic text-bold-600"> <%# "  "+Eval("usuario")%></h7>
                                                        <br />                                                        
                                                        <h7 class="text-bold-400 font-small-2"><%# Eval("ubicacion") %></h7>
                                                        

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                               

                                                <asp:TemplateField HeaderText="Estatus" ItemStyle-Width="20px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                    <ItemTemplate>

                                                            <span class="tag bg-<%# Eval("estado").Equals("NO LOCALIZADO")?"warning":Eval("estado").Equals("LOCALIZADO")?"success":Eval("estado").Equals("DADO DE BAJA")?"danger":""%>"><span class="text-bold-700"><%# Eval("estado")%></span></span>                                                        
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                                <asp:TemplateField HeaderText="Acciones" ItemStyle-Width="120px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                    <ItemTemplate>

                                                        <button type="button" class="btn btn-icon btn-warning mr-1 btn-sm tooltips" onclick="abrirModal(<%# Eval("idbien") %>)" value="" data-toggle="tooltip" data-original-title="Ver detalles"><i class="fa fa-pencil"></i></button>
                                                       

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
                            <a class="nav-link" id="tabobserv" data-toggle="tab" href="#observ" aria-controls="tabobserv" aria-expanded="false"><i class="fa fa-folder-open-o"></i>Historial</a>
                        </li>

                         
                    </ul>
                    <div class="tab-content px-1 pt-1">
                        <div role="tabpanel" class="tab-pane fade active in" id="generales" aria-labelledby="tabgenerales" aria-expanded="true">

                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>

                                    <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" Style="display: none" UseSubmitBehavior="false" />
                                    <asp:Button runat="server" ID="bautorizacion" OnClick="solicitaAutorizacion" Style="display: none" UseSubmitBehavior="false" />

                                    <asp:Button runat="server" ID="Brecuperabien" OnClick="recuperaBien" Style="display: none" UseSubmitBehavior="false" />

                                </ContentTemplate>
                            </asp:UpdatePanel>

                            <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                                <ContentTemplate>
                                    <div class="row" id="tbgenerales">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="col-md-3">

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <asp:Label ID="eti" runat="server"></asp:Label>
                                                                <asp:Image ID="fotopa" runat="server" Height="280" Width="300" CssClass="img-fluid tooltips" onClick="$('#botonpic').click();" Style="cursor: pointer; border: solid; border-color: lightgray; border-width: thin" data-toggle="tooltip" data-original-title="Click para cambiar foto" />
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
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label class="text-bold-600">Centro</label>
                                                                <asp:DropDownList runat="server" ID="centro" CssClass="select2 form-control" DataSourceID="DScentro" DataTextField="centro" DataValueField="idcentro" Style="width: 100%">
                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource ID="DSCentro" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idcentro, centro FROM centro ORDER BY idcentro"></asp:SqlDataSource>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label class="text-bold-600">Estado</label>
                                                                <asp:DropDownList runat="server" ID="estado" CssClass="select2 form-control" DataSourceID="DSestado" DataTextField="estado" DataValueField="idestado" Style="width: 100%">                                                                    
                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource ID="DSestado" runat="server" ProviderName="MySql.Data.MySqlClient" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT idestado, estado FROM estado ORDER BY idestado"></asp:SqlDataSource>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label class="text-bold-600">No. inventario</label>
                                                                <asp:TextBox ID="numinventario" CssClass="form-control text-uppercase" placeholder="inventario" runat="server"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label class="text-bold-600">Adscripción</label>
                                                                <asp:TextBox ID="adscripcion" CssClass="form-control text-uppercase" placeholder="adscripción" runat="server" disabled></asp:TextBox>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label class="text-bold-600">Fecha alta</label>
                                                                <asp:TextBox ID="fechaalta" CssClass="form-control date-inputmask text-uppercase" placeholder="fecha alta" runat="server"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">

                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Marca</label>
                                                        <asp:TextBox ID="marca" CssClass="form-control text-uppercase" placeholder="marca" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Modelo</label>
                                                        <asp:TextBox ID="modelo" CssClass="form-control text-uppercase" placeholder="modelo" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>
                                                 <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">No. serie</label>
                                                        <asp:TextBox ID="noserie" CssClass="form-control text-uppercase" placeholder="noserie" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Costo</label>
                                                        <asp:TextBox ID="costo" CssClass="form-control text-uppercase" placeholder="costo" runat="server" disabled></asp:TextBox>
                                                    </div>
                                                </div>

                                            </div>

                                                </div>
                                            </div>
                                           
                                           
                                           <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Descripción</label>
                                                        <asp:TextBox ID="descripcion" CssClass="form-control text-uppercase" placeholder="descripción" runat="server" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>


                                            


                                           <div class="row">

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Responsable</label>
                                                        <asp:TextBox ID="responsable" CssClass="form-control text-uppercase" placeholder="responsable" runat="server" disabled></asp:TextBox>
                                                    </div>
                                                </div>

                                                
                                                 <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Usuario</label>
                                                        <asp:TextBox ID="usuario" CssClass="form-control text-uppercase" placeholder="usuario" runat="server" ></asp:TextBox>
                                                    </div>
                                                </div>

                                               

                                            </div>

                                             <div class="row">
                                                  <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Ubicación física</label>
                                                        <asp:TextBox ID="ubicacion" CssClass="form-control text-uppercase" placeholder="ubicacion" runat="server" ></asp:TextBox>
                                                    </div>
                                                </div>
                                                 </div>

                                           

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

                                            
                                            <asp:GridView runat="server" ID="GVhistorial" PageSize="8" AllowPaging="true" AllowSorting="false" CssClass="table table-striped lGeneral" 
                                                AutoGenerateColumns="False" DataSourceID="DShistorial" EnableSortingAndPagingCallbacks="true" 
                                                GridLines="Horizontal" BorderWidth="0" RowStyle-CssClass="rowHover" ClientIDMode="Static" OnPageIndexChanged="listadoHistorial">
                                                
                                                <Columns>
                                                    
                                                    <asp:TemplateField HeaderText="Descripción" HeaderStyle-CssClass="primary">
                                                        <ItemTemplate>
                                                            <h7 class="font-weight-bold"><%# Eval("descripcion")%></h7>
                                                            <br />
                                                            <h7 class="text-bold-400 font-small-2"> <%# " FECHA "+Eval("fechatext")%></h7>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Operación"  ItemStyle-Width="20px" HeaderStyle-CssClass="centrarCelda primary" ItemStyle-CssClass="centrarCelda">
                                                        <ItemTemplate>
                                                            <span class="tag bg-<%# Eval("idtipomovimiento").ToString().Equals("1")?"success":Eval("idtipomovimiento").ToString().Equals("2")?"warning":Eval("idtipomovimiento").ToString().Equals("3")?"purple":Eval("idtipomovimiento").ToString().Equals("4")?"cyan":Eval("idtipomovimiento").ToString().Equals("5")?"danger":"primary"%>"><span class="text-bold-700"><%# Eval("tipomovimiento")%></span></span>                                                        
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    
                                                </Columns>

                                            </asp:GridView>
                                               
                                            <asp:SqlDataSource ID="DShistorial" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>

                                        </div>

                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>


                       
                    </div>
                </div>

                <div class="modal-footer">
                                               
                            <button id="bguardar" class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false" >
                                Guardar
                            </button>

                            <button id="bcerrar" type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
                                Salir
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
        $("#catinventario").addClass("active");
        var walert = 0;
        var fecha = '';
        
        var initialLangCode = 'es';
        var dataEvent;

        // Date dd/mm/yyyy
        

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
            var noinventario = $("[id$='numinventario']").val();
            var fechaalta = $("[id$='fechaalta']").val();            
            var marca = $("[id$='marca']").val();
            var modelo = $("[id$='modelo']").val();
            var noserie = $("[id$='noserie']").val();
            var descripcion = $("[id$='descripcion']").val();
            var usuario = $("[id$='usuario']").val();
            var ubicacion = $("[id$='ubicacion']").val();
            var estado = $("[id$='estado']").val();
            walert = 1;

         
            
            if (noinventario == '') {
                alerta('Atención', 'Ingrese el número de inventario del bien', 'warning', $("[id$='noinventario']"));
                return false;
            }

            if (!isValidDate(fechaalta)) {
                alerta('Atención', 'Ingrese una fecha válida', 'warning', $("[id$='fechaalta']"));
                return false;
            }


            if (fechaalta == '') {
                alerta('Atención', 'Ingrese la fecha de alta del bien', 'warning', $("[id$='fechaalta']"));
                return false;
            }


            if (marca == '') {
                alerta('Atención', 'Ingrese la marca del bien', 'warning', $("[id$='marca']"));
                return false;
            }

            if (modelo == '') {
                alerta('Atención', 'Ingrese el modelo del bien', 'warning', $("[id$='modelo']"));
                return false;
            }

            if (noserie == '') {
                alerta('Atención', 'Ingrese el número de serie del bien', 'warning', $("[id$='noserie']"));
                return false;
            }

            if (descripcion == '') {
                alerta('Atención', 'Ingrese la descripción del bien', 'warning', $("[id$='descripcion']"));
                return false;
            }

            if (estado != '2') {

                if (usuario == '') {
                    alerta('Atención', 'Ingrese el usuario del bien', 'warning', $("[id$='usuario']"));
                    return false;
                }

                if (ubicacion == '') {
                    alerta('Atención', 'Ingrese la ubicación del bien', 'warning', $("[id$='ubicacion']"));
                    return false;
                }

            }

            
            walert = 0;
            mostrarLoading();            
            $('#<%= guardar.ClientID %>').click();
                                                                  
        }



        function abrirModal(idcurso) {                        
           mostrarLoading();
            $("*[id$='idP']").val(idcurso);                                
            $('#<%= Brecuperabien.ClientID %>').click();                                                            
        }

     

        function nuevoRegistro() {
            mostrarLoading();
            $("*[id$='idP']").val(0);
            
           
            $('#<%= Bnuevo.ClientID %>').click();
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
            loadJS("/app-assets/js/scripts/ui/scrollable.js");
                     
           

             $(document).ready(function () {
                $('.tooltips').tooltip();
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

            

            // Date dd/mm/yyyy
            $('.date-inputmask').inputmask("yyyy-mm-dd", { "placeholder": "aaaa-mm-dd" });


               

        }
     </script>
</asp:Content>
