<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="listado.aspx.cs" Inherits="elecion.tickets.listado" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
    <link rel="stylesheet" type="text/css" href="/assets/css/style.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/raty/jquery.raty.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/fonts/simple-line-icons/style.min.css" />
    <!-- END VENDOR CSS-->
    <style>
        .truncar {
          /* hide text if it more than N lines  */
          overflow: hidden;
           
          /* for set '...' in absolute position */
          position: relative; 
          /* use this value to count block height */
          line-height: 1.2em;
          /* max-height = line-height (1.2) * lines max number (3) */
          max-height: 4.8em; 
          /* fix problem when last visible word doesn't adjoin right side  */
          text-align: justify;  
          /* place for '...' */
          margin-right: 0em;
          padding-right: 1em;
         
        }

        /* create the ... */
            .truncar:before {
              /* points in the end */
              content: '...';
              /* absolute position */
              position: absolute;
              /* set position to right bottom corner of block */
              right: 0;
              bottom: 0;
            }

        /* hide ... if we have text, which is less than or equal to max lines */
        .truncar:after {
          /* points in the end */
          content: '';
          /* absolute position */
          position: absolute;
          /* set position to right bottom corner of text */
          right: 0;
          /* set width and height */
          width: 1em;
          height: 1em;
          margin-top: 0.2em;
          /* bg color = bg color under block */
          background: white;
        }
    </style>

    <!-- END Custom CSS-->
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Tickets</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Tickets</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Activos</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
 <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
 <asp:UpdatePanel runat="server" ID="PUSeguimiento" UpdateMode="Conditional">
    <ContentTemplate>
<div class="row">
    <div class="col-lg-12 col-md-12 col-xs-12">
        <div class="row">
            <asp:HiddenField runat="server" ID="idP" />
                <asp:Button runat="server" ID="Bnuevo" OnClick="nuevoRegistro" Style="display: none" />
                <asp:Button runat="server" ID="Beditar" OnClick="editarRegistro" Style="display: none" />
                <asp:Button runat="server" ID="Bconsultar" OnClick="listadoTickets" Style="display: none" />
            <div class="col-md-12">
                    <div class="card overflow-hidden">
                        <div class="card-body">
                            <div class="card-block cleartfix">
                                <div class="media">
                                    <div class="media-left media-middle">
                                        <i class="icon-speech primary font-large-2 mr-2"></i>
                                    </div>
                                    <div class="media-body">
                                        <h4>Tickets Activos</h4>
                                        <span><asp:Label runat="server" ID="labelConteo"></asp:Label> actualmente</span>
                                    </div>
                                    <div class="media-right media-middle">
                                        <button type="button" id="nuevo" runat="server" onclick="insertar()" class="btn btn-icon btn-success mr-1" data-toggle="modal">
                                            <i class="ft-file"></i>Nuevo Ticket 
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="card-block card-dashboard">
                                 <div class="row">

                                    <div class="col-md-4" id="datiende" runat="server">
										<div class="form-group">
											<label for="atiende" class="text-bold-600">Asignado a</label>
											<asp:DropDownList runat="server" ID="atiende" CssClass="select2 form-control" DataSourceID="Dsusuarios" DataTextField="NOMBRE" OnSelectedIndexChanged="listadoTickets" AutoPostBack="true" DataValueField="idusuario" style="width:100%" AppendDataBoundItems="true">
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
                                    <div class="col-md-4">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Cliente</label>
											<asp:DropDownList runat="server" ID="cliente" CssClass="select2 form-control" DataSourceID="Dsclientes" DataTextField="nombre" DataValueField="idcliente" AppendDataBoundItems="true" OnSelectedIndexChanged="listadoTickets" AutoPostBack="true" style="width:100%">
                                                <asp:ListItem Value="0">Seleccione un cliente</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="Dsclientes" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT IDCLIENTE, NOMBRE FROM cliente ORDER BY NOMBRE"></asp:SqlDataSource>
                                                
										</div>
									</div>

                                   <div class="col-md-4">
										<div class="form-group">
											<label for="cliente" class="text-bold-600">Concepto</label>
											<asp:TextBox ID="concepto" CssClass="form-control"  placeholder="Concepto" MaxLength="50" name="nombre" runat="server" OnTextChanged="listadoTickets" AutoPostBack="true"></asp:TextBox>
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


<!--/ Analytics spakline & chartjs  -->
<div class="row">
    
    <asp:DataList ID="dlCustomers" runat="server" DataSourceID="DSTickets" RepeatLayout="Flow" RepeatDirection="Horizontal"  OnDataBinding="conteoRegistros" >
    <ItemTemplate>        
       

        <div class="col-md-4 col-sm-12">
			<div class="card box-shadow-1">
				<div class="card-header">
					<h5 class="text-bold-700" style="width:90%"><%# "Tck # "+Eval("folio")%></h5>                    
                    <h5 class="text-bold-700 height-75" style="width:90%"><%# Eval("concepto")%></h5>                    
					<a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
        			<div class="heading-elements">
						<ul class="list-inline">
	                        	<h4 class="card-title"></h4>                                                                              
	                    </ul>
					</div>
                    <div>
                        <span style="">
						  <section id="star-ratings">
                                  <div id='interes_<%#Eval("idticket") %>' class="estrellas"></div>
                                  <input type="hidden" id='ninteres_<%#Eval("idticket") %>' value="<%#Eval("idcalificacion") %>"/>
                           </section> 	
                        </span>
                        <span><%# Eval("fecha") + " - " + Eval("hora") + " hrs." %></span>

							<span class="float-xs-right">
								<span class="tag bg-<%# Eval("prioridad").Equals("Urgente")?"danger":Eval("prioridad").Equals("Alta")?"warning":Eval("prioridad").Equals("Media")?"success":"primary"%>"><%# Eval("prioridad")%></span>								
							</span>
					</div>
				</div>
				<div class="card-body collapse in">
					<div class="card-block">
                        <h6 class="text-bold-600"> <i class="icon-briefcase font-medium-3"></i><%# " "+ Eval("cliente")%> </h6>
                        <h6 class=""> <i class="icon-user font-medium-4"></i><%# " "+ Eval("atiende")%> </h6>
						<p class="truncar height-75" ><%# Eval("observaciones")%></p>
						<div class="card-footer">							
							<span class="float-xs-right">								                                                                                                                                                                              
                                    <button type="button" class="btn btn-icon btn-warning mr-1 btn-sm" data-toggle="tooltip" data-original-title="Editar"><i class="fa fa-pencil" onclick="editar(<%# Eval("idticket") %>)"></i></button>
                                    <!--<button type="button" class="btn btn-icon btn-danger mr-1 btn-sm" data-toggle="tooltip" data-original-title="Eliminar"><i class="fa fa-trash" onclick="eliminar(<%# Eval("idticket") %>)"></i></button>-->
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
        
        </ItemTemplate>
        
</asp:DataList>
<asp:SqlDataSource ID="DSTickets" ProviderName="MySql.Data.MySqlClient" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>">

</asp:SqlDataSource>
    
    
      
  
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
                                                double total = Math.Ceiling((double)totalreg / 12);
                                                int i;

                                                if (totalreg > 12)
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
<div class="row"></div>
<!-- Audience by country & users visit-->

    

  
<!-- Analytics map based session -->
    


<!-- Analytics map based session -->
   </ContentTemplate>
     </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    

 
    <script src="/app-assets/vendors/js/extensions/jquery.knob.min.js" type="text/javascript"></script>
    <script src="/app-assets/js/scripts/extensions/knob.js" type="text/javascript"></script>

    <script src="/app-assets/data/jvector/visitor-data.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/charts/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/unslider-min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/forms/select/select2.full.min.js" type="text/javascript"></script>

    <script src="/app-assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="/app-assets/vendors/js/extensions/jquery.raty.js" type="text/javascript"></script>
    
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN STACK JS-->

    <!-- END STACK JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    
    <script>
        
        $(".nav-item>ul>li.active").removeClass("active");
        $("#ticketsact").addClass("active");
        
        function insertar() {
            mostrarLoading();
            $("*[id$='idP']").val(0);
            $('#<%= Bnuevo.ClientID %>').click();
        }

        function paging(pagina) {
            $("*[id$='pagina']").val(pagina);
            $('#<%= Bconsultar.ClientID %>').click();
        }
       
        function asignar(idticket) {
            // mostrarLoading();
            $("*[id$='idP']").val(idticket);
           $('#<%= Beditar.ClientID %>').click();
        }

        function editar(idticket) {
            mostrarLoading();
           $("*[id$='idP']").val(idticket);
           $('#<%= Beditar.ClientID %>').click();
        }


        function eliminar(idticket) {
            // mostrarLoading();
            $("*[id$='idP']").val(idticket);
           $('#<%= Beditar.ClientID %>').click();
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

        $('.estrellas').each(function () {
           
            var ide = ($(this).attr('id')).split('_');
            
            $(this).raty();                        
            $(this).raty('score', $("#ninteres_" + ide[1]).val());
            $(this).raty('readOnly', true);

        });

        loadJS("/app-assets/vendors/js/extensions/jquery.knob.min.js");
        loadJS("/app-assets/js/scripts/extensions/knob.js");

        loadJS("/app-assets/data/jvector/visitor-data.js");
        loadJS("/app-assets/vendors/js/charts/jquery.sparkline.min.js");
        loadJS("/app-assets/vendors/js/extensions/unslider-min.js");

        loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
        loadJS("/app-assets/vendors/js/forms/icheck/icheck.min.js");
        loadJS("/app-assets/vendors/js/extensions/jquery.raty.js");

                   
    }
    
        </script>
</asp:Content>
