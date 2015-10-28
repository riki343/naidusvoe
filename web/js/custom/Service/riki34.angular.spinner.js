(function (angular) {
    angular.module('riki34', []).factory('spinner', spinner);

    spinner.$inject = [
        '$rootScope'
    ];

    function spinner($rootScope) {
        var self = this;
        this.promises = [];

        return {
            'addPromise': addPromise
        };

        function addPromise(promise) {
            if (self.promises.length == 0) {
                $rootScope.$broadcast('SpinnerStart');
            }
            self.promises.push(promise);
            promise.then(function () {
                self.promises.splice(self.promises.indexOf(promise), 1);
                if (self.promises.length === 0) {
                    $rootScope.$broadcast('SpinnerStop');
                }
            });
        }
    }
})(angular);