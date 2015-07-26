module.exports = (grunt) ->
  pkg = grunt.file.readJSON 'package.json'
  #config
  grunt.initConfig
    dir:
      src: "dev"
      dist: "dist"
    compass:
      dev:
        options:
          sassDir: "<%= dir.src %>/scss"
          cssDir: "<%= dir.dist %>/css"
          imagesDir: "<%= dir.src %>/img"
          noLineComments: true
    autoprefixer:
      options:
        browsers: [ "last 10 version", "ie 9" ]
      dev:
        expand: true
        flatten: true
        src: "<%= dir.dist %>/css/*.css"
        dest: "<%= dir.dist %>/css/"
    csscomb:
      dev:
        expand: true
        flatten: true
        src: "<%= autoprefixer.dev.src %>"
        dest: "<%= autoprefixer.dev.dest %>"
    csslint:
      check:
        src: "<%= autoprefixer.dev.src %>"
    copy:
      spritesImg:
        expand: true
        cwd: "<%= dir.src %>/"
        src: "img/sprites-*.png"
        dest: "<%= dir.dist %>/"
    clean:
      deleteSprites:
        src: "<%= dir.dist %>/img/sprites"
    coffee:
      compile:
        expand: true
        flatten: true
        cwd: "<%= dir.src %>/coffee/"
        src: "*.coffee"
        dest: "<%= dir.dist %>/js/"
        ext: '.js'
    jshint:
      #options:
        #jshintrc: "<%= dir.src %>/coffee/.jshintrc"
      src:
        #cwd: "<%= dir.dist %>/js/"
        src: "<%= dir.dist %>/js/*.js"
    connect:
      server:
        options:
          port: 80
    watch:
      files: ["dev/scss/*.scss", "dev/coffee/*.coffee"]
      tasks: ["compass", "copy:spritesImg", "autoprefixer", "csscomb", "clean:deleteSprites", "coffee", "csslint"]
#"jshint",

  #plugin
  for taskName of pkg.devDependencies
    grunt.loadNpmTasks taskName if taskName.substring(0, 6) is "grunt-"

  #tasks
  grunt.registerTask "default", [
    "connect"
    "watch"
  ]
  grunt.registerTask "dev", [
    "connect"
    "watch"
  ]
  grunt.registerTask "dist", [
    "compass"
    "copy:spritesImg"
    "autoprefixer"
    "csscomb"
    "csslint"
    "clean:deleteSprites"
    "coffee"
    "jshint"
  ]

return
