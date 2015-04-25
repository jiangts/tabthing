"use strict"
request = require("request")
module.exports = (grunt) ->
  
  # show elapsed time at the end
  require("time-grunt") grunt
  
  # load all grunt tasks
  require("load-grunt-tasks") grunt
  reloadPort = 35729
  files = undefined
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    develop:
      server:
        file: "bin/www"
        cmd: "coffee"

    watch:
      options:
        nospawn: true
        livereload: reloadPort

      server:
        files: [
          "bin/www"
          "app.coffee"
          "routes/*.coffee"
        ]
        tasks: [
          "develop"
          "delayed-livereload"
        ]

      coffee:
        files: ["public/coffee/*.coffee"]
        options:
          livereload: reloadPort

      js:
        files: ["public/js/*.js"]
        options:
          livereload: reloadPort

      css:
        files: ["public/css/*.css"]
        options:
          livereload: reloadPort

      views:
        files: ["views/*.jade"]
        options:
          livereload: reloadPort

  grunt.config.requires "watch.server.files"
  files = grunt.config("watch.server.files")
  files = grunt.file.expand(files)
  grunt.registerTask "delayed-livereload", "Live reload after the node server has restarted.", ->
    done = @async()
    setTimeout (->
      request.get "http://localhost:" + reloadPort + "/changed?files=" + files.join(","), (err, res) ->
        reloaded = not err and res.statusCode is 200
        if reloaded
          grunt.log.ok "Delayed live reload successful."
        else
          grunt.log.error "Unable to make a delayed live reload."
        done reloaded
        return

      return
    ), 500
    return

  grunt.registerTask "default", [
    "develop"
    "watch"
  ]
  return
