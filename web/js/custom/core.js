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
        .value('giftLastPage', '1')
        .value('fbApiKey', '401831443348487')
        .value('vkApiKey', '5133169')
    ;

    run.$inject = ['$rootScope', 'authorizationService', '$location', 'redirectService', '$route', 'notificationsService'];
    function run($rootScope, auth, $location, redirector, $route, notificationsService) {
        var routeChecked = false;

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
            auth.getUser().then(function (user) {
                if (user !== null) {
                    routeChecked = true;
                    $location.url('/cabinet');
                } else {
                    routeChecked = true;
                    if ($route.current && next.$$route.originalPath === $route.current.$$route.originalPath) {
                        $route.reload();
                    } else {
                        $location.path(redirector.prepareRoute(next));
                    }
                }
            });
            event.preventDefault();
        }

        function loggedInFirewall(event, next, current) {
            auth.getUser().then(function (user) {
                if (user !== null) {
                    routeChecked = true;
                    if ($route.current && next.$$route.originalPath === $route.current.$$route.originalPath) {
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
            event.preventDefault();
        }

        function anonymousFirewall(event, next, current) {
            // There is nothing!
        }
    }
})(angular);