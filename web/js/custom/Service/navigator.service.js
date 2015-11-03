(function (angular) {
    angular.module('NaiduSvoe').factory('navigatorService', Service);

    Service.$inject = ['tradeLastPage', 'foundLastPage', 'giftLastPage'];

    function Service(tradeLastPage, foundLastPage, giftLastPage) {
        var self = this;

        this.lastPages = {
            'trade': '1',
            'gift':  '1',
            'found': '1'
        };

        var factory = {
            'getLast': function (section) {
                switch (section) {
                    case 'trade':
                        return tradeLastPage;
                    case 'found':
                        return foundLastPage;
                    case 'gift':
                        return giftLastPage;
                }
            },
            'setLast': function (section, page) {
                switch (section) {
                    case 'trade':
                        tradeLastPage = page;
                        break;
                    case 'found':
                        foundLastPage = page;
                        break;
                    case 'gift':
                        giftLastPage = page;
                        break;
                }
            }
        };

        return factory;
    }
})(angular);