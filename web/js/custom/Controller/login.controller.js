(function (angular) {
    angular.module('NaiduSvoe').controller('loginController', Controller);

    Controller.$inject = [
        '$scope', '$location', 'authorizationService', 'spinner', '$window', '$http', 'notify'
    ];

    function Controller($scope, $location, auth, spinner, $window, $http, notify) {

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

        this.login = function (data) {
            var promise = auth.login(data);
            spinner.addPromise(promise);
            promise.then(function (response) {
                if (response === false) {
                    self.captcha.reset();
                }
            });
        };

        this.vk_login = function() {
            var vk_id = "5069614";
            var vk_secret = "9IclVVd4sqek1MZO9OhI";
            var vk_url = "https://oauth.vk.com/authorize?client_id=5069614&scope=1&redirect_uri=http://www.naidusvoe.dev/login&response_type=code";
            $http.get(vk_url).success(function (response) {
                    if(response.data!=null)
                    {
                        var vk_grand_url = "https://api.vk.com/oauth/access_token?client_id=" + vk_id +  "&client_secret=" + vk_secret + "&code=" + response.data.code + "&redirect_uri=http://www.naidusvoe.dev/login";
                        $http.get(vk_grand_url).then(function (response1) {
                            notify("My ID = " + response1.user_id);
                        });
                    }
                    else
                    {
                        $window.location.href="http://www.vk.com";
                    }
                });
        };

        this.signup = function () {
            $location.path('signup');
        };

    }
})(angular);