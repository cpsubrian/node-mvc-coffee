###
Cakefile
###
{exec, spawn} = require 'child_process'

option '-d', '--debug', 'Run in debug mode (node-inspector)'
option '-b', '--debug-brk', 'Run in debug break mode (node-inspector)'

task 'app', 'Run the application (Development mode)', (options) ->
  args = []
  args.push '--debug' if options.debug
  args.push '--debug-brk' if options['debug-brk']
  args.push 'bin/app'
  proc = spawn 'node', args
  proc.stdout.on 'data', (buffer) -> process.stdout.write buffer.toString()
  proc.stderr.on 'data', (buffer) -> process.stderr.write buffer.toString()
  proc.on 'exit', (status) ->
    process.exit(1) if status != 0

task 'server', 'Run the server (Development mode)', (options) ->
  args = []
  args.push '--debug' if options.debug
  args.push '--debug-brk' if options['debug-brk']
  args.push 'bin/server'
  proc = spawn 'node', args
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
