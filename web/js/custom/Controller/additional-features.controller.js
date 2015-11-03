(function (angular) {
    angular.module('NaiduSvoe').controller('additionalFeaturesController', Controller);

    Controller.$inject = [
        '$scope', '$http', '$routeParams', 'spinner', '$translate', 'notify', '$location', '$sce', '$timeout'
    ];

    function Controller($scope, $http, $routeParams, spinner, $translate, notify, $location, $sce, $timeout) {
        var self = this;

        this.model = {
            'advOnMain': { 'checked': false, 'period': '3', 'sum': 15 },
            'advOnTop': { 'checked': false, 'period': '3', 'sum': 15 },
            'advFilled': { 'checked': false, 'period': '3', 'sum': 15 },
            'advUrgent': { 'checked': false, 'period': '3', 'sum': 15 },
            'advUpdate': { 'checked': false, 'sum': 15 },
            'advBlock': { 'checked': false, 'period': '3', 'sum': 15 },
            'total': 0,
            'payWay': 'card'
        };

        this.selectedPayWay = 'card';
        this.payPhase = 1;
        this.payForm = '';
        this.adv_id = $routeParams.adv_id;
        this.type = $routeParams.type;

        this.calculateTotal = function () {
            var total = 0;
            if (self.model.advOnMain.checked === true) {
                switch (self.model.advOnMain.period) {
                    case '3':  total += 15; break;
                    case '7':  total += 30; break;
                    case '14': total += 50; break;
                }
            }

            if (self.model.advOnTop.checked === true) {
                switch (self.model.advOnTop.period) {
                    case '3':  total += 15; break;
                    case '7':  total += 30; break;
                    case '14': total += 50; break;
                }
            }

            if (self.model.advFilled.checked === true) {
                switch (self.model.advFilled.period) {
                    case '3':  total += 15; break;
                    case '7':  total += 30; break;
                    case '14': total += 50; break;
                }
            }

            if (self.model.advUrgent.checked === true) {
                switch (self.model.advUrgent.period) {
                    case '3':  total += 15; break;
                    case '7':  total += 30; break;
                    case '14': total += 50; break;
                }
            }

            if (self.model.advUpdate.checked === true) {
                total += 15;
            }

            if (self.model.advBlock.checked === true) {
                switch (self.model.advBlock.period) {
                    case '3':  total += 15; break;
                    case '7':  total += 30; break;
                    case '14': total += 50; break;
                }
            }

            self.model.total = total;
            self.model.payWay = self.selectedPayWay;
        };

        this.confirmOrder = function () {
            self.calculateTotal();
            var promise = $http.post(Routing.generate('get-pay-form', { 'adv_id': self.adv_id }), self.model);
            spinner.addPromise(promise);
            promise.success(function (response) {
                if (response.status === 'ok') {
                    self.payForm = $sce.trustAsHtml(response.form);
                    self.payPhase = 2;
                } else if (response.status === 'error') {
                    // TODO: Handle code here...
                }
            });
        };

        this.goBack = function () {
            $location.path('/advertisement/'+ self.type +'/'+ self.adv_id);
        };
    }
})(angular);