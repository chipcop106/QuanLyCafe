using System.Collections.Generic;
using System.Data;
using QuanLyCF.DTO;

namespace QuanLyCF.DAO
{
     public class FoodDAO
    {
        private static FoodDAO instance;
        public static FoodDAO Instance
        {
            get { if (instance == null) instance = new FoodDAO(); return FoodDAO.instance; }
            private set { FoodDAO.instance = value; }
        }
        private FoodDAO() { }

        public List<Food> GetFoodByCategoryID(int id)
        {
            List<Food> listfood = new List<Food>();
            string query = "select * from dbo.Food where idCategory = "+id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                Food f = new Food(item);
                listfood.Add(f);
            }
            return listfood;
        }

        public List<Food> GetListFood()
        {
            List<Food> listfood = new List<Food>();
            string query = "select * from dbo.Food";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                Food f = new Food(item);
                listfood.Add(f);
            }
            return listfood;
        }
        public void AddFood(string name, int idCategory, float price)
        {
            DataProvider.Instance.ExecuteQuery("Insert into dbo.Food values ('" + name + "','"+idCategory+ "'," + price + ")");
        }
        public void EditFood(int id,string name,int idCategory, float price)
        {
            DataProvider.Instance.ExecuteQuery("Update dbo.Food set name = '"+name+"',idCategory='"+idCategory+"',price='"+price+"'where id ="+id);
        }
        public void DeleteFood(int id)
        {
            DataProvider.Instance.ExecuteQuery("delete from dbo.Food where id =" + id);
        }
    }
}
