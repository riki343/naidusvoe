(function (angular) {
    angular.module('NaiduSvoe').directive('siteSearch', Directive);

    Directive.$inject = [];

    function Directive() {
        return {
            'templateUrl': '',
            'link': Link,
            'scope': {}
        };

        function Link($scope, $element, $attrs) {

        }
    }
})(angular);