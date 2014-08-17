################################################################################
#                    Express Application Configuration:
################################################################################

Express = require 'express'
Path = require 'path'
Favicon = require 'static-favicon'
Morgan = require 'morgan'
BodyParser = require 'body-parser'
ErrorHandler = require 'errorhandler'
LiveReload = require 'connect-livereload'

module.exports = (app)->
  env = app.get('env')
  root = Path.join app.get('root')

  app.set 'views', Path.join root, 'client'
  app.set 'view engine', 'jade'

  if 'development' == env
    app.use LiveReload()
    app.use Morgan('dev')

  # Dont have a favicon yet...
  # app.use favicon Path.join app.get('root') 'client', 'favicon.ico'

  app.use BodyParser.urlencoded({ extended: false })
  app.use BodyParser.json()

  if 'development' == env
    # Serve the assets and vendor scripts
    app.use Express.static Path.join root, 'client'

    # Serve the comiled files and source maps
    app.use Express.static Path.join root, '.compiled'

  app.use(ErrorHandler())
