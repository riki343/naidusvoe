(function (angular) {
    angular.module('NaiduSvoe').controller('ErrorLogsController', ErrorLogsController);

    ErrorLogsController.$inject = ['$scope', '$http', '$sce'];

    function ErrorLogsController ($scope, $http, $sce) {
        $scope.errors = null;

        $scope.urlGetErrors = URLS.getErrors;

        function highlightSyntax(text) {
            var sqlKeywords = [
                'INSERT', 'INTO', 'SELECT', 'FROM', 'VALUES', 'DELETE'
            ];

            text = text.replace(new RegExp('class', 'gi'), '<span class="class">class</span>');
            text = text.replace(new RegExp('line', 'gi'), '<span class="line">line</span>');
            text = text.replace(new RegExp('[?]', 'gi'), '<span class="question">?</span>');
            text = text.replace(new RegExp('null', 'gi'), '<span class="orange">null</span>');
            text = text.replace(new RegExp('exception', 'gi'), '<span class="exception">exception</span>');
            text = text.replace(new RegExp('file', 'gi'), '<span class="file">file</span>');
            text = text.replace(new RegExp('function', 'gi'), '<span class="function">function</span>');
            for (var i = 0; i < sqlKeywords.length; i++) {
                text = text.replace(new RegExp(sqlKeywords[i], 'gi'), '<span class="SQL">' + sqlKeywords[i] + '</span>')
            }

            return text;
        }

        function prepareErrors(errors) {
            for (var i = 0; i < errors.length; i++) {
                errors[i].message = $sce.trustAsHtml(highlightSyntax(errors[i].message));
                errors[i].where = $sce.trustAsHtml(highlightSyntax(errors[i].where));
                errors[i].from = $sce.trustAsHtml(highlightSyntax(errors[i].from));
            }
            return errors;
        }

        $scope.getErrors = function () {
            $http.get($scope.urlGetErrors)
                .success(function (response) {
                    $scope.errors = prepareErrors(response);
                }
            );
        };
    }

})(angular);