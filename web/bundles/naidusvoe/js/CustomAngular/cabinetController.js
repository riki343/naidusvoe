Naidusvoe.controller('cabinetController', ['$scope', '$http', '$sce', '$routeParams',
    function ($scope, $http, $sce, $routeParams) {
        $scope.urlGetInfo = URLS.getInfo;
        $scope.urlSaveContactInfo = URLS.saveInfo;
        $scope.urlSaveNewEmail = URLS.changeEmail;
        $scope.urlSaveNewPass = URLS.changePass;
        $scope.urlSaveEmailNotificationsSettings = URLS.saveEmailSettings;
        $scope.urlSaveSmsNotificationsSettings = URLS.saveSmsSettings;
        $scope.urlDeleteAccount = URLS.deleteAccount;
        $scope.urlGetFavs = URLS.getFavs;
        $scope.urlDeleteFav = URLS.deleteFav;
        $scope.urlGetUserAdvs = URLS.getUserAdvs;
        $scope.urlDeleteUserAdv = URLS.deleteUserAdv;
        $scope.urlGetUserMessages = URLS.getUserMessages;
        $scope.urlGetConversation = URLS.getConversation;

        $scope.emailChange = {
            'email': null,
            'remail': null
        };
        $scope.passChange = {
            'opass': null,
            'pass': null,
            'rpass': null
        };
        $scope.emailSettings = {
            'notifications': false,
            'spam': false
        };
        $scope.smsSettings = {
            'telephoneNumber': null,
            'notifications': false
        };
        $scope.notifications = {
            'body': '',
            'type': '',
            'visible': false
        };
        $scope.favs = null;
        $scope.userAdvs = null;
        $scope.userMsgs = null;
        $scope.contactInfo = null;
        $scope.regions = null;
        $scope.conv = null;
        $scope.asset = URLS.asset;
        $scope.spinner = false;

        if (angular.isDefined($routeParams.conv_id)) {
            $scope.conversation_id = $routeParams.conv_id;
        }

        $scope.getInfo = function () {
            $scope.spinner = true;
            $http.get($scope.urlGetInfo)
                .success(function (response) {
                    $scope.contactInfo = response.contactInfo;
                    $scope.regions = response.regions;
                    $scope.emailSettings.notifications = response.addInfo.notificationsEmail;
                    $scope.emailSettings.spam = response.addInfo.emailSpam;
                    $scope.smsSettings.telephoneNumber = response.addInfo.telephoneNumber;
                    $scope.smsSettings.notifications = response.addInfo.notificationsSms;
                    $scope.spinner = false;
                }
            );
        };

        $scope.getUserAdvs = function () {
            $scope.spinner = true;
            $http.get($scope.urlGetUserAdvs)
                .success(function (response) {
                    $scope.userAdvs = response;
                    for (var i = 0; i < $scope.userAdvs.length; i++) {
                        if ($scope.userAdvs[i].attachments.length > 0) {
                            $scope.userAdvs[i].image = $sce.trustAsUrl($scope.userAdvs[i].attachments[0].image);
                        }
                    }
                    $scope.spinner = false;
                }
            );
        };

        $scope.deleteUserAdv = function (id, index) {
            $scope.spinner = true;
            var deleteAdvURL = $scope.urlDeleteUserAdv.replace('adv_id', id);
            $http.delete(deleteAdvURL)
                .success(function (response) {
                    if (response) {
                        $scope.userAdvs.splice(index, 1);
                        $scope.spinner = false;
                    }
                }
            );
        };

        $scope.getConversations = function () {
            $scope.spinner = true;
            $http.get($scope.urlGetUserMessages)
                .success(function (response) {
                    if (response) {
                        $scope.conversations = response;
                        $scope.spinner = false;
                    }
                }
            );
        };

        $scope.getConversation = function (conv_id) {
            $scope.spinner = true;
            var convURL = $scope.urlGetConversation.replace('conv_id', conv_id);
            $http.get(convURL)
                .success(function (response) {
                    $scope.conv = response;
                    var msgs = $scope.conv.messages;
                    for (var i = 0; i < msgs.length; i++) {
                        msgs[i].user.avatar = $scope.asset + msgs[i].user.avatar;
                    }
                    for (i = msgs.length - 1; i > 0; i--) {
                        msgs[i].first = (msgs[i - 1].viewed && !msgs[i].viewed);
                    }
                    $scope.conv.messages = msgs;
                    $scope.spinner = false;
                }
            );
        };

        $scope.getFavs = function () {
            $scope.spinner = true;
            $http.get($scope.urlGetFavs)
                .success(function (response) {
                    $scope.favs = response;
                    for (var i = 0; i < $scope.favs.length; i++) {
                        if ($scope.favs[i].advertisment.attachments.length > 0) {
                            $scope.favs[i].advertisment.image =
                                $sce.trustAsUrl($scope.favs[i].advertisment.attachments[0].image);
                        }
                    }
                    $scope.spinner = false;
                }
            );
        };
        
        $scope.deleteFav = function (fav_id, index) {
            $http.delete($scope.urlDeleteFav.replace('fav_id', fav_id))
                .success(function (response) {
                    switch (response) {
                        case 1: $scope.favs.splice(index, 1); break;
                    }
                }
            );
        };

        function savedSucces() {
            $scope.notifications.body = 'Зміни успішно збережені';
            $scope.notifications.type = 'alert-success';
            $scope.notifications.visible = true;
        }

        function savedError(error) {
            $scope.notifications.body = error;
            $scope.notifications.type = 'alert-danger';
            $scope.notifications.visible = true;
        }

        function savedException() {
            $scope.notifications.body = 'Невідома помилка, спробуйте пізніше.';
            $scope.notifications.type = 'alert-danger';
            $scope.notifications.visible = true;
        }

        $scope.saveContactInfo = function (info) {
            $http.post($scope.urlSaveContactInfo, { 'info': info })
                .success(function (response) {
                    switch (response) {
                        case 1: savedSucces(); break;
                        case -1: savedException(); break;
                    }
                }
            );
        };

        $scope.changePassword = function (changes) {
            $http.post($scope.urlSaveNewPass, { 'changes': changes })
                .success(function (response) {
                    switch (response) {
                        case 1: savedSucces(); break;
                        case 0: savedError('Старий пароль невірний.'); break;
                        case -1: savedException(); break;
                    }
                }
            );
        };

        $scope.changeEmail = function (changes) {
            $http.post($scope.urlSaveNewEmail, { 'changes': changes })
                .success(function (response) {
                    switch (response) {
                        case 1: savedSucces(); break;
                        case 0: savedError(); break;
                        case -1: savedException(); break;
                    }
                }
            );
        };

        $scope.saveEmailNotificationSettings = function (settings) {
            $http.post($scope.urlSaveEmailNotificationsSettings, { 'settings': settings })
                .success(function (response) {
                    switch (response) {
                        case 1: savedSucces(); break;
                        case 0: savedError(); break;
                        case -1: savedException(); break;
                    }
                }
            );
        };

        $scope.saveSmsNotificationSettings = function (settings) {
            $http.post($scope.urlSaveSmsNotificationsSettings, { 'settings': settings })
                .success(function (response) {
                    switch (response) {
                        case 1: savedSucces(); break;
                        case 0: savedError(); break;
                        case -1: savedException(); break;
                    }
                }
            );
        };

    }
]);