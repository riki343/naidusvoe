Naidusvoe.controller('tradingController', ['$scope', '$http', '$routeParams',
    function ($scope, $http, $routeParams) {
        $scope.asset = URLS.asset;
        $scope.adv_id = $routeParams.adv_id;

        $scope.urlGetAdv = URLS.getAdv;

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