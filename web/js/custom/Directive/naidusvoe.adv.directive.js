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
                'mini': '=mini',
                'showUrgent': '=',
                'showColor':  '=',
                'titleSize':  '@',
                'titleLineHeight': '@',
                'descriptionSize': '@',
                'citySize':  '@',
                'imgWidth':  '@',
                'infoWidth': '@',
                'blockSize': '@'
            }
        };

        function link($scope, $element, $attr) {
            $element.addClass('o-row');
            $element.css('overflow', 'hidden');

            if (angular.isDefined($scope.blockSize)) {
                $element.css('height', $scope.blockSize);
            }

            $scope.adv = $scope.advert;
            if ($scope.adv.dummy === true) {
                $scope.adv.href = '#'
            } else {
                $scope.adv.href = '/advertisement/' + $scope.adv.type.slug + '/' + $scope.adv.id;
            }

            if ($scope.adv.filled !== null && $scope.showColor === true) {
                $element.addClass('yellow');
            }

            if (angular.isDefined($scope.titleSize)) {
                $element.find('h2').css('font-size', $scope.titleSize);
            }

            if (angular.isDefined($scope.titleLineHeight)) {
                $element.find('h2').css('line-height', $scope.titleLineHeight);
            }

            if (angular.isDefined($scope.descriptionSize)) {
                $element.find('p.description').css('font-size', $scope.descriptionSize);
            }

            if (angular.isDefined($scope.imgWidth)) {
                var imgContainer = $element.find('div.o-cell.photo');
                imgContainer.css('width', $scope.imgWidth);
                var newWidth = imgContainer.width() + 'px';
                imgContainer.css('height', newWidth);
                var img = $element.find('img');
                img.css('width', newWidth);
                img.css('height', newWidth);
            }

            if (angular.isDefined($scope.infoWidth)) {
                $element.find('div.o-cell.info').css('width', $scope.infoWidth);
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