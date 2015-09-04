(function (angular) {
    angular.module('NaiduSvoe').controller('tradingController', tradingController);

    tradingController.$inject = ['$scope', '$http', '$routeParams', '$sce', 'spinner'];

    function tradingController ($scope, $http, $routeParams, $sce, spinner) {
        $scope.asset = URLS.asset;
        $scope.adv_id = $routeParams.adv_id;
        $scope.adv = null;
        $scope.advs = null;
        $scope.notifications = {
            'body': '',
            'type': '',
            'visible': false
        };
        $scope.message = '';
        $scope.filterID = null;

        $scope.urlGetAdv = URLS.getAdv;
        $scope.urlAddToFav = URLS.addToFav;
        $scope.urlSendNewMessage = URLS.sendNewMessage;

        $scope.$on('PaginatorClicked', function (e, params) {
            $scope.getAdvs(params);
        });

        $scope.getAdvs = function (options) {
            if ($scope.filterID) {
                options.filter = $scope.filterID;
            }

            var promise = $http.get(Routing.generate('get-trade-advs', options));
            spinner.addPromise(promise);
            promise.success(function (response) {
                $scope.advs = response.advs.items;
                $scope.data = response.advs.data;
                $scope.categories = response.categories;

                for (var i = 0; i < $scope.advs.length; i++) {
                    if ($scope.advs[i].attachments.length > 0) {
                        $scope.advs[i].image = $sce.trustAsUrl($scope.advs[i].attachments[0].image);
                    }
                }
            });
        };

        $scope.selectCategory = function (id) {
            $scope.filterID = id;
            $scope.getAdvs({});
        };

        $scope.getAdv = function () {
            var advUrl = $scope.urlGetAdv.replace('adv_id', $scope.adv_id);
            $http.get(advUrl)
                .success(function (response) {
                    $scope.adv = response.adv;
                    $scope.advUser = response.user;
                    $scope.advUser.avatar = $scope.asset + $scope.advUser.avatar;
                    for (var i = 0; i < $scope.adv.attachments.length; i++) {
                        $scope.adv.attachments[i].image = $sce.trustAsUrl($scope.adv.attachments[i].image);
                    }
                }
            );
        };

        $scope.addToFav = function () {
            var promise = $http.put($scope.urlAddToFav.replace('adv_id', $scope.adv_id));
            promise.success(function (response) {
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
            });
        };

        $scope.sendNewMessage = function (message) {
            if (!message) return;
            var sendMessageURL = $scope.urlSendNewMessage
                .replace('user_id', $scope.advUser.id)
                .replace('adv_id', $scope.adv.id);
            var promise = $http.post(sendMessageURL, { 'message': message });
            promise.success(function (response) {
                $scope.message = '';
                $('#send_new_message').modal('hide');
                if (response) {
                    $scope.notifications.body = 'Повідомлення відправлено';
                    $scope.notifications.type = 'alert-success';
                    $scope.notifications.visible = true;
                }
            });
        };
    }

})(angular);