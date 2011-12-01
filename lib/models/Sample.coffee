# Sample Model.
module.exports = (app) ->

  class Sample

    constructor: ->
      @name = 'Sample'

    setName: (newName) ->
      @name = newName

    getName: ->
      @name

  Sample
