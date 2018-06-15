using System.Collections.Generic;
using System.Data;
using QuanLyCF.DTO;

namespace QuanLyCF.DAO
{
public class AccountDAO
    {
        private static AccountDAO instance;
        public static AccountDAO Instance
        {
            get { if (instance == null) instance = new AccountDAO(); return AccountDAO.instance; }
            private set { AccountDAO.instance = value; }
        }
        private AccountDAO() { }
        public bool Login(string userName, string passWord)
        {
            string query = "USP_Login @userName , @passWord";
            DataTable result = DataProvider.Instance.ExecuteQuery(query, parameter: new object[]{ userName, passWord });
            return result.Rows.Count>0;
        }

        public bool AdminCheck(string userName, string passWord)
        {
            string query = "USP_AdminCheck @userName , @passWord";
            DataTable result = DataProvider.Instance.ExecuteQuery(query, parameter: new object[] { userName, passWord });
            return result.Rows.Count > 0;
        }

        public List<Account> GetListAccount()
        {
            List<Account> listaccount = new List<Account>();
            string query = "select [ID], [UserName], [DisplayName], [PassWord], [Type] from dbo.Account";
            DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (DataRow item in data.Rows)
            {
                Account acc = new Account(item);
                listaccount.Add(acc);
            }
            return listaccount;
        }
        public void AddAccount(string userName, string displayName, string passWord,int type)
        {
            DataProvider.Instance.ExecuteQuery("Insert into dbo.Account values ('" + userName + "','"+displayName+ "','" + passWord + "'," + type + ")");
        }
        public void EditAccount(int id,string userName, string displayName, string passWord, int type)
        {
            DataProvider.Instance.ExecuteQuery("Update dbo.Account set DisplayName='"+ displayName + "',PassWord='"+ passWord + "',Type="+type+" where id ="+ id);
        }
        public void DeleteAccount(int id)
        {
            DataProvider.Instance.ExecuteQuery("delete from dbo.Account where id =" + id);
        }
    }
}
