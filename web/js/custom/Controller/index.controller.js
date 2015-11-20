(function (angular) {
    angular.module('NaiduSvoe').controller('indexController', IndexController);

    IndexController.$inject = ['$scope', '$http', 'spinner', '$location'];
    function IndexController ($scope, $http, spinner, $location) {
        var self = this;

        this.advs = {
            'trade': [],
            'find':  [],
            'gift':  []
        };

        this.getMainAdvs = function () {
            var promise = $http.get(Routing.generate('get-main-advs'));
            promise.success(function (response) {
                self.advs = response;
            });
        };

        this.goTo = function (category) {
            $location.path(/advertisements/ + category);
        }
    }
})(angular);