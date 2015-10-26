(function (angular) {
    angular.module('NaiduSvoe').directive('advertisment', advertisment);

    advertisment.$inject = [ '$http', 'notify', '$translate' ];

    function advertisment($http, notify, $translate) {
        return {
            'restrict': 'E',
            'link': link,
            'templateUrl': '/js/custom/Directive/templates/advertisment.html',
            'scope': {
                'advert': '=advert',
                'favId': '=favId',
                'showDelButton': '=showDelButton',
                'showDelFromFavButton': '=showDelFromFavButton'
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
                    } else {
                        $translate('FAV_ALREADY_EXIST').then(function (val) {
                            notify(val);
                        });
                    }
                });
            };

            $scope.deleteFromFavs = function (adv) {
                var promise = $http.delete(Routing.generate('delete-user-fav', { 'fav_id': $scope.favId } ));
                promise.success(function (response) {
                    if (response === true) {
                        $scope.$emit('FavDeleted', adv);
                    }
                });
            };
        }
    }
})(angular);