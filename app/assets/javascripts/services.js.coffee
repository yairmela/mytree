angular.module('Mytree.services', ['ngResource'])
  .factory 'Services', ($http, $q) ->

    create_category: (categoryParams) ->
      $http.post('/category', categoryParams).then (resp) ->
#        console.log('Services.create_category response', resp.data)
        return resp.data

    create_link: (linkParams) ->
      $http.post('/link', linkParams).then (resp) ->
#        console.log('Services.create_link response', resp.data)
        return resp.data

    fetch_links: () ->
      $http.get('/link').then (resp) ->
#        console.log('Services.fetch_links response', resp.data)
        return resp.data

    fetch_categories: () ->
      $http.get('/category').then (resp) ->
#        console.log('Services.fetch_categories response', resp.data)
        return resp.data

    fetch_friends: () ->
      $http.get('/friend').then (resp) ->
#        console.log('Services.fetch_friends response', resp.data)
        return resp.data

    get_friend_links: (friendID) ->
      $http.get('/friend/' + friendID).then (resp) ->
        console.log('Services.get_friend_links response', resp.data)
        return resp.data

    delete_link: (linkID) ->
      console.log('Services.delete_link request',  {linkID: linkID})
      $http.delete('/link/' + linkID).then (resp) ->
        console.log('Services.delete_link response', resp.data)
        return resp.data

    update_link: (linkID, linkParams) ->
      $http.post('/link/' + linkID, linkParams).then (resp) ->
        console.log('Services.update_link response', resp.data)
        return resp.data