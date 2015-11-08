(function (angular) {
    angular.module('NaiduSvoe').factory('errorInterceptorService', Service);

    Service.$inject = [ '$rootScope' ];

    function Service($rootScope) {
        var self = this;

        var factory = {
            'response': function (response) {
                var data = response.data;
                if (angular.isDefined(data.status && data.status === 'error')) {
                    dispatchError(data.message);
                }

                return response;
            }
        };

        return factory;

        function dispatchError(error) {
            $rootScope.$broadcast('HttpError', error);
        }
    }
})(angular);