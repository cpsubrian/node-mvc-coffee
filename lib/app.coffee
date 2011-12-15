# Load modules.
path = require 'path'
express = require "express"
app = module.exports = express.createServer()
nconf = require 'nconf'
boot = require "./boot"

# Save a reference to the application base path.
app.basePath = path.join __dirname, '..'

# Bootstrap the application.
boot app

app.start = () ->
  app.listen nconf.get('port')
  msg = "\nExpress server listening on port %d in %s mode"
  console.log msg, app.address().port, app.settings.env

# Only listen on $ node app.js
unless module.parent
  app.start()
