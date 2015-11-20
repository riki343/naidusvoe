(function (angular) {
    angular.module('NaiduSvoe').directive('conversationMessage', Directive);

    Directive.$inject = [];

    function Directive() {
        return {
            'restrict': 'E',
            'templateUrl': '/js/custom/Directive/templates/conversation-message.html',
            'link': Link,
            'scope': {
                'message': '=message',
                'conversation': '=conversation'
            }
        };

        function Link($scope, $element, $attrs) { }
    }
})(angular);