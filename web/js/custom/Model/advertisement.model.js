(function (angular) {
    angular.module('NaiduSvoe').factory('Advertisement', AdvertisementFactory);

    AdvertisementFactory.$inject = [ '$http', '$q' ];

    /**
     * @param $http
     * @param $q
     * @returns {(Advertisement)}
     * @constructor
     */
    function AdvertisementFactory ($http, $q) {
        function Advertisement() {
            this.title = '';
            this.description = '';
            this.typeID = 1;
            this.categoryID = 20;
            this.subCategoryID = 1;
            this.photos = [
                { 'id': 'file1', 'image': null },
                { 'id': 'file2', 'image': null },
                { 'id': 'file3', 'image': null },
                { 'id': 'file4', 'image': null },
                { 'id': 'file5', 'image': null }
            ];
            this.price = '0';
            this.priceType = 1;
            this.contactPerson = '';
            this.email = '';
            this.telephoneNumber = '';
            this.skype = '';
        }

        Advertisement.prototype.save = function() {
            var defer = $q.defer();
            var promise = $http.post(Routing.generate('naidusvoe_add_adv'), this);
            promise.success(function (response) {
                defer.resolve(response);
            });

            return defer.promise;
        };

        Advertisement.get = function (id) {
            var defer = $q.defer();
            var promise = $http.get(Routing.generate('get-adv', { 'adv_id': id }));
            promise.success(function (adv) {
                defer.resolve(adv);
            });

            return defer.promise;
        };

        return (Advertisement);
    }

})(angular);