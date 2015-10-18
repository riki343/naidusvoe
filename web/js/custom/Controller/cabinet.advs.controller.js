(function (angular) {
    angular.module('NaiduSvoe').controller('cabinetAdvsController', Controller);

    Controller.$inject = [ '$http', '$scope', 'settingsService' ];

    function Controller($http, $scope, settings) {
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
            self.spinner = true;
            var promise = $http.get(Routing.generate('get-user-advs'));
            promise.success(function (response) {
                self.userAdvs = response;
                self.spinner = false;
            });
        };

        this.changeAdsView = function(view) {
            settings.setAdsView(view);
        };

    }

})(angular);