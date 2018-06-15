using System.Data;

namespace QuanLyCF.DTO
{
    public class Category
    {
        private int iD;
        private string name;

        public Category(int id, string name)
        {
            this.ID = id;
            this.name = name;
        }

        public Category(DataRow row)
        {
            this.ID = (int) row["id"];
            this.name = row["name"].ToString();
        }
        public int ID { get => iD; set => iD = value; }
        public string Name { get => name; set => name = value; }
    }
}
