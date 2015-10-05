(function (angular) {
    angular.module('NaiduSvoe').directive('advertisment', advertisment);

    function advertisment() {
        return {
            'restrict': 'E',
            'link': link,
            'templateUrl': 'js/custom/Directive/templates/advertisment.html',
            'scope': {
                'advert': '=advert'
            }
        };

        function link($scope, $element, $attr) {
            $scope.adv = $scope.advertisement;

            $scope.$watch('advert', function (val) {
                $scope.adv = val;
            });
        }
    }
})(angular);