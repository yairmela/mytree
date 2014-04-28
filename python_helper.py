# # -*- encoding:utf-8 -*-
# __author__ = 'yair'

# import os, sys, json, time

# awsKey = ''
# awsAccess = ''

# class color:
#     OK = '\033[92m'
#     WARN = '\033[93m'
#     FAIL = '\033[91m'
#     ENDC = '\033[0m'
#     if sys.platform.startswith('win'):
#         OK = WARN = FAIL = ENDC = ''

# # def log(msg, msgColor):
# #     print msgColor + msg + color.ENDC

# # import urllib
# # import urllib2
# # from config.keys import secrets
# # from urllib2 import HTTPError
# # from cookielib import CookieJar
# # import json

# # crmUrl = secrets.crmUrl
# # crmEnv = "PROD"
# # crmUser = secrets.crmUser
# # crmPassword = secrets.crmPassword

# # opener = None
# def connectToWeb(url)


# def connectToCrm():
#     cookieJar = CookieJar()
#     opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookieJar))
#     login = {'crmLoginusrname':crmUser, 'crmLoginpassword':crmPassword, 'crmEnvironment':crmEnv}
#     data = urllib.urlencode(login)
#     opener.open(crmUrl + '/crmlogin', data)
#     return opener

# def getGameId(fbId):
#     fb_id_data = {'crmFBid':fbId, 'environment':'PROD'}
#     data = urllib.urlencode(fb_id_data)
#     request = urllib2.Request('%s/crmuser/' % (crmUrl), data)
#     request.get_method = lambda: 'POST'
#     codeResponse = crmOpener.open(request)
#     game_id = ''
#     if len(codeResponse.geturl().split('crmuser/')) > 1 :
#         game_id = codeResponse.geturl().split('crmuser/')[1]
#     print json.dumps({'user_id':game_id})

# def getGameIds(fbIds):
#     game_ids = []
#     for fbId in fbIds:
#         fb_id_data = {'crmFBid':fbId, 'environment':'PROD'}
#         data = urllib.urlencode(fb_id_data)
#         request = urllib2.Request('%s/crmuser/' % (crmUrl), data)
#         request.get_method = lambda: 'POST'
#         codeResponse = crmOpener.open(request)
#         if len(codeResponse.geturl().split('crmuser/')) > 1:
#             game_id = codeResponse.geturl().split('crmuser/')[1]
#             game_ids.append(getInfo(game_id, fbId))
#     return game_ids

# def getInfo(userId, fbId): 
#     request = urllib2.Request('%s/crmuser/%s' % (crmUrl, userId))
#     codeResponse = crmOpener.open(request)
#     html = codeResponse.read().upper()
#     if 'BANKROLL' in html:
#         fb_id = ''
#         bankroll = ''
#         xp = ''
#         rank = ''
#         user_state = ''
#         hands_played = ''
#         total_spending = ''
#         display_name = ''

#         if fbId != None:
#             fb_id = fbId
#         else:
#             img_url = html.split('<INPUT NAME="DISPLAY_PROF_PICTURE" TYPE="TEXT" VALUE="')[1].split('"></INPUT>')[0].lower()
#             if 'fbcdn-profile' in img_url:
#                 if len(img_url.split('_')) > 1:
#                     fb_id = img_url.split('_')[1]
#             elif 'graph.facebook' in img_url:
#                 if len(img_url.split('_')) > 3:
#                     fb_id = img_url.split('/')[3]
#                 elif len(img_url.split('graph.facebook.com/')) > 1:
#                     if len(img_url.split('graph.facebook.com/')[1].split('/picture')) > 1:
#                         fb_id = img_url.split('graph.facebook.com/')[1].split('/picture')[0]
#         user_name = 'NO-NAME'
#         display_name ='no-name'
#         if len(html.split('<LI>NAME: ')) > 1:
#             user_name = html.split('<LI>NAME: ')[1].split('</LI')[0].lower()
#         if len(html.split('DISPLAY_NAME"')) > 1:
#             display_name = html.split('DISPLAY_NAME"')[1].split('VALUE="')[1].split('">')[0].lower()
#         if len(html.split('BANKROLL"')) > 1:
#             bankroll = html.split('BANKROLL"')[1].split('VALUE="')[1].split('">')[0].lower()
#         if len(html.split('EXPERIENCE"')) > 1:
#           xp = html.split('EXPERIENCE"')[1].split('VALUE="')[1].split('">')[0].lower()
#         if len(html.split('RANK"')) > 1:        
#             rank = html.split('RANK"')[1].split('VALUE="')[1].split('">')[0].lower()
#         if len(html.split('<SELECT NAME="USER_ACCOUNT_STATE"><OPTION>')) > 1:                
#           user_state = html.split('<SELECT NAME="USER_ACCOUNT_STATE"><OPTION>')[1].split('</OPTION>')[0].lower()
#         if len(html.split('HANDS_PLAYED"')) > 1:                
#             hands_played = html.split('HANDS_PLAYED"')[1].split('VALUE="')[1].split('">')[0].lower()
#         if len(html.split('TOTAL_SPENDING"')) > 1:                        
#             total_spending = html.split('TOTAL_SPENDING"')[1].split('VALUE="')[1].split('">')[0].lower()
#         properties = {'user_id':userId, 'facebook_id':fb_id, 'name':user_name, 'status':user_state, 'total_paid':total_spending, 'bankroll':bankroll, 'xp':xp, 'rank':rank, 'hands_played':hands_played, 'display_name':display_name}
#         return properties
#     else:
#         return {}

# def setUserStatus(userId, status):
#     request = urllib2.Request('%s/crmuser/%s' % (crmUrl, userId))
#     codeResponse = crmOpener.open(request)
#     html = codeResponse.read().upper()
#     if len(html.split('<SELECT NAME="USER_ACCOUNT_STATE"><OPTION>')) > 1:                
#         old_user_state = html.split('<SELECT NAME="USER_ACCOUNT_STATE"><OPTION>')[1].split('</OPTION>')[0].lower()

#     payload = {'USER_ACCOUNT_STATE':status.upper()}
#     data = urllib.urlencode(payload)
#     request = urllib2.Request('%s/crmuser/%s' % (crmUrl, userId), data)
#     request.get_method = lambda: 'POST'
#     codeResponse = crmOpener.open(request)
#     html = codeResponse.read().upper()
#     if len(html.split('<SELECT NAME="USER_ACCOUNT_STATE"><OPTION>')) > 1:                
#         new_user_state = html.split('<SELECT NAME="USER_ACCOUNT_STATE"><OPTION>')[1].split('</OPTION>')[0].lower()

#     print json.dumps({'old_status': old_user_state, 'new_status':new_user_state})
    
# def setAction(userId, action, value):
#     request = urllib2.Request('%s/crmuser/%s' % (crmUrl, userId))
#     codeResponse = crmOpener.open(request)
#     html = codeResponse.read().upper()
#     if len(html.split(action.upper() + '"')) > 1:                
#         old_value = html.split(action.upper() + '"')[1].split('VALUE="')[1].split('">')[0].lower()
#     payload = {action.upper():value }
#     data = urllib.urlencode(payload)
#     request = urllib2.Request('%s/crmuser/%s' % (crmUrl, userId), data)
#     request.get_method = lambda: 'POST'
#     codeResponse = crmOpener.open(request)
#     html = codeResponse.read().upper()
#     if len(html.split(action.upper() + '"')) > 1:                
#         new_value = html.split(action.upper() + '"')[1].split('VALUE="')[1].split('">')[0].lower()
#     print json.dumps({'old_'+action:old_value, 'new_'+action:new_value})

# # todo - take off python - move to rails
# def friends_list(fb_id):
#     # get token
#     url = "https://graph.facebook.com/oauth/access_token?client_id="+secrets.app_id+"&client_secret="+secrets.app_secret+"&grant_type=client_credentials"
#     cookieJar = CookieJar()
#     opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookieJar))
#     codeResponse = opener.open(url).read()
#     token = codeResponse.split("access_token=")[1]
#     # get friends list
#     url = "https://graph.facebook.com/"+fb_id+"/friends?fields=installed&access_token=" + token
#     codeResponse = opener.open(url).read()

#     friends_list = json.loads(codeResponse)['data']
#     # get friends ids
#     friend_ids = []
#     total_friends_num = len(friends_list)
#     for friend in friends_list:
#        if len(friend) == 2:
#             friend_ids.append(friend['id'])
#     print json.dumps({'friends' : getGameIds(friend_ids), 'total_friends_num' : total_friends_num } )

# crmOpener = connectToCrm()
# if len(sys.argv) > 1:
#     user_id = sys.argv[1]
#     if len(sys.argv) > 2:
#         if sys.argv[2] == 'fb':
#             getGameId(user_id)
#         if sys.argv[2] == 'status':
#             setUserStatus(user_id, sys.argv[3])
#         if sys.argv[2] == 'bankroll' or sys.argv[2] == 'rank':
#             setAction(user_id, sys.argv[2], sys.argv[3])
#         if sys.argv[2] == 'friends':
#             friends_list(user_id)    
#     else:
#         print json.dumps(getInfo(user_id, None))
# else:
#     print "No user id provided"
