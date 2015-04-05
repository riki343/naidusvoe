var Naidusvoe = angular.module('NaiduSvoe', ['ngRoute', 'ngAnimate']);

Naidusvoe.config(['$interpolateProvider', '$httpProvider', '$routeProvider', '$locationProvider', '$compileProvider',
    function ($interpolateProvider, $httpProvider, $routeProvider, $locationProvider, $compileProvider) {
        $interpolateProvider.startSymbol('[[');
        $interpolateProvider.endSymbol(']]');
        $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';

        $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|data):/);

        $routeProvider
            .when('/', {
                templateUrl: TEMPLATES.index,
                controller: 'indexController'
            })
            .when('/cabinet', {
                templateUrl: TEMPLATES.cabinet,
                controller: 'cabinetController'
            })
            .when('/cabinet/messages', {
                templateUrl: TEMPLATES.cabinetMessages,
                controller: 'cabinetController'
            })
            .when('/cabinet/settings', {
                templateUrl: TEMPLATES.cabinetSettings,
                controller: 'cabinetController'
            })
            .when('/cabinet/favorites', {
                templateUrl: TEMPLATES.cabinetFavorites,
                controller: 'cabinetController'
            })
            .when('/cabinet/addAdv', {
                templateUrl: TEMPLATES.addAdvertisment,
                controller: 'advertismentController'
            })
            .when('/trade', {
                templateUrl: TEMPLATES.trading,
                controller: 'tradingController'
            })
            .when('/adv/trade/:adv_id', {
                templateUrl: TEMPLATES.tradingAdv,
                controller: 'tradingController'
            })
            .when('/found', {
                templateUrl: TEMPLATES.found,
                controller: 'tradingController'
            })
            .when('/adv/found/:adv_id', {
                templateUrl: TEMPLATES.foundAdv,
                controller: 'tradingController'
            })
            .when('/give', {
                templateUrl: TEMPLATES.gift,
                controller: 'tradingController'
            })
            .when('/adv/give/:adv_id', {
                templateUrl: TEMPLATES.giftAdv,
                controller: 'tradingController'
            })
            .otherwise({
                redirectTo: '/'
            });

        $locationProvider.html5Mode(true);
    }
]);