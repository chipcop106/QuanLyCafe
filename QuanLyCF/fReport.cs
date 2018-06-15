using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Reporting.WinForms;
using System.Data.SqlClient;
using QuanLyCF.DAO;

namespace QuanLyCF
{
    public partial class fReport : Form
    {
        public fReport()
        {
            InitializeComponent();
        }

        private void fReport_Load(object sender, EventArgs e)
        {
            ShowReport();
            this.reportViewer1.RefreshReport();
        }

        private DataTable GetData(DateTime checkIn, DateTime checkOut)
        {

            DataTable dt = new DataTable();
            string query = "exec USP_GetListBillByDateForReport @checkIn , @checkOut";
            dt = DataProvider.Instance.ExecuteQuery(query,new object[]{checkIn, checkOut});
            return dt;
        }

        private void ShowReport()
        {

            try
            {

                reportViewer1.Reset();
                ReportParameter[] rparams = new ReportParameter[]
                {
                    new ReportParameter("fromDate",dtpkFromDate.Value.Date.ToShortDateString()),
                    new ReportParameter("toDate",dtpkToDate.Value.Date.ToShortDateString())
                };
                DataTable dt = GetData(dtpkFromDate.Value, dtpkToDate.Value);
                ReportDataSource rds = new ReportDataSource("DataSet1", dt);
                reportViewer1.LocalReport.DataSources.Add(rds);
                reportViewer1.LocalReport.ReportEmbeddedResource = "QuanLyCF.Report1.rdlc";
                reportViewer1.RefreshReport();


                           reportViewer1.LocalReport.SetParameters(rparams);
                reportViewer1.LocalReport.Refresh();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Please select date to show first !!", "Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        private void btnLoadReport_Click(object sender, EventArgs e)
        {
            ShowReport();
        }
    }
}
