(function (angular) {
    angular.module('NaiduSvoe').controller('conversationController', Controller);

    Controller.$inject = [ '$http', '$routeParams', 'spinner' ];

    function Controller($http, $routeParams, spinner) {
        var self = this;

        if (angular.isDefined($routeParams.conv_id)) {
            this.conversation_id = $routeParams.conv_id;
        }

        this.getConversation = function () {
            var promise = $http.get(Routing.generate('user-get-conversation',
                { 'conv_id': self.conversation_id })
            );
            spinner.addPromise(promise);
            promise.success(function (response) {
                self.conv = response;
                var msgs = self.conv.messages;
                for (var i = msgs.length - 1; i > 0; i--) {
                    msgs[i].first = (
                        msgs[i - 1].viewed === true &&
                        msgs[i].viewed === false &&
                        msgs[i].user.id !== self.conv.myself.id
                    );
                }
            });
        };

        this.sendNewMessage = function (message) {
            if (!message) return;
            var user_id = (self.conv.user1.id == self.conv.myself.id)
                ? self.conv.user2.id : self.conv.user1.id;

            var promise = $http.post(
                Routing.generate('message-send',
                    { 'user_id': user_id, 'adv_id': self.conv.advertismentID }),
                    { 'message': message }
            );

            promise.success(function (response) {
                self.message = '';
                self.conv.messages.push(response);
            });
        };

    }

})(angular);