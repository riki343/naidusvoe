(function (angular) {
    angular.module('NaiduSvoe').directive('topMenu', Directive);

    Directive.$inject = ['authorizationService', '$rootScope'];

    function Directive(auth, $rootScope) {
        this.notifications = 0;
        return {
            'templateUrl': '/js/custom/Directive/templates/topmenu.html',
            'link': Link,
            'scope': {}
        };

        function Link($scope, $element, $attrs) {
            $scope.notifications = 0;
            auth.getUser().then(function (response) {
                $scope.user = response;
            });

            $scope.logout = function () {
                auth.logout();
            };

            $scope.$on('SessionLogout', function () {
                $scope.user = null;
            });

            $scope.$on('SessionLogin', function (event, user) {
                $scope.user = user;
            });

            $rootScope.$on('NewMessageNotification', function (event, notification) {
                if(notification!=null)
                {
                    $scope.notifications = $scope.notifications + 1;
                }
                else
                {
                    $scope.notifications = 0;
                }
            });
        }
    }
})(angular);