(function (angular) {
    angular.module('NaiduSvoe').directive('topMenu', Directive);

    Directive.$inject = ['authorizationService'];

    function Directive(auth) {
        return {
            'templateUrl': '/js/custom/Directive/templates/topmenu.html',
            'link': Link,
            'scope': {}
        };

        function Link($scope, $element, $attrs) {
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
        }
    }
})(angular);