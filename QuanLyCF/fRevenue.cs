using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyCF.DAO;

namespace QuanLyCF
{
    public partial class fRevenue : Form
    {
        public DateTime FromDay;
        public DateTime FromToDay;
        public fRevenue()
        {
            InitializeComponent();
            LoadDateTimePickerBill();
            LoadListBillByDate(dtpkFromDay.Value, dtpkToDay.Value);
        }

        void LoadDateTimePickerBill()
        {
            DateTime today = DateTime.Now;
            dtpkFromDay.Value = new DateTime(today.Year,today.Month,1);
            dtpkToDay.Value = dtpkFromDay.Value.AddMonths(1).AddDays(-1);
            FromDay = dtpkFromDay.Value;
            FromToDay = dtpkToDay.Value;

        }
        void LoadListBillByDate(DateTime checkIn, DateTime checkOut)
        {
           dtgvRevenue.DataSource = BillDAO.Instance.GetBillListByDate(checkIn, checkOut);

        }
        private void btnShowReport_Click(object sender, EventArgs e)
        {
            LoadListBillByDate(dtpkFromDay.Value,dtpkToDay.Value);
        }
    }
}
