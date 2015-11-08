(function (angular) {
    angular.module('NaiduSvoe').controller('loginController', Controller);

    Controller.$inject = [
        '$scope', '$location', 'authorizationService', 'spinner', '$window', '$timeout', 'vkApiKey', 'fbApiKey'
    ];

    function Controller($scope, $location, auth, spinner, $window, $timeout, vkKey, fbKey) {

        var self = this;
        var currentSocial = null;
        var modalContainer = angular.element('body').find('div#credentials-modal');
        var asyncContainer = angular.element('body').find('div#async-scripts');

        if (angular.isUndefined(self.captcha)) {
            this.captcha = {};
        }

        this.credentials = { 'email': '', 'name': '', 'captcha': '' };

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
                'resource': 'facebook',
                'resourceId': response.authResponse.userID
            }
        }

        function checkFbResponse(response) {
            if (response.status === 'connected') {

            } else {
                FB.login(function(response) {
                    if (response.authResponse) {

                    }
                }, {scope: 'email'});
            }
        }

        this.fbLogin = function () {
            FB.getLoginStatus(checkFbResponse);
        };

        function generateVKAuthRequest(session) {
            return {
                'resource': 'vkontakte',
                'resourceId': session.mid
            }
        }

        function checkVkResponse(response) {
            if (response.session !== null) {
                var promise = auth.loginOAuth(generateVKAuthRequest(VK.Auth.getSession()), null);
                promise.then(function (localResponse) {
                    if (localResponse.status === 'credential_required') {
                        $scope.$broadcast('VkCredentialsRequired');
                    }
                });
            } else {
                VK.Auth.login(function(response) {
                    if (response.session) {
                        var promise = auth.loginOAuth(generateVKAuthRequest(VK.Auth.getSession()), null);
                        promise.then(function (localResponse) {
                            if (localResponse.status === 'credential_required') {
                                self.OAuthRequest = response;
                                self.credentials.name = response.user.first_name;
                                modalContainer.modal({'show': true, 'backdrop': 'static'});
                            }
                        });
                    }
                }, 4194304);
            }
        }

        function showRegisterModal() {
            currentSocial = 'vkontakte';
            VK.Auth.login(function(response) {
                if (response.session) {
                    self.OAuthRequest = response.session;
                    self.credentials.name = response.session.user.first_name;
                    modalContainer.modal({'show': true, 'backdrop': 'static'});
                }
            }, 4194304);
        }

        $scope.$on('VkCredentialsRequired', function (event, data) {
            if (VK.Auth.getSession() !== null) {
                VK.Auth.logout(function () {
                    showRegisterModal();
                });
            } else {
                showRegisterModal();
            }
        });

        this.vkLogin = function () {
            VK.Auth.getLoginStatus(checkVkResponse);
        };


        this.signUpOAuth = function (credentials) {
            if (currentSocial === 'vkontakte'){
                request = generateVKAuthRequest(VK.Auth.getSession());
            }
            auth.loginOAuth(request, credentials);
        };

        this.signup = function () {
            $location.path('signup');
        };
    }
})(angular);