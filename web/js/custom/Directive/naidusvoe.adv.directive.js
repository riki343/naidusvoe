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
                'showDelFromFavButton': '=showDelFromFavButton',
                'mini': '=mini'
            }
        };

        function link($scope, $element, $attr) {
            $element.css('overflow', 'hidden');
            $element.addClass('o-row');

            $scope.adv = $scope.advert;
            if ($scope.adv.dummy === true) {
                $scope.adv.href = '/v_pizdu'
            } else {
                $scope.adv.href = '/advertisement/' + $scope.adv.type.slug + '/' + $scope.adv.id;
            }

            if ($scope.adv.advColor === true) {
                $element.addClass('yellow');
            }

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