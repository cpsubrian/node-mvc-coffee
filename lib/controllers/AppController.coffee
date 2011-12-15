###
Application controller.
###

module.exports = (app) ->

  class AppController

    ###
    Contsructor
    ###
    constructor: () ->

      # Define params.
      ###
      app.param 'someId', (req, res, next, someId) ->
        fetchFromDBOrSomething (someObj) ->
          res.someObj = someObj
          next()
      ###

      # Define routes.
      app.get "/", @index


    ###
    Index.
    ###
    index: (req, res) =>
      res.render "index"
