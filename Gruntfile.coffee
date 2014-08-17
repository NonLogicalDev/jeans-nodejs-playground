RequreNpmTasks = { #{{{1
  # Wiring bower links into files
  wiredep:  'grunt-wiredep'
  # Injecting custom assets into files
  injector: 'grunt-asset-injector'

  # Converting files
  coffee: 'grunt-contrib-coffee'
  jade:   'grunt-contrib-jade'
  sass:   'grunt-contrib-sass'

  # Clean Up
  clean: 'grunt-contrib-clean'
  
  # For launching grunt tasks with http requests
  serve: 'grunt-serve'
  # For starting an express background server
  express: 'grunt-express-server'
  # Reacting to file changes
  watch: 'grunt-contrib-watch'
  # Runninng tasks in parallel
  concurrent: 'grunt-concurrent'
  # Filter to run tasks on files that are newer than dependencies
  newer: 'grunt-newer'

  # For openning links in your browser
  open: 'grunt-open'

  # Minification/Optimisation tools
  usemin: 'grunt-usemin'
} #}}}
# User settings {{{1============================================================
DefaultTask = 'livedev'

SourceConfig =
  dest:  '.compiled'
  src:   'client'
  url:   'http://localhost:3000'

Aliases = [
  name: 'build'
  dependency: [
    'clean'
    'injector:scripts'
    'injector:sass'
    'wiredep'
    'concurrent:convertAssets'
    'injector:css'
  ]
,
  name: 'livedev'
  dependency: [
    'build'
    'express'
    'wait'
    'open'
    'watch'
  ]
]

# User tasks {{{1==============================================================
Tasks = [
  name: 'wait'
  description: 'Wait till server reloads'
  task: (grunt)->
    grunt.log.ok('Waiting for server reload...')
    done = do this.async
    setTimeout ->
      grunt.log.writeln('Done waiting!')
      done()
    , 1500
]

# Configuring Grunt Plugins {{{1===============================================
GruntInitConfig = -> #{{{2
  pkg: @file.readJSON('package.json')
  src: SourceConfig

  concurrent: ConcurrentTaskGroups
  wiredep: WiredepConfig
  injector: InjectorConfig
  coffee: CoffeeConfig
  jade: JadeConfig
  sass: SassConfig
  clean: CleanConfig
  watch: WatchConfig
  express: ExpressConfig
  open: OpenUrlConfig

ConcurrentTaskGroups = #{{{2
  convertAssets: ['coffee', 'jade', 'sass']

WiredepConfig = #{{{2
  target:
    src: '<%= src.src %>/index.jade'
    

InjectorConfig = #{{{2
  scripts:
    options:
      transform: (filePath)->
        src = SourceConfig.src
        filePath = filePath.replace('/' + src + '/', '')
        filePath = filePath.replace('.coffee', '.js')
        return 'script(src="' + filePath + '")'
      starttag: '// injector:js'
      endtag: '// endinjector'
    files:
      '<%= src.src %>/index.jade': \
      [
        '<%= src.src %>/app/**/*.coffee'
      ]

  sass:
    options:
      transform: (filePath)->
        src = SourceConfig.src
        filePath = filePath.replace('/' + src + '/app/', '')
        return '@import \'' + filePath + '\''
      starttag: '// injector'
      endtag: '// endinjector'
    files:
      '<%= src.src %>/app/app.sass': \
      [
        '<%= src.src %>/app/**/*.sass'
        '!<%= src.src %>/app/app.sass'
      ]

  css:
    options:
      transform: (filePath) ->
        src = SourceConfig.dest
        filePath = filePath.replace('/' + src + '/', '')
        return '<link rel=\'stylesheet\' href=\'' + filePath + '\'>'

      starttag: '<!-- injector:css -->'
      endtag: '<!-- endinjector -->'

    files:
      '<%= src.dest %>/index.html': [
        '<%= src.dest %>/app/**/*.css'
      ]

CoffeeConfig = #{{{2
  options:
    sourceMap: true
    sourceRoot: ''
  compile:
    expand: true
    extDot: 'last'
    cwd: '<%= src.src %>'
    src: [
      'app/**/*.coffee'
      '*.coffee'
    ]
    dest: '<%= src.dest %>'
    ext: '.js'

JadeConfig = #{{{2
  options:
    debug: false
    pretty: true
  compile:
    expand: true
    cwd: '<%= src.src %>'
    src: [
      'app/**/*.jade'
      '*.jade'
    ]
    dest: '<%= src.dest %>'
    ext: '.html'

SassConfig = #{{{2
  options:
    sourcemap: true
    noCache: true
    compass: false
    loadPath: [
      '<%= src.src %>/vendor'
      '<%= src.src %>/app'
    ]
  compile:
    expand: true
    cwd: '<%= src.src %>'
    src: [
      'app/app.sass'
    ]
    dest: '<%= src.dest %>'
    ext: '.css'

CleanConfig = #{{{2
  compile: '<%= src.dest %>'

WatchConfig = #{{{2
  coffee:
    files: [
      '<%= src.src %>/app/**/*.coffee'
    ]
    tasks: ['newer:injector:scripts', 'newer:coffee']
  sass:
    files: [
      '<%= src.src %>/**/*.sass'
    ]
    tasks: ['newer:injector:sass', 'newer:sass', 'injector:css']
  jade:
    files: [
      '<%= src.src %>/**/*.jade'
    ]
    tasks: ['newer:jade', 'injector:css']
  vendorChange:
    files: [
      '<%= src.src %>/vendor/**/*'
    ]
    tasks: ['wiredep']
  config:
    files: [
      'Gruntfile.coffee'
    ]
    options:
      reload: true
  livereload:
    files: [
      '<%= src.src %>/**/*'
      '<%= src.dest %>/**/*'
    ]
    options:
      livereload: true

ExpressConfig = #{{{2
  dev: 
    options:
      script: 'server/app.coffee'
      opts: ['node_modules/coffee-script/bin/coffee']
      debug: true

OpenUrlConfig = #{{{2
  server:
    url: '<%= src.url %>'

# Grunt Configuration {{{1=====================================================
module.exports = ->
  # (require 'time-grunt') this
  (require 'jit-grunt') this, RequreNpmTasks

  # Inintialise the config
  @initConfig do GruntInitConfig.bind this

  # Register user tasks
  ((tasks)=>
    for task in tasks
      grunt = this
      @registerTask task.name, task.description, ->
        (task.task.bind this) grunt
  ) Tasks

  # Register user aliases
  ((aliases)=>
    for alias in aliases
      @registerTask alias.name, alias.dependency
  ) Aliases

  @registerTask 'default', [DefaultTask]

# vim:foldmethod=marker
