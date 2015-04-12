Naidusvoe.controller('cabinetController', ['$scope', '$http',
    function ($scope, $http) {
        $scope.urlGetInfo = URLS.getInfo;
        $scope.urlSaveContactInfo = URLS.saveInfo;
        $scope.urlSaveNewEmail = URLS.changeEmail;
        $scope.urlSaveNewPass = URLS.changePass;
        $scope.urlSaveEmailNotificationsSettings = URLS.saveEmailSettings;
        $scope.urlSaveSmsNotificationsSettings = URLS.saveSmsSettings;
        $scope.urlDeleteAccount = URLS.deleteAccount;

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