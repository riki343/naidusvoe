(function (angular) {
    angular.module('NaiduSvoe').directive('adaptiveImage', Directive);

    Directive.$inject = [];

    function Directive() {
        return {
            'restrict': 'E',
            'template': '<div style="display: inline-block;" class="adaptive-image-container"><img /></div>',
            'link': Link,
            'scope': {
                'imgSrc'   : '=imgSrc',
                'imgAlt'   : '=imgAlt',
                'imgWidth' : '@',
                'imgHeight': '@'
            }
        };

        function Link($scope, $element, $attrs) {
            /** @type {jQuery} */
            var container = $element.find('div.adaptive-image-container');
            /** @type {jQuery} */
            var img       = $element.find('img');

            img.on('load', function (e) {
                if (img.width() > img.height()) {
                    img.css('height', '100%');
                    img.css('width', 'auto');
                } else {
                    img.css('width', '100%');
                    img.css('height', 'auto');
                }
            });

            $scope.$watch('imgSrc', function (newValue, oldValue) {
                if (newValue) {
                    container.css('width', $scope.imgWidth);
                    container.css('height', $scope.imgHeight);
                    container.css('overflow', 'hidden');
                    img.attr('src', $scope.imgSrc);
                    img.attr('alt', $scope.imgAlt);
                }
            });
        }
    }
})(angular);