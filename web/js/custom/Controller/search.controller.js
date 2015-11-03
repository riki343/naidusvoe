(function(angular){
    angular.module('Naidusvoe').controller('searchController', Controller);

    Controller.$inject = [
        '$scope', '$location', 'authorizationService', 'spinner', 'notify'
    ];

    function Controller($scope, $location, auth, spinner, notify){
        var self = this;
        var searchResult = {};
        var searchData = {condition: 'iPhone', region: 1, city: 'Uzh'};

        this.search = function (data) {
            var promise = $http.post(Routing.generate('search', data));
            promise.success(function (response) {
                notify(response.data);
            });
        }
    }

})(angular);