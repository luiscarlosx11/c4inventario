namespace elecion.reportes
{
    using System;

    using Telerik.ReportViewer.Html5.WebForms;
    using MySql.Data.MySqlClient;
    using System.Web.Security;
    using ReportLibrary;
    using System.Collections;
    using Telerik.Reporting.Processing;
    using System.Web;

    public partial class RVSalida : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Salida reporte = new Salida();
                reporte.ReportParameters["idsalida"].Value = Session["idP"];

                Hashtable deviceInfo = new Hashtable();
                deviceInfo["JavaScript"] = "this.print({bUI: false, bSilent: true, bShrinkToFit: true});";


                ReportProcessor reportProcessor = new ReportProcessor();
                Telerik.Reporting.InstanceReportSource instanceReportSource = new Telerik.Reporting.InstanceReportSource();
                instanceReportSource.ReportDocument = reporte;
                RenderingResult result = reportProcessor.RenderReport("PDF", instanceReportSource, deviceInfo);

                string fileName = result.DocumentName + "." + result.Extension;

                Response.Clear();
                Response.ContentType = result.MimeType;
                Response.Cache.SetCacheability(HttpCacheability.Private);
                Response.Expires = -1;
                Response.Buffer = true;

                /* Response.AddHeader("Content-Disposition",
                                    string.Format("{0};FileName=\"{1}\"",
                                                  "attachment",
                                                  fileName));*/
                Response.BinaryWrite(result.DocumentBytes);
                Response.End();

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }
            finally
            {

            }



        }
    }
}