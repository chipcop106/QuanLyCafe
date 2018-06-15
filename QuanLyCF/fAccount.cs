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
using QuanLyCF.DTO;

namespace QuanLyCF
{
    public partial class fAccount : Form
    {
        public fAccount()
        {
            InitializeComponent();
            LoadAccount();
        }

        void LoadAccount()
        {
            List<Account> listcategory = AccountDAO.Instance.GetListAccount();
            foreach (Account item in listcategory)
            {
                ListViewItem lstvitem = new ListViewItem(item.ID.ToString());
                lstvitem.SubItems.Add(item.UserName.ToString());
                lstvitem.SubItems.Add(item.DisplayName.ToString());
                lstvitem.SubItems.Add(item.PassWord.ToString());
                lstvitem.SubItems.Add(item.Type.ToString());
                lstvAccount.Items.Add(lstvitem);
            }

        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void lstvAccount_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (ListViewItem item in lstvAccount.SelectedItems)
            {
                
                txbAccUsername.Text = item.SubItems[1].Text;
                txbAccDisplayName.Text = item.SubItems[2].Text;
                txbAccPassword.Text = item.SubItems[3].Text;
                txbAccType.Text = item.SubItems[4].Text;
            }
        }

        private void btnAddAccount_Click(object sender, EventArgs e)
        {
            lstvAccount.Items.Clear();
            string userName = txbAccUsername.Text;
            string dislayName = txbAccDisplayName.Text;
            string passWord = txbAccPassword.Text;
            int type = int.Parse(txbAccType.Text);
            AccountDAO.Instance.AddAccount(userName,dislayName,passWord,type);
            LoadAccount();
        }

        private void btnEditAccount_Click(object sender, EventArgs e)
        {

            int id=0;
            foreach (ListViewItem item in lstvAccount.SelectedItems)
            {
                id= int.Parse(item.SubItems[0].Text);
            }
            string userName = txbAccUsername.Text;
            string dislayName = txbAccDisplayName.Text;
            string passWord = txbAccPassword.Text;
            int type = int.Parse(txbAccType.Text);
            AccountDAO.Instance.EditAccount(id,userName, dislayName, passWord, type);
            lstvAccount.Items.Clear();
            LoadAccount();
        }

        private void btnDeleteAccount_Click(object sender, EventArgs e)
        {
            
            int id = 0;
            foreach (ListViewItem item in lstvAccount.SelectedItems)
            {
                id = int.Parse(item.SubItems[0].Text);
            }
            string userName = txbAccUsername.Text;
            AccountDAO.Instance.DeleteAccount(id);
            lstvAccount.Items.Clear();
            LoadAccount();
        }
    }
}
