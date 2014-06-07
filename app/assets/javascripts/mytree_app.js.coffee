angular.module('mytree',['ngRoute', 'Mytree.controllers', 'Mytree.services']).config(
  ($routeProvider)->
    $routeProvider
      .when('/', {
        template: JST['views/show_all'],
        controller: 'MyController'
        })
      .otherwise({redirectTo: '/'})
)