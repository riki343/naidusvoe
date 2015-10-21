(function (angular) {
    angular
        .module('NaiduSvoe', [
            'ngRoute',
            'ngAnimate',
            'luegg.directives',
            'pascalprecht.translate',
            'cgNotify',
            'cgBusy',
            'riki34'
        ])
        .config(['$interpolateProvider', '$httpProvider', '$routeProvider', '$locationProvider', '$compileProvider', '$translateProvider',
            function ($interpolateProvider, $httpProvider, $routeProvider, $locationProvider, $compileProvider, $translateProvider) {
                $interpolateProvider.startSymbol('[[');
                $interpolateProvider.endSymbol(']]');
                $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';

                $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|data):/);

                var templates = '/templates/';

                $routeProvider
                    .when('/', {
                        templateUrl: templates + 'index.html',
                        controller: 'indexController'
                    })
                    .when('/cabinet', {
                        templateUrl: templates + 'cabinet.html'
                    })
                    .when('/cabinet/advs', {
                        templateUrl: templates + 'cabinet-advs.html'
                    })
                    .when('/cabinet/messages', {
                        templateUrl: templates + 'cabinetMessages.html'
                    })
                    .when('/cabinet/conversation/:conv_id', {
                        templateUrl: templates + 'cabinetConversation.html'
                    })
                    .when('/cabinet/settings', {
                        templateUrl: templates + 'cabinetSettings.html'
                    })
                    .when('/cabinet/favorites', {
                        templateUrl: templates + 'cabinetFavorites.html'
                    })
                    .when('/add-adv', {
                        templateUrl: templates + 'addAdvertisment.html'
                    })
                    .when('/trade', {
                        templateUrl: templates + 'trading.html'
                    })
                    .when('/adv/trade/:adv_id', {
                        templateUrl: templates + 'tradingAdv.html'
                    })
                    .when('/found', {
                        templateUrl: templates + 'found.html'
                    })
                    .when('/adv/found/:adv_id', {
                        templateUrl: templates + 'foundAdv.html',
                        controller: 'foundController'
                    })
                    .when('/gift', {
                        templateUrl: templates + 'gift.html'
                    })
                    .when('/adv/gift/:adv_id', {
                        templateUrl: templates + 'giftAdv.html',
                        controller: 'giftController'
                    })
                    .when('/features', {
                        templateUrl: templates + 'additionalFeatures.html'
                    })
                    .when('/test', {
                        'templateUrl': 'bundles/naidusvoe/templates/test.html',
                        'controller': 'TestController as test'
                    })
                    .otherwise({
                        redirectTo: '/'
                    }
                );

                $locationProvider.html5Mode(true);

                $translateProvider.useStaticFilesLoader({
                    prefix: 'translations/locale-',
                    suffix: '.json'
                });

                $translateProvider.preferredLanguage('ru');
            }
        ]);
})(angular);