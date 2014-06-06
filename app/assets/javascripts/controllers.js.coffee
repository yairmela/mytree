ctrls = angular.module('Mytree.controllers',[])

ctrls.controller 'MyController',
  ($scope, Services)->

  	$scope.get_links = ()->
	  	Services.get_links().then (resp)->
	  		$scope.links = {}
	  		$scope.links = resp.data
	  		console.log $scope.links

	  $scope.save_link = ()->
	  	console.log "before save_links" + $scope.name
	  	Services.save_link($scope.value,$scope.parent, $scope.name ).then (status)->
	  		load_links()
	  		console.log 'after load_links'

	  $scope.remove_link = (link)->
	  	Services.delete_link(link).then (resp)->
	  		console.log 'resp: ' + resp
	  		load_links()

	  load_links = ()->
	  	$scope.get_links()

	  	$scope.parent = ''
	  	$scope.name = ''
	  	$scope.value = ''

    $scope.new_link = ()->
      console.log $('#myModal')#.modal()
      linkParams = {nuss : 'itay'}
      console.log('scope.new_link request', linkParams)

      #Services.new_link(linkParams).then (resp)->
        #new_link()
      #  console.log('scope.new_link response', resp)

	  load_links()

