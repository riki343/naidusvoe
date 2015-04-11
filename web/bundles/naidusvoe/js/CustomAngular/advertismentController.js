Naidusvoe.controller('advertismentController', ['$scope', '$http', '$routeParams',
    function ($scope, $http, $routeParams) {
        $scope.addAdv = {
            'title': null,
            'description': null,
            'categoryID': null,
            'subCategoryID': null,
            'typeID': null,
            'photos': [],
            'price': null,
            'priceType': 1,
            'contactPerson': null,
            'email': null,
            'telephoneNumber': null,
            'skype': null,
            'advOnMain': false,
            'advInBlock': false,
            'advColor': false,
            'advOnTop': false
        };

        $scope.subCategories = null;
        $scope.priceTypes = null;
        $scope.categories = null;
        $scope.advTypes = null;

        $scope.urlGetAdvDetails = URLS.getAdvDetails;
        $scope.urlAddAdv = URLS.addAdv;


        $scope.getAdvDetails = function () {
            $http.get($scope.urlGetAdvDetails)
                .success(function (response) {
                    $scope.advTypes = response.advTypes;
                    $scope.categories = response.categories;
                    $scope.priceTypes = response.priceTypes;
                    $scope.addAdv.contactPerson = response.contactPerson;
                    $scope.addAdv.email = response.email;
                    $scope.addAdv.telephoneNumber = response.telephoneNumber;
                    $scope.addAdv.skype = response.skype;
                }
            );
        };
        
        $scope.addNewAdv = function (adv) {
            $http.post($scope.urlAddAdv, { 'adv': adv })
                .success(function (response) {
                    if (response) {
                        location.href = '/adv/' + response.type.enName + '/' + response.id;
                    }
                }
            );
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

        function readURL(input, id) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#' + id + '_img').attr('src', e.target.result);
                    var index = -1;
                    for (var i = 0; i < $scope.addAdv.photos.length; i++) {
                        if ($scope.addAdv.photos[i].id == id) {
                            index = i;
                            break;
                        }
                    }
                    if (index == -1) {
                        $scope.$apply(function () {
                            $scope.addAdv.photos.push({ 'img': e.target.result, 'id': id });
                        });
                    } else {
                        $scope.$apply(function () {
                            $scope.addAdv.photos[index].img = e.target.result;
                        });
                    }
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        $scope.uploadImage = function (num) {
            switch (num) {
                case 1: $('#upload_image_1').click(); break;
                case 2: $('#upload_image_2').click(); break;
                case 3: $('#upload_image_3').click(); break;
                case 4: $('#upload_image_4').click(); break;
                case 5: $('#upload_image_5').click(); break;
                case 6: $('#upload_image_6').click(); break;
            }
        };

        $(".upload_image").change(function(){
            readURL(this, $(this).attr('id'));
        });
    }
]);