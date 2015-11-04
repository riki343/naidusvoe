(function(angular){
    angular.module('NaiduSvoe').controller('SearchController', SearchController);

    SearchController.$inject = [
        '$scope', '$location', 'authorizationService', 'spinner', 'notify', '$routeParams', '$http'
    ];

    function SearchController($scope, $location, auth, spinner, notify, $routeParams, $http){
        var self = this;
        this.searchData = {slug: $routeParams.slug, region: $routeParams.region, city: $routeParams.city};
        this.searchResult = {};

        this.search = function () {
            var promise = $http.post(Routing.generate('search'), self.searchData);
            promise.success(function (response) {
                self.searchResult.advs = response;
            });
        }
    }

})(angular);