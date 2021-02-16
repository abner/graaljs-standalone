const Class = Java.type("java.lang.Class");
const Properties = Java.type("java.util.Properties");
const DriverManager = Java.type("java.sql.DriverManager");
const System = Java.type("java.lang.System");

// load postgresql JDBC Driver
Class.forName("org.postgresql.Driver");

var props = new Properties();
props.setProperty("user", "pguser");
props.setProperty("password", "pgpassword");
props.setProperty("ssl", "false");

var pgport = System.getProperty("postgres.port") || 5432;

var url = `jdbc:postgresql://localhost:${pgport}/pgdb`;

console.log(`--------------------------------------------------------------`)
console.log(`GRAAL JS - Postgres script - PG Port: ${pgport}`);
console.log(`--------------------------------------------------------------`)

var conn = DriverManager.getConnection(url, props);

var st = conn.createStatement();
var rs = st.executeQuery("SELECT * FROM pgtable");
var rowCount = 0;
console.log(`--------------------------------------------------------------`)
while (rs.next()) {
  rowCount++;
  console.log(`Row ${rowCount}\t::::\t${rs.getString(1)}\t|\t${rs.getString(2)}`);
}
console.log(`--------------------------------------------------------------`)
rs.close();
st.close();

// String url = "jdbc:postgresql://localhost/test?user=fred&password=secret&ssl=true";
//Connection conn = DriverManager.getConnection(url);
