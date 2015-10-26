(function (angular) {
    angular.module('NaiduSvoe').controller('cabinetFavsController', Controller);

    Controller.$inject = ['$scope', '$http'];

    function Controller($scope, $http) {
        var self = this;

        this.favs = [];

        $scope.$on('FavDeleted', function (event, data) {
            self.favs.splice(self.favs.indexOf(data), 1);
        });

        this.getFavs = function () {
            var promise = $http.get(Routing.generate('get-user-favs'));
            promise.success(function (response) {
                self.favs = response;
            });
        };
    }

})(angular);