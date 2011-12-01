###
Cakefile
###
{exec, spawn} = require 'child_process'

task 'app', 'Run the application (Development mode)', ->
  proc = spawn 'coffee', ['lib/app.coffee', '--nodejs']
  proc.stdout.on 'data', (buffer) -> process.stdout.write buffer.toString()
  proc.stderr.on 'data', (buffer) -> process.stderr.write buffer.toString()
  proc.on 'exit', (status) ->
    process.exit(1) if status != 0

task 'server', 'Run the server (Development mode)', ->
  proc = spawn 'node', ['bin/server']
  proc.stdout.on 'data', (buffer) -> process.stdout.write buffer.toString()
  proc.stderr.on 'data', (buffer) -> process.stderr.write buffer.toString()
  proc.on 'exit', (status) ->
    process.exit(1) if status != 0

task 'test', 'Run Mocha tests', ->
  proc = spawn 'mocha', ['-R', 'spec', '--colors']
  proc.stdout.on 'data', (buffer) -> process.stdout.write buffer.toString()
  proc.stderr.on 'data', (buffer) -> process.stderr.write buffer.toString()
  proc.on 'exit', (status) ->
    process.exit(1) if status != 0
