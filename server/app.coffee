###############################################################################
#                           Server Initialisation:
###############################################################################

# Unless environment is explicitly set assume its development
process.env.NODE_ENV = process.env.NODE_ENV || 'development'

# Setting up the server
Express = require 'express'
Path = require 'path'
ConfigureExpress = require './config/express'
SetUpRoutes = require './routes'

# Creating the app
app = Express()

# Setting up environment
app.set 'env', process.env.NODE_ENV
app.set 'port', process.env.PORT || 3000
app.set 'root', Path.normalize(__dirname + '/..')

# Configuring the app
ConfigureExpress app
SetUpRoutes app

http_server = require('http').createServer(app)
http_server.listen app.get('port'), '0.0.0.0', ->
  console.log \
    'Express server listening on %d, in %s mode',
    app.get('port'), process.env.NODE_ENV

module.exports = app
