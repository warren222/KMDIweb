using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KMDIweb.KMDIweb.AE.AccountingClearance
{
    public class AC_RequestModel
    {
        public string Id { get; set; }
        public string Project_Label { get; set; }
        public string Job_Order_No { get; set; }
        public string Parentjono { get; set; }
        public string FullAdd { get; set; }
        public string Acct_Exec_Incharge { get; set; }
        public string Collection_Per { get; set; }
        public string Status { get; set; }
        public string Status_Date { get; set; }
        public string Hold_Reason { get; set; }
        public List<JO_ListModel> JO_List { get; set; }
    }
}