Naidusvoe.controller('foundController', ['$scope', '$http', '$routeParams', '$sce',
    function ($scope, $http, $routeParams, $sce) {
        $scope.asset = URLS.asset;
        $scope.adv_id = $routeParams.adv_id;
        $scope.adv = null;
        $scope.advs = null;

        $scope.urlGetAdv = URLS.getAdv;
        $scope.urlGetAdvs = URLS.getFoundAdvs;

        $scope.getAdvs = function () {
            $http.get($scope.urlGetAdvs)
                .success(function (response) {
                    $scope.advs = response;
                    for (var i = 0; i < $scope.advs.length; i++) {
                        if ($scope.advs[i].attachments.length > 0) {
                            $scope.advs[i].image = $sce.trustAsUrl($scope.advs[i].attachments[0].image);
                        }
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
                        ImagesPreviewFunction();
                        return;
                    }, 400);
                }
            );
        };
    }
]);