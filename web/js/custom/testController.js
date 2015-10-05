(function (angular) {
    angular.module('NaiduSvoe').controller('TestController', Controller);

    Controller.$inject = ['$http', '$scope'];

    function Controller ($http, $scope) {
        var self = this;

        $scope.$on('PaginatorClicked', function (e, page) {
            test(page);
        });

        function test(params) {
            var promise = $http.get(Routing.generate('test-ctrl', params));
            promise.success(function (response) {
                self.pager = response;
            });
        }

        test();
    }

})(angular);