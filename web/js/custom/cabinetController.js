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
        $scope.favs = [];
        $scope.userMsgs = [];
        $scope.contactInfo = [];
        $scope.regions = [];
        $scope.conv = [];
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

        $scope.getFavs = function () {
            $scope.spinner = true;
            var promise = $http.get(Routing.generate('get-user-favs'));
            promise.success(function (response) {
                $scope.favs = response;
                $scope.spinner = false;
            });
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

        $scope.saveContactInfo = function (info) {
            $http.post($scope.urlSaveContactInfo, { 'info': info })
                .success(function (response) {}
            );
        };

        $scope.changePassword = function (changes) {
            $http.post($scope.urlSaveNewPass, { 'changes': changes })
                .success(function (response) {}
            );
        };

        $scope.changeEmail = function (changes) {
            $http.post($scope.urlSaveNewEmail, { 'changes': changes })
                .success(function (response) {}
            );
        };

        $scope.saveEmailNotificationSettings = function (settings) {
            $http.post($scope.urlSaveEmailNotificationsSettings, { 'settings': settings })
                .success(function (response) {}
            );
        };

        $scope.saveSmsNotificationSettings = function (settings) {
            $http.post($scope.urlSaveSmsNotificationsSettings, { 'settings': settings })
                .success(function (response) {}
            );
        };
    }

})(angular);