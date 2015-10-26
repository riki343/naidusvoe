(function (angular) {
    angular.module('NaiduSvoe').controller('addAdvertisementController', advertismentController);

    advertismentController.$inject = ['$scope', '$http', 'Advertisement', '$window'];

    function advertismentController($scope, $http, Advertisement, $window) {
        var self = this;

        this.showPreview = false;

        $scope.addAdv = new Advertisement();
        $scope.addAdv.region = 1;
        $scope.priceTypes = [];
        $scope.regions = [];
        $scope.typeModel = {
            'typeID': 0,
            'categoryID': 0,
            'subCategoryID': 0
        };

        this.togglePreview = function () {
            self.showPreview = !self.showPreview;
        };


        $scope.getAdvDetails = function () {
            $http.get(Routing.generate('naidusvoe_get_adv_info'))
                .success(function (response) {
                    $scope.addAdv.contactPerson = response.contactPerson;
                    $scope.addAdv.email = response.email;
                    $scope.addAdv.telephoneNumber = response.telephoneNumber;
                    $scope.addAdv.skype = response.skype;
                    $scope.addAdv.region = response.region.id.toString();
                    $scope.addAdv.city = response.city;
                    $scope.priceTypes = response.priceTypes;
                    $scope.regions = response.regions;
                    $scope.advUser = response.user;
                }
            );
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
            promise.then(function (response) {
                if (response) {
                    location.href = '/advertisement/' + response.type.slug + '/' + response.id;
                }
            });
        };

        self.types = [
            {
                'id': 1,
                'label': 'Продам|Куплю',
                'items': [
                    {
                        'id': 20,
                        'label': "Дитячий світ",
                        'items': [
                            { 'label': "Дитячий одяг",         'id': 1 },
                            { 'label': "Дитяче взуття",        'id': 2 },
                            { 'label': "Дитячі коляски",       'id': 3 },
                            { 'label': "Дитячі автокрісла",    'id': 4 },
                            { 'label': "Дитячі меблі",         'id': 5 },
                            { 'label': "Іграшки",              'id': 6 },
                            { 'label': "Дитячий транспорт",    'id': 7 },
                            { 'label': "Годування",            'id': 8 },
                            { 'label': "Товари для школярів",  'id': 9 },
                            { 'label': "Інші дитячі товари",   'id': 10 }
                        ]
                    },
                    {
                        'id': 21,
                        'label': "Нерухомість",
                        'items': [
                            { 'id': 11, 'label': "Оренда квартир" },
                            { 'id': 12, 'label': "Оренда кімнат" },
                            { 'id': 13, 'label': "Оренда будинків" },
                            { 'id': 14, 'label': "Оренда землі" },
                            { 'id': 15, 'label': "Оренда гаражів / стоянок" },
                            { 'id': 16, 'label': "Шукаю компаньйона" },
                            { 'id': 17, 'label': "Продаж квартир" },
                            { 'id': 18, 'label': "Продаж кімнат" },
                            { 'id': 19, 'label': "Продаж кімнат" },
                            { 'id': 20, 'label': "Продаж землі" },
                            { 'id': 21, 'label': "Продаж гаражів / стоянок" },
                            { 'id': 22, 'label': "Оренда приміщень" },
                            { 'id': 23, 'label': "Продаж приміщень" },
                            { 'id': 24, 'label': "Інша нерухомість" },
                            { 'id': 25, 'label': "Обмін нерухомості" }
                        ]
                    },
                    {
                        'id': 22,
                        'label': "Транспорт",
                        'items': [
                            { 'id': 26, 'label': "Легкові автомобілі" },
                            { 'id': 27, 'label': "Мото" },
                            { 'id': 28, 'label': "Автобуси" },
                            { 'id': 29, 'label': "Спецтехніка" },
                            { 'id': 30, 'label': "Вантажні автомобілі" },
                            { 'id': 31, 'label': "Сільгосптехніка" },
                            { 'id': 32, 'label': "Водний транспорт" },
                            { 'id': 33, 'label': "Водний транспорт" },
                            { 'id': 34, 'label': "Запчастини " },
                            { 'id': 35, 'label': "Аксесуари" },
                            { 'id': 36, 'label': "Причепи" },
                            { 'id': 37, 'label': "Інший транспорт" }
                        ]
                    },
                    {
                        'id': 23,
                        'label': "Робота",
                        'items': [
                            { 'id': 38, 'label': "Роздрібна торгівля / Продажі" },
                            { 'id': 39, 'label': "Транспорт / логістика" },
                            { 'id': 40, 'label': "Будівництво" },
                            { 'id': 41, 'label': "Бари / ресторани" },
                            { 'id': 42, 'label': "Юриспруденція та бухгалтерія" },
                            { 'id': 43, 'label': "Охорона / безпека" },
                            { 'id': 44, 'label': "Домашній персонал" },
                            { 'id': 45, 'label': "Краса / фітнес / спорт" },
                            { 'id': 46, 'label': "Туризм / відпочинок / розваги" },
                            { 'id': 47, 'label': "Освіта" },
                            { 'id': 48, 'label': "Культура / мистецтво" },
                            { 'id': 49, 'label': "Медицина / фармація" },
                            { 'id': 50, 'label': "ІТ / телеком / комп'ютери" },
                            { 'id': 51, 'label': "Нерухомість" },
                            { 'id': 52, 'label': "Маркетинг / реклама / дизайн" },
                            { 'id': 53, 'label': "Виробництво / енергетика" },
                            { 'id': 54, 'label': "Cекретаріат / АХО" },
                            { 'id': 55, 'label': "Часткова зайнятість" },
                            { 'id': 56, 'label': "Початок кар'єри / Студенти" },
                            { 'id': 57, 'label': "Сервіс і побут" },
                            { 'id': 58, 'label': "Інші сфери занять" }
                        ]
                    },
                    {
                        'id': 24,
                        'label': "Тварини",
                        'items': [
                            { 'id': 59, 'label': "Собаки" },
                            { 'id': 60, 'label': "Коти" },
                            { 'id': 61, 'label': "Акваріумістика" },
                            { 'id': 62, 'label': "Пташки" },
                            { 'id': 63, 'label': "Гризуни" },
                            { 'id': 64, 'label': "Рептилії" },
                            { 'id': 65, 'label': "Сільгосп тварини" },
                            { 'id': 66, 'label': "Тварини безкоштовно" },
                            { 'id': 67, 'label': "Зоотовари" },
                            { 'id': 68, 'label': "В'язка" },
                            { 'id': 69, 'label': "Бюро знахідок" },
                            { 'id': 70, 'label': "Інші тварини" }
                        ]
                    },
                    {
                        'id': 25,
                        'label': "Дім і сад",
                        'items': [
                            { 'id': 71, 'label': "Канцтовари / витратні матеріали"},
                            { 'id': 72, 'label': "Меблі"},
                            { 'id': 73, 'label': "Продукти харчування / напої"},
                            { 'id': 74, 'label': "Сад / город"},
                            { 'id': 75, 'label': "Предмети інтер'єру"},
                            { 'id': 76, 'label': "Будівництво / ремонт"},
                            { 'id': 77, 'label': "Інструменти"},
                            { 'id': 78, 'label': "Кімнатні рослини"},
                            { 'id': 79, 'label': "Посуд / кухонне приладдя"},
                            { 'id': 80, 'label': "Садовий інвентар"},
                            { 'id': 81, 'label': "Господарський інвентар"},
                            { 'id': 82, 'label': "Побутова хімія"}
                        ]
                    },
                    {
                        'id': 26,
                        'label': "Електроніка",
                        'items': [
                            { 'id': 84, 'label': "Телефони"},
                            { 'id': 85, 'label': "Комп'ютери"},
                            { 'id': 86, 'label': "Фото / відео"},
                            { 'id': 87, 'label': "Тв / відеотехніка"},
                            { 'id': 88, 'label': "Аудіотехніка"},
                            { 'id': 89, 'label': "Ігри та ігрові приставки"},
                            { 'id': 90, 'label': "Техніка для дому"},
                            { 'id': 91, 'label': "Техніка для кухні"},
                            { 'id': 92, 'label': "Кліматичне обладнання"},
                            { 'id': 93, 'label': "Індивідуальний догляд"},
                            { 'id': 94, 'label': "Аксесуари й комплектуючі"},
                            { 'id': 95, 'label': "Інша електроніка"}
                        ]
                    },
                    {
                        'id': 27,
                        'label': "Бізнес та послуги",
                        'items': [
                            { 'id': 96,  'label': "Будівництво / ремонт / прибирання" },
                            { 'id': 97,  'label': "Фінансові послуги / партнерство" },
                            { 'id': 98,  'label': "Перевезення / оренда транспорту" },
                            { 'id': 99,  'label': "Реклама / поліграфія / маркетинг / інтернет" },
                            { 'id': 100, 'label': "Няні / доглядальниці" },
                            { 'id': 101, 'label': "Сировина / матеріали" },
                            { 'id': 102, 'label': "Краса / здоров'я" },
                            { 'id': 103, 'label': "Обладнання" },
                            { 'id': 104, 'label': "Освіта / Спорт" },
                            { 'id': 105, 'label': "Послуги для тварин" },
                            { 'id': 106, 'label': "Продаж бізнесу" },
                            { 'id': 107, 'label': "Розваги / Мистецтво / Фото / Відео" },
                            { 'id': 108, 'label': "Туризм / іміграція" },
                            { 'id': 109, 'label': "Послуги перекладачів / набір тексту" },
                            { 'id': 110, 'label': "Авто / мото послуги" },
                            { 'id': 111, 'label': "Обслуговування, ремонт техніки" },
                            { 'id': 112, 'label': "Мережевий маркетинг" },
                            { 'id': 113, 'label': "Юридичні послуги" },
                            { 'id': 114, 'label': "Прокат товарів" },
                            { 'id': 115, 'label': "Інші послуги" }
                        ]
                    },
                    {
                        'id': 28,
                        'label': "Мода і стиль",
                        'items': [
                            { 'id': 116, 'label': "Одяг/взуття" },
                            { 'id': 117, 'label': "Для весілля" },
                            { 'id': 118, 'label': "Наручні годинники" },
                            { 'id': 119, 'label': "Аксесуари" },
                            { 'id': 120, 'label': "Подарунки" },
                            { 'id': 121, 'label': "Краса / здоров'я" },
                            { 'id': 122, 'label': "Мода різне" }
                        ]
                    },
                    {
                        'id': 29,
                        'label': "Хобі та відпочинок",
                        'items': [
                            { 'id': 123, 'label': "Антикваріат / колекції" },
                            { 'id': 124, 'label': "Музичні інструменти" },
                            { 'id': 125, 'label': "Спорт / відпочинок" },
                            { 'id': 126, 'label': "Спорт / відпочинок" },
                            { 'id': 127, 'label': "CD / DVD / Платівки" },
                            { 'id': 128, 'label': "Квитки" },
                            { 'id': 129, 'label': "Пошук попутників" },
                            { 'id': 130, 'label': "Пошук гуртів / музикантів" },
                            { 'id': 131, 'label': "Інше" }
                        ]
                    },
                    {
                        'id': 30,
                        'label': "Обміняю",
                        'items': []
                    }
                ]
            },

            {
                'id': 2,
                'label': 'Знайшов|Загубив',
                'items': [
                    {
                        'id': 34,
                        'label': "Документи",
                        'items': [
                            { 'id': 133, 'label': "Паспорт" },
                            { 'id': 134, 'label': "Права" },
                            { 'id': 135, 'label': "Техпаспорт / Страховка" },
                            { 'id': 136, 'label': "Посвідчення" },
                            { 'id': 137, 'label': "Ділова документація / Договори" },
                            { 'id': 138, 'label': "Пластикові картки" },
                            { 'id': 139, 'label': "Інше" }
                        ]
                    },
                    {
                        'id': 35,
                        'label': "Сумки / Багажі / Покладь",
                        'items': [
                            { 'id': 140, 'label': "Сумки жіночі" },
                            { 'id': 141, 'label': "Сумки багажні" },
                            { 'id': 142, 'label': "Сумки спортивні" },
                            { 'id': 143, 'label': "Гаманці" },
                            { 'id': 144, 'label': "Портмоне" },
                            { 'id': 145, 'label': "Барсетки" }
                        ]
                    },
                    {
                        'id': 36,
                        'label': "Прикраси",
                        'items': [
                            { 'id': 146, 'label': "Окуляри" },
                            { 'id': 147, 'label': "Браслети" },
                            { 'id': 148, 'label': "Наручні годинники" },
                            { 'id': 149, 'label': "Вироби з золота / срібла" },
                            { 'id': 150, 'label': "Вироби з золота / срібла" },
                            { 'id': 151, 'label': "Різне" }
                        ]
                    },
                    {
                        'id': 37,
                        'label': "Електроніка",
                        'items': [
                            { 'id': 152, 'label': "Телефони" },
                            { 'id': 153, 'label': "Планшети" },
                            { 'id': 154, 'label': "Ноутбуки" },
                            { 'id': 155, 'label': "Фотоапарати" },
                            { 'id': 156, 'label': "Музикальні плеєри" },
                            { 'id': 157, 'label': "Ігрові приставки" },
                            { 'id': 158, 'label': "Аксесуари і комплектуючі" },
                            { 'id': 159, 'label': "Інша електроніка" }
                        ]
                    },
                    {
                        'id': 38,
                        'label': "Одяг / Взуття",
                        'items': []

                    },
                    {
                        'id': 39,
                        'label': "Дрібниці",
                        'items': [
                            { 'id': 160, 'label': "Ключі" },
                            { 'id': 161, 'label': "Брилки" },
                            { 'id': 162, 'label': "Різне" }
                        ]
                    },
                    {
                        'id': 40,
                        'label': "Тварини",
                        'items': []
                    }
                ]
            },

            {
                'id': 3,
                'label': 'Віддам|Потребую',
                'items': [
                    {
                        'id': 41,
                        'label': "Одяг / Взуття",
                        'items': []
                    },
                    {
                        'id': 42,
                        'label': "Продукти харчування",
                        'items': []
                    },
                    {
                        'id': 43,
                        'label': "Житло",
                        'items': []
                    },
                    {
                        'id': 44,
                        'label': "Тварини",
                        'items': []
                    },
                    {
                        'id': 45,
                        'label': "Електроніка",
                        'items': []
                    },
                    {
                        'id': 46,
                        'label': "Транспорт",
                        'items': []
                    },
                    {
                        'id': 47,
                        'label': "Потребую допомогу в",
                        'items': [
                            { 'id': 163, 'label': "Оформлення документів" },
                            { 'id': 164, 'label': "Консультації" },
                            { 'id': 165, 'label': "Пошук роботи" },
                            { 'id': 166, 'label': "Послуги транспортування" },
                            { 'id': 167, 'label': "Допомога в лікуванні" },
                            { 'id': 168, 'label': "Допомога потерпілим" },
                            { 'id': 169, 'label': "Психологічна підтримка" }
                        ]
                    },
                    {
                        'id': 48,
                        'label': "Допоможу вирішити",
                        'items': [
                            { 'id': 171, 'label': "Оформлення документів" },
                            { 'id': 172, 'label': "Консультації" },
                            { 'id': 173, 'label': "Пошук роботи" },
                            { 'id': 174, 'label': "Послуги транспортування" },
                            { 'id': 175, 'label': "Допомога в лікуванні" },
                            { 'id': 176, 'label': "Допомога потерпілим" },
                            { 'id': 177, 'label': "Психологічна підтримка" },
                            { 'id': 178, 'label': "Інше" }
                        ]
                    }
                ]
            }
        ];
    }

})(angular);