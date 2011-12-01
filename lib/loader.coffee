###
Directory loader.

Loads all coffeescript files in a directory.  Assumes each file exports a
function that accepts the `app` as the only argument.

@see ./modules/Sample.coffee
@see ./controllers/AppController.coffee
###

fs = require "fs"
path = require "path"

module.exports = (dir, app) ->
  dir = path.resolve __dirname, dir
  indexPath = "#{dir}/index.coffee"
  objects = (if path.existsSync(indexPath) then require(indexPath) app else {})

  fs.readdirSync(dir).forEach (file) ->
    match = file.match /([^\/]+)\.coffee$/
    return  if match is null or match[1] is "index"
    name = match[1]
    objects[name] = require("#{dir}/#{name}") app

  objects
