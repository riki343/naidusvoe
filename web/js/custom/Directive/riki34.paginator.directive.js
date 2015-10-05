(function (angular) {
    angular.module('riki34').directive('paginator', directive);

    directive.$inject = [];

    function directive() {
        return {
            'restrict': 'EA',
            'link': link,
            'templateUrl': 'js/custom/Directive/templates/paginator.html',
            'scope': {
                'data': '=data'
            }
        };

        function link($scope, $elem, $attrs) {

            $scope.$watch('data', function (data) {
                /** @type {Paginator} $scope.paginator */
                $scope.paginator = data;
            });

            $scope.browse = function (page) {
                var paginator = $scope.paginator;
                if (paginator.current !== page) {
                    var params = {};
                    params[paginator.pageParameterName] = page;
                    $scope.$emit('PaginatorClicked', params);
                }
            };
        }

        function Paginator(data) {
            this.first = data.first;
            this.last = data.last;
            this.pageCount = data.pageCount;
            this.current = data.current;
            this.itemsPerPage = data.itemsPerPage;
            this.pageParameterName = data.pageParameterName;
            this.sortFieldParameterName = data.sortFieldParameterName;
            this.sortDirectionParameterName = data.sortDirectionParameterName;
            this.filterFieldParameterName = data.filterFieldParameterName;
            this.pagesInRange = data.pagesInRange;
        }
    }

})(angular);