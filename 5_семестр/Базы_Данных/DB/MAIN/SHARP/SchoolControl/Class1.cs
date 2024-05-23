using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SchoolControl
{
    class Class1
    {
        [SqlFunction()]
        static public SqlBoolean isPos(SqlString st_wealth)
        {
            string str = st_wealth.ToString();
            bool fl = false;
            char symbol = '-';
            if (str.Contains(symbol))
            {
                fl = true;
            }
            return (SqlBoolean)fl;
        }
    }
}
