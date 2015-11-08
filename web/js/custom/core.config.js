(function (angular) {
    angular.module('NaiduSvoe').config(config);

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
        $httpProvider.interceptors.push('errorInterceptorService');

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
})(angular);