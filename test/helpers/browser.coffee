tobi = require 'tobi'

# Vows browser topic macros
module.exports = (app) ->
  browser = tobi.createBrowser app
  methods =
    # Returns a macro for making GET requests.
    get: (path, test) ->
      (done) ->
        browser.get path, (res, $) ->
          test(res, $)
          done()

    # Returns a macro for making POST requests.
    post: (path, data, test) ->
      options =
        body: JSON.stringify data
        headers: header
      (done) ->
        browser.post path, options, (res, $) ->
          test(res, $)
          done()

    # Returns a macro for making PUT requests.
    put: (path, data, test) ->
      options =
        body: JSON.stringify data
        headers: header
      (done) ->
        browser.put path, options, (res, $) ->
          test(res, $)
          done()

    # Returns a macro for making GET requests.
    del: (path, test) ->
      (done) ->
        browser.del path, (res, $) ->
          test(res, $)
          done()
