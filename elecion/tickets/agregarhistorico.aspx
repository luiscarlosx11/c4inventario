<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="agregarhistorico.aspx.cs" Inherits="elecion.tickets.agregarhistorico" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/plugins/forms/checkboxes-radios.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/css/pages/timeline.css">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/raty/jquery.raty.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">DETALLE DE TICKET</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Tickets</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Histórico</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Path="~/app-assets/js/UpdatePanelFocus.js" />
        </Scripts>
    </asp:ScriptManager>


    <div class="card box-shadow-1">
        <ul class="nav nav-tabs nav-top-border no-hover-bg">
							<li class="nav-item">
							<a class="nav-link active" id="homeIcon-tab1" data-toggle="tab" href="#homeIcon1" aria-controls="homeIcon1" aria-expanded="true"><i class="fa fa-desktop"></i> Generales</a>
							</li>
							<li class="nav-item">
							<a class="nav-link" id="profileIcon-tab1" data-toggle="tab" href="#profileIcon1" aria-controls="profileIcon1" aria-expanded="false"><i class="fa fa-comment-o"></i> Seguimiento</a>
							</li>														
		</ul>
		<div class="tab-content px-1 pt-1">
					<div role="tabpanel" class="tab-pane fade active in" id="homeIcon1" aria-labelledby="homeIcon-tab1" aria-expanded="true">
                                <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header">
                                                <span class="float-xs-left">
                                                    <h4 class="text-bold-700" style="width:90%"><asp:Label runat="server" ID="lticket"></asp:Label></h4>
                                                    <h6> <i class="icon-calendar font-medium-2"></i><b> Inició en </b><asp:Label runat="server" ID="lfechahora"></asp:Label></h6>
                                                    <h6> <i class="icon-calendar font-medium-2"></i><b> Inició atención en </b><asp:Label runat="server" ID="latencion"></asp:Label></h6>
                                                    <h6> <i class="icon-calendar font-medium-2"></i><b> Finalizado en </b><asp:Label runat="server" ID="lfechahoracierre"></asp:Label></h6>  
                                                    <h6> <i class="icon-check font-medium-2"></i><b> Terminación </b><asp:Label runat="server" ID="lterminacion"></asp:Label></h6>
                                                    <button type="button" class="btn btn-warning mr-1" data-toggle="tooltip" data-original-title="Finalizar" onclick="regresar()" >
	                                                                <i class="ft-arrow-left"></i> Volver  
	                                                 </button> 
                                                </span>

                                                <span class="float-xs-right">
                                                    <h6><b>Grado de Satisfacción </b></h6>
                                                    <section id="star-ratings">
                                                    <div id='interes' class="estrellas"></div>
                                                          <input type="hidden" id='ninteres' Value="" runat="server"/>

                                                    </section> 
                                                    <br />
                                                    <h6><b>Capacidad Técnica </b></h6>
                                                    <section id="star-ratings">
                                                    <div id='interestec' class="estrellas"></div>
                                                          <input type="hidden" id='ninterestec' Value="" runat="server"/>

                                                    </section> 
                                            	</span>
                                                <asp:HiddenField runat="server" ID="idP" Value="0"/> 
                                                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                                                <div class="heading-elements">
                                                    <ul class="list-inline mb-0">
                                
                                                    </ul>
                                                </div>
                                                <span class="float-xs-left">								                                                                                                                                                                              
                                                      <asp:Button runat="server" ID="guardar" OnClick="actualizar" CssClass="ocultar"/>
                                                      <asp:Button runat="server" ID="volver" OnClick="regresarListado"  class="ocultar" />                                
                                                        
                                                         <!--<button class="btn btn-primary mr-1" data-toggle="tooltip" data-original-title="Calificar" onclick="valida()" type="button" > 
	                                                             <i class="fa fa-check-square-o"></i>   Calificar
	                                                     </button> 
                                                         -->                                                                                                                                                                          
                                                        
                                                    
                                                    
						                        </span>

                                        </div>
                       <asp:UpdatePanel runat="server" ID="PUDatos" UpdateMode="Conditional">
                       <ContentTemplate>

                        <div class="card-body collapse in">
                        <div class="card-block">
                            
                            <div class="form-body">                           
                                <div class="row">

                                    <div class="col-md-6">
										<div class="form-group">
											<label for="atiende" class="text-bold-600">Asignado a</label>
											<asp:DropDownList runat="server" ID="atiende" CssClass="select2 form-control" DataSourceID="Dsusuarios" DataTextField="nombre" OnSelectedIndexChanged="actualizar" AutoPostBack="true" DataValueField="idusuario" style="width:100%" Enabled="false">
                                                    <asp:ListItem Value="0">Seleccione quien atiende</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="Dsusuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" 
                                                    SelectCommand="SELECT U.IDUSUARIO, (CONCAT(COALESCE(U.nombre,''),' ',COALESCE(U.apaterno,''),' ',COALESCE(U.amaterno,''),' - ', A.AREA  ))as NOMBRE
                                                                    FROM usuario U
                                                                    LEFT JOIN area A ON U.IDAREA = A.IDAREA
                                                                    WHERE U.IDTIPOUSUARIO = 4
                                                                    ORDER BY NOMBRE"></asp:SqlDataSource>
                                                
										</div>
									</div>
                                </div>
                                
                                <div class="row">

                                    <div class="col-md-6">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Cliente</label>
											<asp:DropDownList runat="server" ID="cliente" CssClass="select2 form-control" DataSourceID="Dsclientes" DataTextField="nombre" DataValueField="idcliente" OnDataBound="clientes_DataBound" OnSelectedIndexChanged="actualizar" AutoPostBack="true" style="width:100%" Enabled="false">
                                                    
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="Dsclientes" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT IDCLIENTE, NOMBRE FROM cliente ORDER BY NOMBRE"></asp:SqlDataSource>
                                                
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label for="contrato" class="text-bold-600">Contrato</label>
											<asp:DropDownList runat="server" ID="contrato" CssClass="select2 form-control" DataSourceID="Dscontratos" DataTextField="nombre" DataValueField="idcontrato" OnSelectedIndexChanged="actualizar" style="width:100%" AutoPostBack="true" Enabled="false">
                                                
                                               </asp:DropDownList>                                                
                                                <asp:SqlDataSource ID="Dscontratos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT IDCONTRATO, NOMBRE FROM contrato WHERE IDCLIENTE=@idc ORDER BY NOMBRE">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="cliente" Name="idc" PropertyName="SelectedValue" />                                                        
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
										</div>
									</div>

                                 
                                                                            
                                 </div>
                                                                                                 

                                <div class="row">

                                    <div class="col-md-6">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Concepto</label>
											<asp:TextBox ID="concepto" CssClass="form-control"  placeholder="Concepto" MaxLength="50" name="nombre" runat="server" OnTextChanged="actualizar" AutoPostBack="true" ReadOnly="true"></asp:TextBox>
										</div>
									</div>
									

                                    <div class="col-md-3">
                                        <div class="form-group">
                                                 <label for="contrato" class="text-bold-600">Prioridad</label>                                                    
                                                 <asp:DropDownList runat="server" ID="prioridad" CssClass="select2 form-control" DataSourceID="Dsprioridades" DataTextField="prioridad" DataValueField="idprioridad"  AutoPostBack="true" style="width:100%" OnSelectedIndexChanged="actualizar" Enabled="false">                                                
                                                 </asp:DropDownList>                                                
                                                 <asp:SqlDataSource ID="Dsprioridades" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT IDPRIORIDAD, PRIORIDAD FROM prioridad ORDER BY IDPRIORIDAD">                                                    
                                                 </asp:SqlDataSource>                                                                                               
                                        </div>
                                    </div>
                                                                                                        
                                 </div>

                                <div class="row">

                                    <div class="col-md-6">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Tipo de Servicio</label>
											<asp:DropDownList runat="server" ID="tiposervicio" CssClass="select2 form-control" DataSourceID="DsTipo" DataTextField="tiposervicio" DataValueField="idtiposervicio"  AutoPostBack="true" style="width:100%" OnSelectedIndexChanged="actualizar" Enabled="false">                                                
                                                 </asp:DropDownList>                                                
                                                 <asp:SqlDataSource ID="DsTipo" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT IDTIPOSERVICIO, TIPOSERVICIO FROM tiposervicio ORDER BY IDTIPOSERVICIO">                                                    
                                                 </asp:SqlDataSource>  
										</div>
									</div>
									

                                    <div class="col-md-3">
                                        <div class="form-group">
                                                 <label for="contrato" class="text-bold-600">Lugar</label>                                                    
                                                 <asp:DropDownList runat="server" ID="lugarservicio" CssClass="select2 form-control" DataSourceID="DsLugares" DataTextField="lugarservicio" DataValueField="idlugarservicio"  AutoPostBack="true" style="width:100%" OnSelectedIndexChanged="actualizar" Enabled="false">                                                
                                                 </asp:DropDownList>                                                
                                                 <asp:SqlDataSource ID="DsLugares" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT IDLUGARSERVICIO, LUGARSERVICIO FROM lugarservicio ORDER BY IDLUGARSERVICIO">                                                    
                                                 </asp:SqlDataSource>                                                                                               
                                        </div>
                                    </div>
                                                                                                        
                                 </div>

                                <div class="row">

                                    <div class="col-md-12">
                                    <div class="form-group">
	                            	        <label for="observaciones" class="text-bold-600">Observaciones</label>		                                                                                  
                                              <asp:TextBox ID="observaciones" CssClass="form-control" Rows="3" TextMode="MultiLine" placeholder="Observaciones" name="observaciones" runat="server" OnTextChanged="actualizar"  AutoPostBack="true" ReadOnly="true"></asp:TextBox>                                              		                                     
		                             </div>
                                    </div>

                                </div>

                                <div class="row">

                                    <div class="col-md-6">
										<div class="form-group">
											<label for="contacto" class="text-bold-600">Contacto</label>
											<asp:TextBox ID="contacto" CssClass="form-control"  placeholder="Contacto" MaxLength="50" name="nombre" runat="server" OnTextChanged="actualizar"  AutoPostBack="true" ReadOnly="true"></asp:TextBox>
										</div>                                       
									</div>
									

                                    <div class="col-md-3">
                                        <div class="form-group">
											<label for="contactotel" class="text-bold-600">Teléfono</label>
											<asp:TextBox ID="contactotel" CssClass="form-control"  placeholder="Teléfono" MaxLength="50" name="nombre" runat="server" OnTextChanged="actualizar"  AutoPostBack="true" ReadOnly="true"></asp:TextBox>
										</div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="form-group">
											<label for="contactomail" class="text-bold-600">Email</label>
											<asp:TextBox ID="contactomail" CssClass="form-control"  placeholder="Email" MaxLength="50" name="nombre" runat="server" OnTextChanged="actualizar"  AutoPostBack="true" ReadOnly="true"></asp:TextBox>
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
                     </div>

                    
                    <div class="tab-pane fade" id="profileIcon1" role="tabpanel" aria-labelledby="profileIcon-tab1" aria-expanded="false">
                         <asp:UpdatePanel runat="server" ID="PUSeguimiento" UpdateMode="Conditional">
                         <ContentTemplate>
                                 <section id="timeline" class="timeline-center timeline-wrapper">
                                
                                        <ul class="timeline">
                                          <li class="timeline-line"></li>
                                          <li class="timeline-group">
                                            <a href="#" class="btn btn-primary"><i class="fa fa-calendar-o"></i> Inicio</a>
                                          </li>
                                        </ul>
                                        <ul class="timeline">
                                          <li class="timeline-line"></li>
                                    
                                    
                                              <asp:Repeater ID="repSeguimiento" runat="server" DataSourceID="DSSeguimiento" >
                                                <ItemTemplate> 

                                                      <li class="timeline-item<%# (Container.ItemIndex%2==0)?" ":" mt-3" %>">
                                                        <div class="timeline-badge">
                                                          <span class="bg-red bg-lighten-1" data-toggle="tooltip" data-placement="right" title=""><i class="fa fa-file-o"></i></span>
                                                        </div>
                                                        <div class="timeline-card card border-grey border-lighten-2 box-shadow-2">
                                                          <div class="card-header">					        
                                                                            <h6 class="text-bold-700" style="width:90%">
                                                                                <i class="icon-calendar font-medium-2"></i> <%# Eval("fecha")+ " a las " + Eval("hora") + " hrs"  %></h6>                            
                                                                            <h6 style="width:90%"><i class="icon-user font-medium-2"></i>  <%# Eval("nombre") %></h6>
					                                                        <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>        			                    
				                                                        </div>
				                                                        <div class="card-body collapse in">
					                                                        <div class="card-block">
                                                                                <p><%# Eval("comentario")%></p>						        
					                                                        </div>
				                                                        </div>
         
                                                        </div>
                                                      </li>

                                                </ItemTemplate> 
                                                </asp:Repeater>
                                                <asp:SqlDataSource ID="DSSeguimiento" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>">
                                                </asp:SqlDataSource>
                                    
     
                                        </ul>

    
                                        <ul class="timeline">
                                          <li class="timeline-line"></li>
                                          <li class="timeline-group">
                                            <a href="javascript:void(0)" class="btn btn-primary" onclick=""><i class="fa fa-calendar-o"></i>  Fin de notas</a>
                                          </li>
                                        </ul>
                                  </section>
                                

                                     <div class="modal fade text-xs-left" id="frmNota" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
        
		                                        <div class="modal-dialog" role="document">
		                                            <div class="modal-content">
			                                                <div class="modal-header bg-primary white">
			                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                                                <span aria-hidden="true">&times;</span>
			                                                </button>
			                                                <h3 class="modal-title">Nota de Seguimiento</h3>
			                                                </div>
			   
                       
			                                                <div class="modal-body">
                    
	                                                                    <div class="row">
	                                                                        <div class="col-md-12">
	                                                                            <div class="card">
	                                                                                <div class="card-header">
	                                            
	                                                                                </div>
	                                                                                <div class="card-body collapse in">
	                                                                                    <div class="card-block">
						                                              
	                    	                                                                    <div class="form-body">	
                                                                                                    <div class="col-md-12">                    		                                                                                            
                                                                                                        <div class="form-group row">
	                            	                                                                        <label for="tipogasto">Nota</label>		                                                                                                                                                                                                                                                                            
                                                                                                                <asp:TextBox ID="nota" CssClass="form-control" Rows="7" TextMode="MultiLine" placeholder="Nota o comentario" name="nota" runat="server" ></asp:TextBox>
                                                                                                                <div class="help-block"></div>		                                                          
		                                                                                                </div>	         
                                                                                                     </div>                                                      	                                                		                                                   
							                                                                    </div>    	                                                   
	                       
	                                                                                    </div>
	                                                                                </div>
	                                                                            </div>
	                                                                        </div>
	                                                                    </div>

                                                                </div>
                                              
			                                                <div class="modal-footer">
                                                                <asp:Button runat="server" ID="guardarModal" OnClick="generaSeguimiento" CssClass="ocultar"/>                       
				                                                <button class="btn btn-success" onclick="valida()" type="button"> 
	                                                                <i class="fa fa-check-square-o"></i> Aceptar
	                                                             </button>
                 
	                                                             <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
	                                                                <i class="ft-x"></i> Cancelar
	                                                             </button>
			                                                </div>
			       
		                                                </div>
		                                        </div>
                            
	                                    </div>


                                    
                               
                          </ContentTemplate>
                          </asp:UpdatePanel>
                         
                             

                    </div>

                     <div class="modal fade text-xs-left" id="frmFinalizar" tabindex="-1" aria-labelledby="myModalLabel2" role="dialog" aria-hidden="true">
        
		                                        <div class="modal-dialog" role="document">
		                                            <div class="modal-content">
			                                                <div class="modal-header bg-primary white">
			                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                                                <span aria-hidden="true">&times;</span>
			                                                </button>
			                                                <h3 class="modal-title">Finalizar Ticket</h3>
			                                                </div>
			   
                       
			                                                <div class="modal-body">
                    
	                                                                    <div class="row">
	                                                                        <div class="col-md-12">
	                                                                            <div class="card">
	                                                                                <div class="card-header">
	                                            
	                                                                                </div>
	                                                                                <div class="card-body collapse in">
	                                                                                    <div class="card-block">
						                                              
	                    	                                                                    <div class="form-body">	
                                                                                                    <asp:HiddenField ID="nestrellas" runat="server" Value="0" />
                                                                                                     <asp:HiddenField ID="nestrellas_tecnicas" runat="server" Value="0" />
                                                                                                    <div class="col-md-12">
                                                                                                    <div class="form-group">
                                                                                                             <label for="contrato" class="text-bold-600">El servicio quedó</label>                                                    
                                                                                                             <asp:DropDownList runat="server" ID="terminacion" CssClass="select2 form-control" DataSourceID="DSFinalizacion" DataTextField="terminacion" DataValueField="idterminacion"  AutoPostBack="true" style="width:100%" OnSelectedIndexChanged="actualizar">                                                
                                                                                                             </asp:DropDownList>                                                
                                                                                                             <asp:SqlDataSource ID="DSFinalizacion" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT IDTERMINACION, TERMINACION FROM terminacion ORDER BY TERMINACION">                                                    
                                                                                                             </asp:SqlDataSource>                                                                                               
                                                                                                    </div>
                                                                                                </div>
                                                                                                    <div class="col-md-12">                    		                                                                                            
                                                                                                        <div class="form-group">
	                            	                                                                        <label for="tipogasto" class="text-bold-600">Motivo de la finalización</label>		                                                                                                                                                                                                                                                                            
                                                                                                                <asp:TextBox ID="notafinalizar" CssClass="form-control" Rows="7" TextMode="MultiLine" maxlength="60" placeholder="Nota o comentario" name="nota" runat="server" ></asp:TextBox>
                                                                                                                <div class="help-block"></div>		                                                          
		                                                                                                </div>	         
                                                                                                     </div> 
                                                                                                     
                                                                                                    
                                                                                                    <div class="col-md-12">
                                                                                                        <div class="form-group">
                                                                                                        <label for="calificacion" class="text-bold-600">Grado de Satisfacción</label>
                                                                                                          <section id="star-ratings">
                                                                                                            <div id="calificacion" runat="server"></div>
                                                                                                        </section>
                                                                                                        </div>
                                                                                                    </div>  
                                                                                                    
                                                                                                    <div class="col-md-12">
                                                                                                        <div class="form-group">
                                                                                                        <label class="text-bold-600" for="calificacion">Capacidad Técnica</label>
                                                                                                          <section id="star-ratings">
                                                                                                            <div id="calificacion_tecnica" runat="server"></div>
                                                                                                        </section>
                                                                                                        </div>
                                                                                                    </div>                                                     	                                                		                                                   
							                                                                    </div>    	                                                   
	                       
	                                                                                    </div>
	                                                                                </div>
	                                                                            </div>
	                                                                        </div>
	                                                                     </div>

                                                                </div>
                                              
			                                                <div class="modal-footer">
                                                                <asp:Button runat="server" ID="finalizarTicket" OnClick="finalizar" CssClass="ocultar"/>                       
				                                                <button class="btn btn-success" type="button" onclick="finalizar()" data-backdrop="false"> 
	                                                                <i class="fa fa-check-square-o"></i> Aceptar
	                                                             </button>
                 
	                                                             <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" >
	                                                                <i class="ft-x"></i> Cancelar
	                                                             </button>
			                                                </div>
			       
		                                                </div>
		                                        </div>
                            
	                                    </div>
                           
                    
     </div>


      </div> 
    
       
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/assets/js/cyrpto/core-min.js"></script>
    <script src="/assets/js/cyrpto/cipher-core.js"></script>
    <script src="/assets/js/cyrpto/mode-cfb.js"></script>
    <script src="/assets/js/cyrpto/enc-base64-min.js"></script>
    <script src="/assets/js/cyrpto/aes.js"></script>
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/timeline/horizontal-timeline.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/jquery.raty.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    
    <script>

        jQuery.fn.ForceNumericOnly =
         function () {
             return this.each(function () {
                 $(this).keydown(function (e) {
                     var key = e.charCode || e.keyCode || 0;
                     // allow backspace, tab, delete, enter, arrows, numbers and keypad numbers ONLY
                     // home, end, period, and numpad decimal
                     return (
                         key == 8 ||
                         key == 9 ||
                         key == 13 ||
                         key == 46 ||
                         key == 110 ||
                         key == 190 ||
                         (key >= 35 && key <= 40) ||
                         (key >= 48 && key <= 57) ||
                         (key >= 96 && key <= 105));
                 });
             });
         };

        //$(document).prop('title', 'PLACEL - Agregar Coordinador');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#ticketshist").addClass("active");
        $(document).ready(function () {

           

        });

        function guardaRating() {
            //alert($("[id*=interes]").raty('score'));
            $("*[id$='nestrellas']").val($("[id*=calificacion]").raty('score'));
        }

        function guardaRatingTecnico() {
            //alert($("[id*=interes]").raty('score'));
            $("*[id$='nestrellas_tecnicas']").val($("[id*=calificacion_tecnica]").raty('score'));
        }

        function abrirModal() {
            $("*[id$='nota']").val('');
            $("#frmNota").modal('show');
        }


        function valida() {
            var nota = $("*[id$='nota']").val();
           
            if (nota == '') {
                swal("Atención", "Ingrese una nota o comentario sobre el seguimiento", "warning");
                return false;
            } else {
                
                mostrarLoading();
                
                $('#<%= guardarModal.ClientID %>').click();
                $('#frmNota').modal('hide');
                $("*[id$='nota']").val('');
                return true;
            }
        }


        function finalizarModal() {            
            $('#frmFinalizar').modal('show');
        }

        function finalizar() {
           mostrarLoading();                
           $('#<%= finalizarTicket.ClientID %>').click();
        }

        function regresar() {
           
             /*swal({
                title: "Los datos no guardados se perderán, ¿Desea cancelar?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Aceptar",
                cancelButtonText: "Cancelar",
                closeOnConfirm: true,
                closeOnCancel: true
            },
            function (isConfirm) {
                if (isConfirm) {
                   
                } 
            });*/

             mostrarLoading();
             $('#<%= volver.ClientID %>').click();

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
           
                $.fn.raty.defaults.path = '/app-assets/images/raty/';

                $("*[id$='calificacion']").raty();
                $("*[id$='calificacion']").raty({ mouseout: guardaRating });

                $("*[id$='calificacion_tecnica']").raty();
                $("*[id$='calificacion_tecnica']").raty({ mouseout: guardaRatingTecnico });

                $("*[id$='interes']").raty();
                $("*[id$='interes']").raty('score', $("*[id$='ninteres']").val());
                $("*[id$='interes']").raty('readOnly', true);

                $("*[id$='interestec']").raty();
                $("*[id$='interestec']").raty('score', $("*[id$='ninterestec']").val());
                $("*[id$='interestec']").raty('readOnly', true);

               
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
               // loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
               // loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                loadJS("/app-assets/js/scripts/extensions/rating.js");
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

        }
    </script>
</asp:Content>