(function (angular) {
    angular
        .module('NaiduSvoe', [
            'ngRoute',
            'ngAnimate',
            'luegg.directives',
            'pascalprecht.translate',
            'cgNotify',
            'cgBusy',
            'noCAPTCHA',
            'riki34'
        ])
        .config(config)
        .run(run)
    ;

    config.$inject = [
        '$interpolateProvider', '$httpProvider', '$routeProvider',
        '$locationProvider', '$compileProvider', '$translateProvider',
        'noCAPTCHAProvider'
    ];

    function config(
        $interpolateProvider, $httpProvider, $routeProvider,
        $locationProvider, $compileProvider, $translateProvider,
        noCAPTCHAProvider
    ) {
        $interpolateProvider.startSymbol('[[');
        $interpolateProvider.endSymbol(']]');
        $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';

        noCAPTCHAProvider.setTheme('light');
        noCAPTCHAProvider.setSiteKey('6LeAmw8TAAAAABnJ-CyDKBVRYBe5_b4Mrrcx2XuE');

        $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|data):/);

        var templates = '/templates/';

        $routeProvider
            .when('/', {
                templateUrl: templates + 'index.html',
                controller: 'indexController'
            })
            .when('/login', {
                templateUrl: templates + 'login.html'
            })
            .when('/signup', {
                templateUrl: templates + 'signup.html'
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
            .when('/features', {
                templateUrl: templates + 'additionalFeatures.html'
            })
            .when('/test', {
                'templateUrl': 'bundles/naidusvoe/templates/test.html',
                'controller': 'TestController as test'
            })
            .when('/adv/search/:slug', {
                'templateUrl': templates + 'search.html'
            })
            .when('/advertisements/:type', {
                templateUrl: templates + 'advertisements.html'
            })
            .when('/advertisement/:adv_id/additional-features', {
                templateUrl: templates + 'additionalFeatures.html'
            })
            .when('/advertisement/:type/:adv-id', {
                templateUrl: templates + 'advertisement.html'
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

        $translateProvider.preferredLanguage('ua');
    }

    run.$inject = ['$rootScope', 'authorizationService', '$location'];
    function run($rootScope, auth, $location) {
        $rootScope.$on('$routeChangeStart', function (event, next, current) {
            if (next.$$route.originalPath.search('cabinet') > 0) {
                var user = auth.getUserDirect();
                if (user === null) {
                    $rootScope.$broadcast('SpinnerStart');
                    $location.path('/login');
                }
            } else {
                $rootScope.$broadcast('SpinnerStart');
            }
        });
        $rootScope.$on('$routeChangeSuccess', function() {
            $rootScope.$broadcast('SpinnerStop');
        });
    }
})(angular);