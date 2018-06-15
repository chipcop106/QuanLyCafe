using System.Data;

namespace QuanLyCF.DTO
{
    public class BillInfo
    {
        private int iD;
        private int idBill;
        private int idFood;
        private int count;

        public BillInfo(int id, int idBill, int idFood, int count)
        {
            this.ID = id;
            this.IdBill = idBill;
            this.IdFood = idFood;
            this.Count = count;
        }

        public BillInfo(DataRow row)
        {
            this.ID = (int) row["id"];
            this.IdBill = (int) row["idBill"];
            this.IdFood = (int) row["idFood"];
            this.Count = (int) row["count"];
        }
        public int ID { get => iD; set => iD = value; }
        public int IdBill { get => idBill; set => idBill = value; }
        public int IdFood { get => idFood; set => idFood = value; }
        public int Count { get => count; set => count = value; }
    }
}
