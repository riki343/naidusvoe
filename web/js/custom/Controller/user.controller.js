(function (angular) {
    angular.module('NaiduSvoe').controller('userController', userController);

    userController.$inject = [ '$scope', '$http', 'notify', '$translate', 'spinner' ];

    function userController ($scope, $http, notify, $translate, spinner) {
        var self = this;

        this.user = {};
        this.advs = [];
        this.currentRating = 0;

        this.getUser = function () {
            var promise = $http.get(Routing.generate('get-cabinet-profile'));
            spinner.addPromise(promise);
            promise.success(function (response) {
                self.user = response.user;
                self.advs = response.advs;
            });
        };

        this.vote = function (num) {
            num *= 2;
            var promise = $http.get(Routing.generate('get-cabinet-profile'));
            promise.success(function (response) {
                self.user = response.user;
                self.advs = response.advs;
            });
        };
    }

})(angular);