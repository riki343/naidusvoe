(function (angular) {
    angular.module('NaiduSvoe').factory('authorizationService', Service);

    Service.$inject = ['$http', '$rootScope', '$timeout', '$location', '$translate', 'notify', '$q', 'redirectService', 'spinner'];

    function Service($http, $rootScope, $timeout, $location, $translate, notify, $q, redirector, spinner) {
        var self = this;
        this.user = null;
        this.init = true;
        this.authPromise = null;

        $rootScope.$on('SessionLogin', function (event, user) {
            self.user = user;
            self.init = false;
            self.authPromise = null;
            $location.url('/cabinet');
        });

        $rootScope.$on('SessionLogout', function () {
            self.init = true;
            self.authPromise = null;
            $location.url('/');
        });

        $rootScope.$on('UserFetched', function (event, user) {
            self.user = user;
            self.init = false;
            self.authPromise = null;
            redirector.toggleRedirects();
        });

        $rootScope.$on('RegistrationSuccess', function () {
            $translate('USER_ADDED').then(function (val) {
                notify(val);
            });
            $location.url('/login');
        });

        var factory = {
            'getUser': function () {
                return checkSession(true);
            },
            'login': function (data) {
                if (self.authPromise !== null) {
                    return self.authPromise;
                } else {
                    var defer = $q.defer();
                    var promise = $http.post(Routing.generate('login'), data);
                    spinner.addPromise(promise);
                    self.authPromise = promise;
                    promise.success(function (response) {
                        if (response.status === 'success') {
                            defer.resolve(true);
                            $rootScope.$broadcast('SessionLogin', response.user);
                        } else {
                            defer.resolve(false);
                            handleError(response);
                        }

                        self.authPromise = null;
                    });

                    return defer.promise;
                }
            },
            'loginOAuth': function (data) {
                var promise = $http.post(Routing.generate('oauth-login'), data);
                spinner.addPromise(promise);
                promise.success(function (response) {
                    if (response.status === 'success') {
                        defer.resolve(true);
                        $rootScope.$broadcast('SessionLogin', response.user);
                    } else {
                        defer.resolve(false);
                        handleError(response);
                    }
                });
            },
            'logout': function () {
                var promise = $http.get(Routing.generate('logout'));
                promise.success(function () {
                    $rootScope.$broadcast('SessionLogout');
                });
            },
            'signUp': function (data) {
                var defer = $q.defer();
                var promise = $http.post(Routing.generate('signup'), data);
                promise.success(function (response) {
                    if (response.status === 'success') {
                        defer.resolve(true);
                        $rootScope.$broadcast('RegistrationSuccess');
                    } else {
                        defer.resolve(false);
                        handleError(response);
                    }
                });

                return defer.promise;
            },
            'getUserDirect': function () {
                if (self.init === true) {
                    return 'init';
                } else {
                    return self.user;
                }
            }
        };

        $timeout(checkSession, 120000);

        return factory;

        function checkSession(recent) {
            if (self.authPromise === null) {
                var defer = $q.defer();
                if (angular.isUndefined(recent) || self.init === true) {
                    var promise = $http.get(Routing.generate('get-user'));
                    self.authPromise = promise;
                    promise.success(function(response) {
                        checkResponse(response, true);
                        defer.resolve(response.user);
                        self.init = false;
                        self.authPromise = null;
                    });
                } else {
                    defer.resolve(self.user);
                }

                return defer.promise;
            } else {
                return self.authPromise;
            }
        }

        function checkResponse(response, remote) {
            if (self.user !== response.user) {
                if (response.user === null && self.user !== null && remote === true) {
                    $rootScope.$broadcast('SessionLogout');
                } else if (response.user !== null && self.user === null && remote === true) {
                    $rootScope.$broadcast('UserFetched', response.user);
                }
            }
        }

        function handleError(response) {
            switch (response.reason) {
                case 'captcha':
                    $translate('WRONG_CAPTCHA').then(function (val) {
                        notify(val);
                    });
                    break;
                case 'user not found':
                    $translate('USER_NOT_FOUND').then(function (val) {
                        notify(val);
                    });
                    break;
                case 'wrong password':
                    $translate('WRONG_PASSWORD').then(function (val) {
                        notify(val);
                    });
                    break;
                case 'user not active':
                    $translate('USER_NOT_ACTIVE').then(function (val) {
                        notify(val);
                    });
                    break;

                case 'user exist':
                    $translate('USER_ALREADY_EXIST').then(function (val) {
                        notify(val);
                    });
                    break;
                case 'password not match':
                    $translate('PASSWORDS_NOT_MATCH').then(function (val) {
                        notify(val);
                    });
                    break;
            }
        }
    }
})(angular);