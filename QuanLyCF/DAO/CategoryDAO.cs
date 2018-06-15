using System.Collections.Generic;
using System.Data;
using QuanLyCF.DTO;

namespace QuanLyCF.DAO
{
    public class CategoryDAO
    {
        private static CategoryDAO instance;
        public static CategoryDAO Instance
        {
            get { if (instance == null) instance = new CategoryDAO(); return CategoryDAO.instance; }
            private set { CategoryDAO.instance = value; }
        }
        private CategoryDAO() { }

        public List<Category> GetListCategory()
        {
            List<Category> listcategory = new List<Category>();
            string query = "select * from dbo.FoodCategory";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                Category category = new Category(item);
                listcategory.Add(category);
            }
            return listcategory;
        }

        public void AddCategory(string name)
        {
            DataProvider.Instance.ExecuteQuery("Insert into dbo.FoodCategory values ('" + name + "')");
        }
        public void EditCategory(string name,int id)
        {
            DataProvider.Instance.ExecuteQuery("Update dbo.FoodCategory set name='"+name+"'where id ="+id);
        }

    }
}
