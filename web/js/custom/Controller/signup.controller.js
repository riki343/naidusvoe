(function (angular) {
    angular.module('NaiduSvoe').controller('signUpController', Controller);

    Controller.$inject = [
        '$scope', '$location', 'authorizationService', 'spinner'
    ];

    function Controller($scope, $location, auth, spinner) {
        var self = this;
        this.user = null;

        this.model = {
            'name':  '', 'email': '',
            'pass':  '', 'rpass': '',
            'captcha': ''
        };

        var promise = auth.getUser();
        spinner.addPromise(promise);
        promise.then(function (user) {
            self.user = user;
        });

        if (self.user !== null) {
            $location.path('/cabinet');
        }

        if (angular.isUndefined(this.captcha)) {
            this.captcha = {};
        }

        self.signUp = function(data) {
            var promise = auth.signUp(data);
            spinner.addPromise(promise);
            promise.then(function (response) {
               if (response === false) {
                   self.captcha.reset();
               }
            });
        };

        self.login = function () {
            $location.path('/login');
        }
    }
})(angular);