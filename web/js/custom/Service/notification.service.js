(function (angular) {
    angular.module('NaiduSvoe').factory('notificationsService', Service);

    Service.$inject = ['$rootScope', '$http', '$interval', 'authorizationService', '$translate', 'notify'];

    function Service($rootScope, $http, $interval, auth, $translate, notify) {
        var self = this;
        this.notifications = [];
        this.checkHandler = null;

        $rootScope.$on('SessionLogin', function () {
            if (self.checkHandler === null) {
                self.checkHandler = $interval(checkNotifications, 10000);
            }
        });

        $rootScope.$on('SessionLogout', function () {
            self.checkHandler.clear();
            self.checkHandler = null;
        });

        var factory = {
            'getNotifications': function () {
                return self.notifications;
            },
            'removeNotification': function (notification) {
                self.notifications.splice(self.notifications.indexOf(notification), 1);
            }
        };

        return factory;

        function checkNotifications() {
            var promise = auth.getUser();
            promise.then(function (user) {
                if (user !== null) {
                    checkForUser();
                    if (self.checkHandler === null) {
                        self.checkHandler = $interval(checkNotifications, 10000);
                    }
                } else if (self.checkHandler !== null) {
                    self.checkHandler.clear();
                    self.checkHandler = null;
                }
            });
        }

        function checkForUser() {
            var promise = $http.get('check-notifications');
            promise.success(function (notifications) {
                if (self.notifications.length === 0 || (notifications.length > 0 && notifications[0].id !== self.notifications[0].id)) {
                    angular.forEach(notifications, function (val) {
                        if (findById(val, this) !== null) {
                            dispatchNotification(val);
                            this.push(val);
                        }
                    }, self.notifications);
                }
            });
        }

        function dispatchNotification(notification) {
            switch (notification.type) {
                case 1:
                    $rootScope.$broadcast('NewMessageNotification', notification);
                    break;
                default: break;
            }
        }

        function findById(item, array) {
            var element = null;

            for (var i in array) {
                if (array[i].id === item.id) {
                    element = array[i];
                    break;
                }
            }

            return element;
        }
    }
})(angular);