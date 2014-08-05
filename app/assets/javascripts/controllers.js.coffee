ctrls = angular.module('Mytree.controllers',[])

ctrls.controller 'MyController',

  ($scope, Services, TreeSketch)->

    $scope.initialize = ()->
#      console.log "initialize"
      $scope.links = {}
      $scope.categories = {}
      $scope.friends = {}
      $scope.get_categories()
      $scope.get_friends()
      $("button").attr("disabled", null);

    $scope.onCategoriesAndLinksFetched = ()->
#      console.log $scope.categories
#      console.log $scope.links
      TreeSketch.drawTree($scope.categories, $scope.links)

    $scope.save_category = ()->
      categoryParams = {name: $scope.categoryName, parentID: $scope.categoryParentID}

      $scope.categoryName = '';
      $scope.categoryParentID = 1;

      angular.element('#newCategory').modal('hide')

      Services.create_category(categoryParams).then (resp)->
#        console.log(resp)
#        $scope.categories = resp
        $scope.categories.push(resp)

        if ($scope.toggleLinkModal == 'newLink')
          $scope.linkCategoryID = resp.id
          angular.element('#newLink').modal('show')
          $scope.toggleLinkModal = false
        else if ($scope.toggleLinkModal == 'editLink')
          $scope.linkCategoryID = resp.id
          angular.element('#editLink').modal('show')
          $scope.toggleLinkModal = false
        else
          $scope.onCategoriesAndLinksFetched()

    $scope.save_link = ()->
      linkParams = {name: $scope.linkName, categoryID: $scope.linkCategoryID, url: $scope.linkUrl}

      $scope.linkName = '';
      $scope.linkCategoryID = 1;
      $scope.linkUrl = '';

      Services.create_link(linkParams).then (resp)->
        console.log(resp)
        $scope.links = resp
        $scope.onCategoriesAndLinksFetched()

    $scope.delete_link = (linkID)->
      Services.delete_link(linkID).then (resp)->
        $scope.links = resp
        $scope.onCategoriesAndLinksFetched()

    $scope.edit_link = ()->
      linkParams = {name: $scope.linkName, categoryID: $scope.linkCategoryID, url: $scope.linkUrl}

      Services.update_link($scope.linkID, linkParams).then (resp)->
        $scope.links = resp
        $scope.onCategoriesAndLinksFetched()

    $scope.get_categories = ()->
      Services.fetch_categories().then (resp)->
#        console.log(resp)
        $scope.categories = resp
        $scope.get_links()

    $scope.get_links = ()->
      Services.fetch_links().then (resp)->
#        console.log(resp)
        $scope.links = resp
        $scope.onCategoriesAndLinksFetched()

    $scope.get_friends = ()->
      Services.fetch_friends().then (resp)->
#        console.log(resp)
        $scope.friends = resp

    $scope.getCategoryNameById = (category_id)->
      for category in $scope.categories
        if(category.id == category_id)
          return category.name


    $scope.toggle_new_link_modal = (type)->
      $scope.toggleLinkModal = type
      angular.element('#newLink').modal('hide')
      angular.element('#editLink').modal('hide')
      angular.element('#newCategory').modal('show')
      true

    $scope.show_friend_tree = ()->
#      console.log($scope.friendID)
      Services.get_friend_links($scope.friendID).then (resp)->
        $scope.links = resp

        $scope.categories = []
        tmp = []
        for l in $scope.links

          if (!tmp[l.category_id])
            tmp[l.category_id] = 1;
            c = {id: l.category_id, name: l.category_name, category_id: l.category_parent_id}
            $scope.categories.push(c)

          if (!tmp[l.category_parent_id])
            tmp[l.category_parent_id] = 1;
            c = {id: l.category_parent_id, name: l.category_name + ' PARENT', category_id: 1}
            $scope.categories.push(c)

        $scope.onCategoriesAndLinksFetched()
        $("button").attr("disabled", "disabled");

    $scope.set_edit_link_fields = (link)->
      console.log(link)

      if (link)
        $scope.linkName = link.link_name
        $scope.linkUrl = link.url
        $scope.linkCategoryID = link.category_id
        $scope.linkID = link.id
      else
        $scope.linkName = ""
        $scope.linkUrl = ""
        $scope.linkCategoryID = ""


    $scope.initialize()

