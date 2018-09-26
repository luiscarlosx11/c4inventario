<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false"  
    CodeBehind="listadoforo.aspx.cs" Inherits="elecion.foro.listadoforo" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .ascending a {
	       /* background:url(/images/descending.png) right no-repeat;*/
	        display:block;
        }

        .descending a {
	       /* background:url(/images/ascending.png) right no-repeat; */
	        display:block;
	
        }      
}
    </style>
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/toggle/switchery.min.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/selects/select2.min.css" />
  
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Foro Nuevo Sol</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="index.html">Inicio</a>
                </li>
                <li class="breadcrumb-item"><a href="#">Campaña</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Foro Nuevo Sol</a>
                </li>
              </ol>
            </div>
          </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">

    <asp:ScriptManager runat="server" ID="sc"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="pU">
        <ContentTemplate>

            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="false"></rsweb:ReportViewer>
            <asp:HiddenField ID="hent" runat="server" />
            <div class="row" id="header-styling">
                <div class="col-xs-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">LISTADO DE AFILIADOS</h4>
                            <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                            <div class="heading-elements">
                                <ul class="list-inline mb-0">
                                    <li><a data-action="collapse"><i class="ft-minus"></i></a></li>
                                    <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                                    <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                                    <li><a data-action="close"><i class="ft-x"></i></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-body collapse in">

                            <div class="card-block card-dashboard">
                                <p class="card-text">

                                    <asp:Button runat="server" ID="Beditar" OnClick="editaRegistro" Style="display: none" />
                                    <asp:Button runat="server" ID="Bborrar" OnClick="borrarRegistro" Style="display: none" />
                                    <asp:HiddenField runat="server" ID="idP" />


                                    <asp:Button runat="server" ID="Bnuevo" OnClick="nuevoRegistro" Style="display: none" />
                                    <button type="button" id="nuevo" onclick="nuevoRegistro();" class="btn btn-icon btn-success mr-1" data-toggle="modal">
                                        <i class="ft-file"></i>Nuevo Registro 
                                    </button>
                                </p>

                                <p class="card-text">


                                    <div class="row">

                                        <div class="col-md-2">
                                            <label for="seccionbus">Sección</label>
                                            <asp:DropDownList runat="server" ID="seccionbus" CssClass="select2 form-control" DataSourceID="DsSeccionBus" DataTextField="seccion" DataValueField="seccion" AutoPostBack="true" OnDataBound="refrescaGrid" name="seccionbus"></asp:DropDownList>
                                            <asp:SqlDataSource ID="DsSeccionBus" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [seccion] FROM [secciones] where entidad=18 ORDER BY [seccion]"></asp:SqlDataSource>
                                        </div>
                                        <div class="col-md-7">
                                        </div>

                                        <div class="col-xl-3 col-lg-6 col-xs-12">
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="card-block">
                                                        <div class="media">
                                                            <div class="media-left media-middle">
                                                                <i class="icon-folder primary font-large-2 float-xs-left"></i>
                                                            </div>
                                                            <div class="media-body text-xs-right">
                                                                <h3>
                                                                    <asp:Label runat="server" ID="labelConteo"></asp:Label></h3>
                                                                <span>Registros encontrados</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <p>
                                    </p>
                                </p>
                            </div>

                            <div class="card-block card-dashboard">
                                <div style="overflow-x: auto; width: 100%">
                                    <asp:GridView runat="server" ID="lpromovidos" PageSize="25" AllowPaging="True" AllowSorting="True" CssClass="table table-striped table-bordered base-style"
                                        AutoGenerateColumns="False" DataKeyNames="idP" DataSourceID="DsListado" EnableSortingAndPagingCallbacks="True"
                                        AlternatingRowStyle-BackColor="#F5F7FA" OnDataBinding="conteoRegistros">
                                        <SortedAscendingHeaderStyle CssClass="ascending" BackColor="#16D39A" ForeColor="White" />
                                        <SortedDescendingHeaderStyle CssClass="descending" BackColor="#16D39A" ForeColor="White" />
                                        <AlternatingRowStyle BackColor="#F5F7FA" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="No." ItemStyle-Width="20px">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                                <ItemStyle Width="20px" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="completo" HeaderText="Nombre" SortExpression="completo" />
                                            <asp:BoundField DataField="clave_e" HeaderText="Clave Electoral" SortExpression="clave_e" />
                                            <asp:BoundField DataField="seccion" HeaderText="Sección" SortExpression="seccion" />
                                            <asp:TemplateField HeaderText="Acciones">
                                                <ItemTemplate>

                                                    <button type="button" id="editar" onclick="editarRegistro(<%# Eval("idP")%>)" class="btn btn-icon btn-success mr-1" data-toggle="tooltip" data-original-title="Editar">
                                                        <i class="ft-edit"></i>
                                                    </button>

                                                    <asp:ImageButton ID="bimprimir" ImageUrl="~/images/printer.png" CssClass="btn btn-icon btn-warning mr-1" CommandArgument="<%# Container.DataItemIndex %>" OnClientClick="mostrarLoading();" CommandName="ccClick" OnClick="bimprimir_Click" runat="server" data-toggle="tooltip" data-original-title="Imprimir"/>

                                                    <button type="button" id="borrar" onclick="eliminarRegistro(<%# Eval("idP")%>)" class="btn btn-icon btn-danger mr-1" data-toggle="tooltip" data-original-title="Borrar">
                                                        <i class="ft-delete"></i>
                                                    </button>

                                                   

                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>

                                    <asp:SqlDataSource ID="DsListado" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT [idP], [clave_e], ([nombre]+' '+[paterno]+' '+ [materno])as completo, [seccion], [email], [telefono] FROM [forosol] WHERE entidad = @ent and seccion=@seccion">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="hent" Name="ent" PropertyName="Value" />
                                            <asp:ControlParameter ControlID="seccionbus" Name="seccion" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>

                            </div>

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

        $(document).prop('title', 'PLACEL - Listado de Promovidos');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#listadoforo").addClass("active");


        function editarRegistro(idP) {
            $("*[id$='idP']").val(idP);
            mostrarLoading();
           $('#<%= Beditar.ClientID %>').click();
        }

        function nuevoRegistro() {
            mostrarLoading();
           $('#<%= Bnuevo.ClientID %>').click();
        }

        function eliminarRegistro(idP) {
            $("*[id$='idP']").val(idP);
            
            

             swal({
                title: "Desea eliminar este registro?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Aceptar",
                cancelButtonText: "Cancelar",
                closeOnConfirm: false,
                closeOnCancel: true
            },
            function (isConfirm) {
                if (isConfirm) {
                    
                    mostrarLoading();                  
                    
                    $('#<%= Bborrar.ClientID %>').click();
                    
                    //swal.close();
                   
                } 
            });

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

                $("*[id$='cp']").ForceNumericOnly(); 
                $("*[id$='seccion']").ForceNumericOnly();
                loadJS("/app-assets/js/scripts/forms/select/form-select2.js");
                loadJS("/app-assets/js/scripts/forms/extended/form-inputmask.js");
                loadJS("/app-assets/js/scripts/forms/validation/form-validation.js");
                loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");
          
        }
    </script>

</asp:Content>