Path = require 'path'
Errors = require './components/errors'

module.exports = (app)->
  root = app.get('root')

  # Put your API routes here
  app.use '/api/test_data', require './api/test_data'

  
  # All undefined asset or api routes should return a 404
  app.route '/:url(api|auth|app|vendor|assets)/*'
   .get(Errors[404])

  # The rest must redirect to the index page
  # and we will hande all the routing there
  app.route '/*'
    .get (req, res)->
      res.sendFile Path.join root, '.compiled', 'index.html'

