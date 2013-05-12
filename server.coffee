express = require('express')

module.exports.createServer = () ->
  app     = express()
  httpd   = require('http').createServer(app)
  app.use express.static('public')

  app.configure ->
    app.get "*", (req, res) ->
      res.sendfile('public/index.html')

  return httpd