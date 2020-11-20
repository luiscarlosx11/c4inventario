namespace ReportLibrary
{
    partial class Credencial
    {
        #region Component Designer generated code
        /// <summary>
        /// Required method for telerik Reporting designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Credencial));
            Telerik.Reporting.ReportParameter reportParameter1 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.ReportParameter reportParameter2 = new Telerik.Reporting.ReportParameter();
            Telerik.Reporting.Drawing.StyleRule styleRule1 = new Telerik.Reporting.Drawing.StyleRule();
            this.generales = new Telerik.Reporting.SqlDataSource();
            this.pageHeaderSection1 = new Telerik.Reporting.PageHeaderSection();
            this.detail = new Telerik.Reporting.DetailSection();
            this.panel1 = new Telerik.Reporting.Panel();
            this.textBox23 = new Telerik.Reporting.TextBox();
            this.shape1 = new Telerik.Reporting.Shape();
            this.textBox33 = new Telerik.Reporting.TextBox();
            this.textBox34 = new Telerik.Reporting.TextBox();
            this.textBox35 = new Telerik.Reporting.TextBox();
            this.textBox36 = new Telerik.Reporting.TextBox();
            this.pictureBox1 = new Telerik.Reporting.PictureBox();
            this.textBox1 = new Telerik.Reporting.TextBox();
            this.pictureBox2 = new Telerik.Reporting.PictureBox();
            this.pictureBox3 = new Telerik.Reporting.PictureBox();
            this.textBox2 = new Telerik.Reporting.TextBox();
            this.shape2 = new Telerik.Reporting.Shape();
            this.shape3 = new Telerik.Reporting.Shape();
            this.textBox3 = new Telerik.Reporting.TextBox();
            this.shape4 = new Telerik.Reporting.Shape();
            this.textBox4 = new Telerik.Reporting.TextBox();
            this.textBox5 = new Telerik.Reporting.TextBox();
            this.textBox6 = new Telerik.Reporting.TextBox();
            this.textBox7 = new Telerik.Reporting.TextBox();
            this.panel2 = new Telerik.Reporting.Panel();
            this.pictureBox4 = new Telerik.Reporting.PictureBox();
            this.textBox8 = new Telerik.Reporting.TextBox();
            this.textBox9 = new Telerik.Reporting.TextBox();
            this.textBox11 = new Telerik.Reporting.TextBox();
            this.shape5 = new Telerik.Reporting.Shape();
            this.textBox10 = new Telerik.Reporting.TextBox();
            this.textBox12 = new Telerik.Reporting.TextBox();
            this.textBox13 = new Telerik.Reporting.TextBox();
            this.textBox15 = new Telerik.Reporting.TextBox();
            this.textBox16 = new Telerik.Reporting.TextBox();
            this.textBox17 = new Telerik.Reporting.TextBox();
            this.textBox18 = new Telerik.Reporting.TextBox();
            this.textBox14 = new Telerik.Reporting.TextBox();
            this.shape6 = new Telerik.Reporting.Shape();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // generales
            // 
            this.generales.ConnectionString = "ReportLibrary.Properties.Settings.icaten";
            this.generales.Name = "generales";
            this.generales.Parameters.AddRange(new Telerik.Reporting.SqlDataSourceParameter[] {
            new Telerik.Reporting.SqlDataSourceParameter("@idsolicitud", System.Data.DbType.Int32, "= Parameters.idsolicitud.Value")});
            this.generales.SelectCommand = resources.GetString("generales.SelectCommand");
            // 
            // pageHeaderSection1
            // 
            this.pageHeaderSection1.Height = Telerik.Reporting.Drawing.Unit.Cm(0.40000009536743164D);
            this.pageHeaderSection1.Name = "pageHeaderSection1";
            this.pageHeaderSection1.PrintOnLastPage = true;
            // 
            // detail
            // 
            this.detail.Height = Telerik.Reporting.Drawing.Unit.Cm(6.6000003814697266D);
            this.detail.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.panel1,
            this.panel2});
            this.detail.Name = "detail";
            this.detail.Style.BackgroundImage.MimeType = "";
            this.detail.Style.BackgroundImage.Repeat = Telerik.Reporting.Drawing.BackgroundRepeat.NoRepeat;
            this.detail.Style.BorderColor.Default = System.Drawing.Color.Gray;
            this.detail.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.None;
            // 
            // panel1
            // 
            this.panel1.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.textBox23,
            this.shape1,
            this.textBox33,
            this.textBox34,
            this.textBox35,
            this.textBox36,
            this.pictureBox1,
            this.textBox1,
            this.pictureBox2,
            this.pictureBox3,
            this.textBox2,
            this.shape2,
            this.shape3,
            this.textBox3,
            this.shape4,
            this.textBox4,
            this.textBox5,
            this.textBox6,
            this.textBox7});
            this.panel1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.85138881206512451D), Telerik.Reporting.Drawing.Unit.Cm(0.60019993782043457D));
            this.panel1.Name = "panel1";
            this.panel1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(10.001287460327148D), Telerik.Reporting.Drawing.Unit.Cm(5.3998003005981445D));
            this.panel1.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            // 
            // textBox23
            // 
            this.textBox23.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(5.35902738571167D), Telerik.Reporting.Drawing.Unit.Cm(4.8921613693237305D));
            this.textBox23.Name = "textBox23";
            this.textBox23.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.4830389022827148D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox23.Style.Font.Bold = true;
            this.textBox23.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(7D);
            this.textBox23.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox23.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox23.Value = "= \"FIRMA DEL DIRECTOR\"";
            // 
            // shape1
            // 
            this.shape1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(5.35902738571167D), Telerik.Reporting.Drawing.Unit.Cm(4.691960334777832D));
            this.shape1.Name = "shape1";
            this.shape1.ShapeType = new Telerik.Reporting.Drawing.Shapes.LineShape(Telerik.Reporting.Drawing.Shapes.LineDirection.EW);
            this.shape1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.483039379119873D), Telerik.Reporting.Drawing.Unit.Cm(0.13229165971279144D));
            // 
            // textBox33
            // 
            this.textBox33.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.0923612117767334D), Telerik.Reporting.Drawing.Unit.Cm(0.19473832845687866D));
            this.textBox33.Name = "textBox33";
            this.textBox33.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.7755932807922363D), Telerik.Reporting.Drawing.Unit.Cm(0.28154489398002625D));
            this.textBox33.Style.Font.Bold = true;
            this.textBox33.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox33.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox33.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox33.Value = "= \"SUBSECRETARIA DE EDUCACIÓN E INVESTIGACIÓN TECNOLÓGICAS\"";
            // 
            // textBox34
            // 
            this.textBox34.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.3424606323242188D), Telerik.Reporting.Drawing.Unit.Cm(0.48834145069122314D));
            this.textBox34.Name = "textBox34";
            this.textBox34.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.0498991012573242D), Telerik.Reporting.Drawing.Unit.Cm(0.28154489398002625D));
            this.textBox34.Style.Font.Bold = true;
            this.textBox34.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox34.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox34.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox34.Value = "= \"DIRECCIÓN GENERAL DE CENTROS DE\"";
            // 
            // textBox35
            // 
            this.textBox35.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.3424606323242188D), Telerik.Reporting.Drawing.Unit.Cm(0.79980158805847168D));
            this.textBox35.Name = "textBox35";
            this.textBox35.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.0498981475830078D), Telerik.Reporting.Drawing.Unit.Cm(0.28154489398002625D));
            this.textBox35.Style.Font.Bold = true;
            this.textBox35.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox35.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox35.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox35.Value = "= \"FORMACIÓN PARA ELTRABAJO\"";
            // 
            // textBox36
            // 
            this.textBox36.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.3424606323242188D), Telerik.Reporting.Drawing.Unit.Cm(1.0815465450286865D));
            this.textBox36.Name = "textBox36";
            this.textBox36.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.0499000549316406D), Telerik.Reporting.Drawing.Unit.Cm(0.28154489398002625D));
            this.textBox36.Style.Font.Bold = true;
            this.textBox36.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox36.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox36.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox36.Value = "= \"UNIDAD DE CAPACITACIÓN\"";
            // 
            // pictureBox1
            // 
            this.pictureBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.2000001072883606D), Telerik.Reporting.Drawing.Unit.Cm(0.63591098785400391D));
            this.pictureBox1.MimeType = "image/jpeg";
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.9999997615814209D), Telerik.Reporting.Drawing.Unit.Cm(0.72718030214309692D));
            this.pictureBox1.Sizing = Telerik.Reporting.Drawing.ImageSizeMode.Stretch;
            this.pictureBox1.Value = ((object)(resources.GetObject("pictureBox1.Value")));
            // 
            // textBox1
            // 
            this.textBox1.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.3499000072479248D), Telerik.Reporting.Drawing.Unit.Cm(1.6254945993423462D));
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.0498981475830078D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox1.Style.Font.Bold = true;
            this.textBox1.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox1.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox1.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox1.Value = "= \"CLAVE DEL CCT \" + Fields.clavecct";
            // 
            // pictureBox2
            // 
            this.pictureBox2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.15902775526046753D), Telerik.Reporting.Drawing.Unit.Cm(1.6484105587005615D));
            this.pictureBox2.MimeType = "";
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.0409722328186035D), Telerik.Reporting.Drawing.Unit.Cm(2.4979164600372314D));
            this.pictureBox2.Sizing = Telerik.Reporting.Drawing.ImageSizeMode.Stretch;
            this.pictureBox2.Style.BorderColor.Default = System.Drawing.Color.Gray;
            this.pictureBox2.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            this.pictureBox2.Value = "=Fields.foto";
            // 
            // pictureBox3
            // 
            this.pictureBox3.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.95902752876281738D), Telerik.Reporting.Drawing.Unit.Cm(4.3055548667907715D));
            this.pictureBox3.MimeType = "image/jpeg";
            this.pictureBox3.Name = "pictureBox3";
            this.pictureBox3.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(0.44097205996513367D), Telerik.Reporting.Drawing.Unit.Cm(0.49979871511459351D));
            this.pictureBox3.Sizing = Telerik.Reporting.Drawing.ImageSizeMode.Stretch;
            this.pictureBox3.Value = ((object)(resources.GetObject("pictureBox3.Value")));
            // 
            // textBox2
            // 
            this.textBox2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.3499000072479248D), Telerik.Reporting.Drawing.Unit.Cm(2.126537561416626D));
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.890877366065979D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox2.Style.Font.Bold = true;
            this.textBox2.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox2.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox2.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox2.Value = "= \"ACREDITA A:\"";
            // 
            // shape2
            // 
            this.shape2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(4.4832334518432617D), Telerik.Reporting.Drawing.Unit.Cm(2.4265382289886475D));
            this.shape2.Name = "shape2";
            this.shape2.ShapeType = new Telerik.Reporting.Drawing.Shapes.LineShape(Telerik.Reporting.Drawing.Shapes.LineDirection.EW);
            this.shape2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(5.3828473091125488D), Telerik.Reporting.Drawing.Unit.Cm(0.13229165971279144D));
            // 
            // shape3
            // 
            this.shape3.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.3422605991363525D), Telerik.Reporting.Drawing.Unit.Cm(3.0650787353515625D));
            this.shape3.Name = "shape3";
            this.shape3.ShapeType = new Telerik.Reporting.Drawing.Shapes.LineShape(Telerik.Reporting.Drawing.Shapes.LineDirection.EW);
            this.shape3.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.5072431564331055D), Telerik.Reporting.Drawing.Unit.Cm(0.13229165971279144D));
            // 
            // textBox3
            // 
            this.textBox3.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.3499000072479248D), Telerik.Reporting.Drawing.Unit.Cm(3.4150784015655518D));
            this.textBox3.Name = "textBox3";
            this.textBox3.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.6500999927520752D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox3.Style.Font.Bold = true;
            this.textBox3.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox3.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox3.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox3.Value = "= \"CON CURP:\"";
            // 
            // shape4
            // 
            this.shape4.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(4.5666584968566895D), Telerik.Reporting.Drawing.Unit.Cm(3.7150778770446777D));
            this.shape4.Name = "shape4";
            this.shape4.ShapeType = new Telerik.Reporting.Drawing.Shapes.LineShape(Telerik.Reporting.Drawing.Shapes.LineDirection.EW);
            this.shape4.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(5.2994222640991211D), Telerik.Reporting.Drawing.Unit.Cm(0.13229165971279144D));
            // 
            // textBox4
            // 
            this.textBox4.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.3499000072479248D), Telerik.Reporting.Drawing.Unit.Cm(4.0065975189208984D));
            this.textBox4.Name = "textBox4";
            this.textBox4.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.216771125793457D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox4.Style.Font.Bold = true;
            this.textBox4.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox4.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox4.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox4.Value = "= \"COMO ALUMNO\"";
            // 
            // textBox5
            // 
            this.textBox5.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(4.3331379890441895D), Telerik.Reporting.Drawing.Unit.Cm(2.1150789260864258D));
            this.textBox5.Name = "textBox5";
            this.textBox5.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(5.5163640975952148D), Telerik.Reporting.Drawing.Unit.Cm(0.29999959468841553D));
            this.textBox5.Style.Font.Bold = true;
            this.textBox5.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox5.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox5.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox5.Value = "= Fields.nombrealumno";
            // 
            // textBox6
            // 
            this.textBox6.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(4.2331347465515137D), Telerik.Reporting.Drawing.Unit.Cm(2.7648792266845703D));
            this.textBox6.Name = "textBox6";
            this.textBox6.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(5.616370677947998D), Telerik.Reporting.Drawing.Unit.Cm(0.29999959468841553D));
            this.textBox6.Style.Font.Bold = true;
            this.textBox6.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox6.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox6.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox6.Value = "= Fields.apellidos";
            // 
            // textBox7
            // 
            this.textBox7.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(4.3331384658813477D), Telerik.Reporting.Drawing.Unit.Cm(3.4148781299591064D));
            this.textBox7.Name = "textBox7";
            this.textBox7.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(5.5329432487487793D), Telerik.Reporting.Drawing.Unit.Cm(0.29999959468841553D));
            this.textBox7.Style.Font.Bold = true;
            this.textBox7.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox7.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox7.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox7.Value = "= Fields.curp";
            // 
            // panel2
            // 
            this.panel2.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.pictureBox4,
            this.textBox8,
            this.textBox9,
            this.textBox11,
            this.shape5,
            this.textBox10,
            this.textBox12,
            this.textBox13,
            this.textBox15,
            this.textBox16,
            this.textBox17,
            this.textBox18,
            this.textBox14,
            this.shape6});
            this.panel2.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(10.851388931274414D), Telerik.Reporting.Drawing.Unit.Cm(0.60019993782043457D));
            this.panel2.Name = "panel2";
            this.panel2.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(10D), Telerik.Reporting.Drawing.Unit.Cm(5.4000000953674316D));
            this.panel2.Style.BorderStyle.Default = Telerik.Reporting.Drawing.BorderType.Solid;
            // 
            // pictureBox4
            // 
            this.pictureBox4.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(4.59999942779541D), Telerik.Reporting.Drawing.Unit.Cm(2.4254944324493408D));
            this.pictureBox4.MimeType = "image/jpeg";
            this.pictureBox4.Name = "pictureBox4";
            this.pictureBox4.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(1.1346899271011353D), Telerik.Reporting.Drawing.Unit.Cm(1.3312878608703613D));
            this.pictureBox4.Sizing = Telerik.Reporting.Drawing.ImageSizeMode.Stretch;
            this.pictureBox4.Value = ((object)(resources.GetObject("pictureBox4.Value")));
            // 
            // textBox8
            // 
            this.textBox8.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999746978282929D), Telerik.Reporting.Drawing.Unit.Cm(0.45862790942192078D));
            this.textBox8.Name = "textBox8";
            this.textBox8.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3.0000016689300537D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox8.Style.Font.Bold = true;
            this.textBox8.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox8.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox8.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox8.Value = "= \"NÚMERO DE CONTROL:\"";
            // 
            // textBox9
            // 
            this.textBox9.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(3.3256940841674805D), Telerik.Reporting.Drawing.Unit.Cm(0.48834145069122314D));
            this.textBox9.Name = "textBox9";
            this.textBox9.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(6.3830318450927734D), Telerik.Reporting.Drawing.Unit.Cm(0.30000001192092896D));
            this.textBox9.Style.Font.Bold = true;
            this.textBox9.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox9.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox9.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox9.Value = "= Fields.nocontrol";
            // 
            // textBox11
            // 
            this.textBox11.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999746978282929D), Telerik.Reporting.Drawing.Unit.Cm(1.6254945993423462D));
            this.textBox11.Name = "textBox11";
            this.textBox11.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(2.40000057220459D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox11.Style.Font.Bold = true;
            this.textBox11.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox11.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Left;
            this.textBox11.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox11.Value = "= \"ESPECIALIDAD:\"";
            // 
            // shape5
            // 
            this.shape5.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.6256935596466064D), Telerik.Reporting.Drawing.Unit.Cm(2.0997998714447021D));
            this.shape5.Name = "shape5";
            this.shape5.ShapeType = new Telerik.Reporting.Drawing.Shapes.LineShape(Telerik.Reporting.Drawing.Shapes.LineDirection.EW);
            this.shape5.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.0830392837524414D), Telerik.Reporting.Drawing.Unit.Cm(0.13229165971279144D));
            // 
            // textBox10
            // 
            this.textBox10.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(2.6256935596466064D), Telerik.Reporting.Drawing.Unit.Cm(1.1588277816772461D));
            this.textBox10.Name = "textBox10";
            this.textBox10.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(7.0830345153808594D), Telerik.Reporting.Drawing.Unit.Cm(0.88492172956466675D));
            this.textBox10.Style.Font.Bold = true;
            this.textBox10.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox10.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox10.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Bottom;
            this.textBox10.Value = "= Fields.especialidad";
            // 
            // textBox12
            // 
            this.textBox12.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999746978282929D), Telerik.Reporting.Drawing.Unit.Cm(3.2226059436798096D));
            this.textBox12.Name = "textBox12";
            this.textBox12.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3.00000262260437D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox12.Style.Font.Bold = true;
            this.textBox12.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox12.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox12.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox12.Value = "= \"FECHA DE EXPEDICIÓN\"";
            // 
            // textBox13
            // 
            this.textBox13.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999746978282929D), Telerik.Reporting.Drawing.Unit.Cm(2.9224071502685547D));
            this.textBox13.Name = "textBox13";
            this.textBox13.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3.000002384185791D), Telerik.Reporting.Drawing.Unit.Cm(0.2999991774559021D));
            this.textBox13.Style.Font.Bold = true;
            this.textBox13.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox13.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox13.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox13.Value = "= Fields.anio + \" \" + Fields.mes + \" \" + Fields.dia";
            // 
            // textBox15
            // 
            this.textBox15.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999746978282929D), Telerik.Reporting.Drawing.Unit.Cm(4.5052981376647949D));
            this.textBox15.Name = "textBox15";
            this.textBox15.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3.3999991416931152D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox15.Style.Font.Bold = true;
            this.textBox15.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox15.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox15.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox15.Value = "= \"LOCALIDAD\"";
            // 
            // textBox16
            // 
            this.textBox16.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(0.19999746978282929D), Telerik.Reporting.Drawing.Unit.Cm(4.2050986289978027D));
            this.textBox16.Name = "textBox16";
            this.textBox16.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3.3999989032745361D), Telerik.Reporting.Drawing.Unit.Cm(0.2999991774559021D));
            this.textBox16.Style.Font.Bold = true;
            this.textBox16.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox16.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox16.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox16.Value = "= Fields.localidad";
            // 
            // textBox17
            // 
            this.textBox17.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(6.508732795715332D), Telerik.Reporting.Drawing.Unit.Cm(3.2226059436798096D));
            this.textBox17.Name = "textBox17";
            this.textBox17.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3.200000524520874D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox17.Style.Font.Bold = true;
            this.textBox17.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(6D);
            this.textBox17.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox17.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox17.Value = "= \"CICLO ESCOLAR\"";
            // 
            // textBox18
            // 
            this.textBox18.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(6.508732795715332D), Telerik.Reporting.Drawing.Unit.Cm(2.8551955223083496D));
            this.textBox18.Name = "textBox18";
            this.textBox18.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(3.1999938488006592D), Telerik.Reporting.Drawing.Unit.Cm(0.2999991774559021D));
            this.textBox18.Style.Font.Bold = true;
            this.textBox18.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(8D);
            this.textBox18.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox18.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox18.Value = "= Fields.cicloescolar";
            // 
            // textBox14
            // 
            this.textBox14.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(5.2256932258605957D), Telerik.Reporting.Drawing.Unit.Cm(4.8921613693237305D));
            this.textBox14.Name = "textBox14";
            this.textBox14.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.4830389022827148D), Telerik.Reporting.Drawing.Unit.Cm(0.34097358584403992D));
            this.textBox14.Style.Font.Bold = true;
            this.textBox14.Style.Font.Size = Telerik.Reporting.Drawing.Unit.Point(7D);
            this.textBox14.Style.TextAlign = Telerik.Reporting.Drawing.HorizontalAlign.Center;
            this.textBox14.Style.VerticalAlign = Telerik.Reporting.Drawing.VerticalAlign.Middle;
            this.textBox14.Value = "= \"FIRMA DEL ALUMNO\"";
            // 
            // shape6
            // 
            this.shape6.Location = new Telerik.Reporting.Drawing.PointU(Telerik.Reporting.Drawing.Unit.Cm(5.2256932258605957D), Telerik.Reporting.Drawing.Unit.Cm(4.691960334777832D));
            this.shape6.Name = "shape6";
            this.shape6.ShapeType = new Telerik.Reporting.Drawing.Shapes.LineShape(Telerik.Reporting.Drawing.Shapes.LineDirection.EW);
            this.shape6.Size = new Telerik.Reporting.Drawing.SizeU(Telerik.Reporting.Drawing.Unit.Cm(4.483039379119873D), Telerik.Reporting.Drawing.Unit.Cm(0.13229165971279144D));
            // 
            // Credencial
            // 
            this.DataSource = this.generales;
            this.Items.AddRange(new Telerik.Reporting.ReportItemBase[] {
            this.pageHeaderSection1,
            this.detail});
            this.Name = "Credencial";
            this.PageSettings.BackgroundImage.MimeType = "";
            this.PageSettings.BackgroundImage.Repeat = Telerik.Reporting.Drawing.BackgroundRepeat.NoRepeat;
            this.PageSettings.ContinuousPaper = false;
            this.PageSettings.Landscape = false;
            this.PageSettings.Margins = new Telerik.Reporting.Drawing.MarginsU(Telerik.Reporting.Drawing.Unit.Mm(0D), Telerik.Reporting.Drawing.Unit.Mm(0D), Telerik.Reporting.Drawing.Unit.Mm(10D), Telerik.Reporting.Drawing.Unit.Mm(0D));
            this.PageSettings.PaperKind = System.Drawing.Printing.PaperKind.Letter;
            reportParameter1.Name = "idsolicitud";
            reportParameter1.Type = Telerik.Reporting.ReportParameterType.Integer;
            reportParameter1.Value = "85";
            reportParameter2.Name = "idpago";
            reportParameter2.Type = Telerik.Reporting.ReportParameterType.Integer;
            reportParameter2.Value = "1";
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
            this.Width = Telerik.Reporting.Drawing.Unit.Cm(21.590002059936523D);
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }
        #endregion

        private Telerik.Reporting.PageHeaderSection pageHeaderSection1;
        private Telerik.Reporting.DetailSection detail;
        private Telerik.Reporting.SqlDataSource generales;
        private Telerik.Reporting.Panel panel1;
        private Telerik.Reporting.TextBox textBox23;
        private Telerik.Reporting.Shape shape1;
        private Telerik.Reporting.TextBox textBox33;
        private Telerik.Reporting.TextBox textBox34;
        private Telerik.Reporting.TextBox textBox35;
        private Telerik.Reporting.TextBox textBox36;
        private Telerik.Reporting.Panel panel2;
        private Telerik.Reporting.PictureBox pictureBox1;
        private Telerik.Reporting.TextBox textBox1;
        private Telerik.Reporting.PictureBox pictureBox2;
        private Telerik.Reporting.PictureBox pictureBox3;
        private Telerik.Reporting.TextBox textBox2;
        private Telerik.Reporting.Shape shape2;
        private Telerik.Reporting.Shape shape3;
        private Telerik.Reporting.TextBox textBox3;
        private Telerik.Reporting.Shape shape4;
        private Telerik.Reporting.TextBox textBox4;
        private Telerik.Reporting.PictureBox pictureBox4;
        private Telerik.Reporting.TextBox textBox5;
        private Telerik.Reporting.TextBox textBox6;
        private Telerik.Reporting.TextBox textBox7;
        private Telerik.Reporting.TextBox textBox8;
        private Telerik.Reporting.TextBox textBox9;
        private Telerik.Reporting.TextBox textBox11;
        private Telerik.Reporting.Shape shape5;
        private Telerik.Reporting.TextBox textBox10;
        private Telerik.Reporting.TextBox textBox12;
        private Telerik.Reporting.TextBox textBox13;
        private Telerik.Reporting.TextBox textBox15;
        private Telerik.Reporting.TextBox textBox16;
        private Telerik.Reporting.TextBox textBox17;
        private Telerik.Reporting.TextBox textBox18;
        private Telerik.Reporting.TextBox textBox14;
        private Telerik.Reporting.Shape shape6;
    }
}