(function (angular) {
    angular.module('NaiduSvoe').controller('cabinetMessagesController', Controller);

    Controller.$inject = [ '$http', 'spinner' ];

    function Controller($http, spinner) {
        var self = this;

        this.conversations = [];

        this.getConversations = function () {
            var promise = $http.get(Routing.generate('user-get-conversations'));
            spinner.addPromise(promise);
            promise.success(function (response) {
                if (response) {
                    self.conversations = response;
                }
            });
        };
    }

})(angular);