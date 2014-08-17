###############################################################################
#                             Global configuration
###############################################################################

# Defining a global app variable that will be accessible in other scripts
@app = angular.module 'Playground', ['ui.router']

# Setting up some global parameters of the app
# The routes are going to be managed in the files they are providing routs for
@app.config ($stateProvider, $urlRouterProvider,  $locationProvider) ->
  $urlRouterProvider.otherwise '/'
  $locationProvider.html5Mode true

# Defining a base controller class
# (src: http://www.devign.me/angular-dot-js-coffeescript-controller-base-class)
class @BaseCtrl
  @register: (app, name) ->
    name ?= @name || @toString().match(/function\s*(.*?)\(/)?[1]
    app.controller name, @
 
  @inject: (args...) ->
    @$inject = args
 
  constructor: (args...) ->
    for key, index in @constructor.$inject
      @[key] = args[index]
 
    for key, fn of @constructor.prototype
      continue unless typeof fn is 'function'
      continue if key in ['constructor', 'initialize'] or key[0] is '_'
      @$scope[key] = fn.bind?(@) || _.bind(fn, @)
 
    @initialize?()
