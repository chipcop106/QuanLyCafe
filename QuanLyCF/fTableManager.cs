using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using QuanLyCF.DAO;
using QuanLyCF.DTO;

namespace QuanLyCF
{
    public partial class fTableManager : Form
    {


        public fTableManager()
        {
            InitializeComponent();
            LoadTable();
            LoadCategory();
            LoadComboTable(cbListTable);
        }


        #region Methods

        void LoadTable()
        {
            flowLayoutPanel1.Controls.Clear();
            
            List<Table> tablelist = TableDAO.Instance.LoadTableList();
            foreach (Table item in tablelist)
            {
                Button btn = new Button() {Width = TableDAO.TableWidth, Height = TableDAO.TableWidth};
                btn.Text = item.Name + "\n" + item.Status;
                btn.Click += Btn_Click;
                btn.Tag = item;
                
                btn.FlatStyle = FlatStyle.Flat;

                switch (item.Status)
                {
                    case "Trống":
                        btn.BackColor = Color.DarkKhaki;


                        break;
                    default:
                        btn.BackColor = Color.Brown;
                        btn.ForeColor = Color.White;
                        break;
                }
                flowLayoutPanel1.Controls.Add(btn);
                
            }
            Table table = lstvTableInfo.Tag as Table;
            
     
        }

        private void Btn_Click(object sender, EventArgs e)
        {

            int tableID = ((sender as Button).Tag as Table).ID;
            lstvTableInfo.Tag = (sender as Button).Tag;
            ShowInfoTable(tableID);
        }

        void ShowInfoTable(int id)
        {
            flowLayoutPanel1.Controls.Clear();
            
            txbDateCreateBill.Text = DateTime.Now.ToLocalTime().ToString();
            lstvTableInfo.Items.Clear();
            float totalPrice = 0;

            List<TableInfo> listBillInfo = TableInfoDAO.Instance.GetTableInfoByTable(id);
            foreach (TableInfo item in listBillInfo)

            {
                ListViewItem lstvitem = new ListViewItem(item.ID.ToString());
                lstvitem.SubItems.Add(item.FoodName.ToString());
                lstvitem.SubItems.Add(item.CategoryName.ToString());
                lstvitem.SubItems.Add(item.Count.ToString());
                lstvitem.SubItems.Add(item.Price.ToString());
                lstvitem.SubItems.Add(item.TotalPrice.ToString());
                totalPrice += item.TotalPrice;
                lstvTableInfo.Items.Add(lstvitem);

            }

            
            Table table = lstvTableInfo.Tag as Table;
            lbTableName.Text = "Food Information at " + table.Name.ToLower();
            txbTable.Text = table.Name;
            CultureInfo culture = new CultureInfo("vi-VN");
            Thread.CurrentThread.CurrentCulture = culture;
            txbTotal.Text = totalPrice.ToString();

            txbTotalPrice.Text = (totalPrice - (totalPrice * 0.1)).ToString();

            LoadTable();
        }

        void LoadCategory()
        {
            List<Category> listcategory = CategoryDAO.Instance.GetListCategory();
            cbCategory.DataSource = listcategory;
            cbCategory.DisplayMember = "name";
            lstvFood.Items[0].Selected = true;
            lstvFood.Items[0].Focused = true;
        }

        void LoadFoodListByIdCategory(int id)
        {
            lstvFood.Items.Clear();
            List<Food> listfood = FoodDAO.Instance.GetFoodByCategoryID(id);

            foreach (Food item in listfood)
            {

                ListViewItem lstvitem = new ListViewItem(item.ID.ToString());
                lstvitem.SubItems.Add(item.Name.ToString());
                lstvitem.SubItems.Add(item.IDCategory.ToString());
                lstvitem.SubItems.Add(item.Price.ToString());
                lstvFood.Items.Add(lstvitem);
            }
            


        }

        void LoadComboTable(ComboBox cb)
        {
            cb.DataSource = TableDAO.Instance.LoadTableList();
            cb.DisplayMember = "name";
        }

        #endregion

        #region Events

        //Menu Click Event
        private void accountManagerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fAccount f = new fAccount();
            f.ShowDialog();
        }

        private void foodManagerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fFoodManager f = new fFoodManager();
            f.ShowDialog();
        }

        private void reportToolStripMenuItem_Click(object sender, EventArgs e)
        {
            fRevenue f = new fRevenue();
            f.ShowDialog();

        }
        //end Menu click Event

        private void lstvTableInfo_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void txbGuestMoney_TextChanged(object sender, EventArgs e)
        {
            if (txbGuestMoney.Text == "")
            {
                txbGuestMoney.Text = "0";

            }
            txbRefundMoney.Text =
                ((float) Convert.ToDouble(txbGuestMoney.Text) - ((float) Convert.ToDouble(txbTotalPrice.Text)))
                .ToString("c0");
        }

        private void txbRefundMoney_TextChanged(object sender, EventArgs e)
        {
            if (txbRefundMoney.Text == "")
            {
                txbRefundMoney.Text = "0";

            }
        }

        private void cbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id = 0;
            ComboBox cb = sender as ComboBox;
            if (cb.SelectedItem == null)
                return;
            Category selected = cb.SelectedItem as Category;
            id = selected.ID;
            LoadFoodListByIdCategory(id);
            lstvFood.Items[0].Selected = true;
            lstvFood.Items[0].Focused = true;
        }

        //Food Button
        private void btnAddFood_Click(object sender, EventArgs e)
        {
            Table table = lstvTableInfo.Tag as Table;

            if (table == null)
            {
                MessageBox.Show("Please select table !");
                return;
            }
            try
            {
                int idBill = BillDAO.Instance.GetUcheckBillIdByTableId(table.ID);

                int idFood = int.Parse(lstvFood.SelectedItems[0].SubItems[0].Text);
                int count = (int)nbrAmount.Value;
                if (idBill == -1)
                {
                    BillDAO.Instance.InsertBill(table.ID);
                    BillInfoDAO.Instance.InsertBillInfo(BillDAO.Instance.GetMaxIdBill(), idFood, count);
                }
                else
                {
                    BillInfoDAO.Instance.InsertBillInfo(idBill, idFood, count);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Please select Food on List Food to Add on table !!", "Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
           
            ShowInfoTable(table.ID);
            LoadTable();
        }

        private void btnDeleteFood_Click(object sender, EventArgs e)
        {
            Table table = lstvTableInfo.Tag as Table;
            if (table == null)
            {
                MessageBox.Show("Hãy chọn bàn");
                return;
            }

            try
            {
                int idBill = BillDAO.Instance.GetUcheckBillIdByTableId(table.ID);
                if (MessageBox.Show("Are you sure to delete this food ? ", "Warning !!", MessageBoxButtons.OKCancel) != System.Windows.Forms.DialogResult.OK)
                {
                    return;
                }

                int idFood = int.Parse(lstvTableInfo.SelectedItems[0].SubItems[0].Text);
                if (idBill == -1)
                {
                    BillDAO.Instance.InsertBill(table.ID);
                    BillInfoDAO.Instance.DeleteBillInfo(BillDAO.Instance.GetMaxIdBill(), idFood);
                }
                else
                {
                    BillInfoDAO.Instance.DeleteBillInfo(idBill, idFood);
                }

                foreach (ListViewItem item in lstvTableInfo.Items)
                {
                    if (item.Selected)
                        item.Remove();
                }
            }
            catch (Exception exception)
            {
                MessageBox.Show("Please select Food on list Table to Detele !!", "Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            
            ShowInfoTable(table.ID);
            LoadTable();
        }

        private void lstvFood_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
        
        //Checkout Buttton
        private void btnCheckOut_Click(object sender, EventArgs e)
        {
            Table table = lstvTableInfo.Tag as Table;
            int idBill = BillDAO.Instance.GetUcheckBillIdByTableId(table.ID);
            double finalTotalPrice = Convert.ToDouble(txbTotalPrice.Text);
            if (idBill != -1)
            {
                if (MessageBox.Show("Are you sure to check out ?", "Check Out !!", MessageBoxButtons.OKCancel) ==
                    System.Windows.Forms.DialogResult.OK)
                {
                    BillDAO.Instance.CheckOut(idBill, (float)finalTotalPrice);
                    ShowInfoTable(table.ID);
                    txbRefundMoney.Clear();
                    txbGuestMoney.Clear();
                    LoadTable();
                }
            }
        }
        //Button Table
        private void btnAddTable_Click(object sender, EventArgs e)
        {
            string name = txbTable.Text.ToString();
            TableDAO.Instance.InsertTable(name);
            LoadTable();
        }
        private void btnEditTable_Click(object sender, EventArgs e)
        {
            string name = txbTable.Text.ToString();
            Table table = lstvTableInfo.Tag as Table;
            int id = table.ID;
            TableDAO.Instance.EditTable(name,id);
            LoadTable();
        }
        private void btnSwitchTable_Click(object sender, EventArgs e)
        {
            try
            {
                int idOld = (lstvTableInfo.Tag as Table).ID;
                int idNew = (cbListTable.SelectedItem as Table).ID;
                if (MessageBox.Show(
                        "Do you want to swap from " + ((lstvTableInfo.Tag as Table).Name) + " to " +
                        ((cbListTable.SelectedItem as Table).Name), "Warning !!", MessageBoxButtons.OKCancel) ==
                    System.Windows.Forms.DialogResult.OK)
                {
                    TableDAO.Instance.SwitchTable(idOld, idNew);
                    LoadTable();
                }
            }
            catch (Exception exception)
            {
                MessageBox.Show("Please select table to switch on list");
            }


        }

        //end Button Table

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                int idOld = (lstvTableInfo.Tag as Table).ID;
                int idNew = (cbListTable.SelectedItem as Table).ID;
                if (MessageBox.Show(
                        "Do you want to group " + ((lstvTableInfo.Tag as Table).Name) + " and " +
                        ((cbListTable.SelectedItem as Table).Name), "Warning !!", MessageBoxButtons.OKCancel) ==
                    System.Windows.Forms.DialogResult.OK)
                {
                    TableDAO.Instance.GroupTable(idOld, idNew);
                    LoadTable();
                }
            }
            catch (Exception exception)
            {
                MessageBox.Show("Please select table to group on list");
            }

        }
        private void reportToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            fReport f = new fReport();
            f.ShowDialog();
        }

        private void btnCancelBill_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void fTableManager_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Are you sure to exit ?", "Message !!", MessageBoxButtons.OKCancel) !=
                System.Windows.Forms.DialogResult.OK)
            {
                e.Cancel = true;
            }
        }

        private void fTableManager_Load(object sender, EventArgs e)
        {
            if (AdminCheck(fLogin.userName, fLogin.passWord)==false)
            {
                accountManagerToolStripMenuItem.Enabled = false;
                reportToolStripMenuItem.Enabled = false;
                revenueToolStripMenuItem.Enabled = false;
            }
          
        }
        public bool AdminCheck(string userName, string passWord)
        {
            return AccountDAO.Instance.AdminCheck(userName, passWord);
        }

        private void logoutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void lstvFood_DoubleClick(object sender, EventArgs e)
        {
            btnAddFood.PerformClick();
        }
    }
    #endregion


}
