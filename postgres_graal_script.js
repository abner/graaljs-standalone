const Class = Java.type("java.lang.Class");
const Properties = Java.type("java.util.Properties");
const DriverManager = Java.type("java.sql.DriverManager");
const System = Java.type("java.lang.System");

// load postgresql JDBC Driver
Class.forName("org.postgresql.Driver");

const props = new Properties();
props.setProperty("user", "pguser");
props.setProperty("password", "pgpassword");
props.setProperty("ssl", "false");

const pgport = System.getProperty("postgres.port") || 5432;

const url = `jdbc:postgresql://localhost:${pgport}/pgdb`;

console.log(`--------------------------------------------------------------`)
console.log(`GRAAL JS - Postgres script - PG Port: ${pgport}`);
console.log(`--------------------------------------------------------------`)

const conn = DriverManager.getConnection(url, props);

const st = conn.createStatement();
const rs = st.executeQuery("SELECT * FROM pgtable");
let rowCount = 0;
console.log(`--------------------------------------------------------------`)
while (rs.next()) {
  rowCount++;
  console.log(`Row ${rowCount}\t::::\t${rs.getString(1)}\t|\t${rs.getString(2)}`);
}
console.log(`--------------------------------------------------------------`)
rs.close();
st.close();
conn.close();

