using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace KMDIweb.SCREENfab
{
    public class ConnectionString
    {
        static string con = string.Empty;
        static string conInventory = string.Empty;
        public static string getConnectionString(string server)
        {
            string connectionstring = string.Empty;
            switch (server)
            {
                case "server1":
                    connectionstring = ConfigurationManager.ConnectionStrings["sqlcon"].ConnectionString;
                    break;
                case "server2":
                    connectionstring = ConfigurationManager.ConnectionStrings["sqlcon2"].ConnectionString;
                    break;
                default:
                    break;
            }
            con = connectionstring;
            return connectionstring;
        }
        public static string getConnectionStringInventory(string server)
        {
            string connectionstring = string.Empty;
            switch (server)
            {
                case "server1":
                    connectionstring = ConfigurationManager.ConnectionStrings["sqlconInventory"].ConnectionString;
                    break;
                case "server2":
                    connectionstring = ConfigurationManager.ConnectionStrings["sqlconInventory2"].ConnectionString;
                    break;
                default:
                    break;
            }
            conInventory = connectionstring;
            return connectionstring;
        }
        public static string sqlconstr()
        {

            return con;
        }
        public static string sqlconstrInventory()
        {
            return conInventory;
        }
    }
}