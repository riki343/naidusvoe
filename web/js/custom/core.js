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
        .run(run)
        .value('tradeLastPage', '1')
        .value('foundLastPage', '1')
        .value('giftLastPage',  '1')
        .value('fbApiKey', '401831443348487')
        .value('vkApiKey', '5133169')
        .value('recaptchaKey', '6LeAmw8TAAAAAGyX-P1jTg13C_GMvdRdJOKNpacc')
    ;

    run.$inject = [
        '$rootScope', 'authorizationService', '$location', 'redirectService',
        '$route', 'notificationsService', '$window', '$timeout', 'vkApiKey', 'fbApiKey'
    ];
    function run(
        $rootScope, auth, $location, redirector, $route,
        notificationsService, $window, $timeout, vkKey, fbKey
    ) {
        var routeChecked = false;
        var asyncContainer = $('div#async-scripts');

        // Init getting of new notifications by timer tick
        notificationsService.init();

        // When route start change we would check next route through firewall
        $rootScope.$on('$routeChangeStart', function (event, next, current) {
            if (routeChecked === false) {
                switch (next.$$route.firewall) {
                    case 'anonymous': anonymousFirewall(event, next, current); break;
                    case 'logged_in': loggedInFirewall(event, next, current);  break;
                    case     'login': loginFirewall(event, next, current);     break;
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
            event.preventDefault();
            auth.getUser().then(function (user) {
                if (user !== null) {
                    routeChecked = true;
                    $location.url('/cabinet');
                } else {
                    routeChecked = true;
                    if ($location.path() === redirector.prepareRoute(next)) {
                        $route.reload();
                    } else {
                        $location.path(redirector.prepareRoute(next));
                    }
                }
            });
        }

        function loggedInFirewall(event, next, current) {
            event.preventDefault();
            auth.getUser().then(function (user) {
                if (user !== null) {
                    routeChecked = true;
                    if ($location.path() === redirector.prepareRoute(next)) {
                        $route.reload();
                    } else {
                        $location.path(redirector.prepareRoute(next));
                    }
                } else {
                    routeChecked = true;
                    redirector.setRedirect(next, true);
                    $location.url('/login');
                }
            });
        }

        function anonymousFirewall(event, next, current) {
            // There is nothing!
        }

        $window.vkAsyncInit = function() {
            VK.init({ 'apiId': vkKey });
        };

        $window.fbAsyncInit = function() {
            FB.init({ 'appId': fbKey, 'xfbml' : true, 'version' : 'v2.5' });
        };

        // Async load facebook API
        $timeout(function() {
            var facebook = angular.element("<script></script>");
            facebook.attr('type', "text/javascript");
            facebook.attr('src', "//connect.facebook.net/en_US/all.js");
            facebook.attr('async', true);
            asyncContainer.append(facebook);
        }, 0);

        // Async load vkontakte API
        $timeout(function() {
            var vk = angular.element("<script></script>");
            vk.attr('type', "text/javascript");
            vk.attr('src', "http://vk.com/js/api/openapi.js");
            vk.attr('async', true);
            asyncContainer.append(vk);
        }, 0);
    }
})(angular);