(function (angular) {
    angular.module('NaiduSvoe').controller('cabinetMessagesController', Controller);

    Controller.$inject = [ '$http' ];

    function Controller($http) {
        var self = this;

        this.conversations = [];

        this.getConversations = function () {
            self.spinner = true;
            $http.get(Routing.generate('user-get-conversations'))
                .success(function (response) {
                    if (response) {
                        self.conversations = response;
                        self.spinner = false;
                    }
                }
            );
        };
    }

})(angular);