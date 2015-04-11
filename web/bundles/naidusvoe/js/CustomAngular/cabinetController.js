Naidusvoe.controller('cabinetController', ['$scope', '$http',
    function ($scope, $http) {
        $scope.urlGetInfo = URLS.getInfo;
        $scope.urlSaveContactInfo = '';
        $scope.urlSaveNewEmail = '';
        $scope.urlSaveNewPass = '';
        $scope.urlSaveEmailNotificationsSettings = '';
        $scope.urlSaveSmsNotificationsSettings = '';
        $scope.urlDeleteAccount = '';

        $scope.emailChange = {
            'new_email': null,
            'repeat_new_email': null
        };
        $scope.passChange = {
            'old_pass': null,
            'new_pass': null,
            'repeat_new_pass': null
        };
        $scope.emailSettings = {};
        $scope.smsSettings = {};

        $scope.contactInfo = null;
        $scope.addInfo = null;
        $scope.regions = null;

        $scope.getInfo = function () {
            $http.get($scope.urlGetInfo)
                .success(function (response) {
                    $scope.contactInfo = response.contactInfo;
                    $scope.addInfo = response.addInfo;
                    $scope.regions = response.regions;
                }
            );
        };

        $scope.saveContactInfo = function (info) {
            $http.post($scope.urlSaveContactInfo, { 'info': info });
        };

        $scope.changePassword = function (changes) {
            $http.post($scope.urlSaveNewPass, { 'changes': changes });
        };

        $scope.changeEmail = function (changes) {
            $http.post($scope.urlSaveNewEmail, { 'changes': changes });
        };

        $scope.saveEmailNotificationSettings = function (settings) {
            $http.post($scope.urlSaveEmailNotificationsSettings, { 'settings': settings });
        };

        $scope.saveSmsNotificationSettings = function (settings) {
            $http.post($scope.urlSaveSmsNotificationsSettings, { 'settings': settings });
        };

        $scope.deleteAccount = function () {
            $http.delete($scope.urlDeleteAccount);
        };
    }
]);