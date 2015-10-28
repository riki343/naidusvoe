(function (angular) {
    angular.module('NaiduSvoe').directive('mainSpinner', Directive);

    Directive.$inject = [ '$timeout' ];

    function Directive($timeout) {
        return {
            'restrict': 'A',
            'link': Link,
            'scope': {}
        };

        function Link($scope, $element, $attrs) {
            var spinner = $element;

            $timeout(function () {
                spinner.addClass('ng-hide');
            });

            $scope.$on('SpinnerStop', function () {
                spinner.addClass('ng-hide');
            });

            $scope.$on('SpinnerStart', function () {
                spinner.removeClass('ng-hide');
            });
        }
    }
})(angular);