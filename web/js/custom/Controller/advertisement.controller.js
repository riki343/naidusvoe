(function (angular) {
    angular.module('NaiduSvoe').controller('advertisementController', Controller);

    Controller.$inject = [
        '$scope',
        '$http',
        '$routeParams',
        'Advertisement',
        'notify',
        '$translate',
        'spinner'
    ];

    function Controller($scope, $http, $routeParams, Advertisement, notify, $translate, spinner) {
        var self = this;

        this.selectedImage = null;
        $scope.asset = '/';
        $scope.adv_id = $routeParams.adv_id;
        this.type = $routeParams.type;
        $scope.adv = {};


        $scope.getAdv = function () {
            var promise = Advertisement.get($scope.adv_id);
            spinner.addPromise(promise);
            promise.then(function (response) {
                $scope.adv = response.adv;
                $scope.advUser = response.advUser;
                self.selectedImage = $scope.adv.attachments[0];
                self.user = response.user;
            });
        };

        $scope.addToFav = function () {
            var promise = $http.put(Routing.generate('add-to-fav', { 'adv_id': $scope.adv_id }));
            spinner.addPromise(promise);
            promise.success(function (response) {
                if (response === true) {
                    $translate('FAV_ADDED').then(function (val) {
                        notify(val);
                    });
                } else {
                    $translate('FAV_ALREADY_EXIST').then(function (val) {
                        notify(val);
                    });
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
            spinner.addPromise(promise);
            promise.success(function (response) {
                if (response === true) {
                    $scope.message = '';
                    $('#send_new_message').modal('hide');
                    $translate('MESSAGE_SENT').then(function (val) {
                        notify(val);
                    });
                }
            });
        };

        this.changeUserRating = function (rating) {
            var promise = $http.get(Routing.generate('change-rating', { 'adv_id': $scope.adv_id, 'rating': rating }));
            spinner.addPromise(promise);
            promise.then(function (response) {
                $scope.adv = response;
            });
        };
    }
})(angular);