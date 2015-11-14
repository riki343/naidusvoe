(function (angular) {
    angular.module('NaiduSvoe').controller('loginController', Controller);

    Controller.$inject = [
        '$scope', '$location', 'authorizationService', 'spinner'
    ];

    function Controller($scope, $location, auth, spinner) {

        var self = this;
        var currentSocial = null;
        var modalContainer = angular.element('body').find('div#credentials-modal');
        var passwordModalContainer = angular.element('body').find('div#password-recovery-modal');

        if (angular.isUndefined(self.captcha)) {
            this.captcha = {};
        }

        this.credentials = { 'email': '', 'name': '', 'captcha': '' };
        this.resetModel = { 'email': '' };

        this.login = function (data) {
            var promise = auth.login(data);
            spinner.addPromise(promise);
            promise.then(function (response) {
                if (response === false) {
                    self.captcha.reset();
                }
            });
        };

        this.generateResetPasswordToken = function (model) {
            var promise = auth.resetPassword(model.email);
            promise.then(function (result) {
                if (result === true) {
                    passwordModalContainer.modal('hide');
                }
            });
        };

        function generateFacebookAuthRequest(session) {
            return {
                'resource': 'facebook',
                'resourceId': session.userID
            }
        }

        function checkFbResponse(response) {
            if (response.status === 'connected') {
                var promise = auth.loginOAuth(generateFacebookAuthRequest(FB.getAuthResponse()), null);
                promise.then(function (localResponse) {
                    if (localResponse.status === 'credential_required') {
                        $scope.$broadcast('FbCredentialsRequired');
                    }
                });
            } else {
                FB.login(function(response) {
                    if (response.authResponse) {
                        var promise = auth.loginOAuth(generateFacebookAuthRequest(FB.getAuthResponse()), null);
                        promise.then(function (localResponse) {
                            if (localResponse.status === 'credential_required') {
                                $scope.$broadcast('FbCredentialsRequired');
                            }
                        });
                    }
                }, {scope: 'email'});
            }
        }

        this.fbLogin = function () {
            FB.getLoginStatus(checkFbResponse);
        };

        $scope.$on('FbCredentialsRequired', function (event, data) {
            var session = FB.getAuthResponse();
            if (session) {
                FB.api("/me",
                    function (response) {
                        if (response && !response.error) {
                            var missingSomething = false;
                            if (response.email) {
                                self.credentials.email = response.email;
                            } else {
                                missingSomething = true;
                            }

                            self.credentials.name = response.name;
                            currentSocial = 'facebook';

                            if (missingSomething === true) {
                                modalContainer.modal({'show': true, 'backdrop': 'static'});
                            } else {
                                self.signUpOAuth(self.credentials);
                            }
                        }
                    }
                );
            }
        });

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
            var request = null;
            switch (currentSocial) {
                case 'vkontakte':
                    request = generateVKAuthRequest(VK.Auth.getSession());
                    break;
                case 'facebook':
                    request = generateFacebookAuthRequest(FB.getAuthResponse());
                    break;
            }
            var promise = auth.loginOAuth(request, credentials);
            promise.then(function (response) {

            });
        };

        this.signup = function () {
            $location.path('signup');
        };
    }
})(angular);