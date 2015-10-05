(function (angular) {
    angular.module('NaiduSvoe').controller('advertismentController', advertismentController);

    advertismentController.$inject = ['$scope', '$http', 'Advertisement'];

    function advertismentController($scope, $http, Advertisement) {
        $scope.addAdv = new Advertisement();

        $scope.subCategories = null;
        $scope.priceTypes = [];
        $scope.categories = [];
        $scope.advTypes = [];

        $scope.getAdvDetails = function () {
            $http.get(Routing.generate('naidusvoe_get_adv_info'))
                .success(function (response) {
                    $scope.advTypes = response.advTypes;
                    $scope.categories = response.categories;
                    $scope.priceTypes = response.priceTypes;
                    $scope.addAdv.contactPerson = response.contactPerson;
                    $scope.addAdv.email = response.email;
                    $scope.addAdv.telephoneNumber = response.telephoneNumber;
                    $scope.addAdv.skype = response.skype;
                    $scope.addAdv.region = response.region;
                    $scope.addAdv.city = response.city;
                }
            );
        };

        /** @param {Advertisement} adv */
        $scope.addNewAdv = function (adv) {
            var promise = adv.save();
            promise.then(function (response) {
                if (response) {
                    location.href = '/adv/' + response.type.slug + '/' + response.id;
                }
            });
        };

        $scope.selectedCategory = function (id) {
            if (id) {
                for (var i = 0; i < $scope.categories.length; i++) {
                    if ($scope.categories[i].id == id) {
                        return $scope.categories[i].subCategories;
                    }
                }
            }
        };

        $scope.selectedType = function (id) {
            if (id) {
                for (var i = 0; i < $scope.advTypes.length; i++) {
                    if ($scope.advTypes[i].id == id) {
                        return $scope.advTypes[i].categories;
                    }
                }
            }
        };

    }

})(angular);