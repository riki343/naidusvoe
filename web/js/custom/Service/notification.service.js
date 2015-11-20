(function (angular) {
    angular.module('NaiduSvoe').factory('notificationsService', Service);

    Service.$inject = ['$rootScope', '$http', '$interval', 'authorizationService', '$translate', 'notify', '$timeout', '$q'];

    function Service($rootScope, $http, $interval, auth, $translate, notify, $timeout, $q) {
        var self = this;
        this.notifications = [];
        this.checkHandler = null;

        $rootScope.$on('SessionLogin', function () {
            if (self.checkHandler === null) {
                self.checkHandler = $timeout(checkNotifications, 20000);
            }
        });

        $rootScope.$on('SessionLogout', function () {
            $interval.cancel(self.checkHandler);
            self.checkHandler = null;
        });

        $rootScope.$on('HttpError', function (event, data) {
            $translate(data).then(function (val) {
                notify(val);
            });
        });

        var factory = {
            'getNotifications': function () {
                return self.notifications;
            },
            'removeNotification': function (notification) {
                self.notifications.splice(self.notifications.indexOf(notification), 1);
            },
            'init': function () {
                if (self.checkHandler === null) {
                    self.checkHandler = $timeout(checkNotifications, 20000);
                }
            }
        };

        return factory;

        function checkNotifications() {
            var promise = auth.getUser();
            promise.then(function (user) {
                if (user !== null) {
                    var promise = checkForUser();
                    promise.then(function () {
                        $interval.cancel(self.checkHandler);
                        self.checkHandler = null;
                        self.checkHandler = $timeout(checkNotifications, 20000);
                    });
                } else if (self.checkHandler !== null) {
                    $interval.cancel(self.checkHandler);
                    self.checkHandler = null;
                }
            });
        }

        function checkForUser() {
            var defer = $q.defer();
            var promise = $http.get(Routing.generate('get-notifications'));
            promise.success(function (notifications) {
                if (self.notifications.length === 0 || (notifications.length > 0 && notifications[0].id !== self.notifications[0].id)) {
                    angular.forEach(notifications, function (val) {
                        if (findById(val, this) !== null) {
                            dispatchNotification(val);
                            self.notifications.push(val);
                        }
                    }, self.notifications);
                }
                if (notifications.length === 0)
                {
                    $rootScope.$broadcast('NewMessageNotification',null);
                }
                defer.resolve();
            });
            return defer.promise;
        }

        function dispatchNotification(notification) {
            console.log(notification.type);
            switch (notification.type) {
                case "CONVERSATION_NOTIFICATION":
                    $rootScope.$broadcast('NewMessageNotification', notification);
                    break;
                default: break;
            }
        }

        function findById(item, array) {
            if(array.length === 0){
                return item;
            }
            var element = null;
            for (var i in array) {
                if (array[i].id !== item.id) {
                    element = array[i];
                    break;
                }
            }

            return element;
        }
    }
})(angular);