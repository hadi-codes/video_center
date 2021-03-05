// DB.js config for your database  
const mysql = require("mysql");

const config = {  
user: 'root',  
password: '',  
server: "localhost",  
port :3306,
database: "video_center"  
}  



// Create a connection to the database
const connection = mysql.createConnection({
  host: config.server,
  user: config.user,
  password: config.password,
  database: config.database,
  port:config.port
});

// open the MySQL connection
connection.connect(error => {
  if (error) throw error;
  console.log("Successfully connected to the database.");
});

module.exports = connection;