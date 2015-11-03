(function (angular) {
    angular.module('NaiduSvoe').controller('indexController', IndexController);

    IndexController.$inject = ['$scope', '$http', 'spinner'];
    function IndexController ($scope, $http, spinner) {
        var self = this;
        var dummyTrade = {
            'title': '',
            'description': '',
            'attachments': [ { 'image': ''} ]
        };

        var dummyGift = {
            'title': '',
            'description': '',
            'attachments': [ { 'image': ''} ]
        };

        var dummyFound = {
            'title': '',
            'description': '',
            'attachments': [ { 'image': ''} ]
        };

        this.getMainAdvs = function () {

        };
    }
})(angular);