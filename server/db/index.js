var mysql = require('mysql');
var Sequelize = require('sequelize');
// Create a database connection and export it from this file.
// You will need to connect with the user "root", no password,
// and to the database "chat".

var db = new Sequelize('mysql://kevinroot:codeDoggy@hr-rpt01.cybvxu5jsrlj.us-east-1.rds.amazonaws.com/chat');

db
.authenticate()
.then(() => {
  console.log('Connection has been established successfully.');
})
.catch(err => {
  console.error('Unable to connect to the database:', err);
});

const Users = db.define('users', {
  //uid: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true},
  username: Sequelize.STRING
});

const Messages = db.define('messages', {
  //mid: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true},
  text: Sequelize.TEXT,
  createdAt: { type: Sequelize.DATE, defaultValue: Sequelize.NOW },
  updatedAt: { type: Sequelize.DATE, defaultValue: Sequelize.NOW }
});

const Rooms = db.define('rooms', {
  //rid: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true},
  roomname: Sequelize.STRING
});

Users.hasMany(Messages);
Messages.belongsTo(Users);
Rooms.hasMany(Messages);

// Users.sync().then(() => {
//   // Table created
//   return Users.create({
//     username: 'John'
//   });
// });
Users.sync();

Rooms.sync();

Messages.sync();

// Messages.findAll().
// then(text => {console.log("Messages: ", text)});

var dbConnection = mysql.createConnection({
  user: 'kevinroot',
  password: 'codeDoggy',
  host:'hr-rpt01.cybvxu5jsrlj.us-east-1.rds.amazonaws.com',
  database: 'chat'
});

var dbSquel = { Messages: Messages, Rooms: Rooms, Users: Users };

module.exports = dbConnection;
module.exports = dbSquel;
