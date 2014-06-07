ctrls = angular.module('Mytree.controllers',[])

ctrls.controller 'MyController',
  ($scope, Services)->

    $scope.initialize = ()->
      $scope.links = {}
      $scope.categories = {}
      $scope.get_links()
      $scope.get_categories()

    $scope.save_category = ()->
      categoryParams = {name: $scope.categoryName, parentID: $scope.categoryParentID}

      $scope.categoryName = '';
      $scope.categoryParentID = 1;

      angular.element('#newCategory').modal('hide')

      Services.create_category(categoryParams).then (resp)->
        console.log(resp)
#        $scope.categories = resp
        $scope.categories.push(resp)

        if ($scope.toggleNewLinkModal)
          $scope.toggleNewLinkModal = false
          $scope.linkCategoryID = resp.id
          angular.element('#newLink').modal('show')


    $scope.save_link = ()->
      linkParams = {name: $scope.linkName, categoryID: $scope.linkCategoryID, url: $scope.linkUrl}

      $scope.linkName = '';
      $scope.linkCategoryID = 1;
      $scope.linkUrl = '';

      Services.create_link(linkParams).then (resp)->
        console.log(resp)
        $scope.links = resp
#        $scope.links.push(resp)

    $scope.get_links = ()->
      Services.fetch_links().then (resp)->
        console.log(resp)
        $scope.links = resp

    $scope.get_categories = ()->
      Services.fetch_categories().then (resp)->
        console.log(resp)
        $scope.categories = resp
#        $scope.initialize()


    $scope.getCategoryNameById = (category_id)->
      for category in $scope.categories
        if(category.id == category_id)
          return category.name


    $scope.initialize()

    $scope.toggle_new_link_modal = ()->
      $scope.toggleNewLinkModal = true
      angular.element('#newLink').modal('hide')
      angular.element('#newCategory').modal('show')
      true

#    console.log angular.element('#newLink').toggle()


#console.log angular.element('#newLink')
#angular.element('#newLink').on('hidden.bs.modal', function (e) {
#  alert('sads');
#})

#    $scope.get_links = ()->
#      console.log 'get_links req'
#	  	Services.fetch_links().then (resp)->
#	  		$scope.links = {}
#        $scope.links = resp.data



#    $scope.save_category = ()->
#      categoryParams = {categoryName: $scope.categoryName, categoryParentID: $scope.categoryParentID}
#      #console.log(categoryParams);
#
#      Services.create_category(categoryParams).then (resp)->
#        console.log(resp)
#
#	  $scope.save_link = ()->
#	  	console.log "before save_links" + $scope.name
#	  	Services.save_link($scope.value,$scope.parent, $scope.name ).then (status)->
#	  		load_links()
#	  		console.log 'after load_links'
#
#	  $scope.remove_link = (link)->
#	  	Services.delete_link(link).then (resp)->
#	  		console.log 'resp: ' + resp
#	  		load_links()
#
#	  load_links = ()->
#	  	$scope.get_links()
#
##	  	$scope.parent = ''
##	  	$scope.name = ''
##	  	$scope.value = ''
#
#    $scope.new_link = ()->
#      console.log $('#myModal')#.modal()
#      linkParams = {nuss : 'itay'}
#      console.log('scope.new_link request', linkParams)

      #Services.new_link(linkParams).then (resp)->
        #new_link()
      #  console.log('scope.new_link response', resp)

#	  load_links()

