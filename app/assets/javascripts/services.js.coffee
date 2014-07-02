angular.module('Mytree.services', ['ngResource'])
  .factory 'Services', ($http, $q) ->
#
#    get_links: () ->
#      $http.get('/links').then (resp) ->
#        resp
#
#    save_link: (value, parent, name) ->
##      params = {"value": value, "parent":parent, "name": name , "authenticity_token": "v0oFzclmvR4jsi3gJlYEfm+BPBbLeezavPq+3XTAmjU="}
#      params = {"value": value, "parent":parent, "name": name}
#      $http.post('/links/', params).then (resp) ->
#        console.log resp
#
#    delete_link: (link) ->
#      $http.delete('/links/' + link.id).then (resp) ->
#        resp
#
#    new_link: (linkParams) ->
#      console.log('Services.new_link request', linkParams)
#      $http.get('/links').then (resp) ->
#        console.log('Services.new_link response', resp.data[0])
#        return resp.data[0]
#



    create_category: (categoryParams) ->
      $http.post('/category', categoryParams).then (resp) ->
        console.log('Services.create_category response', resp.data)
        return resp.data

    create_link: (linkParams) ->
      $http.post('/link', linkParams).then (resp) ->
        console.log('Services.create_link response', resp.data)
        return resp.data

    fetch_links: () ->
      $http.get('/link').then (resp) ->
        console.log('Services.fetch_links response', resp.data)
        return resp.data

    fetch_categories: () ->
      $http.get('/category').then (resp) ->
        console.log('Services.fetch_categories response', resp.data)
        return resp.data

    fetch_friends: () ->
      $http.get('/friend').then (resp) ->
        console.log('Services.fetch_friends response', resp.data)
        return resp.data

    get_friend_links: (friendID) ->
      $http.get('/friend/' + friendID).then (resp) ->
        console.log('Services.get_friend_links response', resp.data)
        return resp.data