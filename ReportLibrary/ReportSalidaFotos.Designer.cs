namespace ReportLibrary
{
    partial class SalidaFotos
    {
        #region Component Designer generated code
        /// <summary>
        /// Required method for telerik Reporting designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SalidaFotos));
            Telerik.Reporting.Group group1 = new Telerik.Reporting.Group();
            Telerik.Reporting.ReportParameter reportParameter1 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.Drawing.StyleRule styleRule1 = new Telerik.Reporting.Drawing.StyleRule();
            this.groupFooterSection = new Telerik.Reporting.GroupFooterSection();
            this.groupHeaderSection = new Telerik.Reporting.GroupHeaderSection();
            this.alumnos = new Telerik.Reporting.SqlDataSource();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.detail = new Telerik.Reporting.DetailSection();
            this.pageFooterSection1 = new Telerik.Reporting.PageFooterSection();
            this.reportHeaderSection1 = new Telerik.Reporting.ReportHeaderSection();
            this.generales = new Telerik.Reporting.SqlDataSource();
            this.panel1 = new Telerik.Reporting.Panel();
            this.textBox1 = new Telerik.Reporting.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // groupFooterSection
            // 
            this.groupFooterSection.Height = Telerik.Reporting.Drawing.Unit.Cm(0.3D);
            this.groupFooterSection.Name = "groupFooterSection";
            this.groupFooterSection.PrintAtBottom = false;
            // 
            // groupHeaderSection
            // 
            this.groupHeaderSection.Height = Telerik.Reporting.Drawing.Unit.Cm(0.5D);
            this.groupHeaderSection.Name = "groupHeaderSection";
            this.groupHeaderSection.Style.BackgroundColor = System.Drawing.Color.Transparent;
            this.groupHeaderSection.Style.BorderColor.Default = System.Drawing.Color.Gray;
            this.groupHeaderSection.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.None;
            // 
            // alumnos
            // 
            this.alumnos.ConnectionString = "ReportLibrary.Properties.Settings.icaten";
            this.alumnos.Name = "alumnos";
            this.alumnos.Parameters.Add(new Telerik.Reporting.SqlDataSourceParameter("@idsalida", System.Data.DbType.String, "= Parameters.idsalida.Value"));
            this.alumnos.SelectCommand = resources.GetString("alumnos.SelectCommand");
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.3D);
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            this.pageHeaderSection1.PrintOnLastPage = true;
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Cm(5.401D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.panel1});
            this.detail.Name = "detail";
            this.detail.Style.BorderColor.Default = System.Drawing.Color.Gray;
            this.detail.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.None;
            // 
            // pageFooterSection1
            // 
            this.pageFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.4D);
            this.pageFooterSection1.Name = "pageFooterSection1";
            this.pageFooterSection1.PrintOnFirstPage = true;
            this.pageFooterSection1.PrintOnLastPage = true;
            // 
            // reportHeaderSection1
            // 
            this.reportHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0D);
            this.reportHeaderSection1.Name = "reportHeaderSection1";
            this.reportHeaderSection1.Style.Visible = true;
            // 
            // generales
            // 
            this.generales.ConnectionString = "ReportLibrary.Properties.Settings.icaten";
            this.generales.Name = "generales";
            this.generales.Parameters.Add(new Telerik.Reporting.SqlDataSourceParameter("@idsalida", System.Data.DbType.Int32, "= Parameters.idsalida.Value"));
            this.generales.SelectCommand = resources.GetString("generales.SelectCommand");
            // 
            // panel1
            // 
            this.panel1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox1});
            this.panel1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0D), Telerik.Reporting.Drawing.Unit.Cm(0D));
            this.panel1.Name = "panel1";
            this.panel1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.302D), Telerik.Reporting.Drawing.Unit.Inch(0.344D));
            // 
            // textBox1
            // 
            this.textBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.3D), Telerik.Reporting.Drawing.Unit.Inch(0.1D));
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.7D), Telerik.Reporting.Drawing.Unit.Inch(0.2D));
            this.textBox1.Value = "= Fields.Data";
            // 
            // SalidaFotos
            // 
            this.DataSource = this.generales;
            group1.GroupFooter = this.groupFooterSection;
            group1.GroupHeader = this.groupHeaderSection;
            group1.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.idsalida"));
            group1.Name = "groupcurso";
            this.Groups.AddRange(new Telerik.Reporting.Group[] {
            group1});
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.groupHeaderSection,
            this.groupFooterSection,
            this.pageHeaderSection1,
            this.detail,
            this.pageFooterSection1,
            this.reportHeaderSection1});
            this.Name = "SalidaFotos";
            this.PageSettings.BackgroundImage.MimeType = "";
            this.PageSettings.BackgroundImage.Repeat = Telerik.Reporting.Drawing.BackgroundRepeat.NoRepeat;
            this.PageSettings.ContinuousPaper = false;
            this.PageSettings.Landscape = false;
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Mm(0D), Telerik.Reporting.Drawing.Unit.Mm(0D), Telerik.Reporting.Drawing.Unit.Mm(10D), Telerik.Reporting.Drawing.Unit.Mm(0D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.Letter;
            reportParameter1.Name = "idsalida";
            reportParameter1.Type = Telerik.Reporting.ReportParameterType.Integer;
            reportParameter1.Value = "1";
            this.ReportParameters.Add(reportParameter1);
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
        private Telerik.Reporting.SqlDataSource alumnos;
        private Telerik.Reporting.GroupHeaderSection groupHeaderSection;
        private Telerik.Reporting.GroupFooterSection groupFooterSection;
        private Telerik.Reporting.PageFooterSection pageFooterSection1;
        private Telerik.Reporting.ReportHeaderSection reportHeaderSection1;
        private Telerik.Reporting.SqlDataSource generales;
        private Telerik.Reporting.Panel panel1;
        private Telerik.Reporting.TextBox textBox1;
    }
}