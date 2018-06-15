using System.Data;

namespace QuanLyCF.DTO
{
    public class Table
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Status { get;set;}

        public Table(int id, string name, string status)
        {
            this.ID = id;
            this.Name = name;
            this.Status = status;
        }

        public Table(DataRow row)
        {
            this.ID = (int)row["id"];
            this.Name = row["name"].ToString();
            this.Status = row["status"].ToString();
        }
    }
    
}
