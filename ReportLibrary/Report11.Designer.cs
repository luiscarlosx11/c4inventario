namespace Telerik.Reporting.Examples.CSharp
{
    partial class Report11
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
            this.detail = new Telerik.Reporting.DetailSection();
            this.list1 = new Telerik.Reporting.List();
            this.panel1 = new Telerik.Reporting.Panel();
            this.textBox1 = new Telerik.Reporting.TextBox();
            this.objectDataSource1 = new Telerik.Reporting.ObjectDataSource();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Inch(2D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.list1});
            this.detail.Name = "detail";
            // 
            // list1
            // 
            this.list1.Body.Columns.Add(new Telerik.Reporting.TableBodyColumn(Telerik.Reporting.Drawing.Unit.Inch(1.302D)));
            this.list1.Body.Rows.Add(new Telerik.Reporting.TableBodyRow(Telerik.Reporting.Drawing.Unit.Inch(0.344D)));
            this.list1.Body.SetCellContent(0, 0, this.panel1);
            tableGroup1.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.Index%3"));
            tableGroup1.Name = "ColumnGroup1";
            this.list1.ColumnGroups.Add(tableGroup1);
            this.list1.DataSource = this.objectDataSource1;
            this.list1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.panel1});
            this.list1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0D), Telerik.Reporting.Drawing.Unit.Inch(0D));
            this.list1.Name = "list1";
            tableGroup2.Groupings.Add(new Telerik.Reporting.Grouping("= Fields.Index/3"));
            tableGroup2.Name = "RowGroup1";
            this.list1.RowGroups.Add(tableGroup2);
            this.list1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.302D), Telerik.Reporting.Drawing.Unit.Inch(0.344D));
            // 
            // panel1
            // 
            this.panel1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox1});
            this.panel1.Name = "panel1";
            this.panel1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(1.302D), Telerik.Reporting.Drawing.Unit.Inch(0.344D));
            // 
            // textBox1
            // 
            this.textBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Inch(0.3D), Telerik.Reporting.Drawing.Unit.Inch(0.1D));
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Inch(0.881D), Telerik.Reporting.Drawing.Unit.Inch(0.2D));
            this.textBox1.Value = "= Fields.Data";
            // 
            // objectDataSource1
            // 
            this.objectDataSource1.Name = "objectDataSource1";
            // 
            // Report11
            // 
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.detail});
            this.Name = "Report11";
            this.PageSettings.Landscape = false;
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D), Telerik.Reporting.Drawing.Unit.Inch(1D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.Letter;
            this.Style.BackgroundColor = System.Drawing.Color.White;
            this.Width = Telerik.Reporting.Drawing.Unit.Cm(17D);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private Telerik.Reporting.DetailSection detail;
        private List list1;
        private Panel panel1;
        private TextBox textBox1;
        private ObjectDataSource objectDataSource1;
    }
}