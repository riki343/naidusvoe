Naidusvoe.controller('foundController', ['$scope', '$http', '$routeParams', '$sce',
    function ($scope, $http, $routeParams, $sce) {
        $scope.asset = URLS.asset;
        $scope.adv_id = $routeParams.adv_id;
        $scope.adv = null;
        $scope.advs = null;
        $scope.paginator = {
            'current': 1,
            'next': 1,
            'prev': 1,
            'first': 1,
            'last': 1,
            'pages': []
        };
        $scope.notifications = {
            'body': '',
            'type': '',
            'visible': false
        };

        if (angular.isDefined($routeParams.page_id)) {
            $scope.paginator.current = $routeParams.page_id;
        } else {
            $scope.paginator.current = 1;
        }

        $scope.urlGetAdv = URLS.getAdv;
        $scope.urlGetAdvs = URLS.getFoundAdvs;
        $scope.urlAddToFav = URLS.addToFav;

        $scope.getAdvs = function () {
            $http.get($scope.urlGetAdvs.replace('page_id', $scope.paginator.current))
                .success(function (response) {
                    $scope.advs = response.advs;

                    $scope.paginator.last = response.pageCount;
                    $scope.paginator.prev = ($scope.paginator.current > 1)
                        ? $scope.paginator.current - 1
                        : 1;
                    $scope.paginator.next = ($scope.paginator.current < $scope.paginator.last)
                        ? $scope.paginator.next + 1
                        : $scope.paginator.last;

                    for (var i = 0; i < $scope.advs.length; i++) {
                        if ($scope.advs[i].attachments.length > 0) {
                            $scope.advs[i].image = $sce.trustAsUrl($scope.advs[i].attachments[0].image);
                        }
                    }

                    $scope.paginator.pages = [];
                    for (i = 0; i < $scope.paginator.last; i++) {
                        $scope.paginator.pages.push(i + 1);
                    }
                }
            );
        };

        $scope.getAdv = function () {
            var advUrl = $scope.urlGetAdv.replace('adv_id', $scope.adv_id);
            $http.get(advUrl)
                .success(function (response) {
                    $scope.adv = response;
                    for (var i = 0; i < $scope.adv.attachments.length; i++) {
                        $scope.adv.attachments[i].image = $sce.trustAsUrl($scope.adv.attachments[i].image);
                    }

                    setTimeout(function () {
                        InitLightBox();
                        return false;
                    }, 400);
                }
            );
        };

        $scope.addToFav = function () {
            $http.put($scope.urlAddToFav.replace('adv_id', $scope.adv_id))
                .success(function (response) {
                    switch(response) {
                        case 1:
                            $scope.notifications.body = 'Додано до обраних';
                            $scope.notifications.type = 'alert-success';
                            $scope.notifications.visible = true;
                            break;
                        case -1:
                            $scope.notifications.body = 'Невідома помилка, спробуйте пізніше.';
                            $scope.notifications.type = 'alert-danger';
                            $scope.notifications.visible = true;
                            break;
                    }
                }
            );
        };
    }
]);