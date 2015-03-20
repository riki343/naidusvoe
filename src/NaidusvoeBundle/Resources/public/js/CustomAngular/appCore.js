var Naidusvoe = angular.module('NaiduSvoe', ['ngRoute', 'ngAnimate']);

Naidusvoe.config(['$interpolateProvider', '$httpProvider', '$routeProvider', '$locationProvider',
    function ($interpolateProvider, $httpProvider, $routeProvider, $locationProvider) {
        $interpolateProvider.startSymbol('[[');
        $interpolateProvider.endSymbol(']]');
        $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';

        $routeProvider
            .when('/', {
                templateUrl: TEMPLATES.index,
                controller: 'indexController'
            })
            .when('/trading', {
                templateUrl: TEMPLATES.trading,
                controller: 'tradingController'
            })
            .otherwise({
                redirectTo: '/'
            });

        $locationProvider.html5Mode(true);
    }
]);

console.log('Core was loaded...');