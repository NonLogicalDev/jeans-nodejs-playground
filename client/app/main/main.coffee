###############################################################################
#                             Main Controller
###############################################################################
angular.module('Playground')

.config ($stateProvider, $urlRouterProvider)->
  router = $stateProvider
  $urlRouterProvider.when '/', '/home'

  router.state "home",
    url: '/home'
    templateUrl: 'app/main/main.html'
    controllerProvider: 'MainController'

.controller 'MainController', ($scope, $http) ->
  $scope.greeting = ->
    "Hello Citizen!"

  $scope.name = "MainController"

  $scope.getServerMessages = ->
    $http.get('/api/test_data').success (data, status)->
      console.log data
      $scope.messages = data

