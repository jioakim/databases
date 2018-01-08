var models = require('../models');
var dbSquel = require('../db/index.js');
var sequelize = require('sequelize');

module.exports = {
  messages: {
    get: function (req, res) {
      // models.messages.get(function(results){
        var results = '';
      dbSquel.Messages.findAll(
        {
          attributes: [
            'text',
            'roomId',
            'userId',
            [sequelize.col('username'), 'username']
            //sequelize.col('dbSquel.Users.username')
          ],
          include: [{
            model: dbSquel.Users,
            attributes: ['username']
          }]
        }
      ).
        then(text => results = text).
        then( () => {
            // loop through the resulrs array
            // for each object find the 'user' key which is it selft an object
            // replace this object with the actual value of its username key
            res.writeHead(200, {'Content-Type': 'application/json'});
            res.end(JSON.stringify({results: results}))
            // we can also use res.json(...) and get rid of both lines
          }
        );
    }, // a function which handles a get request for all messages



    post: function (req, res) {
      var message = '';
      var headers = {};
      var messageBody = req.body;
      if (Object.keys(messageBody).length > 0) {
        models.messages.post(messageBody, function() {
          headers['Content-Type'] = 'application/json';
          res.writeHead(201, headers);
          res.end(JSON.stringify(messageBody));
        });
      } else {
        req.on('data', function(chunk) {
          message += chunk;
        }).on('end', function() {

          message = JSON.parse(message);
          models.messages.post(message, function() {
            headers['Content-Type'] = 'application/json';
            res.writeHead(201, headers);
            res.end(JSON.stringify(message));
          });
        });
      } // a function which handles posting a message to the database
    }
  },

  users: {
    // Ditto as above
    get: function (req, res) {
      models.users.get(function(results) {
        res.writeHead(200, {'Content-Type': 'application/json'});
        res.end(JSON.stringify({results: results}));
      });
    },

    post: function (req, res) {
      console.log('inside user post controller');
      var user = '';
      var headers = {};
      var username = req.body.username;
      models.users.post(username, function() {
        //console.log('inside user post controller db', req.body);
        headers['Content-Type'] = 'application/json';
        res.writeHead(201, headers);
        res.end(JSON.stringify('success'));
      });
      // req.on('data', function(chunk) {
      //   user += chunk;
      // }).on('end', function() {

      //   user = JSON.parse(user);
      //   models.users.post(user, function() {
      //     headers['Content-Type'] = 'application/json';
      //     res.writeHead(201, headers);
      //     res.end(JSON.stringify('success'));
      //   });
      // }); // a function which handles posting a user to the database
    }
  }
};
