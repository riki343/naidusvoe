(function (angular) {
    angular.module('NaiduSvoe').factory('redirectService', Service);

    Service.$inject = [ '$location' ];

    function Service($location) {
        var self = this;

        this.redirector = {
            'redirectTo': '',
            'waitForAuth': false,
            'hasRedirect': false,
            'inProg': false
        };

        var factory = {
            'setRedirect': function (url, auth) {
                self.redirector.redirectTo = url;
                self.redirector.waitForAuth = auth;
                self.redirector.hasRedirect = true;
            },
            'checkForRedirect': function() {
                return self.redirector;
            },
            'clearRedirects': function () {
                self.redirector.waitForAuth = false;
                self.redirector.hasRedirect = false;
                self.redirector.inProg = false;
            },
            'prepareRoute': prepareRoute,
            'checkAuthRedirect': checkAuthRedirect,
            'checkRedirect': function () {
                return self.redirector.hasRedirect === true && self.redirector.waitForAuth === false && self.redirector.inProg === false;
            },
            'setInProg': function () {
                self.redirector.inProg = true;
            },
            'toggleRedirects': toggle
        };

        return factory;

        function toggle() {
            if (checkAuthRedirect()) {
                self.redirector.inProg = true;
                $location.url(prepareRoute(self.redirector.redirectTo));
            }
        }

        function checkAuthRedirect() {
            return self.redirector.hasRedirect === true && self.redirector.waitForAuth === true && self.redirector.inProg === false
        }

        function prepareRoute($route) {
            var route = $route.$$route.originalPath;

            angular.forEach($route.pathParams, function (val, key) {
                route = route.replace(':' + key, val);
            });

            return route;
        }
    }
})(angular);