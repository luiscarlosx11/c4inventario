namespace ReportLibrary
{
    partial class ReportMovDiarios
    {
        #region Component Designer generated code
        /// <summary>
        /// Required method for telerik Reporting designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ReportMovDiarios));
            Telerik.Reporting.Group group1 = new Telerik.Reporting.Group();
            Telerik.Reporting.ReportParameter reportParameter1 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.ReportParameter reportParameter2 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.ReportParameter reportParameter3 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.Drawing.StyleRule styleRule1 = new Telerik.Reporting.Drawing.StyleRule();
            this.groupFooterSection = new Telerik.Reporting.GroupFooterSection();
            this.textBox24 = new Telerik.Reporting.TextBox();
            this.groupHeaderSection = new Telerik.Reporting.GroupHeaderSection();
            this.textBox2 = new Telerik.Reporting.TextBox();
            this.textBox4 = new Telerik.Reporting.TextBox();
            this.textBox17 = new Telerik.Reporting.TextBox();
            this.textBox28 = new Telerik.Reporting.TextBox();
            this.textBox31 = new Telerik.Reporting.TextBox();
            this.textBox9 = new Telerik.Reporting.TextBox();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.textBox29 = new Telerik.Reporting.TextBox();
            this.textBox35 = new Telerik.Reporting.TextBox();
            this.detail = new Telerik.Reporting.DetailSection();
            this.textBox13 = new Telerik.Reporting.TextBox();
            this.textBox19 = new Telerik.Reporting.TextBox();
            this.textBox1 = new Telerik.Reporting.TextBox();
            this.textBox32 = new Telerik.Reporting.TextBox();
            this.textBox8 = new Telerik.Reporting.TextBox();
            this.sqlDataSource1 = new Telerik.Reporting.SqlDataSource();
            this.textBox16 = new Telerik.Reporting.TextBox();
            this.textBox18 = new Telerik.Reporting.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // groupFooterSection
            // 
            this.groupFooterSection.Height = Telerik.Reporting.Drawing.Unit.Cm(0.85902780294418335D);
            this.groupFooterSection.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox24});
            this.groupFooterSection.Name = "groupFooterSection";
            // 
            // textBox24
            // 
            this.textBox24.Format = "{0:C2}";
            this.textBox24.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(20.499691009521484D), Telerik.Reporting.Drawing.Unit.Cm(0.00020024616969749332D));
            this.textBox24.Name = "textBox24";
            this.textBox24.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.3180685043334961D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox24.Style.Font.Bold = true;
            this.textBox24.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox24.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox24.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox24.Value = "= Sum(Fields.importe)";
            // 
            // groupHeaderSection
            // 
            this.groupHeaderSection.Height = Telerik.Reporting.Drawing.Unit.Cm(1.2024306058883667D);
            this.groupHeaderSection.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox2,
            this.textBox4,
            this.textBox17,
            this.textBox28,
            this.textBox31,
            this.textBox9,
            this.textBox16});
            this.groupHeaderSection.Name = "groupHeaderSection";
            // 
            // textBox2
            // 
            this.textBox2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999989867210388D), Telerik.Reporting.Drawing.Unit.Cm(0.761458158493042D));
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.0000002384185791D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox2.Style.Font.Bold = true;
            this.textBox2.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox2.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox2.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox2.Value = "= \"Tipo\"";
            // 
            // textBox4
            // 
            this.textBox4.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(20.499691009521484D), Telerik.Reporting.Drawing.Unit.Cm(0.76145768165588379D));
            this.textBox4.Name = "textBox4";
            this.textBox4.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.299807071685791D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox4.Style.Font.Bold = true;
            this.textBox4.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox4.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox4.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox4.Value = "= \"Importe\"";
            // 
            // textBox17
            // 
            this.textBox17.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(22.799697875976562D), Telerik.Reporting.Drawing.Unit.Cm(0.761458158493042D));
            this.textBox17.Name = "textBox17";
            this.textBox17.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.6999889612197876D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox17.Style.Font.Bold = true;
            this.textBox17.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox17.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox17.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox17.Value = "= \"Fecha\"";
            // 
            // textBox28
            // 
            this.textBox28.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999989867210388D), Telerik.Reporting.Drawing.Unit.Cm(0.16145816445350647D));
            this.textBox28.Name = "textBox28";
            this.textBox28.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.0999999046325684D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox28.Style.Font.Bold = true;
            this.textBox28.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox28.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox28.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox28.Value = "=  \"MOVIMIENTOS\"";
            // 
            // textBox31
            // 
            this.textBox31.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(24.499879837036133D), Telerik.Reporting.Drawing.Unit.Cm(0.76125842332839966D));
            this.textBox31.Name = "textBox31";
            this.textBox31.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.5998034477233887D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox31.Style.Font.Bold = true;
            this.textBox31.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox31.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox31.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox31.Value = "= \"Hora\"";
            // 
            // textBox9
            // 
            this.textBox9.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.2002005577087402D), Telerik.Reporting.Drawing.Unit.Cm(0.76125842332839966D));
            this.textBox9.Name = "textBox9";
            this.textBox9.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.0999999046325684D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox9.Style.Font.Bold = true;
            this.textBox9.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox9.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox9.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox9.Value = "= \"Concepto\"";
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(1.8999999761581421D);
            this.pageHeaderSection1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox29,
            this.textBox35});
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            // 
            // textBox29
            // 
            this.textBox29.Format = "{0:dd.MM.yyyy}";
            this.textBox29.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.20000016689300537D), Telerik.Reporting.Drawing.Unit.Cm(1.0923612117767334D));
            this.textBox29.Name = "textBox29";
            this.textBox29.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(25.999998092651367D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox29.Style.Font.Bold = true;
            this.textBox29.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(11D);
            this.textBox29.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox29.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox29.Value = "=  \"Relación de Movimientos Diarios del \"+ Parameters.fechaini.Value +\" al \"+ Par" +
    "ameters.fechafin.Value";
            // 
            // textBox35
            // 
            this.textBox35.Format = "{0:dd.MM.yyyy}";
            this.textBox35.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.20000030100345612D), Telerik.Reporting.Drawing.Unit.Cm(0.49999994039535522D));
            this.textBox35.Name = "textBox35";
            this.textBox35.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(25.999998092651367D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox35.Style.Font.Bold = true;
            this.textBox35.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(11D);
            this.textBox35.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox35.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox35.Value = "= Fields.nombre";
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Cm(0.44097262620925903D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox13,
            this.textBox19,
            this.textBox1,
            this.textBox32,
            this.textBox8,
            this.textBox18});
            this.detail.Name = "detail";
            // 
            // textBox13
            // 
            this.textBox13.Format = "{0:C2}";
            this.textBox13.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(20.499691009521484D), Telerik.Reporting.Drawing.Unit.Cm(2.7125079782308603E-07D));
            this.textBox13.Name = "textBox13";
            this.textBox13.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.2998061180114746D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox13.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox13.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox13.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox13.Value = "= Fields.importe";
            // 
            // textBox19
            // 
            this.textBox19.Format = "{0:dd-MMM-yy}";
            this.textBox19.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(22.899999618530273D), Telerik.Reporting.Drawing.Unit.Cm(2.5232631983840292E-08D));
            this.textBox19.Name = "textBox19";
            this.textBox19.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.7000902891159058D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox19.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox19.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox19.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox19.Value = "= Fields.fecha";
            // 
            // textBox1
            // 
            this.textBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999989867210388D), Telerik.Reporting.Drawing.Unit.Cm(1.2616315814284462E-07D));
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox1.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox1.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox1.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox1.Value = "= Fields.tipo";
            // 
            // textBox32
            // 
            this.textBox32.Format = "{0:t}";
            this.textBox32.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(24.600286483764648D), Telerik.Reporting.Drawing.Unit.Cm(1.5139579545575543E-07D));
            this.textBox32.Name = "textBox32";
            this.textBox32.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.5998035669326782D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox32.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox32.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox32.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox32.Value = "= Fields.hora";
            // 
            // textBox8
            // 
            this.textBox8.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.2002005577087402D), Telerik.Reporting.Drawing.Unit.Cm(1.5139579545575543E-07D));
            this.textBox8.Name = "textBox8";
            this.textBox8.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(8.3997993469238281D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox8.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox8.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox8.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox8.Value = "= Fields.concepto";
            // 
            // sqlDataSource1
            // 
            this.sqlDataSource1.ConnectionString = "ReportLibrary.Properties.Settings.rendilana";
            this.sqlDataSource1.Name = "sqlDataSource1";
            this.sqlDataSource1.Parameters.AddRange(new Telerik.Reporting.SqlDataSourceParameter[] {
            new Telerik.Reporting.SqlDataSourceParameter("@idsucursal", System.Data.DbType.Int32, "= Parameters.idsucursal.Value"),
            new Telerik.Reporting.SqlDataSourceParameter("@fechaini", System.Data.DbType.String, "= Parameters.fechaini.Value"),
            new Telerik.Reporting.SqlDataSourceParameter("@fechafin", System.Data.DbType.String, "= Parameters.fechafin.Value")});
            this.sqlDataSource1.SelectCommand = resources.GetString("sqlDataSource1.SelectCommand");
            // 
            // textBox16
            // 
            this.textBox16.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(10.600199699401856D), Telerik.Reporting.Drawing.Unit.Cm(0.761458158493042D));
            this.textBox16.Name = "textBox16";
            this.textBox16.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.0999999046325684D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox16.Style.Font.Bold = true;
            this.textBox16.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox16.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox16.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox16.Value = "= \"Usuario\"";
            // 
            // textBox18
            // 
            this.textBox18.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(10.600199699401856D), Telerik.Reporting.Drawing.Unit.Cm(1.5139579545575543E-07D));
            this.textBox18.Name = "textBox18";
            this.textBox18.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.3990883827209473D), Telerik.Reporting.Drawing.Unit.Cm(0.44097232818603516D));
            this.textBox18.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox18.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox18.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox18.Value = "= Fields.usuario";
            // 
            // ReportMovDiarios
            // 
            this.DataSource = this.sqlDataSource1;
            group1.GroupFooter = this.groupFooterSection;
            group1.GroupHeader = this.groupHeaderSection;
            group1.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.fecha"));
            group1.Name = "group";
            this.Groups.AddRange(new Telerik.Reporting.Group[] {
            group1});
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.groupHeaderSection,
            this.groupFooterSection,
            this.pageHeaderSection1,
            this.detail});
            this.Name = "ReportVentas";
            this.PageSettings.ContinuousPaper = true;
            this.PageSettings.Landscape = true;
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Mm(0D), Telerik.Reporting.Drawing.Unit.Mm(0D), Telerik.Reporting.Drawing.Unit.Mm(10D), Telerik.Reporting.Drawing.Unit.Mm(0D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.Legal;
            reportParameter1.Name = "fechaini";
            reportParameter1.Value = "2018-09-26";
            reportParameter2.Name = "fechafin";
            reportParameter2.Value = "2018-10-26";
            reportParameter3.Name = "idsucursal";
            reportParameter3.Type = Telerik.Reporting.ReportParameterType.Integer;
            reportParameter3.Value = "1";
            this.ReportParameters.Add(reportParameter1);
            this.ReportParameters.Add(reportParameter2);
            this.ReportParameters.Add(reportParameter3);
            this.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            styleRule1.Selectors.AddRange(new Telerik.Reporting.Drawing.ISelector[] {
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.TextItemBase)),
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.HtmlTextBox))});
            styleRule1.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2D);
            styleRule1.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.StyleSheet.AddRange(new Telerik.Reporting.Drawing.StyleRule[] {
            styleRule1});
            this.Width = Telerik.Reporting.Drawing.Unit.Cm(26.200092315673828D);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private Telerik.Reporting.PageHeaderSection pageHeaderSection1;
        private Telerik.Reporting.DetailSection detail;
        private Telerik.Reporting.SqlDataSource sqlDataSource1;
        private Telerik.Reporting.TextBox textBox13;
        private Telerik.Reporting.TextBox textBox19;
        private Telerik.Reporting.TextBox textBox1;
        private Telerik.Reporting.TextBox textBox29;
        private Telerik.Reporting.TextBox textBox32;
        private Telerik.Reporting.TextBox textBox35;
        private Telerik.Reporting.TextBox textBox8;
        private Telerik.Reporting.TextBox textBox24;
        private Telerik.Reporting.GroupFooterSection groupFooterSection;
        private Telerik.Reporting.TextBox textBox9;
        private Telerik.Reporting.TextBox textBox31;
        private Telerik.Reporting.TextBox textBox28;
        private Telerik.Reporting.TextBox textBox17;
        private Telerik.Reporting.TextBox textBox4;
        private Telerik.Reporting.TextBox textBox2;
        private Telerik.Reporting.GroupHeaderSection groupHeaderSection;
        private Telerik.Reporting.TextBox textBox16;
        private Telerik.Reporting.TextBox textBox18;
    }
}