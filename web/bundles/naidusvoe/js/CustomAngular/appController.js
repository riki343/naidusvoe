Naidusvoe.controller('ApplicationController', ['$scope', '$http', '$rootScope', '$translate',
    function ($scope, $http, $rootScope, $translate) {
        $scope.user = null;
        $scope.emailToAdmin = {
            'from': '',
            'title': '',
            'message': ''
        };
        $scope.RSB = {

        };

        $rootScope.tradingFilter = null;
        $rootScope.foundFilter = null;
        $rootScope.giftFilter = null;

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

        $scope.switchLanguage = function (lang) {
            $translate.use(lang);
        };
    }
]);