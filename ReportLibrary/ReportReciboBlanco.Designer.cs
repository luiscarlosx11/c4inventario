namespace ReportLibrary
{
    partial class ReciboBlanco
    {
        #region Component Designer generated code
        /// <summary>
        /// Required method for telerik Reporting designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ReciboBlanco));
            Telerik.Reporting.ReportParameter reportParameter1 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.ReportParameter reportParameter2 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.Drawing.StyleRule styleRule1 = new Telerik.Reporting.Drawing.StyleRule();
            this.generales = new Telerik.Reporting.SqlDataSource();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.panel2 = new Telerik.Reporting.Panel();
            this.detail = new Telerik.Reporting.DetailSection();
            this.panel5 = new Telerik.Reporting.Panel();
            this.textBox25 = new Telerik.Reporting.TextBox();
            this.textBox12 = new Telerik.Reporting.TextBox();
            this.textBox13 = new Telerik.Reporting.TextBox();
            this.textBox14 = new Telerik.Reporting.TextBox();
            this.textBox15 = new Telerik.Reporting.TextBox();
            this.textBox16 = new Telerik.Reporting.TextBox();
            this.textBox17 = new Telerik.Reporting.TextBox();
            this.textBox18 = new Telerik.Reporting.TextBox();
            this.textBox19 = new Telerik.Reporting.TextBox();
            this.textBox20 = new Telerik.Reporting.TextBox();
            this.textBox21 = new Telerik.Reporting.TextBox();
            this.textBox22 = new Telerik.Reporting.TextBox();
            this.textBox24 = new Telerik.Reporting.TextBox();
            this.textBox70 = new Telerik.Reporting.TextBox();
            this.textBox28 = new Telerik.Reporting.TextBox();
            this.textBox30 = new Telerik.Reporting.TextBox();
            this.textBox32 = new Telerik.Reporting.TextBox();
            this.textBox37 = new Telerik.Reporting.TextBox();
            this.panel3 = new Telerik.Reporting.Panel();
            this.textBox39 = new Telerik.Reporting.TextBox();
            this.pageFooterSection1 = new Telerik.Reporting.PageFooterSection();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // generales
            // 
            this.generales.ConnectionString = "ReportLibrary.Properties.Settings.icaten";
            this.generales.Name = "generales";
            this.generales.Parameters.Add(new Telerik.Reporting.SqlDataSourceParameter("@idsolicitud", System.Data.DbType.Int32, "= Parameters.idsolicitud.Value"));
            this.generales.Parameters.Add(new Telerik.Reporting.SqlDataSourceParameter("@idpago", System.Data.DbType.Int32, "= Parameters.idpago.Value"));
            this.generales.SelectCommand = resources.GetString("generales.SelectCommand");
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.132D);
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            this.pageHeaderSection1.PrintOnLastPage = true;
            // 
            // panel2
            // 
            this.panel2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.551D), Telerik.Reporting.Drawing.Unit.Cm(3.068D));
            this.panel2.Name = "panel2";
            this.panel2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.2D), Telerik.Reporting.Drawing.Unit.Cm(0.541D));
            this.panel2.Style.BorderColor.Default = System.Drawing.Color.DimGray;
            this.panel2.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.None;
            this.panel2.Style.Color = System.Drawing.Color.DimGray;
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Cm(13.368D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.panel5,
            this.panel2,
            this.panel3});
            this.detail.Name = "detail";
            this.detail.Style.BackgroundImage.MimeType = "";
            this.detail.Style.BackgroundImage.Repeat = Telerik.Reporting.Drawing.BackgroundRepeat.NoRepeat;
            this.detail.Style.BorderColor.Default = System.Drawing.Color.Gray;
            this.detail.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.None;
            // 
            // panel5
            // 
            this.panel5.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox25,
            this.textBox12,
            this.textBox13,
            this.textBox14,
            this.textBox15,
            this.textBox16,
            this.textBox17,
            this.textBox18,
            this.textBox19,
            this.textBox20,
            this.textBox21,
            this.textBox22,
            this.textBox24,
            this.textBox70,
            this.textBox28,
            this.textBox30,
            this.textBox32,
            this.textBox37});
            this.panel5.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.451D), Telerik.Reporting.Drawing.Unit.Cm(3.868D));
            this.panel5.Name = "panel5";
            this.panel5.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(20.651D), Telerik.Reporting.Drawing.Unit.Cm(8.968D));
            this.panel5.Style.BackgroundImage.MimeType = "";
            this.panel5.Style.BorderColor.Default = System.Drawing.Color.Gray;
            this.panel5.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.None;
            // 
            // textBox25
            // 
            this.textBox25.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.2D), Telerik.Reporting.Drawing.Unit.Cm(8.309D));
            this.textBox25.Name = "textBox25";
            this.textBox25.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(20.149D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox25.Style.Font.Bold = false;
            this.textBox25.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox25.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox25.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox25.Value = "= Fields.telefono";
            // 
            // textBox12
            // 
            this.textBox12.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(4.075D), Telerik.Reporting.Drawing.Unit.Cm(0.318D));
            this.textBox12.Name = "textBox12";
            this.textBox12.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(16.263D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox12.Style.Font.Bold = false;
            this.textBox12.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox12.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox12.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox12.Value = "= Fields.alumno";
            // 
            // textBox13
            // 
            this.textBox13.Format = "{0:C2}";
            this.textBox13.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(4.075D), Telerik.Reporting.Drawing.Unit.Cm(1.118D));
            this.textBox13.Name = "textBox13";
            this.textBox13.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.5D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox13.Style.Font.Bold = false;
            this.textBox13.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox13.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox13.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox13.Value = "= Fields.importe";
            // 
            // textBox14
            // 
            this.textBox14.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(4.075D), Telerik.Reporting.Drawing.Unit.Cm(1.918D));
            this.textBox14.Name = "textBox14";
            this.textBox14.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(16.252D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox14.Style.Font.Bold = false;
            this.textBox14.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox14.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox14.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox14.Value = "= Fields.concepto + \" CURSO \" + Fields.nombrecurso ";
            // 
            // textBox15
            // 
            this.textBox15.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(3.149D), Telerik.Reporting.Drawing.Unit.Cm(2.718D));
            this.textBox15.Name = "textBox15";
            this.textBox15.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.199D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox15.Style.Font.Bold = false;
            this.textBox15.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox15.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox15.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox15.Value = "= Fields.diaini";
            // 
            // textBox16
            // 
            this.textBox16.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(5.849D), Telerik.Reporting.Drawing.Unit.Cm(2.718D));
            this.textBox16.Name = "textBox16";
            this.textBox16.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox16.Style.Font.Bold = false;
            this.textBox16.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox16.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox16.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox16.Value = "= Fields.mesini";
            // 
            // textBox17
            // 
            this.textBox17.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(10.049D), Telerik.Reporting.Drawing.Unit.Cm(2.718D));
            this.textBox17.Name = "textBox17";
            this.textBox17.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.399D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox17.Style.Font.Bold = false;
            this.textBox17.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox17.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox17.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox17.Value = "= Fields.anioini";
            // 
            // textBox18
            // 
            this.textBox18.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(12.649D), Telerik.Reporting.Drawing.Unit.Cm(2.718D));
            this.textBox18.Name = "textBox18";
            this.textBox18.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.199D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox18.Style.Font.Bold = false;
            this.textBox18.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox18.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox18.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox18.Value = "= Fields.diafin";
            // 
            // textBox19
            // 
            this.textBox19.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(14.949D), Telerik.Reporting.Drawing.Unit.Cm(2.718D));
            this.textBox19.Name = "textBox19";
            this.textBox19.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox19.Style.Font.Bold = false;
            this.textBox19.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox19.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox19.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox19.Value = "= Fields.mesfin";
            // 
            // textBox20
            // 
            this.textBox20.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(19.139D), Telerik.Reporting.Drawing.Unit.Cm(2.7D));
            this.textBox20.Name = "textBox20";
            this.textBox20.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.199D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox20.Style.Font.Bold = false;
            this.textBox20.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox20.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox20.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox20.Value = "= Fields.aniofin";
            // 
            // textBox21
            // 
            this.textBox21.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(5.6D), Telerik.Reporting.Drawing.Unit.Cm(3.618D));
            this.textBox21.Name = "textBox21";
            this.textBox21.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(14.749D), Telerik.Reporting.Drawing.Unit.Cm(1.382D));
            this.textBox21.Style.Font.Bold = false;
            this.textBox21.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox21.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox21.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Top;
            this.textBox21.Value = "= Fields.observaciones";
            // 
            // textBox22
            // 
            this.textBox22.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.2D), Telerik.Reporting.Drawing.Unit.Cm(7.427D));
            this.textBox22.Name = "textBox22";
            this.textBox22.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(20.149D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox22.Style.Font.Bold = true;
            this.textBox22.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(11D);
            this.textBox22.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox22.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox22.Value = "= Fields.nombresucursal";
            // 
            // textBox24
            // 
            this.textBox24.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.2D), Telerik.Reporting.Drawing.Unit.Cm(7.868D));
            this.textBox24.Name = "textBox24";
            this.textBox24.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(20.149D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox24.Style.Font.Bold = false;
            this.textBox24.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox24.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox24.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox24.Value = "= Fields.direccion";
            // 
            // textBox70
            // 
            this.textBox70.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.2D), Telerik.Reporting.Drawing.Unit.Cm(5.818D));
            this.textBox70.Name = "textBox70";
            this.textBox70.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(0.661D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox70.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox70.StyleName = "";
            this.textBox70.Value = "= Fields.idtipocurso.toString().Equals(\"3\")?\"X\":\"  \"";
            // 
            // textBox28
            // 
            this.textBox28.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(3.3D), Telerik.Reporting.Drawing.Unit.Cm(5.818D));
            this.textBox28.Name = "textBox28";
            this.textBox28.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(0.661D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox28.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox28.StyleName = "";
            this.textBox28.Value = "= Fields.idtipocurso.toString().Equals(\"3\")?\"X\":\"  \"";
            // 
            // textBox30
            // 
            this.textBox30.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.2D), Telerik.Reporting.Drawing.Unit.Cm(6.418D));
            this.textBox30.Name = "textBox30";
            this.textBox30.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(0.661D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox30.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox30.StyleName = "";
            this.textBox30.Value = "= Fields.idtipocurso.toString().Equals(\"1\")?\"X\":\"  \"";
            // 
            // textBox32
            // 
            this.textBox32.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(3.3D), Telerik.Reporting.Drawing.Unit.Cm(6.405D));
            this.textBox32.Name = "textBox32";
            this.textBox32.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(0.661D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox32.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(9D);
            this.textBox32.StyleName = "";
            this.textBox32.Value = "= Fields.idtipocurso.toString().Equals(\"2\")?\"X\":\"  \"";
            // 
            // textBox37
            // 
            this.textBox37.Format = "{0:C2}";
            this.textBox37.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(7.027D), Telerik.Reporting.Drawing.Unit.Cm(1.118D));
            this.textBox37.Name = "textBox37";
            this.textBox37.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(12.992D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox37.Style.Font.Bold = false;
            this.textBox37.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(10D);
            this.textBox37.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox37.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox37.Value = "= ReportLibrary.cs.conversion.enletras(Fields.importe.toString(), 1)+\"M.N.\"";
            // 
            // panel3
            // 
            this.panel3.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox39});
            this.panel3.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(17D), Telerik.Reporting.Drawing.Unit.Cm(3.068D));
            this.panel3.Name = "panel3";
            this.panel3.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.203D), Telerik.Reporting.Drawing.Unit.Cm(0.525D));
            this.panel3.Style.BorderColor.Default = System.Drawing.Color.DimGray;
            this.panel3.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.None;
            this.panel3.Style.Color = System.Drawing.Color.DimGray;
            // 
            // textBox39
            // 
            this.textBox39.Format = "{0:dd  -  MM  -  yyyy}";
            this.textBox39.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.097D), Telerik.Reporting.Drawing.Unit.Cm(0.042D));
            this.textBox39.Name = "textBox39";
            this.textBox39.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.003D), Telerik.Reporting.Drawing.Unit.Cm(0.441D));
            this.textBox39.Style.Font.Bold = false;
            this.textBox39.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox39.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox39.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox39.Value = "= Fields.fecha";
            // 
            // pageFooterSection1
            // 
            this.pageFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.2D);
            this.pageFooterSection1.Name = "pageFooterSection1";
            this.pageFooterSection1.PrintOnFirstPage = false;
            this.pageFooterSection1.PrintOnLastPage = true;
            // 
            // ReciboBlanco
            // 
            this.DataSource = this.generales;
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.pageHeaderSection1,
            this.detail,
            this.pageFooterSection1});
            this.Name = "ReciboBlanco";
            this.PageSettings.BackgroundImage.MimeType = "";
            this.PageSettings.BackgroundImage.Repeat = Telerik.Reporting.Drawing.BackgroundRepeat.NoRepeat;
            this.PageSettings.ContinuousPaper = false;
            this.PageSettings.Landscape = false;
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Mm(0D), Telerik.Reporting.Drawing.Unit.Mm(0D), Telerik.Reporting.Drawing.Unit.Mm(10D), Telerik.Reporting.Drawing.Unit.Mm(0D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.Letter;
            reportParameter1.Name = "idsolicitud";
            reportParameter1.Type = Telerik.Reporting.ReportParameterType.Integer;
            reportParameter1.Value = "305";
            reportParameter2.Name = "idpago";
            reportParameter2.Type = Telerik.Reporting.ReportParameterType.Integer;
            reportParameter2.Value = "5";
            this.ReportParameters.Add(reportParameter1);
            this.ReportParameters.Add(reportParameter2);
            this.Style.BackgroundImage.MimeType = "";
            this.Style.BackgroundImage.Repeat = Telerik.Reporting.Drawing.BackgroundRepeat.NoRepeat;
            this.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            styleRule1.Selectors.AddRange(new Telerik.Reporting.Drawing.ISelector[] {
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.TextItemBase)),
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.HtmlTextBox))});
            styleRule1.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2D);
            styleRule1.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.StyleSheet.AddRange(new Telerik.Reporting.Drawing.StyleRule[] {
            styleRule1});
            this.Width = Telerik.Reporting.Drawing.Unit.Cm(21.59D);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private Telerik.Reporting.PageHeaderSection pageHeaderSection1;
        private Telerik.Reporting.DetailSection detail;
        private Telerik.Reporting.SqlDataSource generales;
        private Telerik.Reporting.PageFooterSection pageFooterSection1;
        private Telerik.Reporting.TextBox textBox12;
        private Telerik.Reporting.TextBox textBox13;
        private Telerik.Reporting.TextBox textBox14;
        private Telerik.Reporting.TextBox textBox15;
        private Telerik.Reporting.TextBox textBox16;
        private Telerik.Reporting.TextBox textBox17;
        private Telerik.Reporting.TextBox textBox18;
        private Telerik.Reporting.TextBox textBox19;
        private Telerik.Reporting.TextBox textBox20;
        private Telerik.Reporting.TextBox textBox21;
        private Telerik.Reporting.TextBox textBox22;
        private Telerik.Reporting.TextBox textBox24;
        private Telerik.Reporting.TextBox textBox25;
        private Telerik.Reporting.TextBox textBox70;
        private Telerik.Reporting.TextBox textBox28;
        private Telerik.Reporting.TextBox textBox30;
        private Telerik.Reporting.TextBox textBox32;
        private Telerik.Reporting.Panel panel2;
        private Telerik.Reporting.TextBox textBox37;
        private Telerik.Reporting.Panel panel5;
        private Telerik.Reporting.Panel panel3;
        private Telerik.Reporting.TextBox textBox39;
    }
}