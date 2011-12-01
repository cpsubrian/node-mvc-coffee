###
Application bootstrapping.
###

express = require "express"
fs = require "fs"
path = require "path"
nconf = require 'nconf'
#mongoose = require 'mongoose'
loader = require "./loader"

###
Perform the bootstrap.
###
module.exports = (app) ->
  boot = booter app
  boot.config()
  boot.application()
  #boot.databases()
  boot.helpers()
  boot.models()
  boot.controllers()

###
Returns boot methods.
###
booter = (app) ->
  # Setup nconf and load configuration.
  config: () ->
    checkConfigFiles(path.resolve(app.basePath, 'conf'), [
      "development.json", "test.json", "production.json", "default.json"
    ])

    # Add environment-specific configuration providers.
    app.configure "development", ->
      nconf.use 'development',
        type: 'file'
        file: "#{app.basePath}/conf/development.json"

    app.configure "test", ->
      nconf.use 'test',
        type: 'file'
        file: "#{app.basePath}/conf/test.json"

    app.configure "production", ->
      nconf.use 'file',
        type: 'file'
        file: "#{app.basePath}/conf/production.json"

    # Add default config provider.
    nconf.use 'default',
      type: 'file'
      file: "#{app.basePath}/conf/default.json"

    # Load configuration.
    nconf.load()

  # Setup application (Express server).
  application: () ->
    # Defaults.
    app.configure ->
      app.set "views", "views"
      app.set "view engine", "html"
      app.register ".html", require("jqtpl").express
      fixLessCompiler()
      app.use express.compiler(
        src: "public"
        enable: [ "less" ]
      )
      app.use express.static("public")
      app.use express.bodyParser()
      app.use express.methodOverride()
      app.use express.cookieParser()
      app.use express.session(secret: nconf.get('session:secret'))

    # Development.
    app.configure "development", ->
      app.use express.errorHandler(
        dumpExceptions: true
        showStack: true
      )

    # Tests.
    app.configure "test", ->
      app.use express.errorHandler()

    # Production.
    app.configure "production", ->
      app.use express.errorHandler()

  # Setup datbases.
  databases: () ->
    # Connect mongoose (for example).
    mongodb = nconf.get 'mongodb'
    app.mongoose = mongoose
    app.mongoose.connect "mongodb://#{mongodb.host}/#{mongodb.db}"

  # Set up static and dynamic helpers.
  helpers: () ->
    app.helpers = loader "helpers", app

  # Load Models.
  models: () ->
    app.models = loader "models", app

  # Load Controllers.
  controllers: () ->
    app.controllers = {};
    for name, Controller of loader "controllers", app
      try
        app.controllers[name] = new Controller

###
Fix LESS compiler so it renders with the path relative to /public/css.
###
fixLessCompiler = () ->
  cache = {}
  express.compiler.compilers.less.compile = (str, fn) ->
    unless cache.less
      cache.less = require "less"
      origRender = cache.less.render
      cache.less.render = (str, options, fn) ->
        if typeof (options) is "function"
          fn = options
          options = paths: [ "public/css" ]
        origRender.call this, str, options, fn
    less = cache.less
    try
      less.render str, fn
    catch err
      fn err

###
Make sure the conf files exist, if not copy the sample files over.
###
checkConfigFiles = (basePath, files) ->
  missing = []
  for file in files
    try
      fs.statSync(path.resolve basePath, file).isFile()
    catch err
      missing.push file

  for file in missing
      src = path.resolve basePath, 'samples', file
      dst = path.resolve basePath, file
      try
        copyFileSync src, dst
      catch err
        console.log 'ERR! Could not find sample configuration file: "%s".', src
        process.exit 1

  if missing.length
    console.log 'Some configuration files were missing ...'
    console.log '- ' + missing.join("\n- ") + "\n"
    console.log 'Temporary versions were copied from %s.  You should edit them.', path.resolve(basePath, 'samples')

###
Synchronous file copy.
###
copyFileSync = (srcFile, destFile) ->
  BUF_LENGTH = 64*1024
  buff = new Buffer(BUF_LENGTH)
  fdr = fs.openSync(srcFile, 'r')
  fdw = fs.openSync(destFile, 'w')
  bytesRead = 1
  pos = 0
  while bytesRead > 0
    bytesRead = fs.readSync(fdr, buff, 0, BUF_LENGTH, pos)
    fs.writeSync(fdw,buff,0,bytesRead)
    pos += bytesRead
  fs.closeSync(fdr)
  fs.closeSync(fdw)
