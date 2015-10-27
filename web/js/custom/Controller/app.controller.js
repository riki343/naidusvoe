(function (angular) {
    angular.module('NaiduSvoe').controller('ApplicationController', ApplicationController);

    ApplicationController.$inject = ['$scope', '$http', '$rootScope', '$translate', 'spinner'];

    function ApplicationController ($scope, $http, $rootScope, $translate, spinner) {
        var lang = LANG;
        var self = this;

        this.spinner = false;

        spinner.onPromisesStart($scope, function () {
            self.spinner = true;
        });

        spinner.onPromisesEnd($scope, function () {
            self.spinner = false;
        });

        $scope.user = null;
        $scope.emailToAdmin = {
            'from': '',
            'title': '',
            'message': ''
        };
        $scope.RSB = {};

        $scope.getUser = function () {
            $http.get(Routing.generate('get-user'))
                .success(function (response) {
                    $scope.user = response;
                }
            );
        };

        $scope.switchLanguage = function (new_lang) {
            if (new_lang != lang) {
                $http.post(Routing.generate('naidusvoe_set_lang'), { 'lang': new_lang })
                    .success(function () {
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