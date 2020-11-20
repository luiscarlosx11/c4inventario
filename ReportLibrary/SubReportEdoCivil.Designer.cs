namespace ReportLibrary
{
    partial class SubReportEdoCivil
    {
        #region Component Designer generated code
        /// <summary>
        /// Required method for telerik Reporting designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Telerik.Reporting.TableGroup tableGroup1 = new Telerik.Reporting.TableGroup();
            Telerik.Reporting.TableGroup tableGroup2 = new Telerik.Reporting.TableGroup();
            Telerik.Reporting.TableGroup tableGroup3 = new Telerik.Reporting.TableGroup();
            Telerik.Reporting.TableGroup tableGroup4 = new Telerik.Reporting.TableGroup();
            Telerik.Reporting.ReportParameter reportParameter1 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.Drawing.StyleRule styleRule1 = new Telerik.Reporting.Drawing.StyleRule();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.detail = new Telerik.Reporting.DetailSection();
            this.table2 = new Telerik.Reporting.Table();
            this.textBox37 = new Telerik.Reporting.TextBox();
            this.textBox2 = new Telerik.Reporting.TextBox();
            this.discapacidad = new Telerik.Reporting.SqlDataSource();
            this.pageFooterSection1 = new Telerik.Reporting.PageFooterSection();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.13229171931743622D);
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Cm(0.62604188919067383D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.table2});
            this.detail.Name = "detail";
            // 
            // table2
            // 
            this.table2.Anchoring = ((Telerik.Reporting.AnchoringStyles)(((Telerik.Reporting.AnchoringStyles.Top | Telerik.Reporting.AnchoringStyles.Bottom) 
            | Telerik.Reporting.AnchoringStyles.Left)));
            this.table2.Body.Columns.Add(new Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Cm(2.299863338470459D)));
            this.table2.Body.Columns.Add(new Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Cm(0.83583354949951172D)));
            this.table2.Body.Rows.Add(new Telerik.Reporting.TableBodyRow(Telerik.Reporting.Drawing.Unit.Cm(0.26458331942558289D)));
            this.table2.Body.SetCellContent(0, 0, this.textBox37);
            this.table2.Body.SetCellContent(0, 1, this.textBox2);
            tableGroup2.Name = "group";
            tableGroup3.Name = "group2";
            tableGroup1.ChildGroups.Add(tableGroup2);
            tableGroup1.ChildGroups.Add(tableGroup3);
            tableGroup1.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.edocivil"));
            tableGroup1.Name = "discapacidad1";
            tableGroup1.Sortings.Add(new Telerik.Reporting.Sorting("= Fields.idedocivil", Telerik.Reporting.SortDirection.Asc));
            this.table2.ColumnGroups.Add(tableGroup1);
            this.table2.DataSource = this.discapacidad;
            this.table2.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox37,
            this.textBox2});
            this.table2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999989867210388D), Telerik.Reporting.Drawing.Unit.Cm(0.1677083820104599D));
            this.table2.Name = "table2";
            tableGroup4.Name = "detailTableGroup";
            this.table2.RowGroups.Add(tableGroup4);
            this.table2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3.1356968879699707D), Telerik.Reporting.Drawing.Unit.Cm(0.26458331942558289D));
            // 
            // textBox37
            // 
            this.textBox37.Name = "textBox37";
            this.textBox37.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.299863338470459D), Telerik.Reporting.Drawing.Unit.Cm(0.26458331942558289D));
            this.textBox37.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox37.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Right;
            this.textBox37.StyleName = "";
            this.textBox37.Value = "= Fields.edocivil";
            // 
            // textBox2
            // 
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(0.83583354949951172D), Telerik.Reporting.Drawing.Unit.Cm(0.26458331942558289D));
            this.textBox2.StyleName = "";
            this.textBox2.Value = "= Fields.entregado.toString().Equals(\"1\")?\"(X)\":\"(  )\"";
            // 
            // discapacidad
            // 
            this.discapacidad.ConnectionString = "ReportLibrary.Properties.Settings.icaten";
            this.discapacidad.Name = "discapacidad";
            this.discapacidad.Parameters.AddRange(new Telerik.Reporting.SqlDataSourceParameter[] {
            new Telerik.Reporting.SqlDataSourceParameter("@idalumno", System.Data.DbType.String, "= Parameters.idalumno.Value")});
            this.discapacidad.SelectCommand = "select d.idedocivil,d.edocivil,\r\n(\r\nselect count(cd.idedocivil)\r\nfrom alumno cd\r\n" +
    "where cd.idalumno = @idalumno\r\nand cd.idedocivil = d.idedocivil\r\n)as entregado\r\n" +
    "from edocivil d\r\norder by d.idedocivil";
            // 
            // pageFooterSection1
            // 
            this.pageFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.13229171931743622D);
            this.pageFooterSection1.Name = "pageFooterSection1";
            // 
            // SubReportEdoCivil
            // 
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.pageHeaderSection1,
            this.detail,
            this.pageFooterSection1});
            this.Name = "Report2";
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Mm(25.399999618530273D), Telerik.Reporting.Drawing.Unit.Mm(25.399999618530273D), Telerik.Reporting.Drawing.Unit.Mm(25.399999618530273D), Telerik.Reporting.Drawing.Unit.Mm(25.399999618530273D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.A4;
            reportParameter1.Name = "idalumno";
            reportParameter1.Type = Telerik.Reporting.ReportParameterType.Integer;
            reportParameter1.Value = "1";
            this.ReportParameters.Add(reportParameter1);
            styleRule1.Selectors.AddRange(new Telerik.Reporting.Drawing.ISelector[] {
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.TextItemBase)),
            new Telerik.Reporting.Drawing.TypeSelector(typeof(Telerik.Reporting.HtmlTextBox))});
            styleRule1.Style.Padding.Left = Telerik.Reporting.Drawing.Unit.Point(2D);
            styleRule1.Style.Padding.Right = Telerik.Reporting.Drawing.Unit.Point(2D);
            this.StyleSheet.AddRange(new Telerik.Reporting.Drawing.StyleRule[] {
            styleRule1});
            this.Width = Telerik.Reporting.Drawing.Unit.Cm(15D);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private Telerik.Reporting.PageHeaderSection pageHeaderSection1;
        private Telerik.Reporting.DetailSection detail;
        private Telerik.Reporting.PageFooterSection pageFooterSection1;
        private Telerik.Reporting.Table table2;
        private Telerik.Reporting.TextBox textBox37;
        private Telerik.Reporting.SqlDataSource discapacidad;
        private Telerik.Reporting.TextBox textBox2;
    }
}