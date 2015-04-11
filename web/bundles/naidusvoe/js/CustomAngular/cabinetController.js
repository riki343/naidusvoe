Naidusvoe.controller('cabinetController', ['$scope', '$http',
    function ($scope, $http) {
        $scope.urlGetInfo = URLS.getInfo;
        $scope.urlSaveContactInfo = URLS.saveInfo;
        $scope.urlSaveNewEmail = URLS.changeEmail;
        $scope.urlSaveNewPass = URLS.changePass;
        $scope.urlSaveEmailNotificationsSettings = URLS.saveEmailSettings;
        $scope.urlSaveSmsNotificationsSettings = URLS.saveSmsSettings;

        $scope.emailChange = {
            'email': null,
            'remail': null
        };
        $scope.passChange = {
            'opass': null,
            'pass': null,
            'rpass': null
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

    }
]);