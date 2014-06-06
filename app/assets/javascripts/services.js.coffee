angular.module('Mytree.services', ['ngResource'])
  .factory 'Services', ($http, $q) ->
    
    get_links: () ->
      $http.get('/links').then (resp) ->
        resp

    save_link: (value, parent, name) ->
#      params = {"value": value, "parent":parent, "name": name , "authenticity_token": "v0oFzclmvR4jsi3gJlYEfm+BPBbLeezavPq+3XTAmjU="}
      params = {"value": value, "parent":parent, "name": name}
      $http.post('/links/', params).then (resp) ->
        console.log resp

    delete_link: (link) ->
      $http.delete('/links/' + link.id).then (resp) ->
        resp

    new_link: (linkParams) ->
      console.log('Services.new_link request', linkParams)
      $http.get('/links').then (resp) ->
        console.log('Services.new_link response', resp.data[0])
        return resp.data[0]
