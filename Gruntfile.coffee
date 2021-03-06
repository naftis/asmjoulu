module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        options:
          flatten: false
          bare: false

      glob_to_multiple: 
        expand: true
        cwd: 'src/coffee'
        src: ['*.coffee']
        dest: 'public/js/modules/'
        ext: '.js'
      
#     jade:
#       compile:
#         files:
#           "public/index.html": "src/jade/index.jade"

    stylus:
      compile:
        files:
          "public/css/styles.css": "src/stylus/*.styl"

        options:
          compress: true

    regarde:
      coffee:
        files: ["src/coffee/**/*.coffee"]
        tasks: ["coffee"]

      stylus:
        files: ["src/stylus/*.styl"]
        tasks: ["stylus"]

#       jade:
#         files: ["src/jade/*.jade"]
#         tasks: ["jade"]

#    reload:
#      port: 30424
#      proxy:
#        host: 'localhost'
#        port: 61768

  #grunt.loadNpmTasks "grunt-reload"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-regarde"

  grunt.registerTask "server", () ->
    execServer = () ->
      exec = 'node_modules/coffee-script/bin/coffee'
      exec = __dirname + '/node_modules/.bin/coffee.cmd' if process.platform is 'win32'
      serverProc = require('child_process').spawn exec, ['runserver.coffee'],
        stdio: 'inherit'
      console.log serverProc.pid
    
    if serverProc?
      console.log "trying to kill old server " + serverProc.pid
    
      serverProc.on 'close', ->
        console.log serverProc     
        setTimeout ->
          execServer()
        , 5000
      serverProc.kill()
    else
      execServer()

  grunt.registerTask "default", ['coffee',  'stylus', 'server', 'regarde']
