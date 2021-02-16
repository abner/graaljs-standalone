const Class = Java.type("java.lang.Class");
const Properties = Java.type("java.util.Properties");
const DriverManager = Java.type("java.sql.DriverManager");

// load postgresql JDBC Driver
Class.forName("org.postgresql.Driver");

var props = new Properties();
props.setProperty("user", "pguser");
props.setProperty("password", "pgpassword");
props.setProperty("ssl", "false");

var url = "jdbc:postgresql://localhost:5432/pgdb";

var conn = DriverManager.getConnection(url, props);

var st = conn.createStatement();
var rs = st.executeQuery("SELECT * FROM pgtable");
var rowCount = 0;
while (rs.next()) {
  rowCount++;
  console.log(`Row ${rowCount}\t::::\t${rs.getString(1)}\t|\t${rs.getString(2)}`);
}
rs.close();
st.close();

// String url = "jdbc:postgresql://localhost/test?user=fred&password=secret&ssl=true";
//Connection conn = DriverManager.getConnection(url);
