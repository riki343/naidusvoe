(function (angular) {
    angular.module('NaiduSvoe').controller('loginController', Controller);

    Controller.$inject = [
        '$scope', '$location', 'authorizationService', 'spinner'
    ];

    function Controller($scope, $location, auth, spinner) {
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

        this.signup = function () {
            $location.path('signup');
        };
    }
})(angular);