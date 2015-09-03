(function (angular) {
    angular.module('').controller('ApplicationController', ApplicationController);

    ApplicationController.$inject = ['$scope', '$http', '$rootScope', '$translate'];

    function ApplicationController ($scope, $http, $rootScope, $translate) {
        var lang = LANG;
        var urlSwitchLang = URLS.switchLang;

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

        $scope.switchLanguage = function (new_lang) {
            if (new_lang != lang) {
                $http.post(urlSwitchLang, { 'lang': new_lang })
                    .success(function (response) {
                        lang = new_lang;
                    }
                );
            }
            $translate.use(new_lang);
        };

        if (angular.isDefined(LANG)) {
            $scope.switchLanguage(LANG);
        }
    }

})(angular);