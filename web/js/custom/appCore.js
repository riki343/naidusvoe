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
        .value('tradeLastPage', '1')
        .value('foundLastPage', '1')
        .value('giftLastPage', '1')
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
//
        $routeProvider
            .when('/', {
                templateUrl: templates + 'index.html',
                controller: 'indexController'
            })
            .when('/pay/confirm/:hash', {
                templateUrl: templates + 'payment-status.html'
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
            .when('/adv/search/:slug', {
                'templateUrl': templates + 'search.html'
            })
            .when('/advertisements/:type', {
                templateUrl: templates + 'advertisements.html'
            })
            .when('/advertisement/:type/:adv_id', {
                templateUrl: templates + 'advertisement.html'
            })
            .when('/advertisement/:type/:adv_id/additional-features', {
                templateUrl: templates + 'additionalFeatures.html'
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

    run.$inject = ['$rootScope', 'authorizationService', '$location', 'redirectService'];
    function run($rootScope, auth, $location, redirector) {
        $rootScope.$on('$routeChangeStart', function (event, next, current) {
            console.log('Route: ' + next.$$route.originalPath);
            var redirect = redirector.checkForRedirect();
            if (redirect.inProg === false) {
                var user = auth.getUserDirect();
                if (user === 'init') {
                    if (Firewall(next.$$route.originalPath) === false) {
                        redirector.setRedirect(next, true);
                        $location.url('/login');
                    }
                } else if (user === null) {
                    if (redirector.prepareRoute(next) === '/cabinet') {
                        $location.url('/login');
                    }
                } else if (user !== null && user !== 'init') {
                    if (redirector.checkAuthRedirect()) {
                        redirector.setInProg();
                        $location.url(redirector.prepareRoute(redirect.redirectTo));
                    }
                }
            }

            $rootScope.$broadcast('SpinnerStart');
        });
        $rootScope.$on('$routeChangeSuccess', function() {
            var redirect = redirector.checkForRedirect();
            if (redirect.inProg === true) {
                redirector.clearRedirects();
            }
            $rootScope.$broadcast('SpinnerStop');
        });

        function Firewall(route) {
            switch (route) {
                case '/pay/confirm/:hash':
                case '/cabinet':
                case '/cabinet/advs':
                case '/cabinet/messages':
                case '/cabinet/conversation/:conv_id':
                case '/cabinet/settings':
                case '/cabinet/favorites':
                case '/advertisement/:type/:adv_id/additional-features':
                    return false;
                default: return true;
            }
        }
    }
})(angular);