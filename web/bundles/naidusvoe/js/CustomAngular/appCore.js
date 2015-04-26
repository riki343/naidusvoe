var Naidusvoe = angular.module('NaiduSvoe', ['ngRoute', 'ngAnimate', 'luegg.directives', 'pascalprecht.translate']);

Naidusvoe.config(['$interpolateProvider', '$httpProvider', '$routeProvider', '$locationProvider', '$compileProvider', '$translateProvider',
    function ($interpolateProvider, $httpProvider, $routeProvider, $locationProvider, $compileProvider, $translateProvider) {
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
            .when('/cabinet/conversation/:conv_id', {
                templateUrl: TEMPLATES.cabinetConversation,
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
            .when('/trade/:page_id', {
                templateUrl: TEMPLATES.trading,
                controller: 'tradingController'
            })
            .when('/adv/trade/:adv_id', {
                templateUrl: TEMPLATES.tradingAdv,
                controller: 'tradingController'
            })
            .when('/found', {
                templateUrl: TEMPLATES.found,
                controller: 'foundController'
            })
            .when('/found/:page_id', {
                templateUrl: TEMPLATES.found,
                controller: 'foundController'
            })
            .when('/adv/found/:adv_id', {
                templateUrl: TEMPLATES.foundAdv,
                controller: 'foundController'
            })
            .when('/gift', {
                templateUrl: TEMPLATES.gift,
                controller: 'giftController'
            })
            .when('/adv/gift/:adv_id', {
                templateUrl: TEMPLATES.giftAdv,
                controller: 'giftController'
            })
            .when('/features', {
                templateUrl: TEMPLATES.additionalFeatures
            })
            .otherwise({
                redirectTo: '/'
            }
        );

        $locationProvider.html5Mode(true);

        $translateProvider.useStaticFilesLoader({
            prefix: 'bundles/naidusvoe/translations/locale-',
            suffix: '.json'
        });

        $translateProvider.preferredLanguage('ru');
    }
]);