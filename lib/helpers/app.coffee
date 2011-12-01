nconf = require 'nconf'

# Helper loading.
module.exports = (app) ->

  # Static helpers.
  app.helpers
    title: nconf.get 'site:title'

  # Dynamic helpers.
  app.dynamicHelpers {}

