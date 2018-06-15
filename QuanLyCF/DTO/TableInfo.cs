using System;
using System.Data;

namespace QuanLyCF.DTO
{
    public class TableInfo
    {
        private int iD;
        private string foodName;
        private int count;
        private float price;
        private string categoryName;
        private float totalPrice;

        public TableInfo(int id,string foodName,string categoryName ,int count, float price, float totalPrice = 0)
        {
            this.ID = id;
            this.FoodName = foodName;
            this.CategoryName = categoryName;
            this.Count = count;
            this.Price = price;
            this.TotalPrice = totalPrice;
        }

        public TableInfo(DataRow row)
        {
            this.ID = (int) row["id"];
            this.FoodName = row["name"].ToString();
            this.CategoryName = row["category"].ToString();
            this.Price = (float) Convert.ToDouble((row["price"]));
            this.Count = (int) row["count"];
            this.TotalPrice = (float) Convert.ToDouble(row["totalPrice"]);
        }
        public string FoodName { get => foodName; set => foodName = value; }
        public int Count { get => count; set => count = value; }
        public float Price { get => price; set => price = value; }
        public float TotalPrice { get => totalPrice; set => totalPrice = value; }
        public string CategoryName { get => categoryName; set => categoryName = value; }
        public int ID { get => iD; set => iD = value; }
    }
}
