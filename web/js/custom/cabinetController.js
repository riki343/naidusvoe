(function (angular) {
    angular.module('NaiduSvoe').controller('cabinetController', cabinetController);

    cabinetController.$inject = ['$scope', '$http', 'settingsService'];

    function cabinetController ($scope, $http, settings) {
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
            $http.post(Routing.generate('user-change-contact-info'), { 'info': info })
                .success(function (response) {}
            );
        };

        $scope.changePassword = function (changes) {
            $http.post(Routing.generate('user-change-pass'), { 'changes': changes })
                .success(function (response) {}
            );
        };

        $scope.changeEmail = function (changes) {
            $http.post(Routing.generate('user-change-email'), { 'changes': changes })
                .success(function (response) {}
            );
        };

        $scope.saveEmailNotificationSettings = function (settings) {
            $http.post(Routing.generate('user-change-email-settings'), { 'settings': settings })
                .success(function (response) {}
            );
        };

        $scope.saveSmsNotificationSettings = function (settings) {
            $http.post(Routing.generate('user-change-sms-settings'), { 'settings': settings })
                .success(function (response) {}
            );
        };
    }

})(angular);