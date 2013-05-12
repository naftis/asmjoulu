# runserver.coffee
fs = require 'fs'

config = JSON.parse fs.readFileSync 'config.json'
config.dirRoot = __dirname

httpd = require('./src/server/server').createServer config
httpd.listen(61768)
