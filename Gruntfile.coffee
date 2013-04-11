module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    meta:
      banner: '// <%= pkg.name %> v<%= pkg.version %> - by Rob Audenaerde\n'

    clean:
      build: ['dist/']

    watch:
      scripts:
        files: ['source/jquery.resizeable-tables.coffee']
        tasks: ['coffee', 'coffeelint']

    coffee:
      options:
        bare: true
      compile:
        files:
          'dist/jquery.resizeable-tables.js': 'source/jquery.resizeable-tables.coffee'

    uglify:
      options:
        banner: '<%= meta.banner %>'
      all:
        files:
          'dist/jquery.resizeable-tables.min.js': ['dist/jquery.resizeable-tables.js']

    coffeelint:
      build:
        files:
          src: ['source/*.coffee']
      options:
        no_tabs:
          level: 'error'
        no_trailing_whitespace:
          level: 'error'
        max_line_length:
          value: 80
          level: 'error'
        camel_case_classes:
          level: 'error'
        indentation:
          value: 2
          level: 'error'
        no_implicit_braces:
          level: 'ignore'
        no_trailing_semicolons:
          level: 'error'
        no_plusplus:
          level: 'ignore'
        no_throwing_strings:
          level: 'error'
        cyclomatic_complexity:
          value: 10
          level: 'ignore'
        no_backticks:
          level: 'error'
        line_endings:
          value: 'unix'
          level: 'error'

    jshint:
      all: ['dist/jquery.resizeable-tables.js']
      options:
        boss: true
        curly: false
        eqeqeq: true
        immed: false
        latedef: true
        newcap: true
        noarg: true
        sub: true
        undef: true
        eqnull: true
        node: true
        loopfunc: true

        globals:
          jQuery: true

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  # Tasks
  grunt.registerTask 'default', ['coffee', 'coffeelint', 'jshint', 'uglify']
