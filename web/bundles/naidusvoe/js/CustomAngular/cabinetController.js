Naidusvoe.controller('cabinetController', ['$scope', '$http',
    function ($scope, $http) {
        $scope.urlGetInfo = URLS.getInfo;
        
        $scope.getInfo = function () {
            $http.get($scope.urlGetInfo)
                .success(function (response) {
                    $scope.contactInfo = response.contactInfo;
                    $scope.addInfo = response.addInfo;
                }
            );
        };

        $scope.saveContactInfo = function () {

        };

        $scope.changePassword = function () {

        };

        $scope.changeEmail = function () {

        };

        $scope.saveEmailNotificationSettings = function () {

        };

        $scope.saveSmsNotificationSettings = function () {

        };

        $scope.deleteAccount = function () {

        };
    }
]);