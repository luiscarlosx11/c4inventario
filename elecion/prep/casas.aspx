<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="casas.aspx.cs" Inherits="elecion.prep.casas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
     <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">Casas Amigas</h3>
          </div>
         <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
             <div class="breadcrumb-wrapper col-xs-12">
                 <ol class="breadcrumb">
                     <li class="breadcrumb-item"><a href="/">Inicio</a>
                     </li>
                     <li class="breadcrumb-item"><a href="/">Casas Amiga</a>
                     </li>
                     <li class="breadcrumb-item active">Activar Casas Amigas
                     </li>
                 </ol>
             </div>
         </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cuerpo" runat="server">
    <div class="row" id="header-styling">
        <div class="col-xs-12">
            <div class="card">

                <div class="card-header">
                    <h4 class="card-title">Activar Casas Amigas</h4>
                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                    <div class="heading-elements">
                        <ul class="list-inline mb-0">
                            <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                            <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                        </ul>
                    </div>
                </div>
                <asp:ScriptManager runat="server" ID="sc"></asp:ScriptManager>
                <asp:UpdatePanel ID="up" runat="server">
                    <ContentTemplate>
                        <div class="card-body collapse in">
                            <div class="card-block card-dashboard">
                                <div class="row center">
                                    <div class="col-lg-4 form-group row"></div>
                                    <div class="col-lg-4 form-group row centrarCelda">
                                        <h2>Buscar</h2>
                                        <asp:TextBox ID="bseccion" CssClass="form-control" autocomplete="off" placeholder="Buscar casa amiga por sección" name="bseccion" runat="server"></asp:TextBox>
                                        <br />
                                        <asp:Button runat="server" ID="Botonbuscar" OnClientClick="mostrarLoading();" OnClick="Botonbuscar_Click" CssClass="btn btn-icon btn-success mr-1 btn_s" Text="Buscar" />
                                    </div>
                                   <div class="col-lg-4 form-group row"></div>
                                </div>
                            </div>
                        </div>

                        <div runat="server" id="uDiv" visible="false">
                            <hr />
                            <asp:HiddenField ID="hidc" runat="server" />
                            <div class="card-body collapse in">
                                <div class="card-block card-dashboard">
                                    <div class="row center">
                                        <div class="centered-table centrarCelda center">
                                            <div class="col-lg-4 form-group row"></div>
                                            <div class="col-lg-4 form-group row">
                                                <h3>Casa Amiga</h3>
                                                <h4>Colonia:
                                                <asp:Label runat="server" ID="col"></asp:Label></h4>
                                                <h4>Municipio: 
                                                <asp:Label runat="server" ID="mun"></asp:Label>
                                                </h4>
                                                <h4>Seccional:
                                                <asp:Label runat="server" ID="nsecc"></asp:Label></h4>
                                                <br />

                                                <div id="nop" runat="server">
                                                    Operadores:
                                                    <asp:TextBox ID="operadores" CssClass="form-control" placeholder="Número de Operadores" MaxLength="3" name="operadores" runat="server">0</asp:TextBox>
                                                    <asp:Button runat="server" ID="guardar" OnClientClick="mostrarLoading();" CssClass="btn btn-icon btn-success mr-1 btn_s" Text="Guardar" OnClick="guardar_Click" />
                                                </div>
                                                <asp:Button runat="server" ID="activar" OnClick="activar_Click" OnClientClick="mostrarLoading();" CssClass="btn btn-icon btn-success mr-1 btn_s" Text="Activar" />
                                            </div>
                                            <div class="col-lg-4 form-group row"></div>
                                            <div class="col-lg-12 form-group row"></div>
                                            <div class="col-lg-4 form-group row"></div>
                                            <div class="col-lg-4 form-group row">
                                                
                                             <div class="col-lg-4 form-group row"></div>
                                            
                                            
                                               
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
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
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

        $("*[id$='bseccion']").ForceNumericOnly();
        $("*[id$='operadores']").ForceNumericOnly();

        $(document).prop('title', 'PLACEL - Casa Amigas');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#mac").addClass("active");

    </script>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="PageLevelJS" runat="server">
</asp:Content>
