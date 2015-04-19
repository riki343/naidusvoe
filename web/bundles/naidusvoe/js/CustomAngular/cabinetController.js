Naidusvoe.controller('cabinetController', ['$scope', '$http', '$sce',
    function ($scope, $http, $sce) {
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
        $scope.contactInfo = null;
        $scope.regions = null;

        $scope.getInfo = function () {
            $http.get($scope.urlGetInfo)
                .success(function (response) {
                    $scope.contactInfo = response.contactInfo;
                    $scope.regions = response.regions;
                    $scope.emailSettings.notifications = response.addInfo.notificationsEmail;
                    $scope.emailSettings.spam = response.addInfo.emailSpam;
                    $scope.smsSettings.telephoneNumber = response.addInfo.telephoneNumber;
                    $scope.smsSettings.notifications = response.addInfo.notificationsSms;
                }
            );
        };

        $scope.getUserAdvs = function () {
            $http.get($scope.urlGetUserAdvs)
                .success(function (response) {
                    $scope.userAdvs = response;
                }
            );
        };

        $scope.getFavs = function () {
            $http.get($scope.urlGetFavs)
                .success(function (response) {
                    $scope.favs = response;
                    for (var i = 0; i < $scope.favs.length; i++) {
                        if ($scope.favs[i].advertisment.attachments.length > 0) {
                            $scope.favs[i].advertisment.image =
                                $sce.trustAsUrl($scope.favs[i].advertisment.attachments[0].image);
                        }
                    }
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