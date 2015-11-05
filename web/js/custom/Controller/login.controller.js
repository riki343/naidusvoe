(function (angular) {
    angular.module('NaiduSvoe').controller('loginController', Controller);

    Controller.$inject = [
        '$scope', '$location', 'authorizationService', 'spinner', '$window', '$http', 'notify', '$timeout',
        'vkApiKey', 'fbApiKey'
    ];

    function Controller($scope, $location, auth, spinner, $window, $http, notify, $timeout, vkKey, fbKey) {

        var self = this;
        this.user = null;

        var promise = auth.getUser();
        spinner.addPromise(promise);
        promise.then(function (user) {
            self.user = user;
        });

        if (self.user !== null) {
            $location.path('/cabinet');
        }

        if (angular.isUndefined(self.captcha)) {
            this.captcha = {};
        }

        this.credentials = {
            'email':    '',
            'password': '',
            'captcha':  ''
        };

        $window.vkAsyncInit = function() {
            VK.init({
                apiId: vkKey
            });
        };

        $window.fbAsyncInit = function() {
            FB.init({
                appId      : fbKey,
                xfbml      : true,
                version    : 'v2.5'
            });
        };

        this.login = function (data) {
            var promise = auth.login(data);
            spinner.addPromise(promise);
            promise.then(function (response) {
                if (response === false) {
                    self.captcha.reset();
                }
            });
        };

        function generateFacebookAuthRequest(response) {
            return {
                'token': response.authResponse.accessToken,
                'resource': 'facebook',
                'resourceId': response.authResponse.userID
            }
        }

        function generateVKAuthRequest(response) {
            return {
                'token': response.authResponse.accessToken,
                'resource': 'vkontakte',
                'resourceId': response.authResponse.userID
            }
        }

        this.fbLogin = function () {
            FB.getLoginStatus(function(response) {
                if (response.status === 'connected') {
                    auth.loginOAuth(generateFacebookAuthRequest(response));
                } else {
                    FB.login(function(response) {
                        console.log(response);
                        if (response.authResponse) {
                            auth.loginOAuth(generateFacebookAuthRequest(response));
                        }
                    }, {scope: 'email'});
                }
            });
        };

        this.vkLogin = function () {
            VK.Auth.getLoginStatus(function (response) {
                if (response.session) {
                    console.log(response);
                } else {
                    VK.Auth.login(function(response) {
                        if (response.session) {
                            console.log(response);
                        }
                    });
                }
                console.log(response);
            });
        };

        this.signup = function () {
            $location.path('signup');
        };

        var asyncContainer = angular.element('body').find('div#async-scripts');
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