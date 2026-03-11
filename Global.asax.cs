using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
//using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;

namespace DOAN_HQTCSDL
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/Scripts/jquery-3.6.0.min.js",  // Đảm bảo đúng đường dẫn file jQuery
                DebugPath = "~/Scripts/jquery-3.6.0.js",
                CdnPath = "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js",
                CdnDebugPath = "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.js"
            });
        }
    }
}