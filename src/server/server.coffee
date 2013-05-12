express = require 'express'
fs = require 'fs'

module.exports.createServer = (config) ->
  app     = express()
  httpd   = require('http').createServer(app)

  app.configure ->
    app.use express.static('public')
 
    app.set 'view engine', 'jade'
    app.set 'views', 'src/jade/'

    app.use express.bodyParser()
    
    auth = express.basicAuth (user, pass) ->
      return true for keypair in config.auth when keypair[0] == user and keypair[1] == pass
      return false

    app.get "/.data/participates.json", auth, (req, res) ->

      file = fs.readFileSync 'participates.json'

      res.setHeader 'Content-Type', 'application/json;charset=utf-8'
      res.setHeader 'Content-Length', file.length
      res.end file

    app.get "/", (req, res) ->
      #res.sendfile('public/index.html')
      json = JSON.parse fs.readFileSync 'participates.json'

      sorted = json.participates.sort (a, b) ->
        result = a.group.localeCompare b.group

        if result is 0
          if a.other is 'J\u00e4rjest\u00e4j\u00e4'
            result = -1
          else if b.other is 'J\u00e4rjest\u00e4j\u00e4'
            result = 1

          if result is 0
            result = a.name.localeCompare b.name
        result

      res.render 'index',
        participates: sorted

    app.get "/hallitse", (req, res) ->
      json = fs.readFileSync 'participates.json'

      res.render 'hallitse',
        jsoncontents: json

    app.post "/hallitse", (req, res) ->
      console.log req.body

      json = fs.readFileSync 'participates.json'

      res.render 'hallitse',
        jsoncontents: json

  return httpd
