(function (angular) {
    angular.module('NaiduSvoe').controller('paymentStatusController', Controller);

    Controller.$inject = [
        '$scope', '$http', '$location', 'spinner', '$translate', '$routeParams'
    ];

    function Controller($scope, $http, $location, spinner, $translate, $routeParams) {
        var self = this;

        this.hash = $routeParams.hash;

        this.getStatus = function () {
            var promise = $http.get(Routing.generate('api-confirm-payment', { 'hash': self.hash }));
            spinner.addPromise(promise);
            promise.success(function (response) {
                switch (response.status) {
                    case 'ok':
                    case 'success':
                        self.details = response.details;
                        break;
                    case 'error':
                        // response.message;
                        break;
                }
            });
        }
    }
})(angular);