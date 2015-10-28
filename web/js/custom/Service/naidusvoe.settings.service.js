(function (angular) {
    angular.module('NaiduSvoe').factory('settingsService', Service);

    Service.$inject = [ '$rootScope' ];

    function Service($rootScope) {
        var self = this;
        this.adsView = 'o-table'; // o-table | o-table width-50

        var factory = {
            'getAdsView': getAdsView,
            'setAdsView': setAdsView
        };

        return factory;

        function getAdsView() {
            return self.adsView;
        }

        function setAdsView(view) {
            if (view !== self.adsView) {
                self.adsView = view;
                $rootScope.$broadcast('AdsViewChanged', self.adsView);
            }
        }
    }
})(angular);