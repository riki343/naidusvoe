(function(angular){
    angular.module('NaiduSvoe').controller('SearchController', SearchController);

    SearchController.$inject = [
        '$scope', 'spinner', 'notify', '$routeParams', '$http'
    ];

    function SearchController($scope, spinner, notify, $routeParams, $http){
        var self = this;
        this.searchData = { 'slug': $routeParams.slug, 'region': $routeParams.region, 'city': $routeParams.city };
        this.searchResult = {
            'advs': [],
            'paginator': {}
        };

        this.search = function () {
            var promise = $http.post(Routing.generate('search'), self.searchData);
            spinner.addPromise(promise);
            promise.success(function (response) {
                self.searchResult.advs = response.items;
                self.searchResult.paginator = response.data;
            });
        }
    }

})(angular);