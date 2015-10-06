(function (angular) {
    angular.module('NaiduSvoe').controller('cabinetFavsController', Controller);

    Controller.$inject = [];

    function Controller() {
        var self = this;

        this.getFavs = function () {
            self.spinner = true;
            var promise = $http.get(Routing.generate('get-user-favs'));
            promise.success(function (response) {
                self.favs = response;
                self.spinner = false;
            });
        };

        this.deleteFav = function (fav_id, index) {
            var promise = $http.delete(Routing.generate('delete-user-fav', { 'fav_id': fav_id }));
            promise.success(function (response) {
                switch (response) {
                    case 1: self.favs.splice(index, 1); break;
                }
            });
        };
    }

})(angular);