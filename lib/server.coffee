###
Cluster server for the application.

Set # of workers in /conf/default.conf.  You should run via /bin/server so that
cluster's logs/ and pids/ stay out of our application root.

@see Cakfile
###
path = require "path"
basePath = path.resolve(__dirname, "..")
process.chdir basePath

cluster = require "cluster"
app = cluster require("#{basePath}/lib/app")
nconf = require 'nconf'
port = nconf.get('port')

app.set "workers", nconf.get('cluster:workers')
app.use cluster.logger "logs"
app.use cluster.stats()
app.use cluster.pidfiles "pids"
app.use cluster.cli()
app.use cluster.reload()

module.exports = server =
  start: ->
    app.listen port
    console.log '\nStarting up the cluster server on port %d', port

server.start() unless module.parent
