# runserver.coffee
httpd = require('./src/server/server').createServer()
httpd.listen(30424)