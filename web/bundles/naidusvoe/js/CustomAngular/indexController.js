(function (angular) {
    angular.module('NaiduSvoe').controller('indexController', indexController);

    indexController.$inject = ['$scope', '$http'];

    function indexController ($scope, $http) {
        $scope.message = 'Hello!!!';
    }

})(angular);