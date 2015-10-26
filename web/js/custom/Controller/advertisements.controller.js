(function (angular) {
    angular.module('NaiduSvoe').controller('advertisementsController', Controller);

    Controller.$inject = [
        '$scope',
        '$http',
        '$routeParams',
        'settingsService'
    ];

    function Controller($scope, $http, $routeParams, settings) {
        var self = this;
        var initialised = false;

        this.type = $routeParams.type;
        this.advsView = settings.getAdsView();
        $scope.advs = [];
        $scope.message = '';
        $scope.filterID = null;
        var target = $('#element-to-scroll');

        $scope.$on('AdsViewChanged', function (event, data) {
            self.advsView = data;
        });
        $scope.$on('PaginatorClicked', function (e, params) {
            $scope.getAdvs(params);
        });

        this.changeAdsView = function(view) {
            settings.setAdsView(view);
        };

        $scope.getAdvs = function (options) {
            options = (angular.isDefined(options) === false) ? {} : options;
            options.type = self.type;
            options.filter = $scope.filterID;

            var promise = $http.get(Routing.generate('get-advs', options));
            promise.success(function (response) {
                $scope.advs = response.advs.items;
                $scope.data = response.advs.data;
                $scope.categories = response.categories;
                $scope.$broadcast('AdvsLoaded');
            });
        };


        $scope.$on('AdvsLoaded', function () {
            if (initialised === true) {
                $('html,body').animate({
                    scrollTop: target.offset().top - 80
                }, 1000);
            }
            initialised = true;
        });

        $scope.selectCategory = function (id) {
            $scope.filterID = id;
            $scope.getAdvs({});
        };
    }
})(angular);