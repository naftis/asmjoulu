serverProc = null

module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          "public/js/modules/*.js": "src/coffee/**/*.coffee"

        options:
          flatten: false
          bare: false

    jade:
      compile:
        files:
          "public/index.html": "src/jade/index.jade"
    stylus:
      compile:
        files:
          "public/css/*.css" : "src/stylus/*.styl"
        options:
          compress: true

    server:
      port: 30424
      base: "public"

    watch:
      server:
        files: ["runserver.coffee", "src/server/**/*.coffee"]
        tasks: ["server", "reload"]

      coffee:
        files: ["src/coffee/**/*.coffee"]
        tasks: ["coffee", "reload"]

      stylus:
        files: ["src/stylus/*.styl"]
        tasks: ["stylus", "reload"]

      jade:
        files: ["src/jade/*.jade"]
        tasks: ["jade", "reload"]

    reload:
      port: 61768
      proxy:
        host: 'localhost'
        port: 30424

  grunt.loadNpmTasks "grunt-shell"
  grunt.loadNpmTasks "grunt-reload"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-contrib-connect"

  grunt.registerTask "server", () ->
    execServer = () ->
      serverProc = require('child_process').spawn 'node_modules/coffee-script/bin/coffee', ['runserver.coffee'],
        stdio: 'inherit'
    if serverProc?
      console.log "trying to kill old server"
      serverProc.on 'close', execServer
      serverProc.kill()
    else
      execServer()

  grunt.registerTask "default", "coffee jade stylus server reload watch"
  grunt.registerTask "compile", "coffee jade stylus"