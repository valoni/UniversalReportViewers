<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Microsoft.Reporting.WebForms" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>

<%@ Page Language="c#"%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>


<script runat="server">
		protected void Page_Load(object sender, EventArgs e)
		{
			string ConnSTR = "Data Source=.\\SqlExpress2016;Initial Catalog=Northwind;User Id=sa;Password=sa;";
			string SQLSelect = "Select * From Employees";
		
			if (!IsPostBack)
			{
				reports("test",retDataTable(ConnSTR,SQLSelect));
		
			}
		
		}
	
	
		private void reports(string report, DataTable mydtb)
		{
			ReportViewer1.ProcessingMode = ProcessingMode.Local;
			ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/rpt/"+report+".rdl");
			ReportDataSource datasource = new ReportDataSource("DataSet1", mydtb);
			ReportViewer1.LocalReport.DataSources.Clear();
			ReportViewer1.LocalReport.DataSources.Add(datasource);

		}
   
		public static DataTable retDataTable(string ConStr,string SqlCmdStr)
        {
            SqlConnection SqlConn = new SqlConnection(ConStr);

   
            SqlConn.Open();
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(SqlCmdStr, SqlConn);
            da.Fill(ds);
            SqlConn.Close();

            return ds.Tables[0];
        }

</script>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BVB Reporting System</title>
</head>
<body>
	
    <form id="postForm" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
		<div style="width:100%; height:100%">
			<rsweb:ReportViewer ID="ReportViewer1" runat="server" Height="900px" Width="100%" ExportContentDisposition="AlwaysInline" style="left: 1px; top: 1px;" ShowFindControls="False"  ShowZoomControl="False" ShowBackButton="False">
			</rsweb:ReportViewer>
		</div>
   </form>
</body>
</html>