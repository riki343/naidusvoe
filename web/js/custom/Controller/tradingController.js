(function (angular) {
    angular.module('NaiduSvoe').controller('tradingController', tradingController);

    tradingController.$inject = [
        '$scope',
        '$http',
        '$routeParams',
        'spinner',
        'settingsService',
        'Advertisement'
    ];

    function tradingController ($scope, $http, $routeParams, spinner, settings, Advertisement) {
        var self = this;

        this.advsView = settings.getAdsView();
        this.selectedImage = null;

        this.changeAdsView = function(view) {
            settings.setAdsView(view);
        };

        $scope.$on('AdsViewChanged', function (event, data) {
            self.advsView = data;
        });

        $scope.asset = '/';
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
            });
        };

        $scope.selectCategory = function (id) {
            $scope.filterID = id;
            $scope.getAdvs({});
        };

        $scope.getAdv = function () {
            var promise = Advertisement.get($scope.adv_id);
            promise.then(function (response) {
                    $scope.adv = response.adv;
                    $scope.advUser = response.user;
                    $scope.advUser.avatar = '/' + $scope.advUser.avatar;

                    self.selectedImage = $scope.adv.attachments[0];
                }
            );
        };

        $scope.addToFav = function () {
            var promise = $http.put(Routing.generate('add-to-fav', { 'adv_id': $scope.adv_id }));
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
            var sendMessageUrl = Routing.generate('message-send', {
                'user_id': $scope.advUser.id,
                'adv_id': $scope.adv.id
            });

            var promise = $http.post(sendMessageUrl, { 'message': message });
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