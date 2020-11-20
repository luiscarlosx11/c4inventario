namespace ReportLibrary
{
    partial class SubReportDocumentacion
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SubReportDocumentacion));
            Telerik.Reporting.ReportParameter reportParameter1 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.Drawing.StyleRule styleRule1 = new Telerik.Reporting.Drawing.StyleRule();
            this.textBox70 = new Telerik.Reporting.TextBox();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.detail = new Telerik.Reporting.DetailSection();
            this.table2 = new Telerik.Reporting.Table();
            this.textBox69 = new Telerik.Reporting.TextBox();
            this.motivo = new Telerik.Reporting.SqlDataSource();
            this.pageFooterSection1 = new Telerik.Reporting.PageFooterSection();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // textBox70
            // 
            this.textBox70.Name = "textBox70";
            this.textBox70.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(0.66145867109298706D), Telerik.Reporting.Drawing.Unit.Cm(0.39999991655349731D));
            this.textBox70.StyleName = "";
            this.textBox70.Value = "= Fields.entregado.toString().Equals(\"1\")?\"(X)\":\"(  )\"";
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.13229171931743622D);
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Cm(0.86770844459533691D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.table2});
            this.detail.Name = "detail";
            // 
            // table2
            // 
            this.table2.Anchoring = Telerik.Reporting.AnchoringStyles.None;
            this.table2.Body.Columns.Add(new Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Cm(9.1702098846435547D)));
            this.table2.Body.Rows.Add(new Telerik.Reporting.TableBodyRow(Telerik.Reporting.Drawing.Unit.Cm(0.39999991655349731D)));
            this.table2.Body.SetCellContent(0, 0, this.textBox69);
            tableGroup1.Name = "group";
            this.table2.ColumnGroups.Add(tableGroup1);
            this.table2.DataSource = this.motivo;
            this.table2.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox69,
            this.textBox70});
            this.table2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.30000004172325134D), Telerik.Reporting.Drawing.Unit.Cm(0.26770833134651184D));
            this.table2.Name = "table2";
            tableGroup3.Name = "detailTableGroup";
            tableGroup2.ChildGroups.Add(tableGroup3);
            tableGroup2.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.documentacion"));
            tableGroup2.Name = "documentacion1";
            tableGroup2.ReportItem = this.textBox70;
            tableGroup2.Sortings.Add(new Telerik.Reporting.Sorting("= Fields.iddocumentacion", Telerik.Reporting.SortDirection.Asc));
            this.table2.RowGroups.Add(tableGroup2);
            this.table2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(9.8316688537597656D), Telerik.Reporting.Drawing.Unit.Cm(0.39999991655349731D));
            this.table2.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            // 
            // textBox69
            // 
            this.textBox69.Name = "textBox69";
            this.textBox69.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(9.1702108383178711D), Telerik.Reporting.Drawing.Unit.Cm(0.39999991655349731D));
            this.textBox69.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox69.StyleName = "";
            this.textBox69.Value = "= Fields.documentacion";
            // 
            // motivo
            // 
            this.motivo.ConnectionString = "ReportLibrary.Properties.Settings.icaten";
            this.motivo.Name = "motivo";
            this.motivo.Parameters.AddRange(new Telerik.Reporting.SqlDataSourceParameter[] {
            new Telerik.Reporting.SqlDataSourceParameter("@idsolicitud", System.Data.DbType.String, "= Parameters.idsolicitud.Value")});
            this.motivo.SelectCommand = resources.GetString("motivo.SelectCommand");
            // 
            // pageFooterSection1
            // 
            this.pageFooterSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.13229171931743622D);
            this.pageFooterSection1.Name = "pageFooterSection1";
            // 
            // SubReportDocumentacion
            // 
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.pageHeaderSection1,
            this.detail,
            this.pageFooterSection1});
            this.Name = "Report2";
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Mm(25.399999618530273D), Telerik.Reporting.Drawing.Unit.Mm(25.399999618530273D), Telerik.Reporting.Drawing.Unit.Mm(25.399999618530273D), Telerik.Reporting.Drawing.Unit.Mm(25.399999618530273D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.A4;
            reportParameter1.Name = "idsolicitud";
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
        private Telerik.Reporting.TextBox textBox69;
        private Telerik.Reporting.SqlDataSource motivo;
        private Telerik.Reporting.TextBox textBox70;
    }
}