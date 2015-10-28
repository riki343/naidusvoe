(function (angular) {
    angular.module('NaiduSvoe').factory('advsService', Service);

    Service.$inject = [ '$http' ];

    function Service($http) {
        var self = this;

        var factory = {
            'getBestInCategory': function () {

            },
            'getTopAds': function () {

            }
        };

        return factory;
    }
})(angular);