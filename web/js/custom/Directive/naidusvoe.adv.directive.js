(function (angular) {
    angular.module('NaiduSvoe').directive('advertisment', advertisment);

    function advertisment() {
        return {
            'restrict': 'E',
            'link': link,
            'templateUrl': '/js/custom/Directive/templates/advertisment.html',
            'scope': {
                'advert': '=advert',
                'showDelButton': '=showDelButton'
            }
        };

        function link($scope, $element, $attr) {
            $scope.adv = $scope.advertisement;

            $scope.$watch('advert', function (val) {
                $scope.adv = val;
            });

            $scope.deleteUserAdv = function (adv) {
                var promise = $http.delete(Routing.generate('delete-user-adv', { 'adv_id': adv.id } ));
                promise.success(function (response) {
                    if (response === true) {
                        $scope.$emit('AdvDeleted', adv);
                    }
                });
            };
        }
    }
})(angular);