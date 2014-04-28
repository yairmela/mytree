angular.module('Mytree.services', ['ngResource'])
  .factory 'Services', ($http, $q) ->
    
    get_links: () ->
      $http.get('/links').then (resp) ->
        resp

    save_link: (value, parent, name) ->
      params = {"value": value, "parent":parent, "name": name}
      $http.post('/links/', params).then (resp) ->
        console.log resp

    delete_link: (link) ->
      console.log link
      $http.delete('/links/' + link.id).then (resp) ->
        resp

