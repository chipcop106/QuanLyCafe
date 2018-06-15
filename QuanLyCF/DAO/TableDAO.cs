using System.Collections.Generic;
using System.Data;
using QuanLyCF.DTO;

namespace QuanLyCF.DAO
{
public class TableDAO
    {
        private static TableDAO instance;
        public static TableDAO Instance
        {
            get { if (instance == null) instance = new TableDAO(); return TableDAO.instance; }
            private set { TableDAO.instance = value; }
        }
        private TableDAO() { }
        public static int TableWidth = 112;
        public static int TableHeight = 112;

        public List<Table> LoadTableList()
        {
            List<Table> tablelist = new List<Table>();
            DataTable data = DataProvider.Instance.ExecuteQuery("USP_GetTableList");
            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                tablelist.Add(table);
            }
            return tablelist;
        }

        public void InsertTable(string name)
        {
            DataProvider.Instance.ExecuteQuery("insert into dbo.TableFood (name) values ('" + name + "')");
        }
        public void EditTable(string name,int id)
        {
            DataProvider.Instance.ExecuteQuery("Update dbo.TableFood set name='" + name+"'where id="+id);
        }
        public void SwitchTable(int idOld,int idNew)
        {
            DataProvider.Instance.ExecuteQuery("USP_SwitchTabel @idTable1 , @idTable2", new object[] {idOld, idNew});
        }
        public void GroupTable(int idOld, int idNew)
        {
            DataProvider.Instance.ExecuteQuery("USP_GroupTable @idTable1 , @idTable2", new object[] { idOld, idNew });
        }

    }
}
