# General Application Tests
process.env.NODE_ENV = 'test'

should = require 'should'
app = require '../lib/app'
browser = require('./helpers/browser') app
{assertStatus} = require './helpers/macros'

describe 'Application Tests', ->
  describe 'GET /', ->
    it 'should respond with 200 OK',
      browser.get '/',
        assertStatus 200
