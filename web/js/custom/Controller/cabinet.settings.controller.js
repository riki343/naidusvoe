(function (angular) {
    angular.module('NaiduSvoe').controller('cabinetSettingsController', Controller);

    Controller.$inject = [
        '$scope', '$http', 'settingsService', '$translate', 'notify', 'spinner'
    ];

    function Controller($scope, $http, settings, $translate, notify, spinner) {
        var self = this;

        this.activeTab = 1;
        this.advsView = settings.getAdsView();

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
        $scope.deleteAccount = false;

        $scope.urlDeleteAccount = Routing.generate('user-delete-account');

        $scope.contactInfo = [];
        $scope.message = '';
        $scope.asset = '/';
        $scope.glued = true;
        $scope.spinner = false;

        $scope.getInfo = function () {
            $scope.spinner = true;
            var promise = $http.get(Routing.generate('user-get-info'));
            spinner.addPromise(promise);
            promise.success(function (response) {
                $scope.contactInfo = response.contactInfo;
                $scope.regions = response.regions;
                $scope.emailSettings.notifications = response.addInfo.notificationsEmail;
                $scope.emailSettings.spam = response.addInfo.emailSpam;
                $scope.smsSettings.telephoneNumber = response.addInfo.telephoneNumber;
                $scope.smsSettings.notifications = response.addInfo.notificationsSms;
                $scope.spinner = false;
            });
        };

        $scope.saveContactInfo = function (info) {
            var promise = $http.post(Routing.generate('user-change-contact-info'),
                { 'info': info }
            );
            spinner.addPromise(promise);
            promise.success(function (response) {
                if (response === 1) {
                    $translate('CHANGES_SAVED').then(function (val) {
                        notify(val);
                    });
                }
            });
        };

        $scope.changePassword = function (changes) {
            var promise = $http.post(Routing.generate('user-change-pass'),
                { 'changes': changes }
            );
            spinner.addPromise(promise);
            promise.success(function (response) {
                if (response === 1) {
                    $translate('CHANGES_SAVED').then(function (val) {
                        notify(val);
                    });
                }
            });
        };

        $scope.changeEmail = function (changes) {
            var promise = $http.post(Routing.generate('user-change-email'),
                { 'changes': changes }
            );
            spinner.addPromise(promise);
            promise.success(function (response) {
                if (response === 1) {
                    $translate('CHANGES_SAVED').then(function (val) {
                        notify(val);
                    });
                }
            });
        };

        $scope.saveEmailNotificationSettings = function (settings) {
            var promise = $http.post(Routing.generate('user-change-email-settings'),
                { 'settings': settings }
            );
            spinner.addPromise(promise);
            promise.success(function (response) {
                if (response === 1) {
                    $translate('CHANGES_SAVED').then(function (val) {
                        notify(val);
                    });
                }
            });
        };

        $scope.saveSmsNotificationSettings = function (settings) {
            var promise = $http.post(Routing.generate('user-change-sms-settings'),
                { 'settings': settings }
            );
            spinner.addPromise(promise);
            promise.success(function (response) {
                if (response === 1) {
                    $translate('CHANGES_SAVED').then(function (val) {
                        notify(val);
                    });
                }
            });
        };
    }
})(angular);