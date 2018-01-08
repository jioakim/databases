var mysql = require('mysql');

// Create a database connection and export it from this file.
// You will need to connect with the user "root", no password,
// and to the database "chat".

var dbConnection = mysql.createConnection({
  user: 'kevinroot',
  password: 'codeDoggy',
  host:'hr-rpt01.cybvxu5jsrlj.us-east-1.rds.amazonaws.com',
  database: 'chat'
});

module.exports = dbConnection;
