using System;
using System.Data;
using QuanLyCF.DTO;

namespace QuanLyCF.DAO
{
    public class BillDAO
    {
        private static BillDAO instance;
        public static BillDAO Instance
        {
            get { if (instance == null) instance = new BillDAO(); return BillDAO.instance; }
            private set { BillDAO.instance = value; }
        }
        private BillDAO() { }
        /// <summary>
        /// Thanh cong return ra Bill id
        /// false return -1.
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int GetUcheckBillIdByTableId(int id)
        {
            DataTable data =
                DataProvider.Instance.ExecuteQuery("SELECT * from dbo.Bill WHERE idTable=" + id + "AND status=0");
            if (data.Rows.Count > 0)
            {
                Bill bill = new Bill(data.Rows[0]);
                return bill.ID;

            }
            return -1;
        }

        public void InsertBill(int id)
        {
           DataProvider.Instance.ExecuteNonQuery("exec USP_InsertBill @idTable", new object[]{id});
        }


        public int GetMaxIdBill()
        {
                return (int)DataProvider.Instance.ExecuteScalar("SELECT MAX(id) from dbo.Bill");
           
        }

        public DataTable GetBillListByDate(DateTime checkIn, DateTime checkOut)
        {
            return DataProvider.Instance.ExecuteQuery("exec USP_GetListBillByDate @checkIn , @checkOut", new object[] {checkIn, checkOut});
        }

        public void CheckOut(int id,float totalPrice)
        {
            string query = "UPDATE dbo.Bill SET dateCheckOut = GETDATE(),"+"totalPrice="+totalPrice+",status = 1 where id = "+id;
            DataProvider.Instance.ExecuteNonQuery(query);
        }
    }
}
