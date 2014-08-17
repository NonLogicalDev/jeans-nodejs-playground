###############################################################################
#                             Global configuration
###############################################################################

# Defining a global app variable that will be accessible in other scripts
# and its modules that we require
angular.module 'Playground', [
  'ui.router'
]

# Setting up some global parameters of the app
# The routes are going to be managed in the files they are providing routes for
.config ($stateProvider, $urlRouterProvider,  $locationProvider) ->
  $urlRouterProvider.otherwise '/'
  $locationProvider.html5Mode true
