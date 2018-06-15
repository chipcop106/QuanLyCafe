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
    public partial class fFoodManager : Form
    {
        public fFoodManager()
        {
            InitializeComponent();
            LoadFoodCategory();
            
        }

        void LoadFoodCategory()
        {
            
            List<Category> listcategory = CategoryDAO.Instance.GetListCategory();
            foreach (Category item in listcategory)
            {
                ListViewItem lstvitem = new ListViewItem(item.ID.ToString());
                lstvitem.SubItems.Add(item.Name.ToString());
                lstvFoodCategory.Items.Add(lstvitem);
            }
        }

        void LoadFood(int id)
        {
            lstvFoodName.Items.Clear();

            List<Food> listfood = FoodDAO.Instance.GetFoodByCategoryID(id);
            foreach (Food item in listfood)
            {
                ListViewItem lstvitem = new ListViewItem(item.ID.ToString());
                lstvitem.SubItems.Add(item.Name.ToString());
                lstvitem.SubItems.Add(item.IDCategory.ToString());
                lstvitem.SubItems.Add(item.Price.ToString());
                lstvFoodName.Items.Add(lstvitem);

            }


        }
        private void lstvFoodCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id=0;
            foreach (ListViewItem item in lstvFoodCategory.SelectedItems)
            {
                txbFoodCategory.Text = item.SubItems[1].Text;
                txbFoodCategoryID.Text = item.SubItems[0].Text;
                if(lstvFoodName.FullRowSelect)
                {
                    txbFoodNameCategory.Text = item.SubItems[0].Text;
                    txbFoodName.Text = "";
                    txbFoodPrice.Text = "";
                }

                if (lstvFoodCategory.Items[0].SubItems[0] == null)
                {
                    return;
                }
                id = int.Parse(item.SubItems[0].Text);
            }
            LoadFood(id);
            
        }
         // Button Category
        private void btnFoodAddCategory_Click(object sender, EventArgs e)
        {
            lstvFoodCategory.Items.Clear();
            string name = txbFoodCategory.Text.ToString();
            
            CategoryDAO.Instance.AddCategory(name);
            LoadFoodCategory();
        }



        private void btnFoodEditCategory_Click(object sender, EventArgs e)
        {
            lstvFoodCategory.Items.Clear();
            string name = txbFoodCategory.Text.ToString();
            int id = int.Parse(txbFoodCategoryID.Text);
 
            CategoryDAO.Instance.EditCategory(name,id);
            LoadFoodCategory();
        }

        private void lstvFoodName_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (ListViewItem item in lstvFoodName.SelectedItems)
            {
                
                txbFoodName.Text = item.SubItems[1].Text;
                txbFoodNameCategory.Text = item.SubItems[2].Text;
                txbFoodPrice.Text = item.SubItems[3].Text;
            }


        }
        // Button Food
        private void btnFoodAddFood_Click(object sender, EventArgs e)
        {
            string name = txbFoodName.Text.ToString();
            int idCategory = int.Parse(txbFoodNameCategory.Text);
            float price = (float)Convert.ToDouble(txbFoodPrice.Text);
            FoodDAO.Instance.AddFood(name,idCategory,price);
            int id = 0;
            foreach (ListViewItem item in lstvFoodCategory.SelectedItems)
            {

                if (lstvFoodCategory.Items[0].SubItems[0] == null)
                {
                    return;
                }
                id = int.Parse(item.SubItems[0].Text);
            }
            LoadFood(id);
        }

        private void btnFoodEditFood_Click(object sender, EventArgs e)
        {
            string name = txbFoodName.Text.ToString();
            int idCategory = int.Parse(txbFoodNameCategory.Text);
            float price = (float)Convert.ToDouble(txbFoodPrice.Text);
           
            
            int idFood = 0;
            int id = 0;
            foreach (ListViewItem item in lstvFoodCategory.SelectedItems)
            {

                if (lstvFoodCategory.Items[0].SubItems[0] == null)
                {
                    return;
                }
                id = int.Parse(item.SubItems[0].Text);
            }
            foreach (ListViewItem item in lstvFoodName.SelectedItems)
            {

                if (lstvFoodName.Items[0].SubItems[0] == null)
                {
                    return;
                }
                idFood = int.Parse(item.SubItems[0].Text);
            }
            FoodDAO.Instance.EditFood(idFood, name, idCategory, price);
            LoadFood(id);
        }

        private void btnFoodDeleteFood_Click(object sender, EventArgs e)
        {
            int idFood = 0;
            int id = 0;
            foreach (ListViewItem item in lstvFoodCategory.SelectedItems)
            {

                if (lstvFoodCategory.Items[0].SubItems[0] == null)
                {
                    return;
                }
                id = int.Parse(item.SubItems[0].Text);
            }
            foreach (ListViewItem item in lstvFoodName.SelectedItems)
            {

                if (lstvFoodName.Items[0].SubItems[0] == null)
                {
                    return;
                }
                idFood = int.Parse(item.SubItems[0].Text);
            }
            FoodDAO.Instance.DeleteFood(idFood);
            LoadFood(id);
        }


    }
}
