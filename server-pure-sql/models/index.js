var db = require('../db');

var getUserID = function(username, callback) {
  var queryString = 'SELECT uid from users where username = ' + JSON.stringify(username);
  var myQuery = db.query(queryString, function(err, userID) {
    if (err) {
      console.log('UserID lookup error: ', err);
    } else {

      console.log('userID: ', userID);
      if (userID.length === 0) {
        var createNewUser = 'INSERT into users (`username`) VALUES (?)';
        var queryArgs = [username];
        db.query(createNewUser, queryArgs, function(err, newUser) {
          if (err) {
            console.log('error creating new user: ', err);
          } else {
            newUser = JSON.parse(JSON.stringify(newUser)).insertId;
            callback(newUser);
          }
        });

      } else {
        var userID = JSON.stringify(userID);
        callback(JSON.parse(userID)[0].uid);
      }
    }
  });
};

var getRoomID = function(roomname, callback) {
  var queryString = 'SELECT rid from rooms where roomname = ' + JSON.stringify(roomname);
  var myQuery = db.query(queryString, function(err, roomID) {
    if (err) {
      console.log('RoomID lookup error: ', err);
    } else {
      //console.log('userID: ', userID);
      if (roomID.length === 0) {
        var createNewRoom = 'INSERT into rooms (`roomname`) VALUES (?)';
        var queryArgs = [roomname];
        db.query(createNewRoom, queryArgs, function(err, newRoom) {
          if (err) {
            console.log('error creating new room: ', err);
          } else {
            newRoom = JSON.parse(JSON.stringify(newRoom)).insertId;
            callback(newRoom);
          }
        });

      } else {
        var roomID = JSON.stringify(roomID);
        callback(JSON.parse(roomID)[0].rid);
      }
    }
  });
};

module.exports = {
  messages: {
    get: function(callback) {
      //db.connect();
      var queryString = 'SELECT messages.mid AS objectId, users.username, rooms.roomname, messages.text, messages.createdAt as created, messages.updatedAt FROM users INNER JOIN (rooms INNER JOIN messages ON rooms.rid = messages.rid_rooms) ON users.uid = messages.uid_users order by ?? desc limit ?';
      var queryArgs = ['created', 100];
      var myQuery = db.query(queryString, queryArgs, function(err, results) {
        if (err) {
          console.log('Query error:', err);
        } else {
          callback(results);
        }
      });

    }, // a function which produces all the messages


    post: function(message, callback) {
        getUserID(message.username, function(userID) {
          getRoomID(message.roomname, function(roomID) {
            var queryString = 'INSERT into messages (`uid_users`, `rid_rooms`, `text`) VALUES (?, ?, ?)';
            var queryArgs = [userID, roomID, message.text];
            var myQuery = db.query(queryString, queryArgs, function(err, results) {
            console.log(myQuery.sql);
              if (err) {
                console.log('Query error:', err);
              } else {
                callback();
              }
            });
          });
        });

        // read object and check if user exists in table
        //  sql insert
      } // a function which can be used to insert a message into the database
  },

  users: {
    // Ditto as above.
    get: function(callback) {
      var queryString = 'SELECT * FROM users';
      db.query(queryString, function(err, results){
        if (err) {
          console.log('Query users error:', err);
        } else {
          callback(results);
        }
      });
    },
    post: function(user, callback) {
      console.log('inside user post model');
      getUserID(user, function(userID) {
        callback();
      });
    }
  }
};



// SELECT messages.mid AS objectId, users.username, rooms.roomname, messages.body FROM users INNER JOIN (rooms INNER JOIN messages ON rooms.[rid] = messages.rid_rooms) ON users.[uid] = messages.uid_users;

// var queryString = 'select m.mid as objectId, u.username, m.text, r.roomname, m.createdAt, m.updatedAt from messages as m, users as u, rooms as r';
