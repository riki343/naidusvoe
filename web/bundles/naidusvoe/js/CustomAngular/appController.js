Naidusvoe.controller('ApplicationController', ['$scope', '$http',
    function ($scope, $http) {
        $scope.user = null;
        $scope.emailToAdmin = {
            'from': '',
            'title': '',
            'message': ''
        };
        $scope.RSB = {

        };

        $scope.urlGetUser = URLS.getUser;

        $scope.updateRSB = function () {

        };

        $scope.getUser = function () {
            $http.get($scope.urlGetUser)
                .success(function (response) {
                    $scope.user = response;
                }
            );
        };
    }
]);