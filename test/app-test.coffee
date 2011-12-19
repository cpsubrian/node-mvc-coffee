# General Application Tests
process.env.NODE_ENV = 'test'

should = require 'should'
app = require '../lib/app'
browser = require('./helpers/browser') app

describe 'Application Tests', ->

  describe 'GET /', ->

    it 'should respond with 200 OK', (done) ->
      browser.get '/', (res, $) ->
        res.should.have.status 200
        done()
