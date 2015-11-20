(function (angular) {
    angular.module('NaiduSvoe').controller('cabinetController', cabinetController);

    cabinetController.$inject = [ '$scope', '$http', 'notify', '$translate', 'spinner', 'notificationsService' ];

    function cabinetController ($scope, $http, notify, $translate, spinner, notifications) {
        var self = this;

        this.user = {};
        this.advs = [];
        this.currentRating = 0;
        this.notifications = {};

        $scope.$on('AdvDeleted', function (event, data) {
            self.advs.splice(self.advs.indexOf(data), 1);
        });

        this.getUser = function () {
            var promise = $http.get(Routing.generate('get-cabinet-profile'));
            spinner.addPromise(promise);
            promise.success(function (response) {
                self.user = response.user;
                self.advs = response.advs;
            });
            self.notifications = notifications.getNotifications();
        };

        $('#change-avatar-input').on('change', function (event) {
            $scope.$apply(function () {
                var src = (event.srcElement || event.target).files[0];
                if (src.size / 1048576 > 1) {
                    $translate('MAX_FILE_SIZE_1').then(function (val) {
                        notify(val);
                    });
                    return;
                }
                var fileReader = new FileReader();
                fileReader.onload = function () {
                    $scope.$broadcast('FileLoaded', fileReader.result);
                    $scope.$apply();
                };
                fileReader.readAsDataURL(src);
            });
        });

        $scope.$on('FileLoaded', function (event, data) {
            self.user.avatar = data;
            var promise = $http.post(Routing.generate('change-avatar'), self.user.avatar);
            promise.success(function (response) {
                if (response !== null) {
                    $translate('AVATAR_CHANGED').then(function (val) {
                        notify(val);
                    });
                } else {
                    $translate('UNKNOWN_ERROR').then(function (val) {
                        notify(val);
                    });
                }
            });
            promise.error(function () {
                $translate('UNKNOWN_ERROR').then(function (val) {
                    notify(val);
                });
            });
        });
    }

})(angular);