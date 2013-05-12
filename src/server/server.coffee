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

    app.get '/.data/participates.json', auth, (req, res) ->

      file = fs.readFileSync 'participates.json'

      res.setHeader 'Content-Type', 'application/json;charset=utf-8'
      res.setHeader 'Content-Length', file.length
      res.end file

    app.get '/', (req, res) ->
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

    app.get '/hallitse/:file', auth, (req, res) ->
      file = fs.readFileSync 'backups/' + req.params.file

      res.setHeader 'Content-Type', 'application/json;charset=utf-8'
      res.setHeader 'Content-Length', file.length
      res.end file

    app.get '/hallitse', auth, (req, res) ->
      json = fs.readFileSync 'participates.json'
      file = fs.readdirSync 'backups'

      fileArr = file.sort (a, b) ->
        b.localeCompare a

      res.render 'hallitse',
        jsoncontents: json
        backups: fileArr

    app.post '/hallitse', auth, (req, res) ->
      # req.body.json
      currenttime = new Date().getTime()

      stream = fs.createReadStream 'participates.json'
      stream.pipe(fs.createWriteStream 'backups/participates.'+currenttime+'.json')

      stream.on 'close', ->
        fs.writeFile 'participates.json', req.body.json, (err) ->
          res.redirect '/hallitse'

  return httpd
