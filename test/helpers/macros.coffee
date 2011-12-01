should = require 'should'

# Vows macros
module.exports =
  # Assert a tobi response status
  assertStatus: (code) ->
    (res, $) ->
      res.should.have.status code
