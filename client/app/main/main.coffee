# app = angular.module 'Playground'
app.config ($stateProvider, $urlRouterProvider)->
  router = $stateProvider
  $urlRouterProvider.when '/', '/home'
  $urlRouterProvider.when '/zomg', '/home'

  router.state "home",
    url: '/home'
    templateUrl: 'app/main/main.html'
    controllerProvider: 'MainController'

class MainController extends @BaseCtrl
  @register app
  @inject '$scope'

  initialize: ->
    @$scope.name = 'MainController'

  greeting: ->
    "Hello Citizen!"

