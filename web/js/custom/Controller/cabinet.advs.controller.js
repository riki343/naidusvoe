(function (angular) {
    angular.module('NaiduSvoe').controller('cabinetAdvsController', Controller);

    Controller.$inject = [ '$http', '$scope', 'settingsService', 'spinner' ];

    function Controller($http, $scope, settings, spinner) {
        var self = this;

        this.userAdvs = [];
        this.spinner = false;
        this.advsView = settings.getAdsView();

        $scope.$on('AdvDeleted', function (event, data) {
            self.userAdvs.splice(self.userAdvs.indexOf(data), 1);
        });

        $scope.$on('AdsViewChanged', function (event, data) {
            self.advsView = data;
        });

        this.getUserAdvs = function () {
            var promise = $http.get(Routing.generate('get-user-advs'));
            spinner.addPromise(promise);
            promise.success(function (response) {
                self.userAdvs = response;
            });
        };

        this.changeAdsView = function(view) {
            settings.setAdsView(view);
        };
    }
})(angular);