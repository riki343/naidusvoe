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
        .value('fbApiKey', '401831443348487')
        .value('vkApiKey', '5133169')
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
        $httpProvider.defaults.useXDomain = true;

        noCAPTCHAProvider.setTheme('light');
        noCAPTCHAProvider.setSiteKey('6LeAmw8TAAAAABnJ-CyDKBVRYBe5_b4Mrrcx2XuE');

        $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|data):/);

        var templates = '/templates/';

        $routeProvider
            .when('/', {
                'templateUrl': templates + 'index.html',
                'firewall': 'anonymous'
            })
            .when('/pay/confirm/:hash', {
                'templateUrl': templates + 'payment-status.html',
                'firewall': 'logged_in'
            })
            .when('/login', {
                'templateUrl': templates + 'login.html',
                'firewall': 'login'
            })
            .when('/signup', {
                'templateUrl': templates + 'signup.html',
                'firewall': 'login'
            })
            .when('/cabinet', {
                'templateUrl': templates + 'cabinet.html',
                'firewall': 'logged_in'
            })
            .when('/cabinet/advs', {
                'templateUrl': templates + 'cabinet-advs.html',
                'firewall': 'logged_in'
            })
            .when('/cabinet/messages', {
                'templateUrl': templates + 'cabinetMessages.html',
                'firewall': 'logged_in'
            })
            .when('/cabinet/conversation/:conv_id', {
                'templateUrl': templates + 'cabinetConversation.html',
                'firewall': 'logged_in'
            })
            .when('/cabinet/settings', {
                'templateUrl': templates + 'cabinetSettings.html',
                'firewall': 'logged_in'
            })
            .when('/cabinet/favorites', {
                'templateUrl': templates + 'cabinetFavorites.html',
                'firewall': 'logged_in'
            })
            .when('/add-adv', {
                'templateUrl': templates + 'addAdvertisment.html',
                'firewall': 'anonymous'
            })
            .when('/search/:slug/:region/:city', {
                'templateUrl': templates + 'search.html',
                'firewall': 'anonymous'
            })
            .when('/advertisements/:type', {
                'templateUrl': templates + 'advertisements.html',
                'firewall': 'anonymous'
            })
            .when('/advertisement/:type/:adv_id', {
                'templateUrl': templates + 'advertisement.html',
                'firewall': 'anonymous'
            })
            .when('/advertisement/:type/:adv_id/additional-features', {
                'templateUrl': templates + 'additionalFeatures.html',
                'firewall': 'logged_in'
            })
            .otherwise({
                redirectTo: '/'
            }
        );

        $locationProvider.html5Mode(true).hashPrefix('!');

        $translateProvider.useStaticFilesLoader({
            prefix: 'translations/locale-',
            suffix: '.json'
        });

        $translateProvider.preferredLanguage('ua');
    }

    run.$inject = ['$rootScope', 'authorizationService', '$location', 'redirectService'];
    function run($rootScope, auth, $location, redirector) {
        var routeChecked = false;


        // When route start change we would check next route through firewall
        $rootScope.$on('$routeChangeStart', function (event, next, current) {
            console.log('Route: ' + redirector.prepareRoute(next));
            if (routeChecked === false) {
                switch (next.$$route.firewall) {
                    case 'anonymous': break;
                    case 'logged_in': loggedInFirewall(event, next, current); break;
                    case     'login': loginFirewall(event, next, current);    break;
                }
            } else {
                routeChecked = false;
            }

            $rootScope.$broadcast('SpinnerStart');
        });
        $rootScope.$on('$routeChangeSuccess', function() {
            $rootScope.$broadcast('SpinnerStop');
        });

        function loginFirewall(event, next, current) {
            console.log('Matched login firewall');
            auth.getUser().then(function (user) {
                if (user !== null) {
                    console.log('User in session');
                    routeChecked = true;
                    $location.path('/cabinet');
                } else {
                    console.log('User not in session');
                    routeChecked = true;
                    $location.path(redirector.prepareRoute(next));
                }
            });
            event.preventDefault();
        }

        function anonymousFirewall(event, next, current) {

        }

        function loggedInFirewall(event, next, current) {
            console.log('Matched loggedIn firewall');
            auth.getUser().then(function (user) {
                if (user !== null) {
                    console.log('User in session');
                    routeChecked = true;
                    $location.path(redirector.prepareRoute(next));
                } else {
                    console.log('User not in session');
                    routeChecked = true;
                    redirector.setRedirect(next, true);
                    $location.path('/login');
                }
            });
            event.preventDefault();
        }
    }
})(angular);