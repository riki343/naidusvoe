Naidusvoe.controller('findController', ['$scope', '$http', '$routeParams',
    function ($scope, $http, $routeParams) {
        $scope.adv_id = $routeParams.adv_id;

        $scope.urlGetAdv = URLS.getAdv;

        $scope.getAdv = function () {
            var advUrl = $scope.urlGetAdv.replace('adv_id', $scope.adv_id);
            $http.get(advUrl)
                .success(function (response) {
                    $scope.Adv = response;
                }
            );
        };
    }
]);