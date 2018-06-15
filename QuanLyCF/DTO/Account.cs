using System.Data;

namespace QuanLyCF.DTO
{
    public class Account
    {
        private int iD;
        private string userName;
        private string displayName;
        private string passWord;
        private int type;
       


        public Account(int iD,string userName, string displayName ,string passWord , int type)
        {
            this.ID = iD;
            this.UserName = userName;
            this.DisplayName = displayName;
            this.PassWord = passWord;
            this.Type = type;
        }

        public Account(DataRow row)
        {
            this.ID = (int) row["ID"];
            this.UserName = row["UserName"].ToString();
            this.DisplayName = row["DisplayName"].ToString();
            this.PassWord = row["PassWord"].ToString();
            this.Type = (int)row["Type"];
        }
        public string UserName { get => userName; set => userName = value; }
        public string DisplayName { get => displayName; set => displayName = value; }
        public string PassWord { get => passWord; set => passWord = value; }
        public int Type { get => type; set => type = value; }
        public int ID { get => iD; set => iD = value; }
    }
}
