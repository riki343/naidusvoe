(function (angular) {
    angular.module('NaiduSvoe').controller('ApplicationController', ApplicationController);

    ApplicationController.$inject = ['$scope', '$http', '$translate', 'spinner'];

    function ApplicationController ($scope, $http, $translate, spinner) {
        var lang = LANG;
        var self = this;

        $scope.switchLanguage = function (new_lang) {
            if (new_lang != lang) {
                var promise = $http.post(Routing.generate('naidusvoe_set_lang'), { 'lang': new_lang });
                spinner.addPromise(promise);
                promise.success(function () {
                    lang = new_lang;
                });
            }
            $translate.use(new_lang);
        };

        if (angular.isDefined(LANG)) {
            $scope.switchLanguage(LANG);
        }
    }

})(angular);