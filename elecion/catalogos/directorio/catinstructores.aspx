<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false"
     CodeBehind="catinstructores.aspx.cs"  Inherits="elecion.catalogos.directorio.catinstructores" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />

        <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/custom.css"/>


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
                <li class="breadcrumb-item active"><a href="#">Directorio</a>
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
        <asp:Button runat="server" ID="guardar" OnClick="guardaEdita" style="display:none" CausesValidation="false"/>
        <div class="row" id="header-styling">
                <div class="col-xs-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">INSTRUCTORES</h4>
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
                                                   <asp:Button runat="server" ID="Beditar" OnClick="editaRegistro" style="display:none" UseSubmitBehavior="false"/> 
                                                   
                                                    <asp:HiddenField runat="server" ID="idP" /> 
                                                    <asp:HiddenField runat="server" ID="limite" Value="48" /> 
                                                    <asp:HiddenField runat="server" ID="idS" /> 
                                                     <asp:HiddenField runat="server" ID="idRol" /> 
                                                    
                                                    <asp:Button runat="server" ID="Bconsultar" OnClick="listadoClientes" Style="display: none" UseSubmitBehavior="false"/>
                                                                                                                                                                  
                                                    <asp:Button runat="server" ID="Bnuevo" OnClick="nuevoRegistro" style="display:none" UseSubmitBehavior="false"/>                                            
                                                    <button type="button" id="nuevo" onclick="abrirModal(0,0,1,'',1,'','','','','','','','','',0,'');" class="btn btn-icon btn-primary mr-1" data-toggle="modal" runat="server" >
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
                            <div class="card box-shadow-1 height-350">
                                <div class="card-header">

                                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                                    <div class="heading-elements">
                                        <ul class="list-inline">
                                            <h4 class="card-title"></h4>
                                        </ul>
                                    </div>

                                    <span class="float-xs-right">
                                        <span class="tag bg-<%# Eval("activoText").Equals("ACTIVO")?"success":"danger"%>"><%# Eval("activoText")%></span>
                                    </span>
                                </div>

                                <div class="modal-body text-xs-center">
                                    
                                        <img src="../../../app-assets/images/portrait/medium/avatar-m-2.png" class="rounded-circle height-100">
                                    
                                    <div class="card-block">
                                        <h5 class="text-bold-700"><%# Eval("nombre")%></h5>
                                        <h7 class="text-bold-400"><%# Eval("profesion")%></h7>                                        
                                        <br />
                                        <br />
                                        <button type="button" class="btn btn-icon btn-primary mr-1 btn-sm" data-toggle="tooltip" data-original-title="Editar" onclick="abrirModal(<%# Eval("idinstructor") %>,<%# Eval("idsucursal") %>, <%# Eval("idespecialidad")%>,'<%# Eval("profesion")%>',<%# Eval("idescolaridad")%>,'<%# Eval("rfc")%>','<%# Eval("curp")%>','<%# Eval("fechanacimiento")%>','<%# Eval("domicilio")%>','<%# Eval("localidad")%>','<%# Eval("email")%>','<%# Eval("telefono")%>','<%# Eval("celular")%>','<%# Eval("observaciones")%>',<%# Eval("activo")%>, '<%#Eval ("nombre") %>')"><i class="ft-edit" ></i> Detalles</button>
                                          <br />                                     
                                    </div>



                                </div>
                            </div>
                        </div>

                        <!--
        <div class="col-md-3 col-sm-12">
			<div class="card box-shadow-1">
				<div class="card-header">
					<h5 class="text-bold-700" style="width:90%"><%# Eval("nombre")%></h5>                    
                    <h5 class="text-bold-700 height-75" style="width:90%"><%# Eval("profesion")%></h5>                    
					<a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
        			<div class="heading-elements">
						<ul class="list-inline">
	                        	<h4 class="card-title"></h4>                                                                              
	                    </ul>
					</div>
                    <div>
                                               
							<span class="float-xs-right">
								<span class="tag bg-<%# Eval("activo").Equals("0")?"danger":"success"%>"><%# Eval("activoText")%></span>								
							</span>
					</div>
				</div>
				<div class="card-body collapse in">
					<div class="card-block">
                        <h6 class="text-bold-600"> <i class="icon-briefcase font-medium-3"></i><%# " "+ Eval("telefono")%> </h6>
                        <h6 class=""> <i class="icon-user font-medium-4"></i><%# " "+ Eval("email")%> </h6>						
						
					</div>
				</div>
			</div>
		</div>  
        -->
                    </ItemTemplate>

                </asp:DataList>
                <asp:SqlDataSource ID="DsUsuarios" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"></asp:SqlDataSource>




            </div>

            <div class="row">
							<div class="col-md-12 ">
								
								<div class="text-xs-center">
									<nav aria-label="Page navigation">
                                        <h5 class="text-xs-center"></h5>
                                        <asp:HiddenField id="pagina" runat="server" Value="1"/>
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
											<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="paging(<%=i + 1%>)"> <%=i + 1%></a></li>
											<%}
                                                } %>								
										</ul>
									</nav>
									
								</div>
							</div>
</div>


            <div class="modal fade text-xs-left" id="bootstrap" role="dialog" aria-labelledby="myModalLabel35" aria-hidden="true">
        
		        <div class="modal-dialog modal-lg" role="document">
		        <div class="modal-content">
			        <div class="modal-header bg-primary white">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				        <span aria-hidden="true">&times;</span>
			        </button>
			        <h5 class="modal-title" id="myModalLabel35">INSTRUCTOR</h5>
			        </div>
			   
                       <asp:HiddenField runat="server" ID="idr" />
                    <div class="modal-body" id="datos">

                        <div class="row">
                            <div class="col-md-12">
                                
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Nombre</label>
                                                        <asp:TextBox ID="nombre" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Nombre" name="nombre" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Especialidad</label>
                                                        <asp:DropDownList runat="server" ID="especialidad" CssClass="select2 form-control" DataSourceID="Dstiposucursal" DataTextField="especialidad" DataValueField="idespecialidad" Style="width: 100%">
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="Dstiposucursal" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                            SelectCommand="SELECT idespecialidad, especialidad from especialidad order by especialidad"></asp:SqlDataSource>
                                                    </div>


                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Escolaridad</label>
                                                        <asp:DropDownList runat="server" ID="escolaridad" CssClass="select2 form-control" DataSourceID="Dsescolaridad" DataTextField="escolaridad" DataValueField="idescolaridad" Style="width: 100%">
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="Dsescolaridad" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                            SelectCommand="SELECT idescolaridad, escolaridad from escolaridad order by escolaridad"></asp:SqlDataSource>
                                                    </div>


                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Profesión</label>

                                                        <asp:TextBox ID="profesion" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Profesión" name="calle" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>
                                                

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600" for="activo">Activo</label>

                                                        <div class="skin skin-flat">
                                                            <asp:CheckBox runat="server" ID="activo" />
                                                        </div>

                                                    </div>
                                                </div>


                                            </div>
                                            
                                           
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">RFC</label>
                                                        <asp:TextBox ID="rfc" CssClass="form-control text-uppercase" MaxLength="60" placeholder="RFC" name="colonia" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">CURP</label>

                                                        <asp:TextBox ID="curp" CssClass="form-control text-uppercase" MaxLength="60" placeholder="CURP" name="cp" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Fecha Nacimiento</label>
                                                        <asp:TextBox ID="fechanacimiento" CssClass="form-control date-inputmask" MaxLength="0" placeholder="Nacimiento" name="fechanacimiento" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>


                                            </div>

                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Domicilio</label>

                                                        <asp:TextBox ID="domicilio" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Domicilio" name="calle" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Localidad</label>

                                                        <asp:TextBox ID="localidad" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Localidad" name="numext" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>
                                            </div>




                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Email</label>
                                                        <asp:TextBox ID="email" CssClass="form-control email-inputmask" MaxLength="60" placeholder="Email" name="telefono" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Teléfono Casa</label>
                                                        <asp:TextBox ID="telefono" CssClass="form-control phone-inputmask" MaxLength="60" placeholder="Casa" name="telefono" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Celular</label>
                                                        <asp:TextBox ID="adicional" CssClass="form-control phone-inputmask" MaxLength="60" placeholder="Celular" name="adicional" runat="server"></asp:TextBox>
                                                    </div>
                                                </div>



                                            </div>

                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Banco</label>
                                                        <asp:DropDownList runat="server" ID="banco" CssClass="select2 form-control" DataSourceID="DSbancos" DataTextField="banco" DataValueField="idbanco" Style="width: 100%">
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="DSbancos" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                            SelectCommand="SELECT idbanco, banco from banco order by banco"></asp:SqlDataSource>
                                                    </div>


                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">No. de cuenta</label>

                                                        <asp:TextBox ID="nocuenta" CssClass="form-control text-uppercase" MaxLength="60" placeholder="No, de Cuenta" name="calle" runat="server"></asp:TextBox>

                                                    </div>


                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label class="text-bold-600">Clabe</label>

                                                        <asp:TextBox ID="clabe" CssClass="form-control text-uppercase" MaxLength="60" placeholder="Clabe" name="calle" runat="server"></asp:TextBox>

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
                                                   
                   
                    <div class="modal-footer">
                             
                        <button class="btn btn-primary" onclick="valida()" type="button" data-backdrop="false" id="aceptar" runat="server">
                            <i class="fa fa-check-square-o"></i>Aceptar
                        </button>

                        <button type="button" class="btn btn-danger mr-1" data-dismiss="modal" id="cerrarModal">
                            <i class="ft-x"></i>Cancelar
                        </button>
                    </div>
</div>

			       
		        </div>
		        </div>
         </ContentTemplate>
        </asp:UpdatePanel>
   
    
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/spinner/jquery.bootstrap-touchspin.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/extended/inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/toggle/switchery.min.js" type="text/javascript"></script>

    <script src="/app-assets/js/scripts/forms/checkbox-radio.js" type="text/javascript"></script>
    <script>
        //$(document).prop('title', 'PLACEL - Promovidos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#catinstructores").addClass("active");
        var walert = 0;
        

        function consultaPrincipal() {
            mostrarLoading();
            $('#<%= Bconsultar.ClientID %>').click();
            cerrarLoading();
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
       
            var nombre = $("*[id$='nombre']").val();
            var profesion = $("*[id$='profesion']").val();
            var fechanacimiento = $("*[id$='fechanacimiento']").val();            
            var domicilio = $("*[id$='colonia']").val();                        
            var localidad = $("*[id$='localidad']").val();  
            
            walert = 1;
            if (nombre == '') {                
                alerta('Atención', 'Ingrese el nombre del instructor', 'warning', $("*[id$='nombre']"));
                return false;                
            }

            if (profesion == '') {
                alerta('Atención', 'Ingrese la profesión del instructor', 'warning', $("*[id$='profesion']"));
                return false;
            }

            if (fechanacimiento == '') {
                alerta('Atención', 'Ingrese la fecha de nacimiento del instructor', 'warning', $("*[id$='fechanacimiento']"));
                return false;
            }

            if (!isValidDate(fechanacimiento)) {
                alerta('Atención', 'Ingrese una fecha válida de nacimiento', 'warning', $("*[id$='fechanacimiento']"));
                return false;
            }
           
            if (domicilio == '') {
                alerta('Atención', 'Ingrese el domicilio del instructor', 'warning', $("*[id$='domicilio']"));
                return false;
            }

            if (localidad == '') {
                alerta('Atención', 'Ingrese la dirección(localidad) del instructor', 'warning', $("*[id$='localidad']"));
                return false;
            }

                              
            walert = 0;
            $('#bootstrap').modal('hide');
            mostrarLoading();
            
            $('#<%= guardar.ClientID %>').click();
                       
                                           
        }
       

        function abrirModal(idinstructor, idsucursal, idespecialidad, profesion, idescolaridad, rfc, curp, fechanacimiento, domicilio, localidad, email, telefono, celular, observaciones, activo, nombre) {

            
            $("*[id$='idP']").val(idinstructor);

            if (idsucursal > 0) {
                $("*[id$='idS']").val(idsucursal);
                $("*[id$='plantelsuc']").val(idsucursal);
                $("*[id$='plantelsuc']").change();
            }
                

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


            //admin   
            if ($("*[id$='idRol']").val().indexOf('1') < 0) {

                

                $("#datos").find('input').each(function () {
                    $(this).attr("readonly", "readonly");
                });

                $("#datos").find('select').each(function () {
                    $(this).attr('disabled', 'disabled');
                });

            }
            //user normal
            else {
                $("#datos").find('input').each(function () {
                    $(this).removeAttr("readonly");
                });

                $("#datos").find('select').each(function () {
                    $(this).removeAttr("readonly");
                });
            }

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
           $('#<%= Bnuevo.ClientID %>').click();
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
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

                loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
                loadJS("/app-assets/js/scripts/forms/checkbox-radio.js");

                walert = 0;
                $('#bootstrap').on('shown.bs.modal', function () {
                    $("*[id$='nombre']").focus();
                });

                $('#bootstrap').on('keypress', function (e) {
                    if (e.keyCode === 13) {
                        
                        if (walert == 0) {
                            valida();
                            return false;
                        }
                        else {
                            swal.close();
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



        }
    </script>
</asp:Content>
