(function (angular) {
    angular.module('NaiduSvoe').directive('siteSearch', Directive);

    Directive.$inject = [];

    function Directive() {
        return {
            'templateUrl': '/js/custom/Directive/templates/search.html',
            'link': Link,
            'scope': true
        };

        function Link($scope, $element, $attrs) {
            $scope.selectedRegion = '1';
            $scope.selectedCity = '';
            $scope.condition = '';

            $scope.toggleSearch = function () {

            }
        }
    }
})(angular);