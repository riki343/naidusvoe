(function (angular) {
    angular.module('NaiduSvoe').controller('addAdvertisementController', advertismentController);

    advertismentController.$inject = ['$scope', '$http', 'Advertisement', '$location', 'notify', '$translate', 'spinner'];
    function advertismentController($scope, $http, Advertisement, $location, notify, $translate, spinner) {
        var self = this;
        var modal = $('#login_modal');

        this.showPreview = false;
        this.photoLimit = 1;

        function Model() {
            this.typeID = 0;
            this.categoryID = 0;
            this.subCategoryID = 0;
            this.authorization = false;
        }

        $scope.addAdv = new Advertisement();
        $scope.addAdv.region = 1;
        $scope.priceTypes = [];
        $scope.regions = [];
        $scope.typeModel = new Model();

        this.togglePreview = function () {
            $scope.addAdv.type = self.types[$scope.typeModel.typeID];
            $scope.addAdv.category = self.types[$scope.typeModel.typeID].items[$scope.typeModel.categoryID];
            if (self.types[$scope.typeModel.typeID].items[$scope.typeModel.categoryID].items.length > 0) {
                $scope.addAdv.subCategory = self.types[$scope.typeModel.typeID].items[$scope.typeModel.categoryID].items[$scope.typeModel.subCategoryID];
            } else {
                $scope.addAdv.subCategory = null;
            }

            self.selectedImage = $scope.addAdv.photos[0];
            self.showPreview = !self.showPreview;
        };

        modal.on('hidden.bs.modal', function () {
            $scope.addAdv.authorization = false;
            $scope.typeModel.authorization = false;
            $scope.$apply();
        });

        $scope.$on('PhotoAdded', function () {
            self.photoLimit++;
        });

        $scope.getAdvDetails = function () {
            var promise = $http.get(Routing.generate('naidusvoe_get_adv_info'));
            spinner.addPromise(promise);
            promise.success(function (response) {
                $scope.addAdv.contactPerson = response.contactPerson;
                $scope.addAdv.email = response.email;
                $scope.addAdv.telephoneNumber = response.telephoneNumber;
                $scope.addAdv.skype = response.skype;
                if (response.region) {
                    $scope.addAdv.region = response.region.id.toString();
                }
                $scope.addAdv.city = response.city;
                $scope.priceTypes = response.priceTypes;
                $scope.regions = response.regions;
                if (response.user) {
                    $scope.advUser = response.user;
                } else {
                    $scope.advUser = generateDummyUser();
                }
            });
            promise = $http.get('/resources/types.json');
            spinner.addPromise(promise);
            promise.success(function (file) {
                self.types = file;
            });
        };

        /** @param {Advertisement} adv */
        $scope.addNewAdv = function (adv) {
            adv.typeID = self.types[$scope.typeModel.typeID].id;
            adv.categoryID = self.types[$scope.typeModel.typeID].items[$scope.typeModel.categoryID].id;
            if (self.types[$scope.typeModel.typeID].items[$scope.typeModel.categoryID].items.length > 0) {
                adv.subCategoryID = self.types[$scope.typeModel.typeID].items[$scope.typeModel.categoryID].items[$scope.typeModel.subCategoryID].id;
            } else {
                adv.subCategoryID = null;
            }

            var promise = adv.save();
            spinner.addPromise(promise);
            promise.then(handleResponse);
        };

        function handleResponse(response) {
            switch (response.status) {
                case -1:
                    $translate('ERROR_CREDENTIALS').then(function (val) {
                        notify(val);
                    });
                    break;
                case  1:
                    modal.modal('hide');
                    if (adv.authorization === true) {
                        location.href = '/advertisement/' + response.object.type.slug + '/' + response.object.id;
                    } else {
                        $location.path('/advertisement/' + response.object.type.slug + '/' + response.object.id);
                    }
                    break;
                case  2:
                    self.modalEmail = response.email;
                    $scope.addAdv.authorization = true;
                    modal.modal('show');
                    break;
                case  3:
                    $translate('USER_ADDED').then(function (val) {
                        notify(val);
                        $location.path('/advertisement/' + response.object.type.slug + '/' + response.object.id)
                    });
                    break;
            }
        }

        function generateDummyUser() {
            return {
                'id': -1,
                'name': 'User',
                'avatar': '/css/img/icon-user-default.png',
                'rating': 7,
                'votesCount': 15
            }
        }
    }
})(angular);