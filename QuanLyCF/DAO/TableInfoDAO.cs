using System.Collections.Generic;
using System.Data;
using QuanLyCF.DTO;

namespace QuanLyCF.DAO
{
    public class TableInfoDAO
    {
        private static TableInfoDAO instance;
        public static TableInfoDAO Instance
        {
            get { if (instance == null) instance = new TableInfoDAO(); return TableInfoDAO.instance; }
            private set { TableInfoDAO.instance = value; }
        }
        private TableInfoDAO() { }

        public List<TableInfo> GetTableInfoByTable(int id)
        {
            List<TableInfo> listTableInfo = new List<TableInfo>();
            string query =
                "select f.id ,f.name,f.price,fc.name as category,bi.count, f.price*bi.count as totalPrice from dbo.FoodCategory as fc, dbo.Food as f,dbo.Bill as b,dbo.BillInfo as bi where bi.idBill = b.id and bi.idFood = f.id and fc.id = f.idCategory and b.status = 0 and b.idTable = " +
                id;
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                TableInfo tableinfo = new TableInfo(item);
                listTableInfo.Add(tableinfo);
            }

            return listTableInfo;
        }
    }
}
