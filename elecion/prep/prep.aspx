<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="prep.aspx.cs" Inherits="elecion.prep.prep" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/extensions/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="/app-assets/vendors/css/forms/spinner/jquery.bootstrap-touchspin.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="titulobreads" runat="server">
    <div class="content-header row">
        <div class="content-header-left col-md-6 col-xs-12 mb-1">
            <h3 class="content-header-title">PREP</h3>
          </div>
          <div class="content-header-right breadcrumbs-right breadcrumbs-top col-md-6 col-xs-12">
            <div class="breadcrumb-wrapper col-xs-12">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item active"><a href="#">Programa de Resultados Electorales Preeliminares</a>
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
                    <h4 class="card-title">Registro PREP</h4>
                    <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                    <div class="heading-elements">
                        <ul class="list-inline mb-0">
                            <li><a data-action="reload"><i class="ft-rotate-cw"></i></a></li>
                            <li><a data-action="expand"><i class="ft-maximize"></i></a></li>
                        </ul>
                    </div>
                </div>
                <div class="card-body collapse in">
                    <div class="card-block card-dashboard">
                        <div class="row center">
                            <div class="col-md-4"></div>
                            <div class="col-md-4 centrarCelda">
                                <h2>Buscar</h2>
                                    <asp:TextBox ID="bseccion" CssClass="form-control" autocomplete="off" placeholder="Buscar casillas por sección" name="bseccion" runat="server"></asp:TextBox>
                                <br />
                                <asp:Button runat="server" ID="Botonbuscar" OnClientClick="mostrarLoading();" CssClass="btn btn-icon btn-success mr-1 btn_s" Text="Buscar" OnClick="Botonbuscar_Click" />
                            </div>
                            <div class="col-md-4"></div>
                        </div>
                        <div class="row center">
                            <div class="col-md-4"></div>
                            <div class="col-md-4 centrarCelda">
                                <br />
                                <asp:Label ID="Legendcasilla" runat="server"></asp:Label>
                              <asp:GridView runat="server" OnDataBound="gCasillas_DataBound" Width="100%" ID="gCasillas" onclick="mostrarLoading()" AutoGenerateColumns="False" DataKeyNames="id" 
                                  CssClass="table table-striped table-bordered base-style" OnRowCreated="gCasillas_RowCreated" OnSelectedIndexChanged="gCasillas_SelectedIndexChanged"
                                  DataSourceID="DsCasillas">
                                  <RowStyle CssClass="item" />
                                  <Columns>
                                      <asp:BoundField DataField="TIPO" HeaderText="Tipo" SortExpression="TIPO" >
                                      <ControlStyle CssClass="centrarCelda" />
                                      <HeaderStyle CssClass="centrarCelda" Font-Size="Large" />
                                      <ItemStyle CssClass="item" />
                                      </asp:BoundField>
                                  </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="DsCasillas" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>" SelectCommand="SELECT  id, casilla as CASILLA, tipo as TIPO FROM [casillas2] WHERE [SECCION] = @secc ORDER BY [SECCION], [TIPO]">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="bseccion" Name="secc" PropertyName="Text" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </div>
                            <div class="col-md-4"></div>
                        </div>
                    </div>
                </div>

                <div runat="server" id="uDiv" visible="false">
                    <asp:HiddenField ID="hidc" runat="server" />
                    <div class="card-body collapse in">
                        <div class="card-block card-dashboard">
                            <div class="row center">
                                <ul class="nav nav-tabs nav-top-border no-hover-bg nav-justified">
                                    <li class="nav-item">
                                        <a class="nav-link active" id="active-tab1" data-toggle="tab" href="#active1" aria-controls="active1" aria-expanded="true">Gobernador</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="pm-tab-t" data-toggle="tab" href="#pm-tab" aria-controls="pm-tab" aria-expanded="false">Ayuntamientos</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="ddip_tap" data-toggle="tab" href="#dip_tap" aria-controls="dip_tap" aria-expanded="false">Regidores</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" id="regidores-tab" data-toggle="tab" href="#regidores" aria-controls="regidores" aria-expanded="false">Diputados</a>
                                    </li>
                                </ul>

                                <div class="tab-content px-1 pt-1 centered-table centrarCelda center">
                                    <asp:Label runat="server" ID="LeyendaC"></asp:Label>

                                    <div role="tabpanel" class="tab-pane fade active in centered-table centrarCelda center" id="active1" aria-labelledby="active-tab1" aria-expanded="true">
                                        <p class="rounded_corners" style="width: 549px; text-align: center;">

                                            <asp:GridView CssClass="centered-table" runat="server" ID="gGobernador" AutoGenerateColumns="False" DataSourceID="DsGobernador" DataKeyNames="id" HorizontalAlign="Center">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                            <img src="<%# Eval("[logo]") %>" style="margin-top: 15px; margin-left: 15px; margin-right: 15px; width: 72px; height: 72px;" />
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="enmedio" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label CssClass="negrita" runat="server" Text='<%# Eval("[PARTIDO]") %>'></asp:Label><br />
                                                            (<%# Eval("[NOMBRE]") %>)
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Middle" CssClass="enmedio" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="VOTOS">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="TextBox1" Style="text-align: center;" Width="50%" runat="server" Text='<%# Eval("votos") %>'></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Middle" CssClass="enmedio" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <br />
                                            <asp:Button ID="btnUpdateGOB" runat="server" Text="Guardar" OnClientClick="mostrarLoading();" CssClass="btn-lg btn-icon btn-success mr-1 btn_s" OnClick="btnUpdate_GOB" Visible="true" /><br />
                                            <asp:SqlDataSource ID="DsGobernador" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                SelectCommand="SELECT [id], [logo], [idCasilla], [secc], [nombre], [PARTIDO], [votos] FROM [vot_gobernador] WHERE ([idCasilla] = @idc) ORDER BY PARTIDO DESC">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hidc" Name="idc" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            &nbsp;

                                        </p>
                                    </div>
                                    <div class="tab-pane fade" id="pm-tab" role="tabpanel" aria-labelledby="pm-tab" aria-expanded="false">
                                        <p class="rounded_corners" style="width: 549px; text-align: center;">
                                            <asp:GridView CssClass="centered-table" runat="server" ID="gPM" AutoGenerateColumns="False" DataSourceID="DsPM" DataKeyNames="id" HorizontalAlign="Center">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                            <img src="<%# Eval("[logo]") %>" style="margin-top: 15px; margin-left: 15px; margin-right: 15px; width: 72px; height: 72px;" />
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="enmedio" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label CssClass="negrita" runat="server" Text='<%# Eval("[PARTIDO]") %>'></asp:Label><br />
                                                            (<%# Eval("[NOMBRE]") %>)
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Middle" CssClass="enmedio" HorizontalAlign="Center" />
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="VOTOS">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="TextBox1" Style="text-align: center;" Width="50%" runat="server" Text='<%# Eval("votos") %>'></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Middle" CssClass="enmedio" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="DsPM" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                SelectCommand="SELECT [id], [logo], [idCasilla], [secc], [nombre], [PARTIDO], [votos] FROM [vot_pm] WHERE ([idCasilla] = @idc) ORDER BY PARTIDO DESC">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hidc" Name="idc" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <br />
                                            <asp:Button ID="bPM" runat="server" Text="Guardar" OnClick="btnUpdate_PM" OnClientClick="mostrarLoading();" CssClass="btn-lg btn-icon btn-success mr-1 btn_s" Visible="true" /><br />
                                            &nbsp;
                                        </p>
                                    </div>
                                    <div class="tab-pane fade" id="dip_tap" role="tabpanel" aria-labelledby="dip_tap-tab1" aria-expanded="false">
                                        <p class="rounded_corners" style="width: 549px; text-align: center;">
                                            <asp:GridView CssClass="centered-table" runat="server" ID="gRegidor" AutoGenerateColumns="False" DataSourceID="DsRegidor" DataKeyNames="id" HorizontalAlign="Center">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                            <img src="<%# Eval("[logo]") %>" style="margin-top: 15px; margin-left: 15px; margin-right: 15px; width: 72px; height: 72px;" />
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="enmedio" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label CssClass="negrita" runat="server" Text='<%# Eval("[PARTIDO]") %>'></asp:Label><br />
                                                            (<%# Eval("[NOMBRE]") %>)
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Middle" CssClass="enmedio" HorizontalAlign="Center" />
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="VOTOS">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="TextBox1" Style="text-align: center;" Width="50%" runat="server" Text='<%# Eval("votos") %>'></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Middle" CssClass="enmedio" HorizontalAlign="Center" />
                                                    </asp:TemplateField>

                                                </Columns>

                                            </asp:GridView>
                                            <br />
                                            <asp:SqlDataSource ID="DsRegidor" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                SelectCommand="SELECT [id], [logo], [idCasilla], [secc], [nombre], [PARTIDO], [votos] FROM [vot_regidores] WHERE ([idCasilla] = @idc) ORDER BY PARTIDO DESC">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hidc" Name="idc" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Button ID="bReg" runat="server" Text="Guardar" OnClick="btnUpdate_Reigor" Visible="true" OnClientClick="mostrarLoading();" CssClass="btn-lg btn-icon btn-success mr-1 btn_s" /><br />
                                            &nbsp;

                                        </p>
                                    </div>
                                    <div class="tab-pane fade" id="regidores" role="tabpanel" aria-labelledby="regidores-tab1" aria-expanded="false">
                                        <p class="rounded_corners" style="width: 549px; text-align: center;">
                                            <asp:GridView CssClass="centered-table" runat="server" ID="gDiputados" AutoGenerateColumns="False" DataSourceID="DsDiputados" DataKeyNames="id" HorizontalAlign="Center">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                            <img src="<%# Eval("[logo]") %>" style="margin-top: 15px; margin-left: 15px; margin-right: 15px; width: 72px; height: 72px;" />
                                                        </ItemTemplate>
                                                        <ItemStyle CssClass="enmedio" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="">
                                                        <ItemTemplate>
                                                            <asp:Label CssClass="negrita" runat="server" Text='<%# Eval("[PARTIDO]") %>'></asp:Label><br />
                                                            (<%# Eval("[NOMBRE]") %>)
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Middle" CssClass="enmedio" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="VOTOS">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="TextBox1" Style="text-align: center;" Width="50%" runat="server" Text='<%# Eval("votos") %>'></asp:TextBox>
                                                        </ItemTemplate>
                                                        <ItemStyle VerticalAlign="Middle" CssClass="enmedio" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            <asp:SqlDataSource ID="DsDiputados" runat="server" ConnectionString="<%$ ConnectionStrings:DBconexion %>"
                                                SelectCommand="SELECT [id], [logo], [idCasilla], [secc], [Distrito], [nombre], [PARTIDO], [votos] FROM [vot_diputados] WHERE ([idCasilla] = @idc) ORDER BY PARTIDO DESC">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="hidc" Name="idc" PropertyName="Value" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <br />
                                            <asp:Button ID="btnUpdate" runat="server" Text="Guardar" OnClick="btnUpdate_Click" Visible="true" OnClientClick="mostrarLoading();" CssClass="btn-lg btn-icon btn-success mr-1 btn_s" /><br />
                                            &nbsp;

                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>  
              
                

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="JavaScript" runat="server">
    <script src="/app-assets/vendors/js/extensions/sweetalert.min.js" type="text/javascript"></script>
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

        $(document).prop('title', 'PLACEL - Captura PREP');
        $(".nav-item>ul>li.active").removeClass("active");
        $("#mprep").addClass("active");

        $("*[id$='bseccion']").ForceNumericOnly();
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

            $("*[id$='bseccion']").ForceNumericOnly();
            loadJS("app-assets/js/scripts/navs/navs.min.js");
            loadJS("/app-assets/js/scripts/extensions/sweet-alerts.js");

        }
    </script>
</asp:Content>
