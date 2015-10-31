(function (angular) {
    angular.module('NaiduSvoe').controller('additionalFeaturesController', Controller);

    Controller.$inject = [
        '$scope'
    ];

    function Controller($scope) {
        var self = this;

        this.model = {
            'advOnMain': {
                'checked': false,
                'period': '3',
                'sum': 15
            },
            'advOnTop': {
                'checked': false,
                'period': '3',
                'sum': 15
            },
            'advFilled': {
                'checked': false,
                'period': '3',
                'sum': 15
            },
            'advUrgent': {
                'checked': false,
                'period': '3',
                'sum': 15
            },
            'advUpdate': {
                'checked': false,
                'sum': 15
            },
            'advBlock': {
                'checked': false,
                'period': '3',
                'sum': 15
            },
            'total': 0
        };

        this.selectedPayWay = 'card';
        this.payPhase = 1;
        this.payForm = '';

        this.calculateTotal = function () {
            var total = 0;
            if (self.model.advOnMain.checked === true) {
                switch (self.model.advOnMain.period) {
                    case '3':  total += 15; break;
                    case '7':  total += 30; break;
                    case '15': total += 50; break;
                }
            }

            if (self.model.advOnTop.checked === true) {
                switch (self.model.advOnTop.period) {
                    case '3':  total += 15; break;
                    case '7':  total += 30; break;
                    case '15': total += 50; break;
                }
            }

            if (self.model.advFilled.checked === true) {
                switch (self.model.advFilled.period) {
                    case '3':  total += 15; break;
                    case '7':  total += 30; break;
                    case '15': total += 50; break;
                }
            }

            if (self.model.advUrgent.checked === true) {
                switch (self.model.advUrgent.period) {
                    case '3':  total += 15; break;
                    case '7':  total += 30; break;
                    case '15': total += 50; break;
                }
            }

            if (self.model.advUpdate.checked === true) {
                total += 15;
            }

            if (self.model.advBlock.checked === true) {
                switch (self.model.advBlock.period) {
                    case '3':  total += 15; break;
                    case '7':  total += 30; break;
                    case '15': total += 50; break;
                }
            }

            self.model.total = total;
        };
    }
})(angular);