tobi = require 'tobi'

# Vows browser topic macros
module.exports = (app) ->
  browser = tobi.createBrowser app
  methods =
    # Returns a macro for making GET requests.
    get: (path, next) ->
      browser.get path, (res, $) ->
        next(res, $)

    # Returns a macro for making POST requests.
    post: (path, data, next) ->
      options =
        body: JSON.stringify data
        headers: header
      browser.post path, options, (res, $) ->
        next(res, $)

    # Returns a macro for making PUT requests.
    put: (path, data, next) ->
      options =
        body: JSON.stringify data
        headers: header
      browser.put path, options, (res, $) ->
        next(res, $)

    # Returns a macro for making GET requests.
    del: (path, next) ->
      browser.del path, (res, $) ->
        next(res, $)
