(function (angular) {
    angular.module('NaiduSvoe').directive('advImage', advImage);

    function advImage() {
        return {
            'restrict': 'E',
            'link': link,
            'templateUrl': 'js/custom/Directive/templates/add-file.html',
            'scope': {
                'file': '=file',
                'image': '&image'
            }
        };

        function link($scope, $element, $attr) {
            $scope.item = $scope.file;

            $scope.$watch('file', function (val) {
                $scope.item = val;
            });

            var input = $element.find('input');
            input.on('change', function (event) {
                var src = (event.srcElement || event.target).files[0];
                var fileReader = new FileReader();
                var image = null;
                fileReader.onload = function (event) {
                    var label = $element.find('label');
                    label.css('background-image', "url(\'" + fileReader.result + "\')");
                    $scope.item.image = fileReader.result;
                    $attr.file.image = fileReader.result;
                    $scope.image = fileReader.result;
                };
                fileReader.readAsDataURL(src);
            });
        }
    }
})(angular);