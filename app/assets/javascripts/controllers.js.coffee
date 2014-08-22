ctrls = angular.module('Mytree.controllers',[])

ctrls.controller 'MyController',

  ($scope, Services, TreeSketch)->

    $scope.initialize = ()->
#      console.log "initialize"
      $scope.myTree = {
        links: {},
        categories: [],
      }
      $scope.links = {}
      $scope.isFriendTree = false
      $scope.categories = []
      $scope.friends = {}
      $scope.get_categories()
      $scope.get_friends()
      $("#new-category-btn").attr("disabled", null);
      $("#new-link-btn").attr("disabled", null);

    $scope.sketch_tree = (categories, links)->
      TreeSketch.drawTree(categories, links)

    $scope.save_category = ()->
      categoryParams = {name: $scope.categoryName, parentID: $scope.categoryParentID}

      $scope.categoryName = '';
      $scope.categoryParentID = 1;

      angular.element('#newCategory').modal('hide')

      Services.create_category(categoryParams).then (resp)->
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
          $scope.sketch_tree($scope.categories, $scope.links)

    $scope.save_link = ()->
      linkParams = {name: $scope.linkName, categoryID: $scope.linkCategoryID, url: $scope.linkUrl}

      $scope.linkName = '';
      $scope.linkCategoryID = 1;
      $scope.linkUrl = '';

      Services.create_link(linkParams).then (resp)->
        $scope.set_mytree_links(resp)

    $scope.delete_link = (linkID)->
      Services.delete_link(linkID).then (resp)->
        $scope.set_mytree_links(resp)

    $scope.edit_link = ()->
      linkParams = {name: $scope.linkName, categoryID: $scope.linkCategoryID, url: $scope.linkUrl}
      Services.update_link($scope.linkID, linkParams).then (resp)->
        $scope.set_mytree_links(resp)

    $scope.get_categories = ()->
      Services.fetch_categories().then (resp)->
        $scope.set_mytree_categories(resp)
        $scope.get_links()

    $scope.get_links = ()->
      Services.fetch_links().then (resp)->
        $scope.set_mytree_links(resp)

    $scope.get_friends = ()->
      Services.fetch_friends().then (resp)->
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
      console.log($scope.categories)
      console.log($scope.links)
      console.log('show_friend_tree : ' + $scope.friendID)
      Services.get_friend_links($scope.friendID).then (resp)->
        $scope.isFriendTree = true

        console.log ('fetching friend (' + $scope.friendID + ') tree')
        console.log(resp)

        $scope.links = []
        $scope.categories = []

        for node in resp
          if node.is_link == 't'
            node.link_name = node.name
            $scope.links.push(node)
          else
            $scope.categories.push(node)

#        $scope.links = resp
#
#        $scope.categories = []
#        tmp = []
#        for l in $scope.links
#          if (!tmp[l.category_id])
#            tmp[l.category_id] = 1;
#            c = {id: l.category_id, name: l.category_name, category_id: l.category_parent_id}
#            $scope.categories.push(c)
#
#          if (!tmp[l.category_parent_id])
#            tmp[l.category_parent_id] = 1;
#            c = {id: l.category_parent_id, name: l.category_name + ' PARENT', category_id: 1}
#            $scope.categories.push(c)

        console.log($scope.categories)
        console.log($scope.links)
        $scope.sketch_tree($scope.categories, $scope.links)
        $("#new-category-btn").attr("disabled", "disabled");
        $("#new-link-btn").attr("disabled", "disabled");

    $scope.set_edit_link_fields = (link)->
      if (link)
        $scope.linkName = link.link_name
        $scope.linkUrl = link.url
        $scope.linkCategoryID = link.category_id
        $scope.linkID = link.id
      else
        $scope.linkName = ""
        $scope.linkUrl = ""
        $scope.linkCategoryID = ""


    $scope.add_link_to_mytree = (link)->
      linkParams = {name: link.link_name, categoryID: link.category_id, url: link.url, id: link.id}

#      Services.add_category(link.category_id).then (resp)->
      Services.create_link(linkParams).then (resp)->
        $scope.friendID = 0
        $scope.initialize()

    $scope.set_mytree_links = (links)->
      $scope.links = links
      $scope.myTree.links = links
      $scope.sketch_tree($scope.categories, $scope.links)

    $scope.set_mytree_categories = (categories)->
      $scope.categories = categories
      $scope.myTree.categories = categories

    $scope.is_already_in_mytree = (linkID)->
      for link in $scope.myTree.links
        if (link.id == linkID)
          return true

      return false


    $scope.initialize()

