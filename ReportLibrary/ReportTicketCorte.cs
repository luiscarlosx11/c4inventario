namespace ReportLibrary
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;
    using MySql.Data.MySqlClient;

    /// <summary>
    /// Summary description for ReportTicket.
    /// </summary>
    public partial class ReportTicketCorte : Telerik.Reporting.Report
	{
		public ReportTicketCorte()
		{
			//
			// Required for telerik Reporting designer support
			//
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}
	}
}