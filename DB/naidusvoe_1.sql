-- Valentina Studio --
-- MySQL dump --
-- ---------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- ---------------------------------------------------------


-- CREATE TABLE "Payment" ----------------------------------
CREATE TABLE `Payment` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`number` VarChar( 255 ) NULL,
	`description` VarChar( 255 ) NULL,
	`client_email` VarChar( 255 ) NULL,
	`client_id` VarChar( 255 ) NULL,
	`total_amount` Int( 11 ) NULL,
	`currency_code` VarChar( 255 ) NULL,
	`details` LongText NOT NULL COMMENT '(DC2Type:json_array)',
	`link_id` Int( 11 ) NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `UNIQ_A295BD91ADA40271` UNIQUE( `link_id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 3;
-- ---------------------------------------------------------


-- CREATE TABLE "PaymentDetails" ---------------------------
CREATE TABLE `PaymentDetails` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`link_id` Int( 11 ) NULL,
	`details` LongText NOT NULL COMMENT '(DC2Type:json_array)',
	`number` VarChar( 255 ) NOT NULL,
	`description` VarChar( 255 ) NOT NULL,
	`client_email` VarChar( 255 ) NOT NULL,
	`client_id` VarChar( 255 ) NOT NULL,
	`total_amount` Int( 11 ) NOT NULL,
	`currency_code` VarChar( 255 ) NOT NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `UNIQ_ACF436DBADA40271` UNIQUE( `link_id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 17;
-- ---------------------------------------------------------


-- CREATE TABLE "PaymentToken" -----------------------------
CREATE TABLE `PaymentToken` ( 
	`hash` VarChar( 255 ) NOT NULL,
	`details` LongText NULL COMMENT '(DC2Type:object)',
	`after_url` LongText NULL,
	`target_url` LongText NOT NULL,
	`gateway_name` VarChar( 255 ) NOT NULL,
	PRIMARY KEY ( `hash` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB;
-- ---------------------------------------------------------


-- CREATE TABLE "advertisment_categories" ------------------
CREATE TABLE `advertisment_categories` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`title` VarChar( 255 ) NOT NULL,
	`type_id` Int( 11 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 49;
-- ---------------------------------------------------------


-- CREATE TABLE "advertisment_subcategories" ---------------
CREATE TABLE `advertisment_subcategories` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`title` VarChar( 255 ) NOT NULL,
	`category_id` Int( 11 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 179;
-- ---------------------------------------------------------


-- CREATE TABLE "advertisment_types" -----------------------
CREATE TABLE `advertisment_types` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`title` VarChar( 255 ) NOT NULL,
	`slug` VarChar( 255 ) NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 4;
-- ---------------------------------------------------------


-- CREATE TABLE "advertisments" ----------------------------
CREATE TABLE `advertisments` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`category_id` Int( 11 ) NOT NULL,
	`sub_category_id` Int( 11 ) NULL,
	`price_type_id` Int( 11 ) NOT NULL,
	`title` VarChar( 255 ) NOT NULL,
	`description` VarChar( 10000 ) NOT NULL,
	`date` DateTime NOT NULL,
	`price` Double( 22, 0 ) NOT NULL,
	`contact_person` VarChar( 255 ) NOT NULL,
	`email` VarChar( 255 ) NOT NULL,
	`telephone_number` VarChar( 255 ) NOT NULL,
	`skype` VarChar( 255 ) NULL,
	`advertisment_on_main_page` DateTime NULL,
	`advertisment_block` DateTime NULL,
	`color_highlight` DateTime NULL,
	`category_top` DateTime NULL,
	`type_id` Int( 11 ) NULL,
	`user_id` Int( 11 ) NULL,
	`city` VarChar( 255 ) NULL,
	`urgent` DateTime NULL,
	`region_id` Int( 11 ) NOT NULL DEFAULT '1',
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 171;
-- ---------------------------------------------------------


-- CREATE TABLE "attachments" ------------------------------
CREATE TABLE `attachments` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`advertisment_id` Int( 11 ) NOT NULL,
	`image` VarChar( 255 ) NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 161;
-- ---------------------------------------------------------


-- CREATE TABLE "back_link_pool" ---------------------------
CREATE TABLE `back_link_pool` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`url` VarChar( 255 ) NOT NULL,
	`text` VarChar( 255 ) NOT NULL,
	`defaultLink` TinyInt( 1 ) NOT NULL,
	`created` DateTime NOT NULL,
	`updated` DateTime NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 14;
-- ---------------------------------------------------------


-- CREATE TABLE "back_links" -------------------------------
CREATE TABLE `back_links` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`user_page_id` Int( 11 ) NOT NULL,
	`title` VarChar( 255 ) NOT NULL,
	`back_link_url` VarChar( 255 ) NOT NULL,
	`back_link_text` VarChar( 255 ) NOT NULL,
	`link_to_check` VarChar( 255 ) NOT NULL,
	`email` VarChar( 255 ) NOT NULL,
	`last_seen` DateTime NULL,
	`created` DateTime NOT NULL,
	`updated` DateTime NOT NULL,
	`back_link_url2` VarChar( 255 ) NULL,
	`back_link_text2` VarChar( 255 ) NULL,
	`link_to_promote` VarChar( 255 ) NOT NULL,
	`admin_link` TinyInt( 1 ) NOT NULL DEFAULT '0',
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 82;
-- ---------------------------------------------------------


-- CREATE TABLE "category" ---------------------------------
CREATE TABLE `category` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`name` LongText NOT NULL,
	`slug` VarChar( 128 ) NOT NULL,
	`description` VarChar( 10000 ) NULL,
	`keywords` VarChar( 1000 ) NULL,
	`created` DateTime NOT NULL,
	`updated` DateTime NOT NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `UNIQ_64C19C1989D9B62` UNIQUE( `slug` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 21;
-- ---------------------------------------------------------


-- CREATE TABLE "conversations" ----------------------------
CREATE TABLE `conversations` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`user1_id` Int( 11 ) NOT NULL,
	`user2_id` Int( 11 ) NOT NULL,
	`advertisment_id` Int( 11 ) NOT NULL,
	`last_updated` DateTime NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 8;
-- ---------------------------------------------------------


-- CREATE TABLE "error_logs" -------------------------------
CREATE TABLE `error_logs` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`message` VarChar( 10000 ) NOT NULL,
	`date` DateTime NOT NULL,
	`where_error` VarChar( 255 ) NOT NULL,
	`from_error` VarChar( 255 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 110;
-- ---------------------------------------------------------


-- CREATE TABLE "ext_log_entries" --------------------------
CREATE TABLE `ext_log_entries` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`action` VarChar( 8 ) NOT NULL,
	`logged_at` DateTime NOT NULL,
	`object_id` VarChar( 64 ) NULL,
	`object_class` VarChar( 255 ) NOT NULL,
	`version` Int( 11 ) NOT NULL,
	`data` LongText NULL COMMENT '(DC2Type:array)',
	`username` VarChar( 255 ) NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 1;
-- ---------------------------------------------------------


-- CREATE TABLE "ext_translations" -------------------------
CREATE TABLE `ext_translations` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`locale` VarChar( 8 ) NOT NULL,
	`object_class` VarChar( 255 ) NOT NULL,
	`field` VarChar( 32 ) NOT NULL,
	`foreign_key` VarChar( 64 ) NOT NULL,
	`content` LongText NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `lookup_unique_idx` UNIQUE( `locale`, `object_class`, `field`, `foreign_key` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 1;
-- ---------------------------------------------------------


-- CREATE TABLE "faq" --------------------------------------
CREATE TABLE `faq` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`question` VarChar( 255 ) NOT NULL,
	`answer` LongText NULL,
	`created` DateTime NOT NULL,
	`updated` DateTime NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 5;
-- ---------------------------------------------------------


-- CREATE TABLE "favorites" --------------------------------
CREATE TABLE `favorites` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`user_id` Int( 11 ) NOT NULL,
	`advertisment_id` Int( 11 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 6;
-- ---------------------------------------------------------


-- CREATE TABLE "languages" --------------------------------
CREATE TABLE `languages` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`title` VarChar( 255 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 3;
-- ---------------------------------------------------------


-- CREATE TABLE "link" -------------------------------------
CREATE TABLE `link` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`user_page_id` Int( 11 ) NULL,
	`url` VarChar( 255 ) NOT NULL,
	`text` VarChar( 255 ) NULL,
	`type` Int( 11 ) NOT NULL DEFAULT '1',
	`file` VarChar( 255 ) NULL,
	`icon` VarChar( 255 ) NULL,
	`show_till` Date NOT NULL,
	`active` TinyInt( 1 ) NOT NULL,
	`created` DateTime NOT NULL,
	`token` VarChar( 255 ) NULL,
	`updated` DateTime NOT NULL,
	`email` VarChar( 255 ) NULL,
	`period` Int( 11 ) NULL DEFAULT '1',
	`category_id` Int( 11 ) NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 77;
-- ---------------------------------------------------------


-- CREATE TABLE "messages" ---------------------------------
CREATE TABLE `messages` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`user_id` Int( 11 ) NOT NULL,
	`conversation_id` Int( 11 ) NOT NULL,
	`message` VarChar( 3000 ) NOT NULL,
	`viewed` TinyInt( 1 ) NOT NULL DEFAULT '0',
	`posted` DateTime NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 29;
-- ---------------------------------------------------------


-- CREATE TABLE "page_recover" -----------------------------
CREATE TABLE `page_recover` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`title` VarChar( 255 ) NOT NULL,
	`url` VarChar( 255 ) NOT NULL,
	`email` VarChar( 255 ) NOT NULL,
	`created` DateTime NOT NULL,
	`updated` DateTime NOT NULL,
	`recovered` TinyInt( 1 ) NOT NULL DEFAULT '0',
	`can_recover` TinyInt( 1 ) NOT NULL DEFAULT '1',
	`snapshot` VarChar( 255 ) NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 478;
-- ---------------------------------------------------------


-- CREATE TABLE "price_types" ------------------------------
CREATE TABLE `price_types` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`title` VarChar( 255 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 4;
-- ---------------------------------------------------------


-- CREATE TABLE "product" ----------------------------------
CREATE TABLE `product` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`name` VarChar( 255 ) NOT NULL,
	`title` VarChar( 255 ) NOT NULL,
	`description` LongText NOT NULL,
	`price` Int( 11 ) NOT NULL,
	`created` DateTime NOT NULL,
	`updated` DateTime NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 3;
-- ---------------------------------------------------------


-- CREATE TABLE "regions" ----------------------------------
CREATE TABLE `regions` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`name` VarChar( 255 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 25;
-- ---------------------------------------------------------


-- CREATE TABLE "roles" ------------------------------------
CREATE TABLE `roles` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`name` VarChar( 255 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 4;
-- ---------------------------------------------------------


-- CREATE TABLE "static_page" ------------------------------
CREATE TABLE `static_page` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`title` VarChar( 255 ) NOT NULL,
	`slug` VarChar( 128 ) NOT NULL,
	`keywords` VarChar( 255 ) NULL,
	`description` VarChar( 255 ) NULL,
	`content` LongText NULL,
	`created` DateTime NOT NULL,
	`updated` DateTime NOT NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `UNIQ_8FA4EF95989D9B62` UNIQUE( `slug` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 9;
-- ---------------------------------------------------------


-- CREATE TABLE "themes" -----------------------------------
CREATE TABLE `themes` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`owner_id` Int( 11 ) NULL,
	`name` VarChar( 255 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 1;
-- ---------------------------------------------------------


-- CREATE TABLE "top_link_categories" ----------------------
CREATE TABLE `top_link_categories` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`name` VarChar( 255 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 11;
-- ---------------------------------------------------------


-- CREATE TABLE "top_links" --------------------------------
CREATE TABLE `top_links` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`text` VarChar( 255 ) NOT NULL,
	`url` VarChar( 255 ) NOT NULL,
	`created` DateTime NOT NULL,
	`updated` DateTime NOT NULL,
	`category_id` Int( 11 ) NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 55;
-- ---------------------------------------------------------


-- CREATE TABLE "user_role" --------------------------------
CREATE TABLE `user_role` ( 
	`user_id` Int( 11 ) NOT NULL,
	`role_id` Int( 11 ) NOT NULL,
	PRIMARY KEY ( `user_id`, `role_id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB;
-- ---------------------------------------------------------


-- CREATE TABLE "user_settings" ----------------------------
CREATE TABLE `user_settings` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`user_id` Int( 11 ) NOT NULL,
	`notifications_email` TinyInt( 1 ) NULL DEFAULT '0',
	`spam_email` TinyInt( 1 ) NULL DEFAULT '0',
	`notifications_sms` TinyInt( 1 ) NULL DEFAULT '0',
	`number_for_sms` VarChar( 255 ) NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `UNIQ_5C844C5A76ED395` UNIQUE( `user_id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 18;
-- ---------------------------------------------------------


-- CREATE TABLE "user_votes" -------------------------------
CREATE TABLE `user_votes` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`user_id` Int( 11 ) NOT NULL,
	`vote_power` Int( 11 ) NOT NULL,
	PRIMARY KEY ( `id` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 1;
-- ---------------------------------------------------------


-- CREATE TABLE "users" ------------------------------------
CREATE TABLE `users` ( 
	`id` Int( 11 ) AUTO_INCREMENT NOT NULL,
	`username` VarChar( 255 ) NOT NULL,
	`password` VarChar( 255 ) NOT NULL,
	`email` VarChar( 255 ) NOT NULL,
	`name` VarChar( 255 ) NULL,
	`registered` DateTime NOT NULL,
	`lastactive` DateTime NOT NULL,
	`active` TinyInt( 1 ) NOT NULL,
	`avatar` VarChar( 255 ) NULL,
	`language_id` Int( 11 ) NULL,
	`telephone_number` VarChar( 255 ) NULL,
	`skype` VarChar( 255 ) NULL,
	`city` VarChar( 255 ) NULL,
	`region_id` Int( 11 ) NULL,
	`deleted` TinyInt( 1 ) NOT NULL DEFAULT '0',
	`rating` Double( 22, 0 ) NOT NULL,
	`vk_id` VarChar( 255 ) NULL,
	`fb_id` VarChar( 255 ) NULL,
	PRIMARY KEY ( `id` ),
	CONSTRAINT `UNIQ_1483A5E9E7927C74` UNIQUE( `email` ),
	CONSTRAINT `UNIQ_1483A5E9F85E0677` UNIQUE( `username` ) )
COLLATE = utf8_unicode_ci
ENGINE = InnoDB
AUTO_INCREMENT = 22;
-- ---------------------------------------------------------


-- Dump data of "Payment" ----------------------------------
INSERT INTO `Payment`(`id`,`number`,`description`,`client_email`,`client_id`,`total_amount`,`currency_code`,`details`,`link_id`) VALUES 
( '1', '55d34c2c089f0', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 1 maanden', 'administratie@rebelinternet.nl', '1439910955n37bkpr4k0e6b6ehpyl5n66nmn', '2000', 'EUR', '{"INVNUM":"55d34c2c089f0","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":"20.00","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/ZPK-jViqnqD5k4L2kWQMLQgCkwh5Sd8DKwH8HrJfCEY","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/ZPK-jViqnqD5k4L2kWQMLQgCkwh5Sd8DKwH8HrJfCEY","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/Z8jbF4FtjEUNKE2Fh4cPyJzJ6D-vGLs6pnxpho8Xm9g","TOKEN":"EC-5X232008X1493230T","TIMESTAMP":"2015-08-18T15:16:34Z","CORRELATIONID":"aec8d82f6786c","ACK":"Success","VERSION":"65.1","BUILD":"000000","BILLINGAGREEMENTACCEPTEDSTATUS":"0","CHECKOUTSTATUS":"PaymentActionCompleted","EMAIL":"contact@rebelinternet.nl","PAYERID":"Z5BDZ9XCUFFV6","PAYERSTATUS":"verified","BUSINESS":"REBEL Internet BV","FIRSTNAME":"Bram","LASTNAME":"van der Veer","COUNTRYCODE":"NL","SHIPTONAME":"REBEL Internet BV","SHIPTOSTREET":"Eerste Ringdijkstraat 1E","SHIPTOCITY":"Amsterdam","SHIPTOZIP":"1097 BC","SHIPTOCOUNTRYCODE":"NL","SHIPTOCOUNTRYNAME":"Netherlands","ADDRESSSTATUS":"Unconfirmed","CURRENCYCODE":"EUR","AMT":"20.00","SHIPPINGAMT":"0.00","HANDLINGAMT":"0.00","TAXAMT":"0.00","NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/Z8jbF4FtjEUNKE2Fh4cPyJzJ6D-vGLs6pnxpho8Xm9g","INSURANCEAMT":"0.00","SHIPDISCAMT":"0.00","PAYMENTREQUEST_0_SHIPPINGAMT":"0.00","PAYMENTREQUEST_0_HANDLINGAMT":"0.00","PAYMENTREQUEST_0_TAXAMT":"0.00","PAYMENTREQUEST_0_INSURANCEAMT":"0.00","PAYMENTREQUEST_0_SHIPDISCAMT":"0.00","PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED":"false","PAYMENTREQUEST_0_SHIPTONAME":"REBEL Internet BV","PAYMENTREQUEST_0_SHIPTOSTREET":"Eerste Ringdijkstraat 1E","PAYMENTREQUEST_0_SHIPTOCITY":"Amsterdam","PAYMENTREQUEST_0_SHIPTOZIP":"1097 BC","PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE":"NL","PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME":"Netherlands","PAYMENTREQUEST_0_ADDRESSSTATUS":"Unconfirmed","PAYMENTREQUESTINFO_0_ERRORCODE":"0","SUCCESSPAGEREDIRECTREQUESTED":"false","INSURANCEOPTIONSELECTED":"false","SHIPPINGOPTIONISDEFAULT":"false","PAYMENTINFO_0_TRANSACTIONID":"6JS02233FA837915A","PAYMENTINFO_0_TRANSACTIONTYPE":"expresscheckout","PAYMENTINFO_0_PAYMENTTYPE":"instant","PAYMENTINFO_0_ORDERTIME":"2015-08-18T15:16:26Z","PAYMENTINFO_0_AMT":"20.00","PAYMENTINFO_0_FEEAMT":"1.03","PAYMENTINFO_0_TAXAMT":"0.00","PAYMENTINFO_0_CURRENCYCODE":"EUR","PAYMENTINFO_0_PAYMENTSTATUS":"Completed","PAYMENTINFO_0_PENDINGREASON":"None","PAYMENTINFO_0_REASONCODE":"None","PAYMENTINFO_0_PROTECTIONELIGIBILITY":"Eligible","PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE":"ItemNotReceivedEligible,UnauthorizedPaymentEligible","PAYMENTINFO_0_ERRORCODE":"0","PAYMENTINFO_0_ACK":"Success","PAYMENTREQUEST_0_TRANSACTIONID":"6JS02233FA837915A","PAYMENTREQUESTINFO_0_TRANSACTIONID":"6JS02233FA837915A","PAYMENTREQUEST_0_TRANSACTIONTYPE":"expresscheckout","PAYMENTREQUEST_0_PAYMENTTYPE":"instant","PAYMENTREQUEST_0_ORDERTIME":"2015-08-18T15:16:26Z","PAYMENTREQUEST_0_FEEAMT":"1.03","PAYMENTREQUEST_0_PAYMENTSTATUS":"Completed","PAYMENTREQUEST_0_PENDINGREASON":"None","PAYMENTREQUEST_0_REASONCODE":"None"}', NULL ),
( '2', '55d5e111e682a', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 12 maanden', 'Etienne@rebelinternet.nl', '1440080145lqxnvrkdmovr5qo62614vk7kcom', '24000', 'EUR', '{"INVNUM":"55d5e111e682a","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":240,"PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/yatDt5dteY1R--Wx4cErute358QtAZVG1yHhutO27gw","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/yatDt5dteY1R--Wx4cErute358QtAZVG1yHhutO27gw","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/Ie2cx2IW78obiWGnE0FrMXnJ_omNS0s1_kL2_qeKLCg","TOKEN":"EC-5WH824580Y965181B","TIMESTAMP":"2015-08-20T14:15:48Z","CORRELATIONID":"f34f0c07abe71","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', NULL );
-- ---------------------------------------------------------


-- Dump data of "PaymentDetails" ---------------------------
INSERT INTO `PaymentDetails`(`id`,`link_id`,`details`,`number`,`description`,`client_email`,`client_id`,`total_amount`,`currency_code`) VALUES 
( '1', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":20,"L_PAYMENTREQUEST_0_AMT0":20,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/TlFx7T4cH8G6pXGExyxc8gAtCN6HFTRySm0ac9OQqsw","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/TlFx7T4cH8G6pXGExyxc8gAtCN6HFTRySm0ac9OQqsw","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/ooAP_UpBft4bWx3RvM4Tp31xpVG3ZpXgAC7t7bHGMZ8","TOKEN":"EC-9DU644378N514931Y","TIMESTAMP":"2015-08-21T20:20:11Z","CORRELATIONID":"3c76b3359e5f3","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55d787f952e94', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 1 maand', 'vladislav.kosko@gmail.com', '1440188409hx2cqh128jod40dokl1gc6id', '2000', 'EUR' ),
( '2', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":20,"L_PAYMENTREQUEST_0_AMT0":20,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/JIOUztZ2lQsnMQ2PtO3mozM6wvTcfgRfe52QInAaWpQ","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/JIOUztZ2lQsnMQ2PtO3mozM6wvTcfgRfe52QInAaWpQ","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/_69FoawjeRBXgBjjJ4fIzguT1g-QAGgF8cXkEbmQROU","TIMESTAMP":"2015-08-21T20:22:12Z","CORRELATIONID":"5836748cd97d6","ACK":"Failure","VERSION":"65.1","BUILD":"000000","L_ERRORCODE0":"10002","L_SHORTMESSAGE0":"Security error","L_LONGMESSAGE0":"Security header is not valid","L_SEVERITYCODE0":"Error"}', '55d78872c42dd', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 1 maand', 'vladislav.kosko@gmail.com', '144018853035c20v9udx7q6ykzm2nul8ixiz', '2000', 'EUR' ),
( '3', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":20,"L_PAYMENTREQUEST_0_AMT0":20,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/qqYUBYEYI4_Qm_CiT7tPZB3xWr4m0VpKHZiZ2YoZu2I","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/qqYUBYEYI4_Qm_CiT7tPZB3xWr4m0VpKHZiZ2YoZu2I","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/RJ682tOtHYzRO3O_SNhtj6gkvifRG4yUO5SWriN9kkQ","TOKEN":"EC-3V555443B5869692L","TIMESTAMP":"2015-08-21T20:23:54Z","CORRELATIONID":"a78d0777b86bc","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55d788d82ac2e', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 1 maand', 'vladislav.kosko@gmail.com', '1440188632to8p0x23ntc02r3b4guwbr', '2000', 'EUR' ),
( '4', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":"20.00","L_PAYMENTREQUEST_0_AMT0":"20.00","L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/DBk3YI6YwDjc5uiKGQFHx6uBqysjnohgkM0A6wnZoTk","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/DBk3YI6YwDjc5uiKGQFHx6uBqysjnohgkM0A6wnZoTk","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/BnEflt7vs5okP4Qq_TlPCX6FB2INs8rr4H34SlwKvG0","TOKEN":"EC-7D693131AK123902D","TIMESTAMP":"2015-08-25T11:53:29Z","CORRELATIONID":"ac7d610a195d0","ACK":"Success","VERSION":"65.1","BUILD":"000000","BILLINGAGREEMENTACCEPTEDSTATUS":"0","CHECKOUTSTATUS":"PaymentActionNotInitiated","CURRENCYCODE":"EUR","AMT":"20.00","ITEMAMT":"20.00","SHIPPINGAMT":"0.00","HANDLINGAMT":"0.00","TAXAMT":"0.00","NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/BnEflt7vs5okP4Qq_TlPCX6FB2INs8rr4H34SlwKvG0","INSURANCEAMT":"0.00","SHIPDISCAMT":"0.00","L_NAME0":"Koop een link","L_QTY0":"1","L_TAXAMT0":"0.00","L_AMT0":"20.00","L_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","L_ITEMWEIGHTVALUE0":"   0.00000","L_ITEMLENGTHVALUE0":"   0.00000","L_ITEMWIDTHVALUE0":"   0.00000","L_ITEMHEIGHTVALUE0":"   0.00000","PAYMENTREQUEST_0_ITEMAMT":"20.00","PAYMENTREQUEST_0_SHIPPINGAMT":"0.00","PAYMENTREQUEST_0_HANDLINGAMT":"0.00","PAYMENTREQUEST_0_TAXAMT":"0.00","PAYMENTREQUEST_0_INSURANCEAMT":"0.00","PAYMENTREQUEST_0_SHIPDISCAMT":"0.00","PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED":"false","L_PAYMENTREQUEST_0_QTY0":"1","L_PAYMENTREQUEST_0_TAXAMT0":"0.00","L_PAYMENTREQUEST_0_ITEMWEIGHTVALUE0":"   0.00000","L_PAYMENTREQUEST_0_ITEMLENGTHVALUE0":"   0.00000","L_PAYMENTREQUEST_0_ITEMWIDTHVALUE0":"   0.00000","L_PAYMENTREQUEST_0_ITEMHEIGHTVALUE0":"   0.00000","PAYMENTREQUESTINFO_0_ERRORCODE":"0"}', '55dc5723afb24', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 1 maand', 'vladislav.kosko@gmail.com', '1440503587l21bjpdng0bs834o7smem5', '2000', 'EUR' ),
( '5', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 12 maanden","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":240,"L_PAYMENTREQUEST_0_AMT0":240,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/P6H_v8oNdFHRRgJZ3n3Eyc3jDe8C1IUGwLUozHpNTmM","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/P6H_v8oNdFHRRgJZ3n3Eyc3jDe8C1IUGwLUozHpNTmM","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/IWn4j8f5z32hLA2yrkw8rpf23vClgwgwFbtcAxYCfRU","TOKEN":"EC-16D63083HM822364V","TIMESTAMP":"2015-08-27T05:25:48Z","CORRELATIONID":"b2361caf7bf23","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55de9f5908423', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 12 maanden', 'judith@twnty4.nl', '1440653144kp358bz90b59kscrislz00', '24000', 'EUR' ),
( '6', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":20,"L_PAYMENTREQUEST_0_AMT0":20,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/65VZmsybN8KhYMFfv7SPULQ73zJi3pS2LrhcXuL2W48","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/65VZmsybN8KhYMFfv7SPULQ73zJi3pS2LrhcXuL2W48","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/zMJ9wumdech4z3RMLzaXZcTciX98yre1LhX3p3MYb9E","TOKEN":"EC-49187035S61219008","TIMESTAMP":"2015-08-27T17:52:42Z","CORRELATIONID":"964d857dd5d11","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55df4e6806add', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 1 maand', 'alexutugrasutu@yahoo.com', '1440697959he58m8fe6us16phliqbmi', '2000', 'EUR' ),
( '7', '67', '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":"20.00","L_PAYMENTREQUEST_0_AMT0":"20.00","L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/raCmMF6I_OwM2iMSqNg36T79s-Xksal7Bde57JwKiSw","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/raCmMF6I_OwM2iMSqNg36T79s-Xksal7Bde57JwKiSw","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/oJ5DU1U5_D5Tlz39OlwGzwz5pnn2YI8tnfMVbtwQ7kA","TOKEN":"EC-768813524Y328653G","TIMESTAMP":"2015-08-31T13:35:07Z","CORRELATIONID":"955dd43db2e07","ACK":"Success","VERSION":"65.1","BUILD":"000000","BILLINGAGREEMENTACCEPTEDSTATUS":"0","CHECKOUTSTATUS":"PaymentActionCompleted","EMAIL":"henkboersema@hotmail.com","PAYERID":"YXYNKSZ2TFFCE","PAYERSTATUS":"verified","FIRSTNAME":"henk","LASTNAME":"boersema","COUNTRYCODE":"NL","SHIPTONAME":"henk boersema","SHIPTOSTREET":"kamerlingh onnesstraat 48","SHIPTOCITY":"Groningen","SHIPTOZIP":"9727hn","SHIPTOCOUNTRYCODE":"NL","SHIPTOCOUNTRYNAME":"Netherlands","ADDRESSSTATUS":"Confirmed","CURRENCYCODE":"EUR","AMT":"20.00","ITEMAMT":"20.00","SHIPPINGAMT":"0.00","HANDLINGAMT":"0.00","TAXAMT":"0.00","INSURANCEAMT":"0.00","SHIPDISCAMT":"0.00","L_NAME0":"Koop een link","L_QTY0":"1","L_TAXAMT0":"0.00","L_AMT0":"20.00","L_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","L_ITEMWEIGHTVALUE0":"   0.00000","L_ITEMLENGTHVALUE0":"   0.00000","L_ITEMWIDTHVALUE0":"   0.00000","L_ITEMHEIGHTVALUE0":"   0.00000","PAYMENTREQUEST_0_ITEMAMT":"20.00","PAYMENTREQUEST_0_SHIPPINGAMT":"0.00","PAYMENTREQUEST_0_HANDLINGAMT":"0.00","PAYMENTREQUEST_0_TAXAMT":"0.00","PAYMENTREQUEST_0_INSURANCEAMT":"0.00","PAYMENTREQUEST_0_SHIPDISCAMT":"0.00","PAYMENTREQUEST_0_INSURANCEOPTIONOFFERED":"false","PAYMENTREQUEST_0_SHIPTONAME":"henk boersema","PAYMENTREQUEST_0_SHIPTOSTREET":"kamerlingh onnesstraat 48","PAYMENTREQUEST_0_SHIPTOCITY":"Groningen","PAYMENTREQUEST_0_SHIPTOZIP":"9727hn","PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE":"NL","PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME":"Netherlands","PAYMENTREQUEST_0_ADDRESSSTATUS":"Confirmed","L_PAYMENTREQUEST_0_QTY0":"1","L_PAYMENTREQUEST_0_TAXAMT0":"0.00","L_PAYMENTREQUEST_0_ITEMWEIGHTVALUE0":"   0.00000","L_PAYMENTREQUEST_0_ITEMLENGTHVALUE0":"   0.00000","L_PAYMENTREQUEST_0_ITEMWIDTHVALUE0":"   0.00000","L_PAYMENTREQUEST_0_ITEMHEIGHTVALUE0":"   0.00000","PAYMENTREQUESTINFO_0_ERRORCODE":"0","SUCCESSPAGEREDIRECTREQUESTED":"false","INSURANCEOPTIONSELECTED":"false","SHIPPINGOPTIONISDEFAULT":"false","PAYMENTINFO_0_TRANSACTIONID":"3T6020124A318434B","PAYMENTINFO_0_TRANSACTIONTYPE":"cart","PAYMENTINFO_0_PAYMENTTYPE":"instant","PAYMENTINFO_0_ORDERTIME":"2015-08-31T13:34:49Z","PAYMENTINFO_0_AMT":"20.00","PAYMENTINFO_0_FEEAMT":"1.03","PAYMENTINFO_0_TAXAMT":"0.00","PAYMENTINFO_0_CURRENCYCODE":"EUR","PAYMENTINFO_0_PAYMENTSTATUS":"Completed","PAYMENTINFO_0_PENDINGREASON":"None","PAYMENTINFO_0_REASONCODE":"None","PAYMENTINFO_0_PROTECTIONELIGIBILITY":"Eligible","PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE":"ItemNotReceivedEligible,UnauthorizedPaymentEligible","PAYMENTINFO_0_SELLERPAYPALACCOUNTID":"contact@vouchercode.nl","PAYMENTINFO_0_ERRORCODE":"0","PAYMENTINFO_0_ACK":"Success","TRANSACTIONID":"3T6020124A318434B","L_ITEMCATEGORY0":"Physical","PAYMENTREQUEST_0_TRANSACTIONID":"3T6020124A318434B","PAYMENTREQUEST_0_SELLERPAYPALACCOUNTID":"contact@vouchercode.nl","L_PAYMENTREQUEST_0_ITEMCATEGORY0":"Physical","PAYMENTREQUESTINFO_0_TRANSACTIONID":"3T6020124A318434B","PAYMENTREQUEST_0_TRANSACTIONTYPE":"cart","PAYMENTREQUEST_0_PAYMENTTYPE":"instant","PAYMENTREQUEST_0_ORDERTIME":"2015-08-31T13:34:49Z","PAYMENTREQUEST_0_FEEAMT":"1.03","PAYMENTREQUEST_0_PAYMENTSTATUS":"Completed","PAYMENTREQUEST_0_PENDINGREASON":"None","PAYMENTREQUEST_0_REASONCODE":"None"}', '55e457e09068f', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 1 maand', 'henkboersema87@gmail.com', '1441028064y6w1k4crj1bl8f1qmbdoaqjk4y', '2000', 'EUR' ),
( '8', '68', '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":"20.00","L_PAYMENTREQUEST_0_AMT0":"20.00","L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/34SvdRs82XvHaDUojmMslHoUhlpn6OAqKg92yYJISdo","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/34SvdRs82XvHaDUojmMslHoUhlpn6OAqKg92yYJISdo","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/uVtEesMTLmAyHmdnqedB84O701OtCiDt9kI27nhtm4E","TOKEN":"EC-21M57947VY308570T","TIMESTAMP":"2015-08-31T13:36:55Z","CORRELATIONID":"dc685285b08a","ACK":"Success","VERSION":"65.1","BUILD":"000000","PHONENUM":" 31 0615239401","BILLINGAGREEMENTACCEPTEDSTATUS":"0","CHECKOUTSTATUS":"PaymentActionCompleted","EMAIL":"henkboersema@hotmail.com","PAYERID":"YXYNKSZ2TFFCE","PAYERSTATUS":"verified","FIRSTNAME":"henk","LASTNAME":"boersema","COUNTRYCODE":"NL","SHIPTONAME":"Henk Boersema","SHIPTOSTREET":"Kamerlingh Onnesstraat 48","SHIPTOCITY":"Groningen","SHIPTOZIP":"9727HN","SHIPTOCOUNTRYCODE":"NL","SHIPTOCOUNTRYNAME":"Netherlands","ADDRESSSTATUS":"Confirmed","CURRENCYCODE":"EUR","AMT":"20.00","ITEMAMT":"20.00","SHIPPINGAMT":"0.00","HANDLINGAMT":"0.00","TAXAMT":"0.00","NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/uVtEesMTLmAyHmdnqedB84O701OtCiDt9kI27nhtm4E","INSURANCEAMT":"0.00","SHIPDISCAMT":"0.00","L_NAME0":"Koop een link","L_QTY0":"1","L_TAXAMT0":"0.00","L_AMT0":"20.00","L_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","PAYMENTREQUEST_0_ITEMAMT":"20.00","PAYMENTREQUEST_0_SHIPPINGAMT":"0.00","PAYMENTREQUEST_0_HANDLINGAMT":"0.00","PAYMENTREQUEST_0_TAXAMT":"0.00","PAYMENTREQUEST_0_INSURANCEAMT":"0.00","PAYMENTREQUEST_0_SHIPDISCAMT":"0.00","PAYMENTREQUEST_0_SELLERPAYPALACCOUNTID":"contact@vouchercode.nl","PAYMENTREQUEST_0_SHIPTONAME":"Henk Boersema","PAYMENTREQUEST_0_SHIPTOSTREET":"Kamerlingh Onnesstraat 48","PAYMENTREQUEST_0_SHIPTOCITY":"Groningen","PAYMENTREQUEST_0_SHIPTOZIP":"9727HN","PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE":"NL","PAYMENTREQUEST_0_SHIPTOCOUNTRYNAME":"Netherlands","PAYMENTREQUEST_0_ADDRESSSTATUS":"Confirmed","L_PAYMENTREQUEST_0_QTY0":"1","L_PAYMENTREQUEST_0_TAXAMT0":"0.00","PAYMENTREQUESTINFO_0_ERRORCODE":"0","SUCCESSPAGEREDIRECTREQUESTED":"false","INSURANCEOPTIONSELECTED":"false","SHIPPINGOPTIONISDEFAULT":"false","PAYMENTINFO_0_TRANSACTIONID":"07W39457TA904502B","PAYMENTINFO_0_TRANSACTIONTYPE":"cart","PAYMENTINFO_0_PAYMENTTYPE":"instant","PAYMENTINFO_0_ORDERTIME":"2015-08-31T13:36:35Z","PAYMENTINFO_0_AMT":"20.00","PAYMENTINFO_0_FEEAMT":"1.03","PAYMENTINFO_0_TAXAMT":"0.00","PAYMENTINFO_0_CURRENCYCODE":"EUR","PAYMENTINFO_0_PAYMENTSTATUS":"Completed","PAYMENTINFO_0_PENDINGREASON":"None","PAYMENTINFO_0_REASONCODE":"None","PAYMENTINFO_0_PROTECTIONELIGIBILITY":"Eligible","PAYMENTINFO_0_PROTECTIONELIGIBILITYTYPE":"ItemNotReceivedEligible,UnauthorizedPaymentEligible","PAYMENTINFO_0_ERRORCODE":"0","PAYMENTINFO_0_ACK":"Success","SHIPTOSTATE":"AL","TRANSACTIONID":"07W39457TA904502B","PAYMENTREQUEST_0_TRANSACTIONID":"07W39457TA904502B","PAYMENTREQUEST_0_SHIPTOSTATE":"AL","PAYMENTREQUESTINFO_0_TRANSACTIONID":"07W39457TA904502B","PAYMENTREQUEST_0_TRANSACTIONTYPE":"cart","PAYMENTREQUEST_0_PAYMENTTYPE":"instant","PAYMENTREQUEST_0_ORDERTIME":"2015-08-31T13:36:35Z","PAYMENTREQUEST_0_FEEAMT":"1.03","PAYMENTREQUEST_0_PAYMENTSTATUS":"Completed","PAYMENTREQUEST_0_PENDINGREASON":"None","PAYMENTREQUEST_0_REASONCODE":"None"}', '55e4583ed57fa', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 1 maand', 'henkboersema87@gmail.com', '1441028158zvqe3ddl72kzsuoquxvfrg7xycr', '2000', 'EUR' ),
( '9', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/wereldkinderen.eigenstart.nl\\/ binnen de 12 maanden","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":96,"L_PAYMENTREQUEST_0_AMT0":96,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/KO2aDtZrXjGKkKUTEpqu8aqgPWQmSd2j-OFiiwm1cYg","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/KO2aDtZrXjGKkKUTEpqu8aqgPWQmSd2j-OFiiwm1cYg","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/f6f0nNsnr6ZJ3aQDV_fmCwgTihhFyquXe0ZEJMKlAoc","TOKEN":"EC-3LV09831BP753670L","TIMESTAMP":"2015-09-04T15:17:14Z","CORRELATIONID":"acfd213d37633","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55e9b5f668e01', 'Koop een link naar een pagina http://wereldkinderen.eigenstart.nl/ binnen de 12 maanden', 'info@patiencespel.nl', '1441379830k8byu9dx5axjat8df3pvwm6', '9600', 'EUR' ),
( '10', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":20,"L_PAYMENTREQUEST_0_AMT0":20,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/WkBraa--YGlfdP3YThVSfPYa_tyqS5dqUf-AHgHt4eo","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/WkBraa--YGlfdP3YThVSfPYa_tyqS5dqUf-AHgHt4eo","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/GGIFKOmMHQUsSFiGzRm5nka0foZy1Fb4PwlfH1PhPS8","TOKEN":"EC-2PM65331AB160560H","TIMESTAMP":"2015-09-08T09:07:55Z","CORRELATIONID":"d643bb336f1ca","ACK":"Success","VERSION":"65.1","BUILD":"17972692"}', '55eea56973623', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 1 maand', 'adsfji@adsjfi.nl', '14417032737pr0p3yzrfbefp221hupfyci', '2000', 'EUR' ),
( '11', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 12 maanden","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":240,"L_PAYMENTREQUEST_0_AMT0":240,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/0Kqff0TnHwaWJLvMLfJwLg7hUoF8txfGKXKERR3Ga58","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/0Kqff0TnHwaWJLvMLfJwLg7hUoF8txfGKXKERR3Ga58","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/TOy2J5A3DOj1HP6HXwCDj7PVlAT66BHnlMerU6BA_pU","TOKEN":"EC-5W726207LD689403S","TIMESTAMP":"2015-09-09T22:56:28Z","CORRELATIONID":"e0e28c8e96a3b","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55f0b91a55918', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 12 maanden', 'grandfameltd@gmail.com', '1441839386o2nwsiegz782pruc9vfs1md7pmc', '24000', 'EUR' ),
( '12', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/link-partner.eigenstart.nl\\/ binnen de 12 maanden","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":96,"L_PAYMENTREQUEST_0_AMT0":96,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/3opOL8HWynV1YdOD4_AE-KcgZmGkO0ehTzeJ1qZr60w","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/3opOL8HWynV1YdOD4_AE-KcgZmGkO0ehTzeJ1qZr60w","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/kYdR5G5zLipFzdNge7N1evUg99FV1Ev-XRjhKqsqBBM","TOKEN":"EC-12F73486X8047430W","TIMESTAMP":"2015-09-10T11:40:37Z","CORRELATIONID":"48adfc60c9788","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55f16c339d221', 'Koop een link naar een pagina http://link-partner.eigenstart.nl/ binnen de 12 maanden', 'pr@gildemaintenance.nl', '1441885235ziexdm76yq87r1ttu8lovryos9e', '9600', 'EUR' ),
( '13', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/link-partner.eigenstart.nl\\/ binnen de 12 maanden","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":96,"L_PAYMENTREQUEST_0_AMT0":96,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/xtT2RW3qO41aXxoOaiQVFCkRetK_ywy4ZPEliANfN68","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/xtT2RW3qO41aXxoOaiQVFCkRetK_ywy4ZPEliANfN68","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/qaDVhjEBYTsKcRY4Sfk6lY5CbrP5OpDYPbAlQwG5evs","TOKEN":"EC-83N047723U330780E","TIMESTAMP":"2015-09-10T11:40:40Z","CORRELATIONID":"b1ba864cc849d","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55f16c3746384', 'Koop een link naar een pagina http://link-partner.eigenstart.nl/ binnen de 12 maanden', 'pr@gildemaintenance.nl', '1441885239jdj4tf59jrpi273ckyxajt5a4ho', '9600', 'EUR' ),
( '14', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 12 maanden","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":240,"L_PAYMENTREQUEST_0_AMT0":240,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/Ufy2hQdGMu0A1Es2RchuAS9lgkNAYy4wZdAbm3X0rFw","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/Ufy2hQdGMu0A1Es2RchuAS9lgkNAYy4wZdAbm3X0rFw","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/cMFa4bqpPnf-wLBzl6WEsAP9snEhtaLfnwgl2vfc7WY","TOKEN":"EC-0UB04482E1537333J","TIMESTAMP":"2015-09-12T12:54:38Z","CORRELATIONID":"6dfca530c2d50","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55f4208cc99dd', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 12 maanden', 'dsad@sds.nl', '1442062476wy6s1cv1lk9nh0ub6biz3ogt', '24000', 'EUR' ),
( '15', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 12 maanden","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":240,"L_PAYMENTREQUEST_0_AMT0":240,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/9OftDanb-8Sr3GCiQSVk4sdpgbVaK9qvrzyvBXOLhoY","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/9OftDanb-8Sr3GCiQSVk4sdpgbVaK9qvrzyvBXOLhoY","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/mkrAkNLDr7-t4QNDRLQezN_uf5pRkuwCBMz0Tt-CUg4","TOKEN":"EC-9TJ46379MM0710633","TIMESTAMP":"2015-09-14T10:35:43Z","CORRELATIONID":"54336f0b56880","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55f6a2fd4b3ca', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 12 maanden', 'admin@taxiutrecht-24.nl', '14422269410pq6umq8h1xzaaoo37srvedf20', '24000', 'EUR' ),
( '16', NULL, '{"L_PAYMENTREQUEST_0_DESC0":"Koop een link naar een pagina http:\\/\\/eigenstart.nl\\/ binnen de 1 maand","PAYMENTREQUEST_0_CURRENCYCODE":"EUR","PAYMENTREQUEST_0_AMT":20,"L_PAYMENTREQUEST_0_AMT0":20,"L_PAYMENTREQUEST_0_NAME0":"Koop een link","PAYMENTREQUEST_0_PAYMENTACTION":"Sale","RETURNURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/LcMWXUSzNkM0ZFKGrJPiSDvbWGsEF6lyf0AYBcybnoI","CANCELURL":"http:\\/\\/eigenstart.nl\\/payment\\/capture\\/LcMWXUSzNkM0ZFKGrJPiSDvbWGsEF6lyf0AYBcybnoI","PAYMENTREQUEST_0_NOTIFYURL":"http:\\/\\/eigenstart.nl\\/payment\\/notify\\/rFdHd1mDU0vcJNMQI57xW2czzkEfluXNCYxFOwk38s0","TOKEN":"EC-4UY53535VY946700E","TIMESTAMP":"2015-09-14T10:36:15Z","CORRELATIONID":"36dcdb237780a","ACK":"Success","VERSION":"65.1","BUILD":"000000"}', '55f6a31d3883e', 'Koop een link naar een pagina http://eigenstart.nl/ binnen de 1 maand', 'admin@taxiutrecht-24.nl', '1442226973hyfkntxwx5ar6aj7qifj4xklf', '2000', 'EUR' );
-- ---------------------------------------------------------


-- Dump data of "PaymentToken" -----------------------------
INSERT INTO `PaymentToken`(`hash`,`details`,`after_url`,`target_url`,`gateway_name`) VALUES 
( '_69FoawjeRBXgBjjJ4fIzguT1g-QAGgF8cXkEbmQROU', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:2;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/_69FoawjeRBXgBjjJ4fIzguT1g-QAGgF8cXkEbmQROU', 'paypal' ),
( '0Kqff0TnHwaWJLvMLfJwLg7hUoF8txfGKXKERR3Ga58', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:11;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=qgIbv0CM4IcvKouJ_dGs_os8W0uRqk8rwgQYobVLDKg', 'http://eigenstart.nl/payment/capture/0Kqff0TnHwaWJLvMLfJwLg7hUoF8txfGKXKERR3Ga58', 'paypal' ),
( '3opOL8HWynV1YdOD4_AE-KcgZmGkO0ehTzeJ1qZr60w', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:12;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=j4tujd_XDftTEOcv8UbOlDdYPPVBQJoPCOivZZF0cjM', 'http://eigenstart.nl/payment/capture/3opOL8HWynV1YdOD4_AE-KcgZmGkO0ehTzeJ1qZr60w', 'paypal' ),
( '65VZmsybN8KhYMFfv7SPULQ73zJi3pS2LrhcXuL2W48', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:6;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=vug7m-7wcO9ptLUYOzzvp-eaYEoJbU6_kYEf_gdH0Ew', 'http://eigenstart.nl/payment/capture/65VZmsybN8KhYMFfv7SPULQ73zJi3pS2LrhcXuL2W48', 'paypal' ),
( '9OftDanb-8Sr3GCiQSVk4sdpgbVaK9qvrzyvBXOLhoY', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:15;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=UrvRvH8j0NCVwBhv7wA2P7ZLjiDQM3G26NeWWDm0I0A', 'http://eigenstart.nl/payment/capture/9OftDanb-8Sr3GCiQSVk4sdpgbVaK9qvrzyvBXOLhoY', 'paypal' ),
( 'BnEflt7vs5okP4Qq_TlPCX6FB2INs8rr4H34SlwKvG0', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:4;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/BnEflt7vs5okP4Qq_TlPCX6FB2INs8rr4H34SlwKvG0', 'paypal' ),
( 'cMFa4bqpPnf-wLBzl6WEsAP9snEhtaLfnwgl2vfc7WY', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:14;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/cMFa4bqpPnf-wLBzl6WEsAP9snEhtaLfnwgl2vfc7WY', 'paypal' ),
( 'f6f0nNsnr6ZJ3aQDV_fmCwgTihhFyquXe0ZEJMKlAoc', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:9;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/f6f0nNsnr6ZJ3aQDV_fmCwgTihhFyquXe0ZEJMKlAoc', 'paypal' ),
( 'FQlvfhFozFrn7CKV01GUu4eidRYE2eDOub4ZrK1sdbU', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:2;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=FQlvfhFozFrn7CKV01GUu4eidRYE2eDOub4ZrK1sdbU', 'paypal' ),
( 'GGIFKOmMHQUsSFiGzRm5nka0foZy1Fb4PwlfH1PhPS8', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:10;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/GGIFKOmMHQUsSFiGzRm5nka0foZy1Fb4PwlfH1PhPS8', 'paypal' ),
( 'Ie2cx2IW78obiWGnE0FrMXnJ_omNS0s1_kL2_qeKLCg', 'C:25:"Payum\\Core\\Model\\Identity":58:{a:2:{i:0;i:2;i:1;s:32:"Catalog\\AppBundle\\Entity\\Payment";}}', NULL, 'http://eigenstart.nl/payment/notify/Ie2cx2IW78obiWGnE0FrMXnJ_omNS0s1_kL2_qeKLCg', 'paypal' ),
( 'iFYboCDFuQpugtGTv93FhE4KaYqPN7JMlWN1FiNgv2A', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:1;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=iFYboCDFuQpugtGTv93FhE4KaYqPN7JMlWN1FiNgv2A', 'paypal' ),
( 'IWn4j8f5z32hLA2yrkw8rpf23vClgwgwFbtcAxYCfRU', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:5;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/IWn4j8f5z32hLA2yrkw8rpf23vClgwgwFbtcAxYCfRU', 'paypal' ),
( 'j4tujd_XDftTEOcv8UbOlDdYPPVBQJoPCOivZZF0cjM', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:12;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=j4tujd_XDftTEOcv8UbOlDdYPPVBQJoPCOivZZF0cjM', 'paypal' ),
( 'KO2aDtZrXjGKkKUTEpqu8aqgPWQmSd2j-OFiiwm1cYg', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:9;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=VLBhRimf6p8oEp_ZpknvT2dBM2ozimt7K9ak7ZR0slc', 'http://eigenstart.nl/payment/capture/KO2aDtZrXjGKkKUTEpqu8aqgPWQmSd2j-OFiiwm1cYg', 'paypal' ),
( 'kYdR5G5zLipFzdNge7N1evUg99FV1Ev-XRjhKqsqBBM', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:12;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/kYdR5G5zLipFzdNge7N1evUg99FV1Ev-XRjhKqsqBBM', 'paypal' ),
( 'L2I4BGc4o_zVY3ulFEz9byry7z2hnwUS3v26sMPnLnw', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:13;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=L2I4BGc4o_zVY3ulFEz9byry7z2hnwUS3v26sMPnLnw', 'paypal' ),
( 'LcMWXUSzNkM0ZFKGrJPiSDvbWGsEF6lyf0AYBcybnoI', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:16;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=W9XnVg3UPT6k5aI1F46a9AwDEGbZMBorxQvEVl7hj8E', 'http://eigenstart.nl/payment/capture/LcMWXUSzNkM0ZFKGrJPiSDvbWGsEF6lyf0AYBcybnoI', 'paypal' ),
( 'LiMkEo3aybxVpZGgo8pmAf5dUeMmXyYTparVwVnRaPw', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:7;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=LiMkEo3aybxVpZGgo8pmAf5dUeMmXyYTparVwVnRaPw', 'paypal' ),
( 'MFbQ8GaOASIsj4ykpt0UxNIgDY6e4WaxVuF1heoIPjw', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:14;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=MFbQ8GaOASIsj4ykpt0UxNIgDY6e4WaxVuF1heoIPjw', 'paypal' ),
( 'mkrAkNLDr7-t4QNDRLQezN_uf5pRkuwCBMz0Tt-CUg4', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:15;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/mkrAkNLDr7-t4QNDRLQezN_uf5pRkuwCBMz0Tt-CUg4', 'paypal' ),
( 'mOrxq5ecOlF27mJf8Ht4v6Pm6l-uB2OrBDWypUYUbTA', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:8;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=mOrxq5ecOlF27mJf8Ht4v6Pm6l-uB2OrBDWypUYUbTA', 'paypal' ),
( 'oJ5DU1U5_D5Tlz39OlwGzwz5pnn2YI8tnfMVbtwQ7kA', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:7;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/oJ5DU1U5_D5Tlz39OlwGzwz5pnn2YI8tnfMVbtwQ7kA', 'paypal' ),
( 'ooAP_UpBft4bWx3RvM4Tp31xpVG3ZpXgAC7t7bHGMZ8', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:1;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/ooAP_UpBft4bWx3RvM4Tp31xpVG3ZpXgAC7t7bHGMZ8', 'paypal' ),
( 'P6H_v8oNdFHRRgJZ3n3Eyc3jDe8C1IUGwLUozHpNTmM', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:5;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=qv-riXrWFnIkeUnJWAFRzMycU5XEQGs8uHowAXoic9g', 'http://eigenstart.nl/payment/capture/P6H_v8oNdFHRRgJZ3n3Eyc3jDe8C1IUGwLUozHpNTmM', 'paypal' ),
( 'PuFxJMd8DMnwBdEmdbtzxz2B8Ol-4ThRQHsk_OL8Ifg', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:3;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=PuFxJMd8DMnwBdEmdbtzxz2B8Ol-4ThRQHsk_OL8Ifg', 'paypal' ),
( 'qaDVhjEBYTsKcRY4Sfk6lY5CbrP5OpDYPbAlQwG5evs', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:13;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/qaDVhjEBYTsKcRY4Sfk6lY5CbrP5OpDYPbAlQwG5evs', 'paypal' ),
( 'qgIbv0CM4IcvKouJ_dGs_os8W0uRqk8rwgQYobVLDKg', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:11;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=qgIbv0CM4IcvKouJ_dGs_os8W0uRqk8rwgQYobVLDKg', 'paypal' ),
( 'QPBjJZ6Q1GETg0NkPylU3yy59cQ8KTPGJcwJMgOR9WA', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:4;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=QPBjJZ6Q1GETg0NkPylU3yy59cQ8KTPGJcwJMgOR9WA', 'paypal' ),
( 'qqYUBYEYI4_Qm_CiT7tPZB3xWr4m0VpKHZiZ2YoZu2I', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:3;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=PuFxJMd8DMnwBdEmdbtzxz2B8Ol-4ThRQHsk_OL8Ifg', 'http://eigenstart.nl/payment/capture/qqYUBYEYI4_Qm_CiT7tPZB3xWr4m0VpKHZiZ2YoZu2I', 'paypal' ),
( 'qv-riXrWFnIkeUnJWAFRzMycU5XEQGs8uHowAXoic9g', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:5;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=qv-riXrWFnIkeUnJWAFRzMycU5XEQGs8uHowAXoic9g', 'paypal' ),
( 'rFdHd1mDU0vcJNMQI57xW2czzkEfluXNCYxFOwk38s0', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:16;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/rFdHd1mDU0vcJNMQI57xW2czzkEfluXNCYxFOwk38s0', 'paypal' ),
( 'RJ682tOtHYzRO3O_SNhtj6gkvifRG4yUO5SWriN9kkQ', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:3;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/RJ682tOtHYzRO3O_SNhtj6gkvifRG4yUO5SWriN9kkQ', 'paypal' ),
( 'TlFx7T4cH8G6pXGExyxc8gAtCN6HFTRySm0ac9OQqsw', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:1;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=iFYboCDFuQpugtGTv93FhE4KaYqPN7JMlWN1FiNgv2A', 'http://eigenstart.nl/payment/capture/TlFx7T4cH8G6pXGExyxc8gAtCN6HFTRySm0ac9OQqsw', 'paypal' ),
( 'TOy2J5A3DOj1HP6HXwCDj7PVlAT66BHnlMerU6BA_pU', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:11;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/TOy2J5A3DOj1HP6HXwCDj7PVlAT66BHnlMerU6BA_pU', 'paypal' ),
( 'Ufy2hQdGMu0A1Es2RchuAS9lgkNAYy4wZdAbm3X0rFw', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:14;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=MFbQ8GaOASIsj4ykpt0UxNIgDY6e4WaxVuF1heoIPjw', 'http://eigenstart.nl/payment/capture/Ufy2hQdGMu0A1Es2RchuAS9lgkNAYy4wZdAbm3X0rFw', 'paypal' ),
( 'UrvRvH8j0NCVwBhv7wA2P7ZLjiDQM3G26NeWWDm0I0A', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:15;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=UrvRvH8j0NCVwBhv7wA2P7ZLjiDQM3G26NeWWDm0I0A', 'paypal' ),
( 'uVtEesMTLmAyHmdnqedB84O701OtCiDt9kI27nhtm4E', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:8;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/uVtEesMTLmAyHmdnqedB84O701OtCiDt9kI27nhtm4E', 'paypal' ),
( 'VLBhRimf6p8oEp_ZpknvT2dBM2ozimt7K9ak7ZR0slc', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:9;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=VLBhRimf6p8oEp_ZpknvT2dBM2ozimt7K9ak7ZR0slc', 'paypal' ),
( 'vug7m-7wcO9ptLUYOzzvp-eaYEoJbU6_kYEf_gdH0Ew', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:6;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=vug7m-7wcO9ptLUYOzzvp-eaYEoJbU6_kYEf_gdH0Ew', 'paypal' ),
( 'vwQjofTja1ILuNohHhgcmD4bHscmn3q-GzGTV0Pgklk', 'C:25:"Payum\\Core\\Model\\Identity":58:{a:2:{i:0;i:1;i:1;s:32:"Catalog\\AppBundle\\Entity\\Payment";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=vwQjofTja1ILuNohHhgcmD4bHscmn3q-GzGTV0Pgklk', 'paypal' ),
( 'vzjfSD4MBMRncCoTxr7mIljKGsqKteUzP8zx-LOK_Dw', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:10;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=vzjfSD4MBMRncCoTxr7mIljKGsqKteUzP8zx-LOK_Dw', 'paypal' ),
( 'W9XnVg3UPT6k5aI1F46a9AwDEGbZMBorxQvEVl7hj8E', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:16;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=W9XnVg3UPT6k5aI1F46a9AwDEGbZMBorxQvEVl7hj8E', 'paypal' ),
( 'WkBraa--YGlfdP3YThVSfPYa_tyqS5dqUf-AHgHt4eo', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:10;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=vzjfSD4MBMRncCoTxr7mIljKGsqKteUzP8zx-LOK_Dw', 'http://eigenstart.nl/payment/capture/WkBraa--YGlfdP3YThVSfPYa_tyqS5dqUf-AHgHt4eo', 'paypal' ),
( 'XCHm5-bm1TfXIYu2EZSNXm0bizM3O-WtdC6yM3Bz0cE', 'C:25:"Payum\\Core\\Model\\Identity":58:{a:2:{i:0;i:2;i:1;s:32:"Catalog\\AppBundle\\Entity\\Payment";}}', NULL, 'http://eigenstart.nl/buy/link/summary?payum_token=XCHm5-bm1TfXIYu2EZSNXm0bizM3O-WtdC6yM3Bz0cE', 'paypal' ),
( 'xtT2RW3qO41aXxoOaiQVFCkRetK_ywy4ZPEliANfN68', 'C:25:"Payum\\Core\\Model\\Identity":66:{a:2:{i:0;i:13;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=L2I4BGc4o_zVY3ulFEz9byry7z2hnwUS3v26sMPnLnw', 'http://eigenstart.nl/payment/capture/xtT2RW3qO41aXxoOaiQVFCkRetK_ywy4ZPEliANfN68', 'paypal' ),
( 'yatDt5dteY1R--Wx4cErute358QtAZVG1yHhutO27gw', 'C:25:"Payum\\Core\\Model\\Identity":58:{a:2:{i:0;i:2;i:1;s:32:"Catalog\\AppBundle\\Entity\\Payment";}}', 'http://eigenstart.nl/buy/link/summary?payum_token=XCHm5-bm1TfXIYu2EZSNXm0bizM3O-WtdC6yM3Bz0cE', 'http://eigenstart.nl/payment/capture/yatDt5dteY1R--Wx4cErute358QtAZVG1yHhutO27gw', 'paypal' ),
( 'Z8jbF4FtjEUNKE2Fh4cPyJzJ6D-vGLs6pnxpho8Xm9g', 'C:25:"Payum\\Core\\Model\\Identity":58:{a:2:{i:0;i:1;i:1;s:32:"Catalog\\AppBundle\\Entity\\Payment";}}', NULL, 'http://eigenstart.nl/payment/notify/Z8jbF4FtjEUNKE2Fh4cPyJzJ6D-vGLs6pnxpho8Xm9g', 'paypal' ),
( 'zMJ9wumdech4z3RMLzaXZcTciX98yre1LhX3p3MYb9E', 'C:25:"Payum\\Core\\Model\\Identity":65:{a:2:{i:0;i:6;i:1;s:39:"Catalog\\AppBundle\\Entity\\PaymentDetails";}}', NULL, 'http://eigenstart.nl/payment/notify/zMJ9wumdech4z3RMLzaXZcTciX98yre1LhX3p3MYb9E', 'paypal' );
-- ---------------------------------------------------------


-- Dump data of "advertisment_categories" ------------------
INSERT INTO `advertisment_categories`(`id`,`title`,`type_id`) VALUES 
( '20', 'Дитячий світ', '1' ),
( '21', 'Нерухомість', '1' ),
( '22', 'Транспорт', '1' ),
( '23', 'Робота', '1' ),
( '24', 'Тварини', '1' ),
( '25', 'Дім і сад', '1' ),
( '26', 'Електроніка', '1' ),
( '27', 'Бізнес та послуги', '1' ),
( '28', 'Мода і стиль', '1' ),
( '29', 'Хобі та відпочинок', '1' ),
( '30', 'Обміняю', '1' ),
( '34', 'Документи', '2' ),
( '35', 'Сумки \\ Багажі \\ Покладь', '2' ),
( '36', 'Прикраси', '2' ),
( '37', 'Електроніка', '2' ),
( '38', 'Одяг \\ Взуття', '2' ),
( '39', 'Дрібниці', '2' ),
( '40', 'Тварини', '2' ),
( '41', 'Одяг \\ Взуття', '3' ),
( '42', 'Продукти харчування', '3' ),
( '43', 'Житло', '3' ),
( '44', 'Тварини', '3' ),
( '45', 'Електроніка', '3' ),
( '46', 'Транспорт', '3' ),
( '47', 'Потребую допомогу в', '3' ),
( '48', 'Допоможу вирішити', '3' );
-- ---------------------------------------------------------


-- Dump data of "advertisment_subcategories" ---------------
INSERT INTO `advertisment_subcategories`(`id`,`title`,`category_id`) VALUES 
( '1', 'Дитячий одяг', '20' ),
( '2', 'Дитяче взуття', '20' ),
( '3', 'Дитячі коляски', '20' ),
( '4', 'Дитячі автокрісла', '20' ),
( '5', 'Дитячі меблі', '20' ),
( '6', 'Іграшки', '20' ),
( '7', 'Дитячий транспорт', '20' ),
( '8', 'Годування', '20' ),
( '9', 'Товари для школярів', '20' ),
( '10', 'Інші дитячі товари', '20' ),
( '11', 'Оренда квартир', '21' ),
( '12', 'Оренда кімнат', '21' ),
( '13', 'Оренда будинків', '21' ),
( '14', 'Оренда землі', '21' ),
( '15', 'Оренда гаражів / стоянок', '21' ),
( '16', 'Шукаю компаньйона', '21' ),
( '17', 'Продаж квартир', '21' ),
( '18', 'Продаж кімнат', '21' ),
( '19', 'Продаж кімнат', '21' ),
( '20', 'Продаж землі', '21' ),
( '21', 'Продаж гаражів / стоянок', '21' ),
( '22', 'Оренда приміщень', '21' ),
( '23', 'Продаж приміщень', '21' ),
( '24', 'Інша нерухомість', '21' ),
( '25', 'Обмін нерухомості', '21' ),
( '26', 'Легкові автомобілі', '22' ),
( '27', 'Мото', '22' ),
( '28', 'Автобуси', '22' ),
( '29', 'Спецтехніка', '22' ),
( '30', 'Вантажні автомобілі', '22' ),
( '31', 'Сільгосптехніка', '22' ),
( '32', 'Водний транспорт', '22' ),
( '33', 'Водний транспорт', '22' ),
( '34', 'Запчастини ', '22' ),
( '35', 'Аксесуари', '22' ),
( '36', 'Причепи', '22' ),
( '37', 'Інший транспорт', '22' ),
( '38', 'Роздрібна торгівля / Продажі', '23' ),
( '39', 'Транспорт / логістика', '23' ),
( '40', 'Будівництво', '23' ),
( '41', 'Бари / ресторани', '23' ),
( '42', 'Юриспруденція та бухгалтерія', '23' ),
( '43', 'Охорона / безпека', '23' ),
( '44', 'Домашній персонал', '23' ),
( '45', 'Краса / фітнес / спорт', '23' ),
( '46', 'Туризм / відпочинок / розваги', '23' ),
( '47', 'Освіта', '23' ),
( '48', 'Культура / мистецтво', '23' ),
( '49', 'Медицина / фармація', '23' ),
( '50', 'ІТ / телеком / комп\'ютери', '23' ),
( '51', 'Нерухомість', '23' ),
( '52', 'Маркетинг / реклама / дизайн', '23' ),
( '53', 'Виробництво / енергетика', '23' ),
( '54', 'Cекретаріат / АХО', '23' ),
( '55', 'Часткова зайнятість', '23' ),
( '56', 'Початок кар\'єри / Студенти', '23' ),
( '57', 'Сервіс і побут', '23' ),
( '58', 'Інші сфери занять', '23' ),
( '59', 'Собаки', '24' ),
( '60', 'Коти', '24' ),
( '61', 'Акваріумістика', '24' ),
( '62', 'Пташки', '24' ),
( '63', 'Гризуни', '24' ),
( '64', 'Рептилії', '24' ),
( '65', 'Сільгосп тварини', '24' ),
( '66', 'Тварини безкоштовно', '24' ),
( '67', 'Зоотовари', '24' ),
( '68', 'В\'язка', '24' ),
( '69', 'Бюро знахідок', '24' ),
( '70', 'Інші тварини', '24' ),
( '71', 'Канцтовари / витратні матеріали', '25' ),
( '72', 'Меблі', '25' ),
( '73', 'Продукти харчування / напої', '25' ),
( '74', 'Сад / город', '25' ),
( '75', 'Предмети інтер\'єру', '25' ),
( '76', 'Будівництво / ремонт', '25' ),
( '77', 'Інструменти', '25' ),
( '78', 'Кімнатні рослини', '25' ),
( '79', 'Посуд / кухонне приладдя', '25' ),
( '80', 'Садовий інвентар', '25' ),
( '81', 'Господарський інвентар ', '25' ),
( '82', 'Побутова хімія', '25' ),
( '83', 'Інші товари для дому', '25' ),
( '84', 'Телефони', '26' ),
( '85', 'Комп\'ютери', '26' ),
( '86', 'Фото / відео', '26' ),
( '87', 'Тв / відеотехніка', '26' ),
( '88', 'Аудіотехніка', '26' ),
( '89', 'Ігри та ігрові приставки', '26' ),
( '90', 'Техніка для дому', '26' ),
( '91', 'Техніка для кухні', '26' ),
( '92', 'Кліматичне обладнання', '26' ),
( '93', 'Індивідуальний догляд', '26' ),
( '94', 'Аксесуари й комплектуючі', '26' ),
( '95', 'Інша електроніка', '26' ),
( '96', 'Будівництво / ремонт / прибирання', '27' ),
( '97', 'Фінансові послуги / партнерство', '27' ),
( '98', 'Перевезення / оренда транспорту', '27' ),
( '99', 'Реклама / поліграфія / маркетинг / інтернет', '27' ),
( '100', 'Няні / доглядальниці', '27' ),
( '101', 'Сировина / матеріали', '27' ),
( '102', 'Краса / здоров\'я', '27' ),
( '103', 'Обладнання', '27' ),
( '104', 'Освіта / Спорт', '27' ),
( '105', 'Послуги для тварин', '27' ),
( '106', 'Продаж бізнесу', '27' ),
( '107', 'Розваги / Мистецтво / Фото / Відео', '27' ),
( '108', 'Туризм / іміграція', '27' ),
( '109', 'Послуги перекладачів / набір тексту', '27' ),
( '110', 'Авто / мото послуги', '27' ),
( '111', 'Обслуговування, ремонт техніки', '27' ),
( '112', 'Мережевий маркетинг', '27' ),
( '113', 'Юридичні послуги', '27' ),
( '114', 'Прокат товарів', '27' ),
( '115', 'Інші послуги', '27' ),
( '116', 'Одяг/взуття', '28' ),
( '117', 'Для весілля', '28' ),
( '118', 'Наручні годинники', '28' ),
( '119', 'Аксесуари', '28' ),
( '120', 'Подарунки', '28' ),
( '121', 'Краса / здоров\'я', '28' ),
( '122', 'Мода різне', '28' ),
( '123', 'Антикваріат / колекції', '29' ),
( '124', 'Музичні інструменти', '29' ),
( '125', 'Спорт / відпочинок', '29' ),
( '126', 'Спорт / відпочинок', '29' ),
( '127', 'CD / DVD / Платівки', '29' ),
( '128', 'Квитки', '29' ),
( '129', 'Пошук попутників', '29' ),
( '130', 'Пошук гуртів / музикантів', '29' ),
( '131', 'Інше', '29' ),
( '133', 'Паспорт', '34' ),
( '134', 'Права', '34' ),
( '135', 'Техпаспорт \\ Страховка', '34' ),
( '136', 'Посвідчення', '34' ),
( '137', 'Ділова документація \\ Договори', '34' ),
( '138', 'Пластикові картки', '34' ),
( '139', 'Інше', '34' ),
( '140', 'Сумки жіночі', '35' ),
( '141', 'Сумки багажні', '35' ),
( '142', 'Сумки спортивні', '35' ),
( '143', 'Гаманці', '35' ),
( '144', 'Портмоне', '35' ),
( '145', 'Барсетки', '35' ),
( '146', 'Окуляри', '36' ),
( '147', 'Браслети', '36' ),
( '148', 'Наручні годинники', '36' ),
( '149', 'Вироби з золота \\ срібла', '36' ),
( '150', 'Вироби з золота \\ срібла', '36' ),
( '151', 'Різне', '36' ),
( '152', 'Телефони', '37' ),
( '153', 'Планшети', '37' ),
( '154', 'Ноутбуки', '37' ),
( '155', 'Фотоапарати', '37' ),
( '156', 'Музикальні плеєри', '37' ),
( '157', 'Ігрові приставки', '37' ),
( '158', 'Аксесуари і комплектуючі', '37' ),
( '159', 'Інша електроніка', '37' ),
( '160', 'Ключі', '39' ),
( '161', 'Брилки', '39' ),
( '162', 'Різне', '39' ),
( '163', 'Оформлення документів', '47' ),
( '164', 'Консультації', '47' ),
( '165', 'Пошук роботи', '47' ),
( '166', 'Послуги транспортування', '47' ),
( '167', 'Допомога в лікуванні', '47' ),
( '168', 'Допомога потерпілим', '47' ),
( '169', 'Психологічна підтримка', '47' ),
( '170', 'Інше', '47' ),
( '171', 'Оформлення документів', '48' ),
( '172', 'Консультації', '48' ),
( '173', 'Пошук роботи', '48' ),
( '174', 'Послуги транспортування', '48' ),
( '175', 'Допомога в лікуванні', '48' ),
( '176', 'Допомога потерпілим', '48' ),
( '177', 'Психологічна підтримка', '48' ),
( '178', 'Інше', '48' );
-- ---------------------------------------------------------


-- Dump data of "advertisment_types" -----------------------
INSERT INTO `advertisment_types`(`id`,`title`,`slug`) VALUES 
( '1', 'Продам\\Куплю', 'trade' ),
( '2', 'Знайшов\\Загубив', 'found' ),
( '3', 'Віддам\\Потребую', 'gift' );
-- ---------------------------------------------------------


-- Dump data of "advertisments" ----------------------------
INSERT INTO `advertisments`(`id`,`category_id`,`sub_category_id`,`price_type_id`,`title`,`description`,`date`,`price`,`contact_person`,`email`,`telephone_number`,`skype`,`advertisment_on_main_page`,`advertisment_block`,`color_highlight`,`category_top`,`type_id`,`user_id`,`city`,`urgent`,`region_id`) VALUES 
( '147', '22', '26', '3', 'Оголошення 1', 'Дуже довгий опис для короткого оголошення, дуже... дуже довгий опис.....', '2015-10-18 16:59:30', '5000', 'Vlad wadawdawd', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '148', '20', '1', '1', 'Some', 'Some motherfucking description for sdsd wsdqd adawd awd awdawd awdawd adawd awdawdawd', '2015-10-19 02:23:07', '5000', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '149', '20', '1', '1', 'Title', 'Some fucking description for satisfy validation requirements....', '2015-10-25 13:44:28', '123456', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '150', '20', '1', '1', 'Qwewsdads', 'asdasd adasdas das asd asd asd asdwdaw daw dawd awd wd awd awdwadawdawd awd ad dawdaw dawd wa', '2015-10-25 13:46:36', '7412589', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '151', '20', '1', '1', 'qwsderffgfgfg', 'sczsczsczsczs d wd efew frfwef wfwef wfwe e fwef fwe fwefwefwe', '2015-10-25 13:47:23', '243434', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '152', '20', '1', '3', 'asdfdgdgsg', 'sdfsdfsd sffsefsefsef seffsefsef sefsefsefesfsef', '2015-10-25 13:48:28', '7878', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '153', '20', '1', '2', 'gyjtygjtyjtjt6frgeg', 'geg4g ege4ge4grggdrhgtdh grg ergegrege getge4ge4ge4g ege4g4ege4 ge4ge4ge4 eg', '2015-10-25 13:49:23', '345654645', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '154', '20', '1', '1', 'qaxsdsfe fsefesfsef sfsef', 'fesfesfesfsefsef awdaw awd awd daw dawd awd wadawd awdawdawd', '2015-10-25 13:52:59', '12345', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '155', '20', '1', '1', 'daeferferf efd wefwefwef', 'fwef wef wefwe wef wef wefwefwefwe wefwefwefwefwef', '2015-10-25 13:57:43', '34', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '156', '20', '1', '1', 'qwdwqdqw', 'qwdqdqwdqdw qwdqwd qwd qwd qwdqw dq wdqw qwdqw dqw qwdqw d qwdqw qwd qwd qdqw dqwererrv eferver', '2015-10-25 13:58:59', '123', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '157', '20', '1', '1', 'adawdawdawd', 'awdawd awd awdawd awd awd awd awd awd awd awdawdawrvrefwerfer wef we fwef wef wefwe fwe fwefwe awdawd awd awdawd awd awd awd awd awd awd awdawdawrvrefwerfer wef we fwef wef wefwe fwe fwefwe awdawd awd awdawd awd awd awd awd awd awd awdawdawrvrefwerfer wef we fwef wef wefwe fwe fwefwe awdawd awd awdawd awd awd awd awd awd awd awdawdawrvrefwerfer wef we fwef wef wefwe fwe fwefwe awdawd awd awdawd awd awd awd awd awd awd awdawdawrvrefwerfer wef we fwef wef wefwe fwe fwefwe', '2015-10-25 13:59:45', '121', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '158', '20', '1', '1', 'ge rg gtrghtrn tyhefwesc zsvawrgr', 'fweferg ergew gwrnh ryshtawgere waeat wsgaer gega w raw4tywj 5ye5 yaetwr aw4gegeg ae4w taw4gtaehrt srgdrgdbtnjsr j grgaegeraheh er  fweferg ergew gwrnh ryshtawgere waeat wsgaer gega w raw4tywj 5ye5 yaetwr aw4gegeg ae4w taw4gtaehrt srgdrgdbtnjsr j grgaegeraheh er  fweferg ergew gwrnh ryshtawgere waeat wsgaer gega w raw4tywj 5ye5 yaetwr aw4gegeg ae4w taw4gtaehrt srgdrgdbtnjsr j grgaegeraheh er  fweferg ergew gwrnh ryshtawgere waeat wsgaer gega w raw4tywj 5ye5 yaetwr aw4gegeg ae4w taw4gtaehrt srgdrgdbtnjsr j grgaegeraheh er  fweferg ergew gwrnh ryshtawgere waeat wsgaer gega w raw4tywj 5ye5 yaetwr aw4gegeg ae4w taw4gtaehrt srgdrgdbtnjsr j grgaegeraheh er  fweferg ergew gwrnh ryshtawgere waeat wsgaer gega w raw4tywj 5ye5 yaetwr aw4gegeg ae4w taw4gtaehrt srgdrgdbtnjsr j grgaegeraheh er', '2015-10-25 14:00:43', '8000', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '159', '20', '1', '1', 'awdawdaw awd ad awdawda', 'adaw awd awd awdawd awd awdawdawd awdadaw dawd awadawdawd awdw', '2015-10-25 14:20:05', '1223120', 'Vlad', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '160', '20', '1', '1', 'Some', 'daw awd awd awd awd awdawd awd awd awdaw daw daw daw daw daw daw dawd aw awd awdawd', '2015-10-26 20:35:54', '5115', 'Vlad', 'vladislav.kosko@gmail.com', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '3', NULL, NULL, '1' ),
( '161', '20', '1', '1', 'Some', 'Sd awda wdaw dawd awl kwhd jkanwd ,manw manwd ,awmd .naklf wj,efnjl mdfna,.dnawmd', '2015-10-26 20:39:32', '6454', 'Vlad', 'vladislav.kosko@gmail.com', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '3', NULL, NULL, '1' ),
( '162', '20', '1', '1', 'Solme', 'dda awddka ,jlwd,awd jljawd jlawd nawd awkldl jlnajnd jkla wdjlawjdn jkadj, awdj, awnj,d', '2015-10-26 20:44:20', '5646', 'Vlad', 'vladislav.kosko@gmail.com', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '3', NULL, NULL, '1' ),
( '163', '20', '1', '1', 'Some', 'wd wadnkawd,awdmawd awdawdaw aw awd awdawd awdawdaw dawdawdawdawdawdafawdawdawdawdaw awd aw aw awd', '2015-10-26 20:49:06', '121', 'dawdawdawd', 'riki34@spaces.ru', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '1', '1', NULL, NULL, '1' ),
( '165', '41', NULL, '1', 'Something special', 'Some shit for description shit', '2015-10-27 02:40:45', '454', 'Vlad', 'vladislav.kosko@gmail.com', 'Qwerty', 'vladislav.kosko', NULL, NULL, NULL, NULL, '3', '3', 'Korne', NULL, '1' ),
( '166', '41', NULL, '1', 'SOmething special for you', 'dawdawd awd awdaw da daw daw daw dawd aw daw daw awd aw awd awd awda', '2015-10-27 03:07:19', '515', 'Vlad', 'vladislav.kosko@gmail.com', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '3', '3', 'Qwerrtty', NULL, '1' ),
( '167', '20', '1', '1', 'awdopawdk', 'd lakwjd aw jdkaw dk;jaw ldakw ;ldawklawjkajw kdjakw ldjalk ajl kwd', '2015-10-27 03:11:48', '0', 'awdawdawdawd', 'vladislav.kosko@gmail.com', '+380978781424', 'dawdawd', NULL, NULL, NULL, NULL, '1', '3', 'awdawdawd', NULL, '7' ),
( '168', '34', '133', '1', 'SOmething else', 'daw daw dawd aw dawdawdawd a dawdaw daw aw daw aw d', '2015-10-27 03:17:07', '455', 'Vlad', 'vladislav.kosko@gmail.com', '+380978781424', 'vladislav.kosko', NULL, NULL, NULL, NULL, '2', '3', 'adwawd', NULL, '7' ),
( '169', '20', '1', '1', 'daw dawdaw adwd', ' awd adawd awd awd aw daw dawd aw daw daw daw awdawd aw dawd awdaw dawd awd', '2015-10-28 00:19:19', '0', 'dawdawd', 'awdawd', 'awdawda', 'awdawdaw', NULL, NULL, NULL, NULL, '1', '19', 'awdawd', NULL, '1' ),
( '170', '20', '1', '1', 'daw dawdaw adwd', ' awd adawd awd awd aw daw dawd aw daw daw daw awdawd aw dawd awdaw dawd awd', '2015-10-29 16:35:09', '0', 'ekjhfd.lke', 'vladsadaw@dwakwdj.com', '+380978781424', 'adwdawd', NULL, NULL, NULL, NULL, '1', '21', 'awdjhawdjkw', NULL, '1' );
-- ---------------------------------------------------------


-- Dump data of "attachments" ------------------------------
INSERT INTO `attachments`(`id`,`advertisment_id`,`image`) VALUES 
( '128', '147', 'uploads/147/1.jpg' ),
( '129', '147', 'uploads/147/2.jpg' ),
( '130', '147', 'uploads/147/3.jpg' ),
( '131', '147', 'uploads/147/4.jpg' ),
( '132', '147', 'uploads/147/5.jpg' ),
( '133', '148', 'uploads/148/1.jpg' ),
( '134', '148', 'uploads/148/2.jpg' ),
( '135', '148', 'uploads/148/3.jpg' ),
( '136', '148', 'uploads/148/4.jpg' ),
( '137', '148', 'uploads/148/5.jpg' ),
( '138', '149', 'uploads/149/1.jpg' ),
( '139', '150', 'uploads/150/1.jpg' ),
( '140', '151', 'uploads/151/1.jpg' ),
( '141', '152', 'uploads/152/1.jpg' ),
( '142', '153', 'uploads/153/1.jpg' ),
( '143', '154', 'uploads/154/1.jpg' ),
( '144', '155', 'uploads/155/1.jpg' ),
( '145', '156', 'uploads/156/1.jpg' ),
( '146', '157', 'uploads/157/1.jpg' ),
( '147', '158', 'uploads/158/1.jpg' ),
( '148', '159', 'uploads/159/1.jpg' ),
( '149', '160', 'uploads/160/1.jpg' ),
( '150', '161', 'uploads/161/1.jpg' ),
( '151', '162', 'uploads/162/1.jpg' ),
( '152', '163', 'uploads/163/1.jpg' ),
( '154', '165', 'uploads/165/1.jpg' ),
( '155', '166', 'uploads/166/1.jpg' ),
( '156', '167', 'uploads/167/1.jpg' ),
( '157', '167', 'uploads/167/2.jpg' ),
( '158', '168', 'uploads/168/1.jpg' ),
( '159', '169', 'uploads/169/1.jpg' ),
( '160', '170', 'uploads/170/1.jpg' );
-- ---------------------------------------------------------


-- Dump data of "back_link_pool" ---------------------------
INSERT INTO `back_link_pool`(`id`,`url`,`text`,`defaultLink`,`created`,`updated`) VALUES 
( '9', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', '0', '2015-07-31 09:02:17', '2015-07-31 09:02:17' ),
( '10', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', '0', '2015-07-31 09:02:54', '2015-07-31 09:02:54' ),
( '11', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', '0', '2015-07-31 09:04:59', '2015-07-31 09:20:45' ),
( '12', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', '0', '2015-07-31 09:05:34', '2015-08-24 08:42:26' ),
( '13', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', '0', '2015-07-31 09:05:39', '2015-07-31 09:05:39' );
-- ---------------------------------------------------------


-- Dump data of "back_links" -------------------------------
INSERT INTO `back_links`(`id`,`user_page_id`,`title`,`back_link_url`,`back_link_text`,`link_to_check`,`email`,`last_seen`,`created`,`updated`,`back_link_url2`,`back_link_text2`,`link_to_promote`,`admin_link`) VALUES 
( '1', '287', 'Link 1', 'http://eigenstart.nl', 'Free eigenstart', 'http://www.google.com/', 'paul_montecillo@yahoo.com', '2015-07-14 08:28:19', '2015-07-14 08:28:19', '2015-07-14 08:28:19', NULL, NULL, '', '0' ),
( '2', '287', 'TestlinkBram.com', 'http://eigenstart.nl', 'Free eigenstart', 'http://bram.com', 'ndssbeheer@gmail.com', '2015-07-14 14:51:49', '2015-07-14 14:51:49', '2015-07-14 14:51:49', NULL, NULL, '', '0' ),
( '3', '1', 'Mijn ZX Site', 'http://eigenstart.nl', 'Free eigenstart', 'http://kortingscodeland.nl', 'ndssbeheer@gmail.com', '2015-07-15 07:01:06', '2015-07-15 07:01:06', '2015-07-15 07:01:06', NULL, NULL, '', '0' ),
( '4', '285', 'Title', 'http://eigenstart.nl', 'Free eigenstart', 'http://some.tk', 'riki34@spaces.ru', '2015-07-15 08:24:26', '2015-07-15 08:24:26', '2015-07-15 08:24:26', NULL, NULL, '', '0' ),
( '5', '287', 'sdasdadasd', 'http://eigenstart.nl', 'Free eigenstart', 'http://google.pl', 'something@niepoda.pl', NULL, '2015-07-15 09:23:52', '2015-07-15 09:23:52', NULL, NULL, '', '0' ),
( '6', '3442', 'Thuis in Reeshof', 'http://tilburgreeshof.eigenstart.nl', 'Tilburgreeshof', 'http://glasvezelvergelijken.org/glavezelaanbieders', 'hggc@home.nl', NULL, '2015-08-24 20:17:18', '2015-08-24 20:17:18', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.tilburgreeshof.eigenstart.nl', '0' ),
( '7', '3177', 'Profijt Meubel Naaldwijk', 'http://denhaag.eigenpage.nl', 'Denhaag', 'http://nieuwbouwwoning.jouwpagina.nl/', 'thomasdejong24@gmail.com', NULL, '2015-08-25 08:01:52', '2015-08-25 08:01:52', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.profijtmeubel.nl/winkels/naaldwijk-profijt', '0' ),
( '8', '2308', 'Goedkope Meubels', 'http://johnpothuizen.eigenstart.nl', 'Johnpothuizen', 'http://nieuwbouwwoning.jouwpagina.nl/', 'thomasdejong24@gmail.com', NULL, '2015-08-25 08:05:53', '2015-08-25 08:05:53', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'http://www.profijtmeubel.nl/', '0' ),
( '9', '2187', 'Goedkope Meubels', 'http://marieke-place.eigenstart.nl', 'Marieke-place', 'http://nieuwbouwwoning.jouwpagina.nl/', 'thomasdejong24@gmail.com', NULL, '2015-08-25 08:11:54', '2015-08-25 08:11:54', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.profijtmeubel.nl/', '0' ),
( '10', '1731', 'Makelaar Roosendaal', 'http://woninginterieur.eigenstart.nl', 'Woninginterieur', 'http://bouwmaterialen.maakjestart.nl/', 'sanne.verdoeve@gmail.com', NULL, '2015-08-25 15:26:02', '2015-08-25 15:26:02', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.johanuwmakelaar.nl/', '0' ),
( '11', '2877', 'Afvallen Hulp Tips voor Gezond Afvallen', 'http://vermageren.eigenstart.be', 'Vermageren', 'http://www.afvallenhulp.eu/linkpartners', 'benjamin.reniers@telenet.be', NULL, '2015-08-25 15:33:45', '2015-08-25 15:33:45', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.afvallenhulp.eu/', '0' ),
( '12', '938', 'Alles over het spoor', 'http://lesidee.eigenstart.nl', 'Lesidee', 'http://www.allesoverhetspoor.nl', 'vanpolen@podium.nl', NULL, '2015-08-26 07:34:36', '2015-08-26 07:34:36', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.allesoverhetspoor.nl', '0' ),
( '13', '3453', 'Zoek op Nummer', 'http://oimgood.eigenstart.nl', 'Oimgood', 'http://www.nummerzoeker.com/', 'oimgood@gmail.com', NULL, '2015-08-26 11:40:56', '2015-08-26 11:40:56', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.nummerzoeker.com/', '0' ),
( '14', '207', 'Letselschade advocaat Groningen', 'http://oostgroningen.eigenstart.nl', 'Oostgroningen', 'http://www.letselpro.nl/links/', 'communicatie@letselpro.nl', NULL, '2015-08-26 11:58:42', '2015-08-26 11:58:42', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.letselpro.nl/letselschade-advocaat-groningen/', '0' ),
( '15', '2940', 'gsm nummer opzoeken', 'http://online-winkelen.eigenstart.be', 'Online-winkelen', 'http://gsm-nummer-opzoeken.com/', 'miasanchez616@outlook.com', NULL, '2015-08-26 16:23:11', '2015-08-26 16:23:11', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://gsm-nummer-opzoeken.com/', '0' ),
( '16', '1773', 'Natuurlijk Houten Vloeren', 'http://laminaat.eigenstart.nl', 'Laminaat', 'http://www.natuurlijk-hout.com/links', 'info@natuurlijk-hout.com', NULL, '2015-08-27 08:57:36', '2015-08-27 08:57:36', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.natuurlijk-hout.com/laminaat-vloeren', '0' ),
( '17', '2307', 'woonaccessoires-sale.nl', 'http://treza.eigenstart.nl', 'Treza', 'http://www.woonaccessoires-sale.nl/links', 'info@woonaccessoires-sale.nl', NULL, '2015-08-27 12:51:54', '2015-08-27 12:51:54', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.woonaccessoires-sale.nl', '0' ),
( '18', '1142', 'BiletBayi', 'http://alanya.eigenstart.nl', 'Alanya', 'http://www.biletbayi.com', 'irfanakmehmet@gmail.com', NULL, '2015-08-27 18:15:02', '2015-08-27 18:15:02', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.biletbayi.com', '0' ),
( '19', '3465', 'Energie vergelijken', 'http://opstal.eigenstart.nl', 'Opstal', 'http://allevergelijksites.nl/linkpartners/', 'laptoptechcenter@gmail.com', NULL, '2015-08-27 23:54:04', '2015-08-27 23:54:04', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://allevergelijksites.nl/energie-vergelijken/', '0' ),
( '20', '3471', 'Rabobank', 'http://wulms.eigenstart.nl', 'Wulms', 'http://wulms.eigenstart.nl', 'pfcwulms@ziggo.nl', NULL, '2015-08-29 18:03:51', '2015-08-29 18:03:51', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.rabobank.nl', '0' ),
( '21', '3471', 'glasvezelvergelijken', 'http://wulms.eigenstart.nl', 'Wulms', 'http://wulms.eigenstart.nl', 'pfcwulms@ziggo.nl', NULL, '2015-08-29 18:08:36', '2015-08-29 18:08:36', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://glasvezelvergelijken.org/">www.glasvezelvergelijken.org', '0' ),
( '22', '3471', 'Rabobank', 'http://wulms.eigenstart.nl', 'Wulms', 'http://wulms.eigenstart.nl', 'pfcwulms@ziggo.nl', NULL, '2015-08-29 18:10:53', '2015-08-29 18:10:53', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.rabobank.nl', '0' ),
( '23', '3471', 'Glasvezel', 'http://wulms.eigenstart.nl', 'Wulms', 'http://wulms.eigenstart.nl', 'pfcwulms@ziggo.nl', NULL, '2015-08-29 18:12:13', '2015-08-29 18:12:13', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://glasvezelvergelijken.org', '0' ),
( '24', '3471', 'wulms', 'http://wulms.eigenstart.nl', 'Wulms', 'http://wulms.eigenstart.nl', 'pfcwulms@ziggo.nl', NULL, '2015-08-29 18:24:34', '2015-08-29 18:24:34', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'http://wulms.eigenstart.nl', '0' ),
( '25', '1776', 'VaVlaggen reus, goedkopen vlaggen', 'http://reclame.eigenstart.nl', 'Reclame', 'http://www.vlaggenreus.nl/links', 'willem@clickbizz.nl', NULL, '2015-08-30 12:35:52', '2015-08-30 12:35:52', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.vlaggenreus.nl', '0' ),
( '26', '2909', 'Yoru no Hime', 'http://shibasites.eigenstart.be', 'Shibasites', 'http://www.estherwiersma.nl/estherwiersma.nl/Home.html', 'e.j.wiersma@gmail.com', NULL, '2015-08-30 19:30:33', '2015-08-30 19:30:33', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'http://www.estherwiersma.nl/estherwiersma.nl/Home.html', '0' ),
( '27', '2909', 'Yoru no Hime', 'http://shibasites.eigenstart.be', 'Shibasites', 'http://www.estherwiersma.nl/estherwiersma.nl/Home.html', 'e.j.wiersma@gmail.com', NULL, '2015-08-30 19:30:39', '2015-08-30 19:30:39', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'http://www.estherwiersma.nl/estherwiersma.nl/Home.html', '0' ),
( '28', '220', 'Campervanman', 'http://oldtimers.eigenstart.nl', 'Oldtimers', 'http://www.campervanman.co.uk/', 'timaldiss@gmail.com', NULL, '2015-08-30 20:56:37', '2015-08-30 20:56:37', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.campervanman.co.uk/', '0' ),
( '29', '220', 'VW LT', 'http://oldtimers.eigenstart.nl', 'Oldtimers', 'http://vwlt.co.uk/', 'tim.aldiss@thinksearch.co.uk', NULL, '2015-08-30 21:01:39', '2015-08-30 21:01:39', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://vwlt.co.uk/', '0' ),
( '30', '1085', 'Last-minute', 'http://vakantiewoning.eigenstart.nl', 'Vakantiewoning', 'http://www.hollandvakanties.nl/handige-links/vakantie.html', 'partners@roompot.nl', NULL, '2015-08-31 08:08:05', '2015-08-31 08:08:05', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.roompot.nl//vakantieparken/last-minute', '0' ),
( '31', '1544', 'Hulp bij je  Zwangerschap', 'http://mamma.eigenstart.nl', 'Mamma', 'http://hulp-bij-astma.nl/astma/links-op-hulp-bij-astma-linkpartners.php', 'info@hulp-bij-je-zwangerschap.nl', NULL, '2015-08-31 09:52:16', '2015-08-31 09:52:16', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://hulp-bij-je-zwangerschap.nl', '0' ),
( '32', '648', 'Nagelstudio Papendrecht', 'http://nagelstudio.eigenstart.nl', 'Nagelstudio', 'https://sites.google.com/a/nagelstudiopapendrecht.nl/nagelstudio-papendrecht/links', 'info@nagelstudiopapendrecht.nl', NULL, '2015-09-01 07:47:57', '2015-09-01 07:47:57', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'http://nagelstudiopapendrecht.nl', '0' ),
( '33', '1028', 'Onlineadministratiemkbutrecht.nl', 'http://030-debilt.eigenstart.nl', '030-debilt', 'http://www.wateenaccountantdoet.nl/overige-partners.html', 'oa-mkb@outlook.com', NULL, '2015-09-01 08:00:43', '2015-09-01 08:00:43', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.onlineadministratiemkbutrecht.nl', '0' ),
( '34', '1028', 'Onlineadministratiemkbutrecht.nl', 'http://030-debilt.eigenstart.nl', '030-debilt', 'http://www.wateenaccountantdoet.nl/overige-partners.html', 'oa-mkb@outlook.com', NULL, '2015-09-01 08:03:31', '2015-09-01 08:03:31', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.onlineadministratiemkbutrecht.nl', '0' ),
( '35', '220', 'Oldtimer Verzekering', 'http://oldtimers.eigenstart.nl', 'Oldtimers', 'http://www.oldtimer-verzekering.nl/over-ons/links', 'info@oldtimer-verzekering.nl', NULL, '2015-09-01 09:59:03', '2015-09-01 09:59:03', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.oldtimer-verzekering.nl', '0' ),
( '36', '220', 'Oldtimer Verzekering', 'http://oldtimers.eigenstart.nl', 'Oldtimers', 'http://www.oldtimer-verzekering.nl/over-ons/links', 'info@oldtimer-verzekering.nl', NULL, '2015-09-01 09:59:04', '2015-09-01 09:59:04', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.oldtimer-verzekering.nl', '0' ),
( '37', '220', 'Oldtimer Verzekering', 'http://oldtimers.eigenstart.nl', 'Oldtimers', 'http://www.oldtimer-verzekering.nl/over-ons/links', 'info@oldtimer-verzekering.nl', NULL, '2015-09-01 09:59:06', '2015-09-01 09:59:06', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.oldtimer-verzekering.nl', '0' ),
( '38', '220', 'Oldtimer Verzekering', 'http://oldtimers.eigenstart.nl', 'Oldtimers', 'http://www.oldtimer-verzekering.nl/over-ons/links', 'info@oldtimer-verzekering.nl', NULL, '2015-09-01 09:59:09', '2015-09-01 09:59:09', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.oldtimer-verzekering.nl', '0' ),
( '39', '1870', 'Oldtimer Verzekering', 'http://verzekeringen.eigenstart.nl', 'Verzekeringen', 'http://www.oldtimer-verzekering.nl/over-ons/links/', 'info@oldtimer-verzekering.nl', NULL, '2015-09-01 10:00:31', '2015-09-01 10:00:31', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.oldtimer-verzekering.nl/', '0' ),
( '40', '3471', 'Rabobank', 'http://wulms.eigenstart.nl', 'Wulms', 'http://wulms.eigenstart.nl', 'pfcwulms@ziggo.nl', NULL, '2015-09-01 14:21:29', '2015-09-01 14:21:29', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'http://www.rabobank.nl', '0' ),
( '41', '363', 'Barbecue Bestellen - Ideaal Catering', 'http://bbqbarbecue.eigenstart.nl', 'Bbqbarbecue', 'http://creampad.nl/partners/', 'joanna@t2r.nl', NULL, '2015-09-02 08:12:28', '2015-09-02 08:12:28', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://ideaalcatering.nl/barbecue-bestellen/', '0' ),
( '42', '2291', 'www.catalpatuinen.nl', 'http://vijftigplus.eigenstart.nl', 'Vijftigplus', 'http://www.gebobv.nl/link-partners', 'seo@onlinq.nl', NULL, '2015-09-02 08:59:26', '2015-09-02 08:59:26', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.catalpatuinen.nl', '0' ),
( '43', '1831', 'Bruijn Advies', 'http://administratie.eigenstart.nl', 'Administratie', 'http://www.bruijnadvies.nl/links', 'mikebruijn1@gmail.com', NULL, '2015-09-02 09:27:09', '2015-09-02 09:27:09', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.bruijnadvies.nl', '0' ),
( '44', '3484', 'RABO bank', 'http://prw.eigenstart.nl', 'Prw', 'http://prw.eigenstart.nl', 'p.r.weijmans@gmail.com', NULL, '2015-09-02 11:57:33', '2015-09-02 11:57:33', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'https://bankieren.rabobank.nl/klanten/?intcamp=pa-homepage-internetbankieren&inttype=tegel-internetbankieren&intsource=particulieren', '0' ),
( '45', '3484', 'NPO', 'http://prw.eigenstart.nl', 'Prw', 'http://prw.eigenstart.nl', 'p.r.weijmans@gmail.com', NULL, '2015-09-02 12:01:18', '2015-09-02 12:01:18', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.npo.nl/', '0' ),
( '46', '1027', 'Autorijschool in Haarlem', 'http://haarlem.eigenstart.nl', 'Haarlem', 'http://zelfwiiombouwen.net/linkpartners/', 'quinten@rubixmarketing.nl', NULL, '2015-09-02 13:48:01', '2015-09-02 13:48:01', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.rijschoolperfect.nl/', '0' ),
( '47', '2067', 'Infrarotheizungen', 'http://michel.eigenstart.nl', 'Michel', 'http://e-sparheizung.de/shop/partner', 'mail@tobias-loos.de', NULL, '2015-09-02 15:11:30', '2015-09-02 15:11:30', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'http://e-sparheizung.de', '0' ),
( '48', '3486', 'Loodgieter Delft', 'http://bedrijf.eigenstart.nl', 'Bedrijf', 'http://www.Loodgieter.frisbegin.nl', 'KevinRoburM@gmail.com', NULL, '2015-09-03 07:37:13', '2015-09-03 07:37:13', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.loodgieters-delft.nl/', '0' ),
( '49', '1716', 'Blanken Verhuizigen', 'http://verhuisbedrijf.eigenstart.nl', 'Verhuisbedrijf', 'http://www.blankenverhuizingen.nl/interessante-links', 'john@triplepro.nl', NULL, '2015-09-03 09:25:52', '2015-09-03 09:25:52', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.blankenverhuizingen.nl/verhuizen', '0' ),
( '50', '708', 'Rijschool purmerend', 'http://rijbewijspagina.eigenstart.nl', 'Rijbewijspagina', 'http://www.rijschoolbasmala.nl', 'etienne@rebelinternet.nl', NULL, '2015-09-03 12:22:55', '2015-09-03 12:22:55', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.rijschoolbasmala.nl', '0' ),
( '51', '3183', 'Patience', 'http://natasja.eigenpage.nl', 'Natasja', 'http://www.patiencespel.nl', 'info@patiencespel.nl', NULL, '2015-09-04 09:45:22', '2015-09-04 09:45:22', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.patiencespel.nl', '0' ),
( '52', '167', 'Patience', 'http://play.eigenstart.nl', 'Play', 'http://www.patiencespel.nl', 'info@patiencespel.nl', NULL, '2015-09-04 10:19:21', '2015-09-04 10:19:21', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.patiencespel.nl', '0' ),
( '53', '327', 'Patience', 'http://prijsvragen.eigenstart.nl', 'Prijsvragen', 'http://www.patiencespel.nl', 'info@patiencespel.nl', NULL, '2015-09-04 10:28:29', '2015-09-04 10:28:29', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.patiencespel.nl', '0' ),
( '54', '2061', 'Patience', 'http://sassefras.eigenstart.nl', 'Sassefras', 'http://www.patiencespel.nl', 'info@patiencespel.nl', NULL, '2015-09-04 11:20:42', '2015-09-04 11:20:42', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.patiencespel.nl', '0' ),
( '55', '2068', 'Patience', 'http://smaaksalon.eigenstart.nl', 'Smaaksalon', 'http://www.patiencespel.nl', 'info@patiencespel.nl', NULL, '2015-09-04 11:43:31', '2015-09-04 11:43:31', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.patiencespel.nl', '0' ),
( '56', '1964', 'Deskbookers.com', 'http://vergaderen.eigenstart.nl', 'Vergaderen', 'http://hotelstunt.nl/index.php/links/', 'b.willemse@deskbookers.com', NULL, '2015-09-04 13:26:13', '2015-09-04 13:26:13', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'https://www.deskbookers.com', '0' ),
( '57', '115', 'Patience', 'http://tommie.eigenstart.nl', 'Tommie', 'http://www.patiencespel.nl', 'info@patiencespel.nl', NULL, '2015-09-04 14:48:21', '2015-09-04 14:48:21', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.patiencespel.nl', '0' ),
( '58', '1511', 'Patience', 'http://wereldkinderen.eigenstart.nl', 'Wereldkinderen', 'http://www.patiencespel.nl', 'info@patiencespel.nl', NULL, '2015-09-04 15:17:25', '2015-09-04 15:17:25', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.patiencespel.nl', '0' ),
( '59', '3495', 'Telegraaf', 'http://hanu.eigenstart.nl', 'Hanu', 'http://hanu.eigenstart.nl', 'vu.son@hotmail.com', NULL, '2015-09-04 22:54:01', '2015-09-04 22:54:01', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.telegraaf.nl', '0' ),
( '60', '1291', 'Goedkoopparkerenschiphol', 'http://reistips.eigenstart.nl', 'Reistips', 'http://www.vakantie-tours.nl/bekijk-ook-eens/', 'info@goedkoopparkerenschiphol.eu', NULL, '2015-09-05 07:54:09', '2015-09-05 07:54:09', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.goedkoopparkerenschiphol.eu', '0' ),
( '61', '1711', 'Dorma deurdranger', 'http://wonen.eigenstart.nl', 'Wonen', 'http://www.hetbouwplein.nl/linkpartners.html', 'lisa.market@outlook.com', NULL, '2015-09-07 07:42:28', '2015-09-07 07:42:28', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.market.nl/dorma-deurdrangers.html', '0' ),
( '62', '3259', 'Patience', 'http://spellenhut.eigenpage.nl', 'Spellenhut', 'http://www.patiencespel.nl', 'info@patiencespel.nl', NULL, '2015-09-07 11:55:38', '2015-09-07 11:55:38', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.patiencespel.nl', '0' ),
( '63', '2003', 'Patience', 'http://sylviasplekkie.eigenstart.nl', 'Sylviasplekkie', 'http://www.patiencespel.nl', 'info@patiencespel.nl', NULL, '2015-09-07 12:56:50', '2015-09-07 12:56:50', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.patiencespel.nl', '0' ),
( '64', '1944', 'ZoGedrukt', 'http://linkpaginas.eigenstart.nl', 'Linkpaginas', 'https://www.zogedrukt.nl/', 'k.zwiep@zogedrukt.nl', NULL, '2015-09-08 08:40:35', '2015-09-08 08:40:35', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'https://www.zogedrukt.nl/', '0' ),
( '65', '2585', 'Transurgent', 'http://truckerroos.eigenstart.nl', 'Truckerroos', 'http://www.transurgent.com/links', 'f.betlem@bta-international.com', NULL, '2015-09-08 08:54:27', '2015-09-08 08:54:27', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.transurgent.com', '0' ),
( '66', '3516', 'Luxury Jewelry Online', 'http://jewelryonline.eigenstart.nl', 'Jewelryonline', 'http://www.fortrove.com/', 'sanahamilton24@gmail.com', NULL, '2015-09-08 20:53:11', '2015-09-08 20:53:11', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'http://www.fortrove.com/', '0' ),
( '67', '1747', 'Zwembad onderhoud', 'http://tuinen.eigenstart.nl', 'Tuinen', 'http://www.nederlandverzorgd.nl/linkpartners/', 'k.aarts@scherponline.nl', NULL, '2015-09-09 08:24:22', '2015-09-09 08:24:22', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.zwembadplein.nl/zwembad-onderhoud/', '0' ),
( '68', '1714', 'Houten vloer Zwolle', 'http://woontip.eigenstart.nl', 'Woontip', 'http://www.houtenvloerspecialist.nl/interessante-links', 'john@triplepro.nl', NULL, '2015-09-09 08:36:30', '2015-09-09 08:36:30', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.houtenvloerspecialist.nl/plaatsen/houten-vloeren-zwolle', '0' ),
( '69', '929', 'Woordzoeker Maken', 'http://deboog4en5.eigenstart.nl', 'Deboog4en5', 'http://www.woordzoekermaken.nl', 'info@woordzoekermaken.nl', NULL, '2015-09-09 10:18:00', '2015-09-09 10:18:00', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.woordzoekermaken.nl', '0' ),
( '70', '1551', 'Woordzoeker Maken', 'http://algemenelinks.eigenstart.nl', 'Algemenelinks', 'http://www.woordzoekermaken.nl', 'info@woordzoekermaken.nl', NULL, '2015-09-09 15:10:21', '2015-09-09 15:10:21', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.woordzoekermaken.nl', '0' ),
( '71', '1655', 'Woordzoeker Maken', 'http://bridgen.eigenstart.nl', 'Bridgen', 'http://www.woordzoekermaken.nl', 'info@woordzoekermaken.nl', NULL, '2015-09-09 19:28:41', '2015-09-09 19:28:41', 'http://glasvezelvergelijken.org/', 'www.glasvezelvergelijken.org', 'http://www.woordzoekermaken.nl', '0' ),
( '72', '613', 'T shirt ontwerpen', 'http://t-shirt.eigenstart.nl', 'T-shirt', 'http://www.shirtlezen.nl/over-ons/', 'info@shirtlezen.nl', NULL, '2015-09-09 19:43:25', '2015-09-09 19:43:25', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.shirtlezen.nl', '0' ),
( '73', '2291', 'Snel geld lenen', 'http://vijftigplus.eigenstart.nl', 'Vijftigplus', 'http://rossels.favos.nl/', 'grandfameltd@gmail.com', NULL, '2015-09-09 22:47:18', '2015-09-09 22:47:18', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://geldlenenperdirect.nl', '0' ),
( '74', '2291', 'Snel geld lenen', 'http://vijftigplus.eigenstart.nl', 'Vijftigplus', 'http://rossels.favos.nl', 'grandfameltd@gmail.com', NULL, '2015-09-09 23:00:48', '2015-09-09 23:00:48', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://geldlenenperdirect.nl', '0' ),
( '75', '432', 'Software Technische Dienst', 'http://link-partner.eigenstart.nl', 'Link-partner', 'http://www.mcmain.nl/nl/links', 'pr@gildemaintenance.nl', NULL, '2015-09-10 11:39:29', '2015-09-10 11:39:29', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'http://www.mcmain.nl/nl/td', '0' ),
( '76', '2835', 'Woordzoeker Maken', 'http://romy.eigenpage.nl', 'Romy', 'http://www.woordzoekermaken.nl', 'info@woordzoekermaken.nl', NULL, '2015-09-10 12:15:18', '2015-09-10 12:15:18', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.woordzoekermaken.nl', '0' ),
( '77', '250', 'Woordzoeker Maken', 'http://debeste.eigenstart.nl', 'Debeste', 'http://www.woordzoekermaken.nl', 'info@woordzoekermaken.nl', NULL, '2015-09-10 14:07:34', '2015-09-10 14:07:34', 'http://glasvezelvergelijken.org/', 'glasvezel op glasvezelvergelijken.org', 'http://www.woordzoekermaken.nl', '0' ),
( '78', '2229', 'Woordzoeker Maken', 'http://djadille.eigenstart.nl', 'Djadille', 'http://www.woordzoekermaken.nl', 'info@woordzoekermaken.nl', NULL, '2015-09-10 14:23:09', '2015-09-10 14:23:09', 'http://glasvezelvergelijken.org/', 'glasvezel aanbieders', 'http://www.woordzoekermaken.nl', '0' ),
( '79', '325', 'Sneakerzoeker', 'http://sneakers-online.eigenstart.nl', 'Sneakers-online', 'http://www.sneakerzoeker.nl', 'vasco@jikko.nl', NULL, '2015-09-12 10:57:25', '2015-09-12 10:57:25', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'http://www.sneakerzoeker.nl', '0' ),
( '80', '708', 'Rijschool Amersfoort', 'http://rijbewijspagina.eigenstart.nl', 'Rijbewijspagina', 'http://www.200pk.nl', 'bram@rebelinternet.nl', NULL, '2015-09-14 10:02:45', '2015-09-14 10:02:45', 'http://glasvezelvergelijken.org/', 'glasvezel internet?', 'http://www.200pk.nl', '0' ),
( '81', '1703', 'Naambordjeswinkel', 'http://huisnummer.eigenstart.nl', 'Huisnummer', 'https://www.naambordjeswinkel.nl/links', 'bvvught87@hotmail.com', NULL, '2015-09-14 11:52:10', '2015-09-14 11:52:10', 'http://glasvezelvergelijken.org/', 'glasvezelvergelijken.org', 'https://www.naambordjeswinkel.nl/', '0' );
-- ---------------------------------------------------------


-- Dump data of "category" ---------------------------------
INSERT INTO `category`(`id`,`name`,`slug`,`description`,`keywords`,`created`,`updated`) VALUES 
( '3', 'Entertainment', 'entertainment', 'MobileMobileMobileMobileMobileMobileMobileMobileMobileMobileMobileMobileMobileMobileMobileMobileMobileMobile', 'Mobile', '2015-06-24 06:24:27', '2015-08-24 16:50:51' ),
( '4', 'Education', 'education', 'De categorie ‘educatie’ bevat vele dochterpagina\'s met onderwerpen die gerelateerd zijn aan opleiding, onderwijs, opvoeding en andere onderwerpen rondom educatie. Een schat aan informatie voor iedereen die geïnteresseerd is in één van deze onderwerpen.', 'Education', '2015-06-24 06:26:18', '2015-08-25 06:51:12' ),
( '5', 'Computer', 'computer', 'Het woord computer is de afgelopen jaren een steeds groter begrip geworden. Daarom hebben wij deze categorie ingedeeld in dochterpagina’s, denk bijvoorbeeld aan het besturingssysteem, software en hardware. Zo kan iedereen vinden waar het naar op zoek is.', 'Computer', '2015-06-24 06:26:42', '2015-08-25 06:52:27' ),
( '6', 'Regional', 'regional', 'Op de categoriepagina van ‘regionaal’ vind je feiten en nieuws over jouw regio. Klik op één van de sub pagina’s om jouw regio te vinden. Zo blijf je op de hoogte van alles wat gaande is in en rondom jouw regio.', 'Regional', '2015-06-24 06:27:28', '2015-08-25 06:53:15' ),
( '7', 'Health', 'health', 'Een gezond leven hangt van veel verschillende factoren af. Om het makkelijker te
maken hebben we alle onderwerpen in sub pagina’s gedeeld. Op deze manier kun je 
makkelijker vinden wat je zoekt én blijf je op de hoogte van de medische wereld.', 'health', '2015-06-24 06:28:12', '2015-08-19 09:33:05' ),
( '8', 'Travel', 'travel', 'Van Afrika tot in Amerika. Er zijn veel verschillende manieren om de wereld te
ontdekken. De categorie ‘reizen’ brengt je op de hoogte van verschillende aspecten 
omtrent reizen, denk aan reisinformatie per land, de goedkoopste vluchten en 
reistips.', 'Travel', '2015-06-24 06:28:41', '2015-08-19 09:33:35' ),
( '10', 'Society', 'society', 'Gezondheid en belastingen. Eigenlijk hebben maar weinig onderwerpen geen betrekking op de maatschappij. Daarom maken we gebruik van categoriepagina’s, zoals de overheid, gezondheid, cultuur en nog veel meer.', 'Society', '2015-06-24 06:31:52', '2015-08-25 06:56:44' ),
( '11', 'Life', 'life', 'De diversiteit van ons leven maakt ons bestaan leuk en interessant. Wat verstaan we onder leven? Je leest het in de categorie ‘leven’. Deze categorie is ingedeeld in verschillende dochterpagina’s, denk aan opvoeding, kinderen en ouder worden.', 'Life', '2015-06-24 06:32:20', '2015-08-25 06:57:27' ),
( '12', 'Sport', 'sport', 'Ben je geïnteresseerd in voetbal of tennis? Of toch liever hockey? Op deze pagina vind je werkelijk waar alles over sport, zodat je niks hoeft te missen. De sub pagina’s zijn per sport ingedeeld.', 'Sport', '2015-06-24 06:32:38', '2015-08-25 06:57:56' ),
( '13', 'Lifestyle', 'lifestyle', 'Hoe ziet jouw levensstijl eruit? Misschien ben je een fanatieke sporter of volg je de laatste mode. Iedereen is verschillend en leidt een ander leven. Daarom maken we gebruik van verschillende dochterpagina’s, denk aan een gezond eten, sporten en de laatste kledingmode.', 'Lifestyle', '2015-06-24 06:33:02', '2015-08-25 06:58:39' ),
( '14', 'Science', 'science', 'De wetenschap ontdekt iedere dag weer iets nieuws. Op deze categoriepagina vertellen we je alles over de wetenschap. De sub onderwerpen waar je aan moet denken zijn: wetenschap over sport, het menselijk lichaam of de laatste technologie.', 'Science', '2015-06-24 06:33:31', '2015-08-25 07:02:33' ),
( '15', 'Mobile', 'mobile', 'Mobiliteit Mobiliteit Mobiliteit Mobiliteit Mobiliteit Mobiliteit Mobiliteit Mobiliteit Mobiliteit Mobiliteit', 'Mobile', '2015-06-24 06:33:55', '2015-06-24 06:33:55' ),
( '16', 'Music', 'music', 'Muziek geeft ons leven iets extra’s. Dagelijks zijn we er mee bezig. De categorie ‘muziek’ kunnen we verder opdelen in rock, pop of elektronische muziek.', 'Music', '2015-06-24 06:37:50', '2015-08-05 15:26:08' ),
( '17', 'Nature', 'nature', 'In de categorie ‘natuur’ vertellen we wat de wereld allemaal te bieden heeft én hoe we beter voor moeder natuur kunnen zorgen. Je kunt onder andere de volgende onderwerpen verwachten: de verwarming van de aarde, vulkanen en duurzaamheid.', 'Nature', '2015-06-24 06:39:20', '2015-08-25 07:04:16' ),
( '18', 'News', 'news', 'Dagelijks gebeuren er noemenswaardig dingen. In de categorie ‘nieuws’ vind je de docherpagina’s algemeen, technologie, sport en nog veel meer.', 'News', '2015-06-24 06:40:52', '2015-08-05 15:29:40' ),
( '19', 'Personal', 'personal', 'Carrière maken of een vervolgstap kiezen naar de middelbare school? In de categorie persoonlijk vind je informatie die er voor jou toe doet. Zo bespreken we de onderwerpen zoals persoonlijke groei of hoe je je leven weer op de rit krijgt.', 'Personal', '2015-06-24 06:41:26', '2015-08-25 07:05:40' ),
( '20', 'Art', 'art', 'Geïnteresseerd in kunst? Dan bevind je op de juiste pagina. Er vallen verschillende sub onderwerpen onder de noemer kunst, denk aan beeldkunst, muzikale kunst of dansen.', 'art', '2015-08-05 15:33:29', '2015-08-25 06:55:52' );
-- ---------------------------------------------------------


-- Dump data of "conversations" ----------------------------
INSERT INTO `conversations`(`id`,`user1_id`,`user2_id`,`advertisment_id`,`last_updated`) VALUES 
( '6', '20', '1', '147', '2015-10-29 12:48:27' ),
( '7', '1', '19', '169', '2015-10-29 12:48:49' );
-- ---------------------------------------------------------


-- Dump data of "error_logs" -------------------------------
INSERT INTO `error_logs`(`id`,`message`,`date`,`where_error`,`from_error`) VALUES 
( '1', 'Notice: Undefined property: stdClass::$telephoneNumber', '2015-04-12 14:36:03', 'File: /opt/lampp/htdocs/naidusvoe/src/NaidusvoeBundle/Entity/User.php, Line: 230', 'Class: User, function: changeSmsNotificationsSettings' ),
( '2', 'Notice: Undefined property: stdClass::$telephoneNumber', '2015-04-12 14:45:12', 'File: /opt/lampp/htdocs/naidusvoe/src/NaidusvoeBundle/Entity/User.php, Line: 230', 'Class: User, function: changeSmsNotificationsSettings' ),
( '3', 'Notice: Undefined property: stdClass::$telephoneNumber', '2015-04-12 14:45:28', 'File: /opt/lampp/htdocs/naidusvoe/src/NaidusvoeBundle/Entity/User.php, Line: 230', 'Class: User, function: changeSmsNotificationsSettings' ),
( '4', 'Notice: Undefined property: stdClass::$telephoneNumber', '2015-04-12 14:46:57', 'File: /opt/lampp/htdocs/naidusvoe/src/NaidusvoeBundle/Entity/User.php, Line: 230', 'Class: User, function: changeSmsNotificationsSettings' ),
( '5', 'An exception occurred while executing \'UPDATE users SET email = ? WHERE id = ?\' with params ["vladislav.kosko@gmail.com", 1]:

SQLSTATE[23000]: Integrity constraint violation: 1062 Duplicate entry \'vladislav.kosko@gmail.com\' for key \'UNIQ_1483A5E9E7927C74\'', '2015-04-16 14:26:31', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'Class: User, function: changeEmail' ),
( '6', 'An exception occurred while executing \'UPDATE users SET email = ? WHERE id = ?\' with params ["vladislav.kosko@gmail.com", 1]:

SQLSTATE[23000]: Integrity constraint violation: 1062 Duplicate entry \'vladislav.kosko@gmail.com\' for key \'UNIQ_1483A5E9E7927C74\'', '2015-04-16 14:26:49', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'Class: User, function: changeEmail' ),
( '7', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 1, 0, "2015-04-20 21:48:11", ""]:

SQLSTATE[42S22]: Column not found: 1054 Unknown column \'posted\' in \'field list\'', '2015-04-20 21:48:11', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '8', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '9', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '10', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '11', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '12', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '13', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '14', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '15', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '16', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '17', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '18', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '19', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '20', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '21', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '22', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '23', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '24', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '25', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '26', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '27', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '28', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '29', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '30', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '31', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '32', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '33', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '34', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '35', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '36', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '37', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '38', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '39', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '40', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '41', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '42', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '43', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '44', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '45', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '46', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '47', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '48', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '49', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '50', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '51', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '52', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '53', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '54', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '55', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '56', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '57', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '58', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '59', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '60', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '61', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '62', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '63', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '64', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '65', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '66', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '67', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '68', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '69', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '70', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '71', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '72', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '73', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '74', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '75', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '76', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '77', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '78', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '79', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '80', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '81', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '82', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '83', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '84', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '85', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '86', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '87', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '88', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '89', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '90', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '91', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '92', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '93', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '94', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '95', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '96', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '97', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '98', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '99', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '100', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '101', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '102', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '103', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '104', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '105', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '106', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '107', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '108', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' ),
( '109', 'An exception occurred while executing \'INSERT INTO messages (user_id, conversation_id, viewed, posted, message) VALUES (?, ?, ?, ?, ?)\' with params [1, 2, 0, "2015-04-21 02:04:55", null]:

SQLSTATE[23000]: Integrity constraint violation: 1048 Column \'message\' cannot be null', '2015-04-21 02:04:55', 'File: /opt/lampp/htdocs/naidusvoe/vendor/doctrine/dbal/lib/Doctrine/DBAL/DBALException.php, Line: 91', 'class: Message, function: addNewMessage' );
-- ---------------------------------------------------------


-- Dump data of "ext_log_entries" --------------------------
-- ---------------------------------------------------------


-- Dump data of "ext_translations" -------------------------
-- ---------------------------------------------------------


-- Dump data of "faq" --------------------------------------
INSERT INTO `faq`(`id`,`question`,`answer`,`created`,`updated`) VALUES 
( '1', 'Ik wil een pagina starten', 'Kijk ten eerst of de pagina nog vrij is door de te zoeken op de Alle Dochters pagina. Zo ja, dan kun je beginnnen! Registeer op de voorpagina je domein en start met het vullen van je pagina met content.
Zodra jje 25 links hebt toegevoegd, zal je pagina online komen te staan.', '2015-07-16 16:02:39', '2015-07-16 16:02:39' ),
( '2', 'Ik wil geen reclame op mijn pagina', 'Je kunt de reclame op je webpagina afkopen. Dit kun je doen door je e-wallet te vullen met credits. Hiervoor bel je in met een 0900 nummer die vervolgens je account vult met credits. Zodoende kun je vervolgens in de administratie klikken op reclameopties en vervolgens de reclame naar wens verwijderen. Vergeet niet de wijzigingen op te slaan voordat de reclame daadwerkelijk is verdwenen van je pagina.', '2015-07-16 16:02:53', '2015-07-16 16:02:53' ),
( '3', 'Ik wil graag contact met de webmaster', 'Als geen van bovenstaande oplossingen voor jou werkt, kun je contact opnemen met de webmaster via ons contactformulier. Let wel, de webmaster beantwoord geen vragen die met bovenstaande oplossingen kan worden opgelost. Dus lees eerst goed onze helpfile door voordat je besluit contact op te nemen met de webmaster. Vanwege de grote hoeveelheid reacties per email zijn wij genoodzaakt een selectie te maken tussen de meest urgente zaken. Bedankt voor uw begrip.', '2015-07-16 16:03:05', '2015-07-16 16:03:05' ),
( '4', 'Ik wil mijn pagina opzeggen', 'Als je besluit te stoppen en je wilt je links niet meer beschikbaar stellen voor publiek, kun je de pagina verwijderen door ons een mailtje te sturen via het contactfomulier, me daarin het e-mailadres en de naam van je pagina. <br>', '2015-07-16 16:03:17', '2015-08-25 10:54:53' );
-- ---------------------------------------------------------


-- Dump data of "favorites" --------------------------------
INSERT INTO `favorites`(`id`,`user_id`,`advertisment_id`) VALUES 
( '4', '1', '147' ),
( '5', '1', '169' );
-- ---------------------------------------------------------


-- Dump data of "languages" --------------------------------
INSERT INTO `languages`(`id`,`title`) VALUES 
( '1', 'ua' ),
( '2', 'ru' );
-- ---------------------------------------------------------


-- Dump data of "link" -------------------------------------
INSERT INTO `link`(`id`,`user_page_id`,`url`,`text`,`type`,`file`,`icon`,`show_till`,`active`,`created`,`token`,`updated`,`email`,`period`,`category_id`) VALUES 
( '48', '286', 'http://testbram.nl', 'Testlink', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-28', '1', '2015-07-28 13:00:26', '1438088426xeq0v32x3iufx36s0l1dlktm', '2015-07-28 13:00:58', 'bram@rebelinternet.nl', '1', '1' ),
( '49', '286', 'http://schipholparkerenvergelijken.nl', 'Lang Parkeren Schiphol', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-07-30', '0', '2015-07-31 08:44:21', '14383322610j5woanbils6xr2n29qak1ym5gchb', '2015-07-31 08:44:21', 'Etienne@rebelinternet.nl', '1', '1' ),
( '50', '2723', 'http://tweakers.net/', 'tweakers', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-07-30', '0', '2015-07-31 09:56:06', '1438336566jpy26snob2zjq1slr4ki1r6bao5', '2015-07-31 09:56:06', 'siki@chello.nl', '1', '1' ),
( '51', '286', 'http://hostingwalk.com', 'Hostingwalk', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-02', '0', '2015-08-03 07:59:39', '1438588779up9uqdjzo7dlu1p0rqiuevtfe77k', '2015-08-03 07:59:39', 'sales@hostingwalk.com', '1', '1' ),
( '52', '2773', 'https://www.drupal.org', 'Drupal.org', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-02', '0', '2015-08-03 07:59:55', '14385887958r8z47g73fm3sml6gocipz5lpvw8', '2015-08-03 07:59:55', 'gcm.boogaarts@upcmail.nl', '1', '1' ),
( '53', '1898', 'http://www.abonnementkeuze.com', 'Abonnement vergelijken', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-02', '0', '2015-08-03 14:31:41', '143861230172w66p8no4ii5wj8m4zmtf', '2015-08-03 14:31:41', 'henkboersema87@gmail.com', '1', '1' ),
( '54', '286', 'http://bbahd.nl/', 'Bed&Breakfast Heilige Duif', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-05', '0', '2015-08-06 13:07:45', '1438866465ffoedx5ljvrl6bwhibh9y4faiwvq', '2015-08-06 13:07:45', 'info@mijngastouderopvang.nl', '1', '1' ),
( '55', '433', 'http://www.in-stranica.com/', 'inStranica', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-05', '0', '2015-08-06 17:08:51', '1438880931f0k9h9ejjznzpx4e2kbe7j5ej8h18', '2015-08-06 17:08:51', 'info@in-stranica.com', '1', '1' ),
( '56', '286', 'http://www.ekogoed.nl', 'ekogoed.nl biologische winkel online met biologische producten', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-10', '0', '2015-08-11 08:17:17', '1439281037bi0v5lkm5erc8jwf6m3r96xcrwc', '2015-08-11 08:17:17', 'info@ekogoed.nl', '1', '1' ),
( '57', '286', 'http://wadawd.com', 'some text', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-10', '0', '2015-08-11 14:41:29', '14393040895vtpp4y95m4wyata8w17', '2015-08-11 14:41:29', 'vladislav.kosko@gmail.com', '1', '1' ),
( '58', '286', 'https://leerlingen.altenacollege.nl/login?path=%2FPortaal%2FLeerlingportaal', 'school', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-10', '0', '2015-08-11 17:37:58', '1439314678jgb2c5lki1az7lg1ikms0', '2015-08-11 17:37:58', 'freekjanvernhout@gmail.com', '1', '1' ),
( '59', '286', 'http://test.nl', 'ALLE ONLINE SHOPS', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-17', '0', '2015-08-18 15:15:55', '1439910955n37bkpr4k0e6b6ehpyl5n66nmn', '2015-08-18 15:15:55', 'administratie@rebelinternet.nl', '1', '1' ),
( '60', '286', 'http://glasvezelvergelijken.org/', 'Glasvezel vergelijken', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-19', '0', '2015-08-20 14:15:45', '1440080145lqxnvrkdmovr5qo62614vk7kcom', '2015-08-20 14:15:45', 'Etienne@rebelinternet.nl', '12', '1' ),
( '61', '286', 'http://some-new.url', 'qwerty', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-20', '0', '2015-08-21 20:20:09', '1440188409hx2cqh128jod40dokl1gc6id', '2015-08-21 20:20:09', 'vladislav.kosko@gmail.com', '1', '1' ),
( '62', '286', 'http://some-new.url', 'qwerty', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-20', '0', '2015-08-21 20:22:10', '144018853035c20v9udx7q6ykzm2nul8ixiz', '2015-08-21 20:22:10', 'vladislav.kosko@gmail.com', '1', '1' ),
( '63', '286', 'http://some-new.url', 'qwerty', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-20', '0', '2015-08-21 20:23:52', '1440188632to8p0x23ntc02r3b4guwbr', '2015-08-21 20:23:52', 'vladislav.kosko@gmail.com', '1', '1' ),
( '64', '286', 'http://riki34.spaces.ru', 'riki34', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-24', '0', '2015-08-25 11:53:07', '1440503587l21bjpdng0bs834o7smem5', '2015-08-25 11:53:07', 'vladislav.kosko@gmail.com', '1', '1' ),
( '65', '286', 'http://www.24wijn.com', 'Grootste aanbod  wijnen online in één overzicht. Altijd de beste aanbiedingen.  Je hoeft niet alle websites te doorzoeken, wij hebben het complete aanbod voor u samengebracht op 24wijn.com   Samengevat: •	Gebruikersvriendelijke website; •	Grootste online ', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-26', '0', '2015-08-27 05:25:44', '1440653144kp358bz90b59kscrislz00', '2015-08-27 05:25:44', 'judith@twnty4.nl', '12', '10' ),
( '66', '286', 'http://www.frescobobo.nl', 'www.frescobobo.nl', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-08-26', '0', '2015-08-27 17:52:39', '1440697959he58m8fe6us16phliqbmi', '2015-08-27 17:52:39', 'alexutugrasutu@yahoo.com', '1', '9' ),
( '67', '286', 'http://www.kortingscode-zoeken.nl', 'Kortingscodes voor jou', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-10-01', '1', '2015-08-31 13:34:24', '1441028064y6w1k4crj1bl8f1qmbdoaqjk4y', '2015-08-31 13:34:55', 'henkboersema87@gmail.com', '1', '10' ),
( '68', '286', 'http://www.abonnementkeuze.com', 'Mobiel abonnement vergelijken', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-10-01', '1', '2015-08-31 13:35:58', '1441028158zvqe3ddl72kzsuoquxvfrg7xycr', '2015-08-31 13:36:38', 'henkboersema87@gmail.com', '1', '6' ),
( '69', '1511', 'http://www.patiencespel.nl', 'Patience', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-09-03', '0', '2015-09-04 15:17:10', '1441379830k8byu9dx5axjat8df3pvwm6', '2015-09-04 15:17:10', 'info@patiencespel.nl', '12', NULL ),
( '70', '286', 'http://etasdf.com', 'adsf', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-09-07', '0', '2015-09-08 09:07:53', '14417032737pr0p3yzrfbefp221hupfyci', '2015-09-08 09:07:53', 'adsfji@adsjfi.nl', '1', '10' ),
( '71', '286', 'http://geldlenenperdirect.nl', 'Snel geld lenen', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-09-08', '0', '2015-09-09 22:56:26', '1441839386o2nwsiegz782pruc9vfs1md7pmc', '2015-09-09 22:56:26', 'grandfameltd@gmail.com', '12', '4' ),
( '72', '432', 'http://www.mcmain.nl/td', 'Software Technische Dienst', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-09-09', '0', '2015-09-10 11:40:35', '1441885235ziexdm76yq87r1ttu8lovryos9e', '2015-09-10 11:40:35', 'pr@gildemaintenance.nl', '12', NULL ),
( '73', '432', 'http://www.mcmain.nl/td', 'Software Technische Dienst', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-09-09', '0', '2015-09-10 11:40:39', '1441885239jdj4tf59jrpi273ckyxajt5a4ho', '2015-09-10 11:40:39', 'pr@gildemaintenance.nl', '12', NULL ),
( '74', '286', 'http://ddsfdf.nl', 'dfsdf', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-09-11', '0', '2015-09-12 12:54:36', '1442062476wy6s1cv1lk9nh0ub6biz3ogt', '2015-09-12 12:54:36', 'dsad@sds.nl', '12', '10' ),
( '75', '286', 'http://taxiutrecht-24.nl/', 'Taxi Utrecht', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-09-13', '0', '2015-09-14 10:35:41', '14422269410pq6umq8h1xzaaoo37srvedf20', '2015-09-14 10:35:41', 'admin@taxiutrecht-24.nl', '12', '9' ),
( '76', '286', 'http://taxiutrecht-24.nl/', 'Taxi Utrecht', '1', NULL, 'glyphicon glyphicon-asterisk', '2015-09-13', '0', '2015-09-14 10:36:13', '1442226973hyfkntxwx5ar6aj7qifj4xklf', '2015-09-14 10:36:13', 'admin@taxiutrecht-24.nl', '1', '9' );
-- ---------------------------------------------------------


-- Dump data of "messages" ---------------------------------
INSERT INTO `messages`(`id`,`user_id`,`conversation_id`,`message`,`viewed`,`posted`) VALUES 
( '16', '20', '6', 'qwerty lol?', '1', '2015-10-28 05:46:10' ),
( '17', '1', '6', 'Lol qwerty!', '1', '2015-10-28 05:46:25' ),
( '18', '20', '6', 'What is lol?', '1', '2015-10-28 05:57:22' ),
( '19', '20', '6', 'What is lol?', '1', '2015-10-28 05:57:22' ),
( '20', '1', '6', 'Don\'t be lol bitch!', '1', '2015-10-28 05:57:45' ),
( '21', '20', '6', 'Why I should not be lol?', '1', '2015-10-28 05:58:15' ),
( '22', '1', '6', 'Because Saimon Said!!!', '1', '2015-10-28 05:58:33' ),
( '23', '20', '6', 'Dou you know Saimon?', '1', '2015-10-28 05:59:06' ),
( '24', '1', '6', 'Yes I know Saimon.', '1', '2015-10-28 06:02:07' ),
( '25', '20', '6', 'And who is it?', '1', '2015-10-28 06:02:29' ),
( '26', '1', '6', 'This is not your business bitch!', '0', '2015-10-28 06:02:52' ),
( '27', '1', '6', 'dawdawd', '0', '2015-10-29 12:48:27' ),
( '28', '1', '7', 'ddadw', '0', '2015-10-29 12:48:49' );
-- ---------------------------------------------------------


-- Dump data of "page_recover" -----------------------------
INSERT INTO `page_recover`(`id`,`title`,`url`,`email`,`created`,`updated`,`recovered`,`can_recover`,`snapshot`) VALUES 
( '1', 'Amsterdam Start', 'http://amsterdam-start.eigenstart.nl/', 'mode@start-pagina.info', '2015-08-17 02:18:50', '2015-08-23 10:37:51', '1', '1', NULL ),
( '2', 'rverlijsdonk', 'http://rverlijsdonk.eigenstart.nl', 'rm.verlijsdonk@gmail.com', '2015-08-17 07:15:16', '2015-08-23 10:37:51', '1', '1', NULL ),
( '3', 'hier', 'http://hier.mijnzooi.nl', 'a.k@live.nl', '2015-08-17 07:22:36', '2015-08-23 10:37:51', '1', '1', NULL ),
( '4', 'rosie', 'http://rosie.eigenstart.nl', 'rm.verlijsdonk@gmail.com', '2015-08-17 07:25:01', '2015-08-23 10:37:51', '0', '0', NULL ),
( '5', 'Anna ICT, Werk, Wifi...', 'http://www.anna.eigenstart.nl/', 'a.m.litjens@tue.nl', '2015-08-17 07:25:44', '2015-08-23 10:37:51', '1', '1', NULL ),
( '6', 'Nouja', 'http://nouja.eigenstart.nl', 'reisje1988@hotmail.com', '2015-08-17 08:14:54', '2015-08-23 10:37:51', '1', '1', NULL ),
( '7', 'Wies', 'http://wies.eigenstart.nl', 'w.beljaars@janvanbrabant.nl', '2015-08-17 08:15:48', '2015-08-23 10:37:51', '0', '0', NULL ),
( '8', 'test bram', 'http://test.eigenstart.nl', 'asfji@ad.nl', '2015-08-17 08:55:10', '2015-08-23 10:37:51', '0', '0', NULL ),
( '9', 'www.jvr.eigenstart.nl', 'http://www.jvr.eigenstart.nl', 'jackvrooij@gmail.com', '2015-08-17 09:01:25', '2015-08-23 10:37:51', '0', '0', NULL ),
( '10', 'xxxjoellee', 'http://xxxjoellee.eigenstart.nl', 'joelle.kelderman@live.nl', '2015-08-17 09:02:08', '2015-08-23 10:37:51', '0', '0', NULL ),
( '11', 'boogaarts.eigenoverzicht.nl', 'http://boogaarts.eigenoverzicht.nl', 'gcm.boogaarts@upcmail.nl', '2015-08-17 09:05:47', '2015-08-23 10:39:42', '1', '1', NULL ),
( '12', 'janw startpagina', 'htpp://www.janw.eigenstart.nl', 'janweijtens@hotmail.nl', '2015-08-17 09:16:02', '2015-08-23 10:39:42', '0', '0', NULL ),
( '13', 'Verzoek tot recover pagina', 'http://linders.bedrijfspagina.ws', 'info@lindersadvies.nl', '2015-08-17 09:42:13', '2015-08-23 10:39:42', '0', '0', NULL ),
( '14', 'Jokes142', 'http://jokes142.eigenstart.nl/', 'edwin352@tele2.nl', '2015-08-17 09:49:15', '2015-08-23 10:39:42', '0', '0', NULL ),
( '15', 'Jokes142', 'http://jokes142.eigenstart.nl/', 'edwin352@tele2.nl', '2015-08-17 09:49:16', '2015-08-23 10:39:42', '0', '0', NULL ),
( '16', 'daaniejelles.eigenstart.nl', 'http://daaniejelles.eigenstart.nl', 'daaniejelle@gmail.com', '2015-08-17 09:57:07', '2015-08-23 10:39:42', '0', '0', NULL ),
( '17', 'Jeevee', 'http://jmmverheijen.eigenstart.nl', 'jmm.verheijen@planet.nl', '2015-08-17 10:20:09', '2015-08-23 10:39:42', '1', '1', NULL ),
( '18', 'Jeevee', 'http://www.jmmverheijen.eigenstart.nl', 'jmm.verheijen@planet.nl', '2015-08-17 10:20:48', '2015-08-23 10:41:38', '0', '0', NULL ),
( '19', 'Crodino\'s persoonlijke links', 'http://crodino.eigenstart.nl', 'crodino@hotmail.com', '2015-08-17 10:29:21', '2015-08-23 10:39:42', '1', '1', NULL ),
( '20', 'bmw-gps', 'http://bmw-gps.eigenstart.nl', 'h.vollenbroek@gmail.com', '2015-08-17 10:36:36', '2015-08-23 10:39:42', '1', '1', NULL ),
( '21', 'classic eigenstart', 'http://classic.eigenstart.nl/', 'webmastersupport@live.nl', '2015-08-17 10:39:00', '2015-08-23 10:41:38', '1', '1', NULL ),
( '22', 'kloontjeleo', 'http://kloontjeleo.eigenstart.nl', 'kloontjeleo@hotmail.com', '2015-08-17 10:51:07', '2015-08-23 10:41:38', '1', '1', NULL ),
( '23', 'ger.eigenstart.nl', 'http://ger.eigenstart.nl', 'mail@gersnijders.nl', '2015-08-17 10:51:42', '2015-08-23 10:41:38', '1', '1', NULL ),
( '24', 'Molino', 'http://www.bagijnhofeigenstart.nl', 'leoniepostelmans@ziggo.nl', '2015-08-17 11:06:08', '2015-08-23 10:41:38', '0', '0', NULL ),
( '25', 'cash', 'http://cash.eigenoverzicht.nl', 'victoreltoro@hotmail.com', '2015-08-17 11:28:54', '2015-08-23 10:41:38', '1', '1', NULL ),
( '26', 'zwiesereijn130509', 'http://zwiesereijn130509.eigenstart.nl', 'marianne_johan@outlook.com', '2015-08-17 11:31:41', '2015-08-23 11:06:55', '0', '0', NULL ),
( '27', 'ronangel', 'http://ronangel.eigenoverzicht.nl/', 'a.verharen@gmail.com', '2015-08-17 11:32:50', '2015-08-23 10:41:38', '1', '1', NULL ),
( '28', 'www.terwoert.eigenstart.nl', 'http://www.terwoert.eigenstart.nl', 'info@terwoer.nl', '2015-08-17 11:34:33', '2015-08-23 10:41:38', '0', '0', NULL ),
( '29', 'www.sylvia.eigenstart.nl', 'http://www.sylvia.eigenstart.nl', 'info@terwoert.nl', '2015-08-17 11:35:04', '2015-08-23 10:41:38', '0', '0', NULL ),
( '30', 'www.sylviaatwork.eigenstart.nl', 'http://www.sylviaatwork.eigenstart.nl', 'info@terwoert.nl', '2015-08-17 11:35:28', '2015-08-23 10:43:38', '1', '1', NULL ),
( '31', 'Heuvelsland', 'http://www.heuvelsland.eigenstart.nl', 'anja@heuvelsland.eu', '2015-08-17 12:20:37', '2015-08-23 10:43:38', '1', '1', NULL ),
( '32', 'rico74', 'http://rico74.eigenstart.nl/', 'rico74@gmx.net', '2015-08-17 12:39:55', '2015-08-23 10:43:38', '1', '1', NULL ),
( '33', 'thijs10092001', 'http://www.thijs10092001.eigenstart.nl', 'toetenbinkie@live.nl', '2015-08-17 12:53:43', '2015-08-23 10:43:38', '0', '0', NULL ),
( '34', 'Links Ferry van Spanje Tools, Utilities, Computers, Handigheidjes, Interessant, Links', 'http://ferry.eigenstart.nl', 'fvspanje@xs4all.nl', '2015-08-17 12:55:07', '2015-08-23 10:43:38', '0', '0', NULL ),
( '35', 'duizendpoot', 'http://www.duizendpoot.eigenstart.nl/', 'spriensma92@gmail.com', '2015-08-17 13:04:12', '2015-08-23 10:43:38', '1', '1', NULL ),
( '36', 'Kruijdenberg eigenstart', 'http://kruijdenberg.eigenstart.nl/', 'j.kruijdenberg@gmail.com', '2015-08-17 13:08:55', '2015-08-23 10:43:38', '1', '1', NULL ),
( '37', 'jave.eigenstart', 'http://jave.eigenstart.nl', 'vernhout@solcon.nl', '2015-08-17 13:58:38', '2015-08-23 10:43:38', '1', '1', NULL ),
( '38', 'zuijlenspage', 'http://zuijlenspage.eigenstart.nl/', 'martinvanzuijlen@hetnet.nl', '2015-08-17 14:03:56', '2015-08-23 10:43:38', '0', '0', NULL ),
( '39', 'jeroenwouter.eigenstart.nl', 'http://www.jeroenwouter.eigenstart.nl', 'j.w.vlist@ziggo.nl', '2015-08-17 14:29:18', '2015-08-23 10:45:50', '1', '1', NULL ),
( '40', 'wimvanegmond eigenoverzicht', 'http://www.wimvanegmond.eigenoverzicht.nl', 'wimvanegmond@gmail.com', '2015-08-17 14:30:39', '2015-08-23 10:45:50', '1', '1', NULL ),
( '41', 'kees.eigenstart.nl', 'http://keees.eigenstart.nl', 'brilmode@xs4all.nl', '2015-08-17 15:00:05', '2015-08-23 10:45:50', '1', '1', NULL ),
( '42', 'janv', 'http://www.janv.eigenstart.nl', 'jan@janenkim.nl', '2015-08-17 16:16:05', '2015-08-23 10:45:50', '0', '0', NULL ),
( '43', 'Globetrotter\'s homepage', 'http://globetrotter.eigenstart.nl', 'smits188@zonnet.nl', '2015-08-17 16:23:46', '2015-08-23 10:45:50', '1', '1', NULL ),
( '44', 'richard-yvonne', 'http://richard-yvonne.eigenoverzicht.nl', 'rpoeser@hotmail.com', '2015-08-17 16:36:17', '2015-08-23 10:45:50', '0', '0', NULL ),
( '45', 'Haarlem en meer', 'http://www.gkoops.eigenstart.nl', 'koops.g@gmail.com', '2015-08-17 17:06:49', '2015-08-23 10:45:50', '1', '1', NULL ),
( '46', 'hannie.eigenstart', 'http://hannie.eigenstart.nl/', 'hanniehokke@gmail.com', '2015-08-17 17:16:17', '2015-08-23 10:45:50', '1', '1', NULL ),
( '47', 'jmmverheijen', 'http://www.jmmverheijen.eigenstart.nl', 'jmm.verheijen@planet.nl', '2015-08-17 17:18:13', '2015-08-23 10:41:38', '0', '0', NULL ),
( '48', 'Welkom op de eigenstart.nl, tweets.eigenstart.nl', 'http://tweets.eigenstart.nl', 'r.tuithof@quicknet.nl', '2015-08-17 17:19:55', '2015-08-23 10:45:50', '1', '1', NULL ),
( '49', 'rallymedia', 'http://rallymedia.eigenstart.nl', 'martijn_schouten84@hotmail.com', '2015-08-17 17:33:28', '2015-08-23 10:47:27', '1', '1', NULL ),
( '50', 'corbalk', 'http://corbalk.eigenstart.nl/', 'corbalk@quicknet.nl', '2015-08-17 17:44:26', '2015-08-23 10:47:27', '1', '1', NULL ),
( '51', 'franka.eigenstart.nl', 'https://franka.eigenstart.nl', 'l.cruijsen@gmail.com', '2015-08-17 17:46:30', '2015-08-23 10:47:27', '1', '1', NULL ),
( '52', 'hokke.eigenstart.nl', 'http://hokke.eigenstart.nl/', 'ghokke@gmail.com', '2015-08-17 17:50:11', '2015-08-23 10:47:27', '1', '1', NULL ),
( '53', 'edithlaurette', 'http://edithlaurette.eigenstart.nl', 'edithdemeij@gmail.com', '2015-08-17 18:07:22', '2015-08-23 10:47:27', '0', '0', NULL ),
( '54', 'plexat4', 'http://plexat4.eigenstart.nl', 'plexat4@hotmail.com', '2015-08-17 18:07:53', '2015-08-23 10:47:27', '1', '1', NULL ),
( '55', 'hkif', 'http://hkif.eigenstart.nl', 'plexat4@hotmail.com', '2015-08-17 18:12:40', '2015-08-23 10:47:27', '0', '0', NULL ),
( '56', 'Taco Hoekstra', 'http://hoekstra.eigenstart.nl', 'taco.hoekstra@hetnet.nl', '2015-08-17 18:29:34', '2015-08-23 10:47:27', '1', '1', NULL ),
( '57', 'runherd', 'http://www.runherd.eigenstart.nl/', 'jrunherd@hetnet.nl', '2015-08-17 19:03:59', '2015-08-23 10:47:27', '1', '1', NULL ),
( '58', 'Yoast\'s links', 'http://yoast.eigenstart.nl', 'joost@nicasie.nl', '2015-08-17 19:08:20', '2015-08-23 10:49:24', '1', '1', NULL ),
( '59', 'dtab52', 'http://dtab52.eigenstart.nl', 'dtab52@hotmail.com', '2015-08-17 20:00:01', '2015-08-23 10:49:24', '1', '1', NULL ),
( '60', 'rowdy', 'http://rowdy.eigenstart.nl', 'rwkarssen@hotmail.com', '2015-08-17 20:00:30', '2015-08-23 10:49:24', '0', '0', NULL ),
( '61', 'jobsam.mijnzooi', 'http://jobsam.mijnzooi.nl/', 'erikhaasnoot@quicknet.nl', '2015-08-17 20:11:55', '2015-08-23 10:49:24', '0', '0', NULL ),
( '62', 'frankvanm', 'htttp://frankvanm.eigenpage.nl', 'fvanmtec@versatel.nl', '2015-08-17 20:15:08', '2015-08-23 10:49:24', '0', '0', NULL ),
( '63', 'sisaO', 'http://sisao.eigenstart.nl', 'sisao_nl@hotmail.com', '2015-08-17 20:58:51', '2015-08-23 10:49:24', '0', '0', NULL ),
( '64', 'Schade', 'http://schade.eigenstart.be', 'chris.cloetens@telenet.be', '2015-08-17 21:11:31', '2015-08-23 10:49:24', '1', '1', NULL ),
( '65', 'Chrizz', 'http://chrizz.eigenstart.nl', 'chris.cloetens@telenet.be', '2015-08-17 21:15:30', '2015-08-23 10:49:24', '1', '1', NULL ),
( '66', 'Schade', 'http://schade.eigenstart.be', 'chris.cloetens@telenet.be', '2015-08-17 21:16:38', '2015-08-23 10:49:24', '1', '1', NULL ),
( '67', 'wilfred.eigenstart.nl', 'http://wilfred.eigenstart.nl', 'wfberkhof@gmail.com', '2015-08-17 21:18:01', '2015-08-23 10:51:23', '0', '0', NULL ),
( '68', 'alleskits', 'http://alleskits.eigenstart.nl', 'kittypeters@gmail.com', '2015-08-17 22:43:40', '2015-08-23 10:51:23', '0', '0', NULL ),
( '69', 'onlinewinkels', 'http://onlinewinkels.eigenoverzicht.nl', 'c.vanschijndel@lijbrandt.nl', '2015-08-18 03:21:17', '2015-08-23 10:51:23', '1', '1', NULL ),
( '70', 'ceasar', 'http://ceasar.eigenstart.nl', 'ceasar343@hotmail.com', '2015-08-18 05:57:00', '2015-08-23 10:51:23', '0', '0', NULL ),
( '71', 'uitzend-bureau', 'http://uitzend-bureau.eigenstart.be/', 'sjans121@hotmail.com', '2015-08-18 06:49:08', '2015-08-23 10:51:23', '1', '1', NULL ),
( '72', 'jans', 'http://jans.eigenstart.nl/', 'sjans121@hotmail.com', '2015-08-18 06:51:13', '2015-08-23 10:51:23', '1', '1', NULL ),
( '73', 'nieuwspagina', 'http://nieuwspagina.eigenstart.be', 'sjans121@hotmail.com', '2015-08-18 06:57:01', '2015-08-23 10:51:23', '1', '1', NULL ),
( '74', 'nieuwspagina', 'http://nieuwspagina.eigenstart.be', 'sjans121@hotmail.com', '2015-08-18 06:57:41', '2015-08-23 10:51:23', '1', '1', NULL ),
( '75', 'koken', 'http://koken.eigenstart.be/', 'sjans121@hotmail.com', '2015-08-18 06:58:01', '2015-08-23 10:51:23', '1', '1', NULL ),
( '76', 'shopping', 'http://shopping.eigenstart.be/', 'sjans121@hotmail.com', '2015-08-18 06:58:58', '2015-08-23 10:53:20', '1', '1', NULL ),
( '77', 'sport-site', 'http://sport-site.eigenstart.be', 'sjans121@hotmail.com', '2015-08-18 07:00:59', '2015-08-23 10:53:20', '1', '1', NULL ),
( '78', 'afklmarketing', 'http://afklmarketing.eigenoverzicht.nl/', 'maaike@exposures.nl', '2015-08-18 07:15:32', '2015-08-23 10:53:20', '1', '1', NULL ),
( '79', 'Exposures favorites', 'http://maaike.eigenpage.nl/', 'maaike@exposures.nl', '2015-08-18 07:16:44', '2015-08-23 10:53:20', '1', '1', NULL ),
( '80', 'vipboxradio', 'http://www.vipboxradio.eigenstart.nl', 'mirror353@hotmail.com', '2015-08-18 07:26:45', '2015-08-23 10:53:20', '0', '0', NULL ),
( '81', 'lening', 'http://lening.eigenstart.nl', '2linkbe@planet.nl', '2015-08-18 07:31:25', '2015-08-23 10:53:20', '1', '1', NULL ),
( '82', 'lloret-de-mar', 'http://lloret-de-mar.eigenstart.nl', '2linkbe@planet.nl', '2015-08-18 07:32:06', '2015-08-23 10:53:20', '1', '1', NULL ),
( '83', 'lloret', 'http://lloret.eigenstart.nl', '2linkbe@planet.nl', '2015-08-18 07:32:29', '2015-08-23 10:53:20', '1', '1', NULL ),
( '84', 'disneyland', 'http://disneyland.eigenstart.nl', '2linkbe@planet.nl', '2015-08-18 07:32:51', '2015-08-23 10:53:20', '1', '1', NULL ),
( '85', 'daaniejelles links', 'http://daaniejelles.eigenstart.nl', 'daaniejelle@gmail.com', '2015-08-18 08:03:43', '2015-08-23 10:39:42', '0', '0', NULL ),
( '86', 'alex', 'http://alex.eigenstart.nl', 'a.helmonds@home.nl', '2015-08-18 08:20:53', '2015-08-23 10:59:38', '1', '1', NULL ),
( '87', 'mysterious ways', 'http://mysteriousways.eigenstart.nl', 'alex65nl@ziggo.nl', '2015-08-18 08:21:28', '2015-08-23 10:59:38', '0', '0', NULL ),
( '88', 'Bedrijflinks', 'http://www.bedrijflinks.eigenpage.nl', 'josmaneschijn@gmail.com', '2015-08-18 08:55:49', '2015-08-23 10:59:38', '0', '0', NULL ),
( '89', 'www.jvr.eigenstart.nl', 'http://www.jvr.eigenstart.nl', 'jackvrooij@gmail.com', '2015-08-18 09:01:42', '2015-08-23 10:37:51', '0', '0', NULL ),
( '90', 'doppie.eigenpage.nl', 'http://www.doppie.eigenpage.nl/', 'hawimacode@hotmail.com', '2015-08-18 09:02:05', '2015-08-23 10:59:38', '0', '0', NULL ),
( '91', 'Cadeautip.eigenoverzicht.nl', 'http://cadeautip.eigenoverzicht.nl', 'wensley@adw-internetmarketing.nl', '2015-08-18 09:30:32', '2015-08-23 10:59:38', '0', '0', NULL ),
( '92', 'Cadeau-online.eigenstart.nl', 'http://cadeau-online.eigenstart.nl', 'wensley@adw-internetmarketing.nl', '2015-08-18 09:31:44', '2015-08-23 10:59:38', '1', '1', NULL ),
( '93', 'weet ik niet meer', 'htttp://www.gezina.eigenstart.nl', 'gezinaterpstra@gmail.com', '2015-08-18 10:02:15', '2015-08-23 10:59:38', '0', '0', NULL ),
( '94', 'bigkingxxl', 'http://www.bigkingxxl.eigenstart.nl/', 'maw62@hotmail.com', '2015-08-18 10:30:48', '2015-08-23 10:59:38', '1', '1', NULL ),
( '95', 'Angelique', 'http://angelique.eigenstart.nl', 'angelique.o@home.nl', '2015-08-18 10:35:33', '2015-08-23 10:59:38', '1', '1', NULL ),
( '96', 'vieuxrose', 'http://vieuxrose.eigenstart.nl', 'anemoon5@gmail.com', '2015-08-18 10:43:22', '2015-08-23 11:01:36', '0', '0', NULL ),
( '97', 'anemoon', 'http://anemoon.eigenstart.nl', 'anemoon5@gmail.com', '2015-08-18 10:44:35', '2015-08-23 11:01:36', '1', '1', NULL ),
( '98', 'Mebs', 'http://mebs.eigenstart.nl', 'esther.b.s@gmail.com', '2015-08-18 10:49:56', '2015-08-23 11:01:36', '1', '1', NULL ),
( '99', 'zandbergen.eigenstart.nl', 'http://zandbergen.eigenstart.nl', 'theo620@gmail.com', '2015-08-18 10:50:10', '2015-08-23 11:01:36', '1', '1', NULL ),
( '100', 'www.jvr.eigenstart.nl', 'http://www.jvr.eigenstart.nl', 'jackvrooij@gmail.com', '2015-08-18 11:09:01', '2015-08-23 10:37:51', '0', '0', NULL ),
( '101', 'ronangel', 'http://ronangel.eigenoverzicht.nl/', 'angel4everlove@hotmail.com', '2015-08-18 11:09:21', '2015-08-23 10:41:38', '1', '1', NULL ),
( '102', '?? anna eigenstart?', 'http://www.anna.eigenstart.nl/', 'anneke.litjens@gmail.com', '2015-08-18 11:35:47', '2015-08-23 10:37:51', '1', '1', NULL ),
( '103', 'bekijk', 'http://bekijk.eigenstart.nl/', 'jollyjumperholland@gmail.com', '2015-08-18 12:24:45', '2015-08-23 11:01:36', '0', '0', NULL ),
( '104', 'jaap', 'http://www.jaap.mijnzooi.nl/', 'jvandrongelen@gmail.com', '2015-08-18 12:25:47', '2015-08-23 11:01:36', '1', '1', NULL ),
( '105', 'rien', 'http://www.renee.eigestart.nl', 'rdappers@caiway.nl', '2015-08-18 12:44:24', '2015-08-23 11:01:36', '0', '0', NULL ),
( '106', 'beni67', 'http://beni67.eigenpage.nl', 'beni67@gmail.com', '2015-08-18 13:34:44', '2015-08-23 11:01:36', '1', '1', NULL ),
( '107', 'Lique', 'http://lique.eigenstart.nl/', 'info@lique66.nl', '2015-08-18 14:14:26', '2015-08-23 11:01:36', '0', '0', NULL ),
( '108', 'Haarlem, e.o. en meer', 'http://www.gkoops.eigenstart.nl', 'koops.g@gmail.com', '2015-08-18 14:20:52', '2015-08-23 10:45:50', '1', '1', NULL ),
( '109', 'Sandra', 'http://sandra.eigenoverzicht.nl/', 'scmanche@gmail.com', '2015-08-18 14:23:00', '2015-08-23 11:04:32', '1', '1', NULL ),
( '110', 'vieuxrose', 'http://vieuxrose.eigenstart.nl', 'anemoon5@planet.nl', '2015-08-18 14:37:59', '2015-08-23 11:01:36', '0', '0', NULL ),
( '111', 'anemoon', 'http://anemoon.eigenstart.nl', 'anemoon5@planet.nl', '2015-08-18 14:38:35', '2015-08-23 11:01:36', '1', '1', NULL ),
( '112', 'slot', 'http://slot.eigenstart.nl', 'hugovanderslot@online.nl', '2015-08-18 14:38:48', '2015-08-23 11:04:32', '1', '1', NULL ),
( '113', 'wil.eigenstart', 'http://www.wil.eigenstart.nl', 'w.haarman@gmail.com', '2015-08-18 15:03:38', '2015-08-23 11:04:32', '0', '0', NULL ),
( '114', 'Wolfertisk', 'http://www.wolfertisk.eigenstart.nl', 'msc@wolfert.nl', '2015-08-18 15:20:10', '2015-08-23 11:04:32', '0', '0', NULL ),
( '115', 'Fasteagle', 'http://fasteagle.eigenstart.nl', 'eagle2512@gmail.com', '2015-08-18 16:28:48', '2015-08-23 11:06:55', '1', '1', NULL ),
( '116', 'mijnfavo', 'http://mijnfavo.eigenstart.nl/', 'bepnet55@zeelandnet.nl', '2015-08-18 17:22:14', '2015-08-23 11:04:32', '1', '1', NULL ),
( '117', 'Startpagina van Robin, Miriam & Arnold', 'http://www.karibu.eigenpage.nl/', 'telecel@tiscalimail.nl', '2015-08-18 17:27:41', '2015-08-23 11:04:32', '1', '1', NULL ),
( '118', 'remcostaps.mijnzooi.nl', 'http://http:www.remcostaps.mijnzooi.nl', 'r.staps@home.nl', '2015-08-18 18:25:29', '2015-08-23 11:04:32', '0', '0', NULL ),
( '119', 'remcostaps.mijnzooi.nl', 'http://http:www.remcostaps.mijnzooi.nl', 'r.staps@home.nl', '2015-08-18 18:25:32', '2015-08-23 11:04:32', '0', '0', NULL ),
( '120', 'remcostaps.mijnzooi.nl', 'http://remcostaps.mijnzooi.nl', 'r.staps@home.nl', '2015-08-18 18:26:38', '2015-08-23 11:06:55', '1', '1', NULL ),
( '121', 'leon.eigenstart.nl', 'http://eigenstart.nl/user/user_page/preview/3280', 'leoncruijsen@gmail.com', '2015-08-18 18:43:02', '2015-08-18 18:43:02', '1', '1', NULL ),
( '122', 'BMadW', 'http://bmadw.eigenstart.nl/', 'bmadw@hotmail.com', '2015-08-18 19:58:42', '2015-08-23 11:06:55', '1', '1', NULL ),
( '123', 'bmn', 'http://bmn.eigenstart.nl', 'bmares72@gmail.com', '2015-08-18 20:22:23', '2015-08-23 11:06:55', '1', '1', NULL ),
( '124', 'Runherd', 'http://runherd.eigenstart.nl/', 'jrunherd@hetnet.nl', '2015-08-18 20:51:15', '2015-08-23 11:06:55', '1', '1', NULL ),
( '125', 'Bonebakker Startpagina', 'http://bonebakker.eigenstart.nl', 'christiaan@tuxtown.net', '2015-08-18 21:18:46', '2015-08-23 11:06:55', '0', '0', NULL ),
( '126', 'Bonebakker Startpagina', 'http://bonebakker.eigenstart.nl', 'christiaan@tuxtown.net', '2015-08-18 21:27:16', '2015-08-23 11:06:55', '0', '0', NULL ),
( '127', 'gouniversity', 'http://www.gouniversity.coolstart.nl', 'growthsystems@live.com', '2015-08-18 21:32:00', '2015-08-23 11:06:55', '0', '0', NULL ),
( '128', 'Chr. Ger. Kerken.', 'http://?', 'pnbosveenendaal@online.nl', '2015-08-19 05:13:39', '2015-08-19 05:13:39', '0', '0', NULL ),
( '129', 'Museumkwartier.nl', 'http://www.museumkwartier.nl/', 'jennifer@museumkwartier.nl', '2015-08-19 07:15:42', '2015-08-23 11:09:25', '1', '1', NULL ),
( '130', 'keees.eigenstartpagina.nl', 'http://keees.eigenstartpagina.nl', 'brilmode@xs4all.nl', '2015-08-19 07:38:19', '2015-08-23 11:09:25', '0', '0', NULL ),
( '131', 'Buurman', 'http://www.buurman.eigenstart.nl/', 'buurman.ep@gmail.com', '2015-08-19 08:53:44', '2015-08-23 11:09:25', '1', '1', NULL ),
( '132', 'philippo', 'http://www.philippo.eigenstart.nl', 'djp.philippo@gmail.com', '2015-08-19 09:12:56', '2015-08-23 11:09:25', '1', '1', NULL ),
( '133', 'mijnzooitje', 'htto://www.mijnzooitje.mijnzooi.nl', 'weer@casema.nl', '2015-08-19 09:24:32', '2015-08-23 11:09:25', '0', '0', NULL ),
( '134', 'wil.eigenstart', 'http://www.wil.eigenstart.nl', 'w.haarman@hotmail.com', '2015-08-19 09:27:05', '2015-08-23 11:04:32', '0', '0', NULL ),
( '135', 'MajdoulineXh', 'http://www.majdouline.eigenstart.nl', 'm.hamdi@cartesius.espritscholen.nl', '2015-08-19 09:38:01', '2015-08-23 11:09:25', '0', '0', NULL ),
( '136', 'Mariam', 'http://www.mariam.eigenstart.nl', 'm.bouichrat@cartesius.espritscholen.nl', '2015-08-19 09:38:03', '2015-08-23 11:09:25', '0', '0', NULL ),
( '137', 'wil.eigenstart', 'http://www.wil.eigenstart.nl', 'w.haarman@gmail.com', '2015-08-19 09:48:26', '2015-08-23 11:04:32', '0', '0', NULL ),
( '138', 'asisto', 'http://asisto.eigenstart.nl', 'a.m.hendriksen@gmail.com', '2015-08-19 10:07:14', '2015-08-23 11:09:25', '1', '1', NULL ),
( '139', 'yvon-alex', 'http://www.yvon-alex.eigenstart.nl/', 'yvonwingender@hotmail.com', '2015-08-19 10:56:20', '2015-08-23 11:12:52', '1', '1', NULL ),
( '140', 'marleens', 'http://www.marleens.eigenstart.nl', 'marleenannen@hotmail.com', '2015-08-19 11:28:22', '2015-08-23 11:12:52', '1', '1', NULL ),
( '141', 'marleens', 'http://www.marleens.eigenstart.nl', 'marleenannen@hotmail.com', '2015-08-19 11:28:24', '2015-08-23 11:12:52', '1', '1', NULL ),
( '142', 'yvon-alex', 'http://www.yvon-alex.eigenstart.nl', 'a.wingender@chello.nl', '2015-08-19 11:49:42', '2015-08-23 11:14:35', '1', '1', NULL ),
( '143', 'Amsterdam Sunshine Escorts', 'http://amsterdamescorts1.com', 'ministerasdescort1@gmail.com', '2015-08-19 11:52:26', '2015-08-23 11:12:52', '0', '0', NULL ),
( '144', 'naaiaterlier', 'http://naaiaterlier.eigenstart.nl', 'naaiaterlier1972@gmail.com', '2015-08-19 11:54:19', '2015-08-23 11:12:52', '0', '0', NULL ),
( '145', 'opmaatbb', 'http://www.eigenstart.opmaatbb.nl', 's.pouwkraan@sboopmaat.nl', '2015-08-19 12:53:26', '2015-08-23 11:12:52', '0', '0', NULL ),
( '146', 'opmaatob', 'http://www.eigenstart.opmaatob.nl', 's.pouwkraan@sboopmaat.nl', '2015-08-19 12:53:48', '2015-08-23 11:14:35', '0', '0', NULL ),
( '147', 'Kisses', 'http://www.kisses.eigenstart.nl', 'gyuryandjemima@hotmail.com', '2015-08-19 13:35:36', '2015-08-23 11:12:52', '0', '0', NULL ),
( '148', 'oeteldonk.eigenstart.nl', 'http://www.lruti.nl/STsnp/', 'ajwsmits@ziggo.nl', '2015-08-19 14:05:09', '2015-08-23 11:12:52', '0', '0', NULL ),
( '149', 'oeteldonk.eigenstart.nl', 'http://www.lruti.nl/STsnp/', 'ajwsmits@ziggo.nl', '2015-08-19 14:06:34', '2015-08-23 11:12:52', '0', '0', NULL ),
( '150', 'Naturistenreizen.eigenstart.nl', 'http://naturistenreizen.eigenstart.nl/', 'naturistenreizen@gmail.com', '2015-08-19 14:52:55', '2015-08-23 11:14:35', '1', '1', NULL ),
( '151', 'joke', 'http://www.joke.eigenstart.nl/', 'johoeberichts@online.nl', '2015-08-19 15:11:52', '2015-08-23 11:14:35', '1', '1', NULL ),
( '152', 'Ingrid', 'http://www.ingrid.eigenstart.nl/', 'ingrid8@gmail.com', '2015-08-19 15:13:05', '2015-08-23 11:14:35', '0', '0', NULL ),
( '153', 'janv.eigenstart.nl', 'http://www.janv.eigenstart.nl', 'jan@janenkim.nl', '2015-08-19 15:46:00', '2015-08-23 10:45:50', '0', '0', NULL ),
( '154', 'bmw-gps', 'http://bmw-gps.eigenstart.nl', 'h.vollenbroek@gmail.com', '2015-08-19 15:59:13', '2015-08-23 10:39:42', '1', '1', NULL ),
( '155', 'hvt', 'http://hvt.eigenstart.nl', 'h.vollenbroek@gmail.com', '2015-08-19 16:00:02', '2015-08-23 11:14:35', '0', '0', NULL ),
( '156', 'hendri', 'http://hendri.eigenstart.nl', 'h.vollenbroek@gmail.com', '2015-08-19 16:00:30', '2015-08-23 11:14:35', '1', '1', NULL ),
( '157', 'Dick van der Vlugt', 'http://dick.eigenoverzicht.nl', 'dickvandervlugt@gmail.com', '2015-08-19 17:06:32', '2015-08-23 11:14:35', '0', '0', NULL ),
( '158', 'Startpagina Mark', 'http://mvz.eigenstart.nl', 'mark@vanzaale.nl', '2015-08-19 17:32:01', '2015-08-23 11:14:35', '0', '0', NULL ),
( '159', 'frankyboy.eigenstart.nl', 'http://www.frankyboy.eigenstart.nl', 'frankyboydual1019@gmail.com', '2015-08-19 18:23:04', '2015-08-23 11:14:35', '1', '1', NULL ),
( '160', 'wimfia', 'http://wimfia.eigenstart.nl', 'wim.fia@gmail.com', '2015-08-19 18:25:56', '2015-08-23 11:16:08', '0', '0', NULL ),
( '161', 'aniet1965', 'http://aniet1965.eigenstart.nl', 'anietslager@gmail.com', '2015-08-19 18:43:51', '2015-08-23 11:16:08', '0', '0', NULL ),
( '162', 'hansjef', 'http://hansjef.eigenstart.nl', 'hansslager64@gmail.com', '2015-08-19 18:46:17', '2015-08-23 11:16:08', '0', '0', NULL ),
( '163', 'sztv', 'http://sztv.eigenstart.nl', 'hans.s@zeelandnet.nl', '2015-08-19 18:47:43', '2015-08-23 11:16:08', '0', '0', NULL ),
( '164', 'slagveer', 'http://slagveer.eigenstart.nl', 'slagveer@kpnmail.nl', '2015-08-19 18:49:21', '2015-08-23 11:16:08', '0', '0', NULL ),
( '165', 'ajb', 'http://ajb.eigenstart.nl', 'andre.bouwman@ajbnet.nl', '2015-08-19 19:53:50', '2015-08-23 11:16:08', '1', '1', NULL ),
( '166', 'muur-decoratie', 'http://www.muur-decoratie.eigenstart.nl', 'vvzz@live.nl', '2015-08-19 20:28:47', '2015-08-23 11:16:08', '1', '1', NULL ),
( '167', 'Jordi', 'http://www.jordi.eigenstart.nl/', 'jordi00hubers@hotmail.com', '2015-08-19 21:57:41', '2015-08-23 11:16:08', '0', '0', NULL ),
( '168', 'gertvandenbrink', 'http://www.gertvandenbrink.coolstart.nl', 'gert.van.den.brink@hotmail.com', '2015-08-19 23:01:11', '2015-08-23 11:16:08', '1', '1', NULL ),
( '169', 'choco2009.eigenstart.nl', 'http://www.choco2009.eigenstart.nl', 'rmrloche@home.nl', '2015-08-20 04:59:35', '2015-08-23 11:16:08', '0', '0', NULL ),
( '170', 'hejsan', 'http://hejsan.eigenstart.nl/', 'hejsan@live.nl', '2015-08-20 05:28:42', '2015-08-23 11:17:56', '1', '1', NULL ),
( '171', 'Saevus', 'http://saevus.eigenstart.nl', 'redelang@gmail.com', '2015-08-20 05:52:09', '2015-08-23 11:17:56', '1', '1', NULL ),
( '172', 'Angelique', 'http://angelique.eigenstart.nl', 'angelique.o@home.nl', '2015-08-20 06:15:33', '2015-08-23 10:59:38', '1', '1', NULL ),
( '173', 'kruijdenberg eigenstart', 'http://kruijdenberg.eigenstart.nl/', 'j.kruijdenberg@gmail.com', '2015-08-20 06:33:43', '2015-08-23 10:43:38', '1', '1', NULL ),
( '174', 'zandbergen', 'http://zandbergen.eigenstart.nl', 'theo620@hotmail.com', '2015-08-20 06:51:45', '2015-08-23 11:01:36', '1', '1', NULL ),
( '175', '-', 'http://anna.eigenstart.nl', 'a.m.litjens@tue.nl', '2015-08-20 07:00:52', '2015-08-23 11:17:56', '1', '1', NULL ),
( '176', 'sisaO', 'http://sisao.eigenstart.nl', 'sisao_nl@hotmail.com', '2015-08-20 07:05:40', '2015-08-23 10:49:24', '0', '0', NULL ),
( '177', 'Sandra', 'http://eigenstart.nl/user/homepage', 'scmanche@gmail.com', '2015-08-20 11:12:05', '2015-08-23 11:20:08', '0', '0', NULL ),
( '178', 'Linders', 'http://linders.bedrijfspagina.ws', 'info@lindersadvies.nl', '2015-08-20 11:13:08', '2015-08-23 10:39:42', '0', '0', NULL ),
( '179', 'Gammapook', 'http://gammapooka.eigenstart.nl', 'gammapooka@hotmail.com', '2015-08-20 11:17:16', '2015-08-23 11:17:56', '1', '1', NULL ),
( '180', 'Gammapooka', 'http://gammapooka.eigenstart.nl', 'gammapooka@hotmail.com', '2015-08-20 11:18:03', '2015-08-23 11:17:56', '1', '1', NULL ),
( '181', 'golfles', 'http://golfles.eigenstart.nl', 'info@mijngvb.nl', '2015-08-20 11:29:36', '2015-08-23 11:17:56', '0', '0', NULL ),
( '182', 'asisto', 'http://www.asisto.eigenstart.nl', 'a.m.hendriksen@gmail.com', '2015-08-20 12:07:29', '2015-08-23 11:17:56', '1', '1', NULL ),
( '183', 'rico74', 'http://rico74.eigenstart.nl', 'rico74@gmx.net', '2015-08-20 12:35:42', '2015-08-23 11:17:56', '1', '1', NULL ),
( '184', 'edithlaurette', 'http://edithlaurette.eigenstart.nl', 'edithdemeij@gmail.com', '2015-08-20 13:13:36', '2015-08-23 10:47:27', '0', '0', NULL ),
( '185', 'BMW GVB', 'http://bmw.eigenstart.nl/', 'gerard.hokke@gvb.nl', '2015-08-20 13:50:00', '2015-08-23 11:17:56', '1', '1', NULL ),
( '186', 'egbert', 'http://www.egbert.eigenpage.nl/', 'egbert.beltman@gmail.com', '2015-08-20 14:03:40', '2015-08-23 11:20:08', '0', '0', NULL ),
( '187', 'Nieno', 'http://nieno.coolstart.nl/', 'diannedetwiler@hotmail.com', '2015-08-20 15:15:54', '2015-08-23 11:20:08', '1', '1', NULL ),
( '188', 'Onderweg', 'http://onderweg.eigenstart.nl', 'p.verweij@solcon.nl', '2015-08-20 16:43:04', '2015-08-23 11:20:08', '1', '1', NULL ),
( '189', 'albeda', 'http://albeda.eigenstart.nl/', 'p.verweij@solcon.nl', '2015-08-20 16:43:36', '2015-08-23 11:20:08', '1', '1', NULL ),
( '190', 'Gartenbahnen', 'http://gartenbahnen.eigenstart.nl', 'webmaster@lgbhobby.eu', '2015-08-20 17:31:23', '2015-08-23 11:24:10', '1', '1', NULL ),
( '191', 'Lehmann blikken speelgoed', 'http://lehmann.eigenstart.nl', 'webmaster@lgbhobby.eu', '2015-08-20 17:32:51', '2015-08-23 11:20:08', '1', '1', NULL ),
( '192', 'LGB Europa', 'http://lgb-europa.eigenstart.nl', 'webmaster@lgbhobby.eu', '2015-08-20 17:33:49', '2015-08-23 11:20:08', '1', '1', NULL ),
( '193', 'LGB Wereld', 'http://lgb-wereld.eigenstart.nl', 'webmaster@lgbhobby.eu', '2015-08-20 17:34:26', '2015-08-23 11:20:08', '1', '1', NULL ),
( '194', 'Oosten dovenclub', 'hhtp://dovenclub.eigenstart.nl', 'webmaster@lgbhobby.eu', '2015-08-20 17:36:04', '2015-08-23 11:20:08', '0', '0', NULL ),
( '195', 'Jansen', 'http://jansen.eigenstart.nl', 'webmaster@lgbhobby.eu', '2015-08-20 17:36:44', '2015-08-23 11:24:10', '0', '0', NULL ),
( '196', 'Wil', 'http://www.wil.eigenstart.nl', 'w.haarman@hotmail.com', '2015-08-20 17:58:52', '2015-08-23 11:04:32', '0', '0', NULL ),
( '197', 'Wil', 'http://www.wil.eigenstart.nl', 'w.haarman@gmail.com', '2015-08-20 17:59:24', '2015-08-23 11:04:32', '0', '0', NULL ),
( '198', 'algemeen', 'http://www.bgb.eigenstart.nl', 'bblaauw46@home.nl', '2015-08-20 18:30:33', '2015-08-23 11:37:03', '1', '1', NULL ),
( '199', 'powerpete', 'http://www.powerpete.eigenstart.nl/', 'powerpete2@gmail.com', '2015-08-20 23:29:22', '2015-08-23 11:24:10', '1', '1', NULL ),
( '200', 'Nico', 'http://www.nico.eigenstart.nl', 'martijn.derks@gmail.com', '2015-08-21 00:03:34', '2015-08-23 11:24:10', '0', '0', NULL ),
( '201', 'alleskits', 'http://alleskits.eigenstart.nl', 'kittypeters@gmail.com', '2015-08-21 03:19:07', '2015-08-23 10:51:23', '0', '0', NULL ),
( '202', 'SalesDepot', 'http://www.salesdepot.eu', 'support@salesdepot.eu', '2015-08-21 06:24:12', '2015-08-23 11:24:10', '0', '0', NULL ),
( '203', 'bigkingxxl', 'http://bigkingxxl.eigenstart.nl', 'maw62@hotmail.com', '2015-08-21 07:13:24', '2015-08-23 11:26:17', '1', '1', NULL ),
( '204', 'Nieno', 'http://www.nienocoolstart.nl', 'diannedetwiler@hotmail.com', '2015-08-21 07:59:07', '2015-08-23 11:24:10', '0', '0', NULL ),
( '205', 'Nieno', 'http://www.nienocoolstart.nl', 'diannedetwiler@hotmail.com', '2015-08-21 07:59:07', '2015-08-23 11:24:10', '0', '0', NULL ),
( '206', 'Nieno', 'http://nienocoolstart.nl', 'diannedetwiler@hotmail.com', '2015-08-21 07:59:59', '2015-08-23 11:26:17', '0', '0', NULL ),
( '207', 'hetraybona', 'http://www.hetraybona.eigenstart.nl/', 'hetraybona@hotmail.com', '2015-08-21 08:55:20', '2015-08-23 11:26:17', '1', '1', NULL ),
( '208', 'Itsmie', 'http://www.itsmie.eigenstart.nl', 'jjdonkerssahuleka@gmail.com', '2015-08-21 09:18:21', '2015-08-23 11:26:17', '0', '0', NULL ),
( '209', 'oeteldonk.eigenstart.nl', 'http://www.lruti.nl/STsnp/', 'ajwsmits@ziggo.nl', '2015-08-21 09:54:27', '2015-08-23 11:12:52', '0', '0', NULL ),
( '210', 'turkoois', 'http://turkoois.eigenstart.nl/', 'turkoois@zonnet.nl', '2015-08-21 11:18:17', '2015-08-23 11:26:17', '1', '1', NULL ),
( '211', 'daaniejelles links', 'http://daaniejelles.eigenstart.nl', 'daaniejelle@gmail.com', '2015-08-21 12:18:27', '2015-08-23 10:39:42', '0', '0', NULL ),
( '212', 'kunstgras-kopen', 'http://kunstgras-kopen.eigenstart.nl', 'eigenstart@schotelbodems.nl', '2015-08-21 12:26:02', '2015-08-23 11:26:17', '0', '0', NULL ),
( '213', 'BMadW', 'http://bmadw.eigenstart.nl/', 'bmadw@hotmail.com', '2015-08-21 12:37:25', '2015-08-23 11:06:55', '1', '1', NULL ),
( '214', 'Privacy', 'http://www.privacy.eigenstart.nl', 'bruinenco@planet.nl', '2015-08-21 13:32:12', '2015-08-23 11:26:17', '1', '1', NULL ),
( '215', 'Privacy', 'htttp://privacy.eigenstart.nl', 'bruinenco@planet.nl', '2015-08-21 13:33:23', '2015-08-23 11:26:17', '0', '0', NULL ),
( '216', 'Divers', 'http://ophetweb.eigenstart.nl', 'bjameijer@gmail.com', '2015-08-21 14:22:02', '2015-08-23 11:26:17', '1', '1', NULL ),
( '217', 'kunstgras-kopen', 'http://kunstgras-kopen.eigenstart.nl', 'eigenstart@schotelbodems.nl', '2015-08-21 14:53:01', '2015-08-23 11:26:17', '0', '0', NULL ),
( '218', 'kunstgras-kopen', 'http://kunstgras-kopen.eigenstart.nl', 'eigenstart@schotelbodems.nl', '2015-08-21 15:06:38', '2015-08-23 11:26:17', '0', '0', NULL ),
( '219', 'Wolfertisk', 'http://www.wolfertisk.eigenstart.nl', 'msc@wolfert.nl', '2015-08-21 15:27:32', '2015-08-23 11:04:32', '0', '0', NULL ),
( '220', 'hvh', 'http://hvh.eigenstart.nl', 'henk@vanheuven.nl', '2015-08-21 15:35:46', '2015-08-23 11:28:13', '1', '1', NULL ),
( '221', 'janv.eigenstart.nl', 'http://www.janv.eigenstart.nl', 'j.verhulst47@chello.nl', '2015-08-21 15:42:35', '2015-08-23 10:45:50', '0', '0', NULL ),
( '222', 'langg', 'http://langg.eigenstart.nl', 'langg@home.nl', '2015-08-21 16:16:53', '2015-08-23 11:28:13', '1', '1', NULL ),
( '223', 'SZTV Eigenstart', 'http://www.sztv.eigenstart.nl/', 'J.A.Slager@sztv.nl', '2015-08-21 16:37:22', '2015-08-23 11:28:13', '0', '0', NULL ),
( '224', 'edlucker.eigenstart.nl', 'http://edlucker.eigenstart.nl', 'edlucker@kpnplanet.nl', '2015-08-21 17:17:55', '2015-08-23 11:28:13', '1', '1', NULL ),
( '225', 'Nouja', 'http://nouja.eigenstart.nl', 'reisje1988@hotmail.com', '2015-08-21 17:54:01', '2015-08-23 10:37:51', '1', '1', NULL ),
( '226', 'Diabetes', 'http://diabetes.eigenstart.nl', 'yskan.83@gmail.com', '2015-08-21 19:06:37', '2015-08-23 11:28:13', '1', '1', NULL ),
( '227', 'hannekevoordouw', 'https://hannekevoordouw.eigenstart.nl', 'hvoordouw@yahoo.com', '2015-08-21 19:22:44', '2015-08-23 11:28:13', '1', '1', NULL ),
( '228', 'hannekevoordouw', 'https://hannekvoordouw.eigenstart.nl', 'hvoordouw@yahoo.com', '2015-08-21 19:27:19', '2015-08-21 19:27:19', '1', '1', '20141026193914' ),
( '229', 'steefke', 'http://steefke.eigenstart.nl/', 'stefan65@hotmail.nl', '2015-08-21 20:11:38', '2015-08-23 11:28:13', '1', '1', NULL ),
( '230', 'oeteldonk.eigenstart.nl', 'http://www.lruti.nl/STsnp/', 'ajwsmits@ziggo.nl', '2015-08-21 20:12:02', '2015-08-23 11:12:52', '0', '0', NULL ),
( '231', 'oeteldonk.', 'http://www.lruti.nl/STsnp/', 'ajwsmits@ziggo.nl', '2015-08-21 20:24:12', '2015-08-23 11:12:52', '0', '0', NULL ),
( '232', 'michels.eigenstart.nl', 'http://michels.eigenstart.nl', 'michel.coetsier@gmail.com', '2015-08-21 21:27:50', '2015-08-23 11:28:13', '1', '1', NULL ),
( '233', 'michels.eigenstart.nl', 'http://michels.eigenstart.nl', 'michel.coetsier@gmail.com', '2015-08-21 21:27:51', '2015-08-23 11:28:13', '1', '1', NULL ),
( '234', 'Opdam op het net', 'http://opdam.eigenstart.nl', 'rob@opdam.net', '2015-08-22 07:58:31', '2015-08-23 11:29:57', '1', '1', NULL ),
( '235', 'hoekstra', 'http://hoekstra.eigenstart.nl', 'taco.hoekstra@hetnet.nl', '2015-08-22 08:52:25', '2015-08-23 10:47:27', '1', '1', NULL ),
( '236', 'Amsterdam Start', 'http://amsterdam-start.eigenstart.nl/', 'vladislav.kosko@gmail.com', '2015-08-22 09:18:35', '2015-08-23 10:37:51', '1', '1', NULL ),
( '237', 'rverlijsdonk', 'http://rverlijsdonk.eigenstart.nl', 'vladislav.kosko@gmail.com', '2015-08-22 09:19:08', '2015-08-23 10:37:51', '1', '1', NULL ),
( '238', 'joseph.eigenstart.nl', 'http://joseph.eigenstart.nl', 'jdas@hetnet.nl', '2015-08-23 09:36:18', '2015-08-23 11:29:57', '0', '0', NULL ),
( '239', 'jacco', 'http://jacco.eigenstart.nl', 'jaccoenanita@hotmail.com', '2015-08-23 09:41:21', '2015-08-23 11:29:57', '1', '1', NULL ),
( '240', 'joseph.eigenstart.nl', 'http://joseph.eigenstart.nl', 'jdas@hetnet.nl', '2015-08-23 09:43:05', '2015-08-23 11:29:57', '0', '0', NULL ),
( '241', 'Heuvelsland', 'http://www.heuvelsland.eigenstart.nl/', 'anja@heuvelsland.eu', '2015-08-23 10:19:32', '2015-08-23 11:29:57', '1', '1', NULL ),
( '242', 'jufemily', 'http://www.jufemily.eigenstart.nl/', 'emilymolenaar@hotmail.com', '2015-08-23 10:22:34', '2015-08-23 11:29:57', '0', '0', NULL ),
( '243', 'heuvelsland', 'http://heuvelsland.eigenstart.nl#sthash.d2jNiPIN.dpuf', 'anja@heuvelsland.eu', '2015-08-23 10:24:51', '2015-08-23 11:29:57', '0', '0', NULL ),
( '244', 'pernis', 'http://pernis.eigenstart.nl/', 'pernisdorp@hotmail.com', '2015-08-23 11:43:39', '2015-08-23 11:43:39', '0', '1', NULL ),
( '245', 'joseph', 'http://joseph.eigenstart.nl', 'jdas@hetnet.nl', '2015-08-23 11:44:04', '2015-08-23 11:44:04', '0', '1', NULL ),
( '246', 'pernis', 'http://pernis.eigenstart.nl', 'pernisdorp@hotmail.com', '2015-08-23 11:50:09', '2015-08-23 11:50:09', '0', '1', NULL ),
( '247', 'labob1', 'http://http:\\\\labob1.eigenstart.nl', 'labob@upcmail.nl', '2015-08-23 13:11:29', '2015-08-23 13:11:29', '0', '1', NULL ),
( '248', 'http://www.kerkdiensten.eigenstart.nl/', 'http://www.kerkdiensten.eigenstart.nl/', 'kerkdigitaal@live.nl', '2015-08-23 13:15:03', '2015-08-23 13:15:03', '0', '1', NULL ),
( '249', 'http://organisten.eigenstart.nl/', 'http://organisten.eigenstart.nl/', 'kerkdigitaal@live.nl', '2015-08-23 13:22:42', '2015-08-23 13:22:42', '0', '1', NULL ),
( '250', 'http://kerkradio.eigenstart.nl/', 'http://kerkradio.eigenstart.nl/', 'kerkdigitaal@live.nl', '2015-08-23 13:23:12', '2015-08-23 13:23:12', '0', '1', NULL ),
( '251', 'http://koren.eigenstart.nl/', 'http://koren.eigenstart.nl/', 'kerkdigitaal@live.nl', '2015-08-23 13:23:34', '2015-08-23 13:23:34', '0', '1', NULL ),
( '252', 'Wolfertisk', 'http://wolfertisk.eigenstart.nl', 'msc@wolfert.nl', '2015-08-23 13:33:40', '2015-08-23 13:33:40', '0', '1', NULL ),
( '253', 'Syllie\'s Favorieten', 'http://www.sylvia.eigenstart.nl', 'info@terwoert.nl', '2015-08-23 14:03:40', '2015-08-23 14:03:40', '0', '1', NULL ),
( '254', 'Syllie\'s Favorieten', 'http://www.sylvia.eigenstart.nl', 'info@terwoert.nl', '2015-08-23 14:03:47', '2015-08-23 14:03:47', '0', '1', NULL ),
( '255', 'Syllie\'s Favorieten', 'http://www.sylvia.eigenstart.nl', 'info@terwoert.nl', '2015-08-23 14:03:48', '2015-08-23 14:03:48', '0', '1', NULL ),
( '256', 'Syllie\'s Favorieten', 'http://www.sylvia.eigenstart.nl', 'info@terwoert.nl', '2015-08-23 14:03:50', '2015-08-23 14:03:50', '0', '1', NULL ),
( '257', 'Terwoert', 'http://www.terwoert.eigenstart.nl/', 'info@terwoert.nl', '2015-08-23 14:04:12', '2015-08-23 14:04:12', '0', '1', NULL ),
( '258', 'jmmverheijen', 'http://jmmverheijen.eigenstart.nl', 'jmm.verheijen@planet.nl', '2015-08-23 14:25:31', '2015-08-23 14:25:31', '0', '1', NULL ),
( '259', 'Robs', 'http://robs.eigenstart.nl', 'rob@vanheuven.nl', '2015-08-23 16:21:24', '2015-08-23 16:21:24', '0', '1', NULL ),
( '260', 'LGB', 'Http://lgb.eigenstart.nl', 'webmaster@lgbhobby.eu', '2015-08-23 18:50:25', '2015-08-23 18:50:25', '0', '1', NULL ),
( '261', 'startpagina Jan Emmelkamp', 'http://www.emmelkamp.eigenstart.nl', '2cops@gmx.de', '2015-08-23 20:31:08', '2015-08-23 20:31:08', '0', '1', NULL ),
( '262', 'dtab52', 'http://dtab52.eigenstart.nl', 'dtab52@zonnet.nl', '2015-08-23 20:54:10', '2015-08-23 20:54:10', '0', '1', NULL ),
( '263', 'gera', 'http://gera.eigenstart.nl', 'gera_roelofs@hotmail.com', '2015-08-24 06:36:29', '2015-08-24 06:36:29', '0', '1', NULL ),
( '264', 'lobbes-vipe', 'http://lobbes-vipe.eigenpage.nl/', 'dogsandfriends@hotmail.com', '2015-08-24 07:01:16', '2015-08-24 07:01:16', '0', '1', NULL ),
( '265', 'jvr.eigenstart', 'http://jvr.eigenstart.nl', 'jackvrooij@gmail.com', '2015-08-24 07:14:53', '2015-08-24 07:14:53', '0', '1', NULL ),
( '266', 'oeteldonk.', 'http://www.lruti.nlSTsnp/', 'ajwsmits@ziggo.nl', '2015-08-24 07:22:27', '2015-08-24 07:22:27', '0', '1', NULL ),
( '267', 'bartvanlier', 'http://www.bartvanlier.eigenstart.nl', 'bartvanlier@hotmail.com', '2015-08-24 07:45:46', '2015-08-24 07:45:46', '0', '1', NULL ),
( '268', 'dickydik', 'http://www.dickydik.eigenstart.nl/', 'dickydik@ziggo.nl', '2015-08-24 08:08:16', '2015-08-24 08:08:16', '0', '1', NULL ),
( '269', 'Beginscherm', 'http://www.beginscherm.eigenstart.nl', 'wab210@yahoo.com', '2015-08-24 08:08:43', '2015-08-24 08:08:43', '0', '1', NULL ),
( '270', 'davidverstappen.eigenstart.nl', 'http://www.davidverstappen.eigenstart.nl', 'davidverstappen@gmail.com', '2015-08-24 08:25:04', '2015-08-24 08:25:04', '0', '1', NULL ),
( '271', 'Remco', 'http://www.remco.eigenoverzicht.nl/', 'informatie@okidokisite.nl', '2015-08-24 08:33:51', '2015-08-24 08:33:51', '0', '1', NULL ),
( '272', 'mariool', 'http://www.mariool.eigenstart.nl/', 'mario_elbers@hotmail.com', '2015-08-24 08:41:32', '2015-08-24 08:41:32', '0', '1', NULL ),
( '273', 'eh38.eigenstart.nl', 'http://www.eh38.eigenstart.nl', 'ehindriks@planet.nl', '2015-08-24 09:00:42', '2015-08-24 09:00:42', '0', '1', NULL ),
( '274', 'Henk van der Sangen', 'http://baltus1956.eigenstart.nl/', 'henkvandersangen1956@gmail.com', '2015-08-24 09:50:57', '2015-08-24 09:50:57', '0', '1', NULL ),
( '275', 'coolstart', 'http://bergsma.coolstart.nl', 'info@bergmbedrukking.nl', '2015-08-24 15:16:38', '2015-08-24 15:16:38', '0', '1', NULL ),
( '276', 'websitecilia', 'http://websitecilia.eigenstart.nl', 'csnijland@home.nl', '2015-08-24 15:16:58', '2015-08-24 15:16:58', '0', '1', NULL ),
( '277', 'Bedrijven Marktplaats', 'http://websitecilia.eigenstart.nl', 'csnijland@home.nl', '2015-08-24 15:26:06', '2015-08-24 15:26:06', '0', '1', NULL ),
( '278', 'prw', 'http://www.prw.eigenstart.nl', 'p.r.weijmans@gmail.com', '2015-08-24 17:22:36', '2015-08-24 17:22:36', '0', '1', NULL ),
( '279', 'aniet1965', 'http://aniet1965.eigenstart.nl', 'anita.s@zeelandnet.nl', '2015-08-24 18:03:40', '2015-08-24 18:03:40', '0', '1', NULL ),
( '280', 'webwinkels', 'http://webwinkel.eigenstart.nl/', 'info@hiker.nl', '2015-08-24 19:19:02', '2015-08-24 19:19:02', '0', '1', NULL ),
( '281', 'hggc.eigenstart.nl', 'http://hggc.eigenstart.nl/', 'hggc@home.nl', '2015-08-24 19:28:48', '2015-08-24 19:28:48', '0', '1', NULL ),
( '282', 'http://guusje.eigenstart.nl/', 'http://guusje.eigenstart.nl/', 'g.evers61@gmail.com', '2015-08-24 20:37:32', '2015-08-24 20:37:32', '0', '1', NULL ),
( '283', 'yusuf', 'http://yusuf.eigenstart.nl', 'yusuf_28@live.nl', '2015-08-24 21:28:56', '2015-08-24 21:28:56', '0', '1', NULL ),
( '284', 'Mart', 'http://mart.eigenstart.nl', 'eemem@live.nl', '2015-08-24 21:59:56', '2015-08-24 21:59:56', '0', '1', NULL ),
( '285', 'maleisie', 'http://maleisie.eigenstart.nl', 'buckdanny@live.nl', '2015-08-25 04:54:08', '2015-08-25 04:54:08', '0', '1', NULL ),
( '286', 'apakabar', 'http://apakabar.eigenstart.nl', 'buckdanny@live.nl', '2015-08-25 04:55:57', '2015-08-25 04:55:57', '0', '1', NULL ),
( '287', 'slaapkamers', 'http://Slaapkamers.eigenstart.nl', 'thomasdejong24@gmail.com', '2015-08-25 06:47:33', '2015-08-25 06:47:33', '0', '1', NULL ),
( '288', 'kerkdiensten.eigenstart.nl', 'http://www.kerkdiensten.eigenstart.nl/', 'kerkdigitaal@live.nl', '2015-08-25 07:17:39', '2015-08-25 07:17:39', '0', '1', NULL ),
( '289', 'fasteagle', 'http://fasteagle.eigenstart.nl', 'eagle2512@gmail.com', '2015-08-25 07:52:55', '2015-08-25 07:52:55', '0', '1', NULL ),
( '290', 'puum.eigenstart', 'http://www.puum.eigenstart.nl/', 'puumke@gmail.com', '2015-08-25 08:00:12', '2015-08-25 08:00:12', '0', '1', NULL ),
( '291', 'mirwais eigenstart', 'http://www.mirwais.eigenstart.nl', 'wais@tele2.nl', '2015-08-25 08:27:55', '2015-08-25 08:27:55', '0', '1', NULL ),
( '292', 'BMadW', 'http://bmadw.eigenstart.nl/', 'bmadw@hotmail.com', '2015-08-25 09:09:10', '2015-08-25 09:09:10', '0', '1', NULL ),
( '293', 'loes.eigenstart.nl', 'http://loes.eigenstart.nl/', 'loesbaas@quicknet.nl', '2015-08-25 14:19:41', '2015-08-25 14:19:41', '0', '1', NULL ),
( '294', 'davidverstappen.eigenstart.nl', 'http://www.davidverstappen.eigenstart.nl', 'davidverstappen@gmail.com', '2015-08-25 19:27:42', '2015-08-25 19:27:42', '0', '1', NULL ),
( '295', 'hansderuiter', 'http://hansderuiter.eigenstart.nl', 'hdruiter2000@hetnet.nl', '2015-08-25 19:44:46', '2015-08-25 19:44:46', '0', '1', NULL ),
( '296', 'mirwais eigenstart', 'http://www.mirwais.eigenstart.nl', 'wais@tele2.nl', '2015-08-25 19:58:58', '2015-08-25 19:58:58', '0', '1', NULL ),
( '297', 'franka', 'https:// franka.eigenstart.nl', 'l.cruijsen@gmail.com', '2015-08-25 20:17:03', '2015-08-25 20:17:03', '0', '1', NULL ),
( '298', 'bigkingxxl', 'http://http:\\\\www.bigkingxxl.eigenstart.nl', 'maw62@hotmail.com', '2015-08-26 02:52:44', '2015-08-26 02:52:44', '0', '1', NULL ),
( '299', 'nicelady', 'http://www.nicelady.eigenstart.nl', 'j.mac.intosh@hotmail.com', '2015-08-26 04:03:28', '2015-08-26 04:03:28', '0', '1', NULL ),
( '300', 'Mariool', 'http://mariool.eigenstart.nl/', 'mario_elbers@hotmail.com', '2015-08-26 06:23:09', '2015-08-26 06:23:09', '0', '1', NULL ),
( '301', 'erikvanvelzen.eigenstart.nl', 'http://erikvanvelzen.eigenstart.nl/', 'e.velzen@hetnet.nl', '2015-08-26 07:54:43', '2015-08-26 07:54:43', '0', '1', NULL ),
( '302', 'Rebound', 'http://rebound.eigenstart.nl', 'galahad_den@hotmail.com', '2015-08-26 09:10:54', '2015-08-26 09:10:54', '0', '1', NULL ),
( '303', 'oimgood', 'http://oimgood.eigenstart.nl/', 'oimgood@gmail.com', '2015-08-26 11:16:21', '2015-08-26 11:16:21', '0', '1', NULL ),
( '304', 'doenormaal', 'http://doenrmaal.eigenstart.nl', 'r.redering@online.nl', '2015-08-26 12:50:26', '2015-08-26 12:50:26', '0', '1', NULL ),
( '305', 'kerkdiensten.eigenstart.nl', 'http://www.kerkdiensten.eigenstart.nl/', 'kerkdigitaal@live.nl', '2015-08-26 12:54:02', '2015-08-26 12:54:02', '0', '1', NULL ),
( '306', 'Dubbelteis', 'http://dubbelteis.eigenstart.nl', 'dubbelteis@zonnet.nl', '2015-08-26 15:10:55', '2015-08-26 15:10:55', '0', '1', NULL ),
( '307', 'edlucker.eigenstart.nl', 'http://edlucker.eigenstart.nl', 'edlucker@gmail.com', '2015-08-26 15:31:38', '2015-08-26 15:31:38', '0', '1', NULL ),
( '308', 'geldgrijper', 'http://geldgrijper.eigenstart.nl', 'hugobink@hotmail.com', '2015-08-26 19:49:28', '2015-08-26 19:49:28', '0', '1', NULL ),
( '309', 'Lockpick', 'http://www.lockpick.eigenstart.nl', '1@lockpickinguniversiteit.nl', '2015-08-27 00:47:49', '2015-08-27 00:47:49', '0', '1', NULL ),
( '310', '24wijn.com Grootste aanbod NL - Beste prijs!', 'http://htttp:www.24wijn.com', 'judith@twnty4.nl', '2015-08-27 05:17:05', '2015-08-27 05:17:05', '0', '1', NULL ),
( '311', 'Wijn', 'http://wijn', 'judith@twnty4.nl', '2015-08-27 05:23:57', '2015-08-27 05:23:57', '0', '1', NULL ),
( '312', 'ZANDBERGEN', 'http://zandbergen.eigenstart.nl', 'theo620@gmail.com', '2015-08-27 07:37:20', '2015-08-27 07:37:20', '0', '1', NULL ),
( '313', 'Beppies Plekkie', 'http://beppies-plekkie.eigenoverzicht.nl/', 'nikkykai@hotmail.com', '2015-08-27 08:13:16', '2015-08-27 08:13:16', '0', '1', NULL ),
( '314', 'kuifje', 'http://kuifje.eigenstart.nl', 'kuifje@wxs.nl', '2015-08-27 08:15:32', '2015-08-27 08:15:32', '0', '1', NULL ),
( '315', 'Ellen Penning eigenstart', 'http://ellenpenning.eigenstart.nl/', 'ellen.penning@xs4all.nl', '2015-08-27 09:45:42', '2015-08-27 09:45:42', '0', '1', NULL ),
( '316', 'ALgemeen', 'http://bgb.eigenstart.nl/', 'bblaauw46@home.nl', '2015-08-27 13:07:54', '2015-08-27 13:07:54', '0', '1', NULL ),
( '317', 'Mediamarketing', 'http://mediamarketing.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:42:35', '2015-08-27 14:42:35', '0', '1', NULL ),
( '318', 'Media', 'http://media.eigenoverzicht.nl', 'info@thomasstorm.nl', '2015-08-27 14:43:02', '2015-08-27 14:43:02', '0', '1', NULL ),
( '319', 'Could', 'http://cloud.eigenoverzicht.nl', 'info@thomasstorm.nl', '2015-08-27 14:43:36', '2015-08-27 14:43:36', '0', '1', NULL ),
( '320', 'Dierenvriend', 'http://dierenvriend.eigenoverzicht.nl', 'info@thomasstorm.nl', '2015-08-27 14:44:30', '2015-08-27 14:44:30', '0', '1', NULL ),
( '321', 'Kattenvoer', 'http://kattenvoer.eigenoverzicht.nl', 'info@thomasstorm.nl', '2015-08-27 14:44:52', '2015-08-27 14:44:52', '0', '1', NULL ),
( '322', 'Kattenvoer', 'http://kattenvoer.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:45:13', '2015-08-27 14:45:13', '0', '1', NULL ),
( '323', 'Caviakooien', 'http://caviakooien.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:45:58', '2015-08-27 14:45:58', '0', '1', NULL ),
( '324', 'Konijnenvoer', 'http://konijnenvoer.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:46:17', '2015-08-27 14:46:17', '0', '1', NULL ),
( '325', 'Kledingbedrukken', 'http://kledingbedrukken.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:47:09', '2015-08-27 14:47:09', '0', '1', NULL ),
( '326', 'Besparen', 'http://besparen.eigenpage.nl', 'info@thomasstorm.nl', '2015-08-27 14:47:43', '2015-08-27 14:47:43', '0', '1', NULL ),
( '327', 'Internetdeals', 'http://internetdeals.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:48:03', '2015-08-27 14:48:03', '0', '1', NULL ),
( '328', 'Voordeel', 'http://voordeel.eigenoverzicht.nl', 'info@thomasstorm.nl', '2015-08-27 14:48:22', '2015-08-27 14:48:22', '0', '1', NULL ),
( '329', 'Vergelijken', 'http://vergelijken.eigenpage.nl', 'info@thomasstorm.nl', '2015-08-27 14:48:41', '2015-08-27 14:48:41', '0', '1', NULL ),
( '330', 'Joggen', 'http://joggen.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:49:11', '2015-08-27 14:49:11', '0', '1', NULL ),
( '331', 'Vervoer', 'http://vervoer.eigenpage.nl', 'info@thomasstorm.nl', '2015-08-27 14:49:36', '2015-08-27 14:49:36', '0', '1', NULL ),
( '332', 'Liefde', 'http://liefde.eigenoverzicht.nl', 'info@thomasstorm.nl', '2015-08-27 14:50:01', '2015-08-27 14:50:01', '0', '1', NULL ),
( '333', 'Betere relatie', 'http://betererelatie.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:50:23', '2015-08-27 14:50:23', '0', '1', NULL ),
( '334', 'Luxe leven', 'http://luxeleven.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:50:55', '2015-08-27 14:50:55', '0', '1', NULL ),
( '335', 'Zonweringpagina', 'http://zonweringpagina.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:51:13', '2015-08-27 14:51:13', '0', '1', NULL ),
( '336', 'Gezonder leven', 'http://gezonderleven.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:51:37', '2015-08-27 14:51:37', '0', '1', NULL ),
( '337', 'Erotiek', 'http://erotiek.eigenpage.nl', 'info@thomasstorm.nl', '2015-08-27 14:52:08', '2015-08-27 14:52:08', '0', '1', NULL ),
( '338', 'Seksspeeltjes', 'http://seksspeeltjes.eigenoverzicht.nl', 'info@thomasstorm.nl', '2015-08-27 14:52:25', '2015-08-27 14:52:25', '0', '1', NULL ),
( '339', 'Gadgets', 'http://gadgets.eigenpage.nl', 'info@thomasstorm.nl', '2015-08-27 14:52:50', '2015-08-27 14:52:50', '0', '1', NULL ),
( '340', 'Hebbedingetjes', 'http://hebbedingetjes.eigenstart.nl', 'info@thomasstorm.nl', '2015-08-27 14:53:20', '2015-08-27 14:53:20', '0', '1', NULL ),
( '341', 'Telefonie', 'http://telefonie.eigenoverzicht.nl', 'info@thomasstorm.nl', '2015-08-27 14:54:22', '2015-08-27 14:54:22', '0', '1', NULL ),
( '342', 'Huisdieren', 'http://huisdieren.eigenbegin.nl', 'info@thomasstorm.nl', '2015-08-27 14:54:52', '2015-08-27 14:54:52', '0', '1', NULL ),
( '343', 'Tjaco', 'http://eigenstart.nl/resetting/reset/w9WteFfhmqxrrCo9S91VF-3DqK_6VhlV9WDbAx7lrnw', 'jacobs_aje@hotmail.com', '2015-08-27 15:57:18', '2015-08-27 15:57:18', '0', '1', NULL ),
( '344', 'Neurochemie', 'http://eigenstart.nl/resetting/reset/w9WteFfhmqxrrCo9S91VF-3DqK_6VhlV9WDbAx7lrnw', 'jacobs_aje@hotmail.com', '2015-08-27 15:58:04', '2015-08-27 15:58:04', '0', '1', NULL ),
( '345', 'Brein', 'http://eigenstart.nl/resetting/reset/w9WteFfhmqxrrCo9S91VF-3DqK_6VhlV9WDbAx7lrnw', 'jacobs_aje@hotmail.com', '2015-08-27 15:58:38', '2015-08-27 15:58:38', '0', '1', NULL ),
( '346', 'Hersenen', 'http://eigenstart.nl/resetting/reset/w9WteFfhmqxrrCo9S91VF-3DqK_6VhlV9WDbAx7lrnw', 'jacobs_aje@hotmail.com', '2015-08-27 15:59:13', '2015-08-27 15:59:13', '0', '1', NULL ),
( '347', 'jomaver50', 'http://jomaver50.eigenstart.nl', 'jomaver50@hotmail.com', '2015-08-27 17:19:46', '2015-08-27 17:19:46', '0', '1', NULL ),
( '348', 'Oma tilburgs', 'http://omatilburgs.eigenstart.nl', 'tilburgsg@msn.com', '2015-08-27 17:29:09', '2015-08-27 17:29:09', '0', '1', NULL ),
( '349', 'fresco catering', 'http://www.frescobobo.nl', 'alexutugrasutu@yahoo.com', '2015-08-27 17:49:10', '2015-08-27 17:49:10', '0', '1', NULL ),
( '350', 'Computer', 'http://computer.coolstart.nl', 'info@thomasstorm.nl', '2015-08-27 18:54:07', '2015-08-27 18:54:07', '0', '1', NULL ),
( '351', 'wanddecoratie', 'http://www.wand-decoratie.eigenstart.nl', 'vvzz@live.nl', '2015-08-28 07:20:06', '2015-08-28 07:20:06', '0', '1', NULL ),
( '352', 'interieurtips', 'http://www.interieur-tips.eigenstart.nl', 'vvzz@live.nl', '2015-08-28 07:21:46', '2015-08-28 07:21:46', '0', '1', NULL ),
( '353', 'Baltus1956', 'http://baltus1956.eigenstart.nl/', 'henkvandersangen1956@gmail.com', '2015-08-28 07:24:49', '2015-08-28 07:24:49', '0', '1', NULL ),
( '354', 'interieurtips', 'http://www.interieurtips.eigenstart.nl', 'dekogifts@live.nl', '2015-08-28 07:25:53', '2015-08-28 07:25:53', '0', '1', NULL ),
( '355', 'vijfluik schildeij', 'http://www.vijfluik.eigenstart.nl', 'vvzz@live.nl', '2015-08-28 07:27:20', '2015-08-28 07:27:20', '0', '1', NULL ),
( '356', 'bijzettafels', 'http://www.bijzettafels.eigenstart.nl', 'vvzz@live.nl', '2015-08-28 07:28:17', '2015-08-28 07:28:17', '0', '1', NULL ),
( '357', 'mooi interieur', 'http://www.mooi-interieur.eigenstart.nl', 'vvzz@live.nl', '2015-08-28 07:30:41', '2015-08-28 07:30:41', '0', '1', NULL ),
( '358', 'Judithrick', 'http://Judithrick.eigenpage.nl', 'r.vd.poll@gmail.com', '2015-08-28 12:30:28', '2015-08-28 12:30:28', '0', '1', NULL ),
( '359', 'antony', 'http://antony.eigenstart.nl', 'firefighterant@hotmail.com', '2015-08-28 12:31:09', '2015-08-28 12:31:09', '0', '1', NULL ),
( '360', 'senseocorner', 'http://senseocorner.coolstart.nl', 'senseoman@gmail.com', '2015-08-28 12:38:16', '2015-08-28 12:38:16', '0', '1', NULL ),
( '361', 'senseocorner', 'http://senseocorner.eigenstart.nl', 'senseoman@gmail.com', '2015-08-28 12:40:34', '2015-08-28 12:40:34', '0', '1', NULL ),
( '362', 'eigen startpagina', 'http://marjoriedebont.eigenstart.nl', 'marjoriede.bont@gmail.com', '2015-08-28 13:56:13', '2015-08-28 13:56:13', '0', '1', NULL ),
( '363', 'Nachtbraker', 'http://eigenstart.nl/nachtbraker', 'nachtbraker@casema.nl', '2015-08-28 14:36:18', '2015-08-28 14:36:18', '0', '1', NULL ),
( '364', 'Nachtbraker', 'http://nachtbraker.eigenstart.nl', 'nachtbraker@casema.nl', '2015-08-28 14:39:18', '2015-08-28 14:39:18', '0', '1', NULL ),
( '365', 'seywan.eigenoverzicht.nl', 'https://www.seywan.eigenoverzicht.nl', 'seywan_salayi@hotmail.com', '2015-08-28 15:19:19', '2015-08-28 15:19:19', '0', '1', NULL ),
( '366', 'Dickydik', 'http://www.dickydik.eigenstart.nl', 'dickydik@ziggo.nl', '2015-08-28 15:59:30', '2015-08-28 15:59:30', '0', '1', NULL ),
( '367', 'antony', 'https://antony.eigenstart.nl', 'firefighterant@hotmail.com', '2015-08-28 19:44:40', '2015-08-28 19:44:40', '0', '1', NULL ),
( '368', 'zoeklichtjes', 'http://zoeklichtjes.eigenstart.nl', 'zonnebloem-joke@hetnet.nl', '2015-08-28 20:14:04', '2015-08-28 20:14:04', '0', '1', NULL ),
( '369', 'hvt.eigenstart.nl', 'http://hvt.eigenstart.nl', 'h.vollenbroek@gmail.com', '2015-08-29 07:44:02', '2015-08-29 07:44:02', '0', '1', NULL ),
( '370', 'wiewatwaar', 'http://http:/www.wiewatwaar.eigenoverzicht.nl', 'verborgentaal@hotmail.nl', '2015-08-29 08:00:20', '2015-08-29 08:00:20', '0', '1', NULL ),
( '371', 'Bagijnhof', 'http://www.bagijnhof.eigenstart.nl', 'leoniepostelmans@ziggo.nl', '2015-08-29 15:52:31', '2015-08-29 15:52:31', '0', '1', NULL ),
( '372', 'Roelof', 'http://http:\\\\Roelof.eigenstart.nl', 'Brilsmit@gmail.com', '2015-08-29 19:05:40', '2015-08-29 19:05:40', '0', '1', NULL ),
( '373', 'robine', 'http://www.robine.eigenstart.nl', 'info@robineclubsportief.nl', '2015-08-30 09:46:01', '2015-08-30 09:46:01', '0', '1', NULL ),
( '374', 'Hubers eigen start', 'http://www.hubers.eigenstart.nl', 'phubers@upcmail.nl', '2015-08-30 10:58:13', '2015-08-30 10:58:13', '0', '1', NULL ),
( '375', 'eh38.eigenstart.nl', 'http://www.eh38.eigenstart.nl', 'ehindriks@planet.nl', '2015-08-30 10:58:33', '2015-08-30 10:58:33', '0', '1', NULL ),
( '376', 'nobody13 eigenstart', 'http://nobody13.eigenstart.nl/', 'creatiefmetnb13@gmail.com', '2015-08-30 12:50:04', '2015-08-30 12:50:04', '0', '1', NULL ),
( '377', 'Sikkens verf', 'http://sikkens.eigenstart.nl', 'pwa.schakel@outlook.com', '2015-08-31 09:20:25', '2015-08-31 09:20:25', '0', '1', NULL ),
( '378', 'wil.eigenstart.nl', 'http://www.wil.eigenstart.nl/', 'w.haarman@hotmail.com', '2015-08-31 10:45:44', '2015-08-31 10:45:44', '0', '1', NULL ),
( '379', 'wi.eigenstart.nl', 'http://www.wil.eigenstart.nl/', 'w.haarman@gmail.nl', '2015-08-31 10:46:15', '2015-08-31 10:46:15', '0', '1', NULL ),
( '380', 'wil.eigenstart.nl', 'http://www.wil.eigenstart.nl/', 'wghaarman@onsbrabantnet.nl', '2015-08-31 10:46:45', '2015-08-31 10:46:45', '0', '1', NULL ),
( '381', 'xxxjoellee', 'http://xxxjoellee.eigenpage.nl/', 'joelle.kelderman@live.nl', '2015-08-31 11:42:11', '2015-08-31 11:42:11', '0', '1', NULL ),
( '382', 'alles', 'http://alles.eigenpage.nl', 'lunalisaloco@hotmail.com', '2015-08-31 20:57:57', '2015-08-31 20:57:57', '0', '1', NULL ),
( '383', 'jurkje', 'http://jurkje.eigenstart.nl', 'lunalisaloco@hotmail.com', '2015-08-31 21:00:09', '2015-08-31 21:00:09', '0', '1', NULL ),
( '384', 'alles', 'http://alles.eigenpage.nl', 'lunalisaloco@hotmail.com', '2015-08-31 21:04:59', '2015-08-31 21:04:59', '0', '1', NULL ),
( '385', 'helmers', 'http://helmers.eigenstart.nl/', 'kameledriver@hotmail.com', '2015-08-31 21:21:10', '2015-08-31 21:21:10', '0', '1', NULL ),
( '386', 'Mirwais', 'http://www.mirwais.eigenstart.nl/', 'wais@tele2.nl', '2015-09-01 06:33:42', '2015-09-01 06:33:42', '0', '1', NULL ),
( '387', 'Ceetje', 'http://ceetje.eigenstart.nl/', 'cee@chello.nl', '2015-09-01 07:06:11', '2015-09-01 07:06:11', '0', '1', NULL ),
( '388', 'jangommans', 'http://jangommans.eigenstart.nl', 'jan.gommans@planet.nl', '2015-09-01 07:55:35', '2015-09-01 07:55:35', '0', '1', NULL ),
( '389', 'Kuifje', 'http://kuifje.eigenstart.nl', 'kuifje@wxs.nl', '2015-09-01 09:30:58', '2015-09-01 09:30:58', '0', '1', NULL ),
( '390', 'meesterkarel', 'http://http:\\\\www.meesterkarel.eigenstart.be', 'meesterkareldevlier@gmail.com', '2015-09-01 10:13:34', '2015-09-01 10:13:34', '0', '1', NULL ),
( '391', 'meesterkareldevlier', 'http://http:\\\\www.meesterkarel.eigenstart.be', 'meesterkareldevlier@gmail.com', '2015-09-01 10:19:35', '2015-09-01 10:19:35', '0', '1', NULL ),
( '392', 'onzeprive', 'http://www.onzeprive.eigenstart.nl/', 'd.vandijk@sealcom.nu', '2015-09-01 11:57:42', '2015-09-01 11:57:42', '0', '1', NULL ),
( '393', 'jeroen van Wijk', 'http://jeroenvanwijk.eigenstart.nl/', 'van_wijk26@zonnet.nl', '2015-09-01 12:19:24', '2015-09-01 12:19:24', '0', '1', NULL ),
( '394', 'Wulms', 'http://wulms.eigenstart.nl', 'pfcwulms@ziggo.nl', '2015-09-01 14:40:19', '2015-09-01 14:40:19', '0', '1', NULL ),
( '395', 'meesterkarel.eigenstart.be', 'http://http:\\\\meesterkarel.eigenstart.be', 'meesterkareldevlier@gmail.com', '2015-09-01 17:21:32', '2015-09-01 17:21:32', '0', '1', NULL ),
( '396', 'boxershortoutlet', 'http://boxershortoutlet.eigenstart.nl/', 'info@dannhensums.com', '2015-09-01 21:26:53', '2015-09-01 21:26:53', '0', '1', NULL ),
( '397', 'Ralfinho', 'http://www.ralfinho.eigenstart.nl', 'veerman_r@hotmail.com', '2015-09-01 23:16:44', '2015-09-01 23:16:44', '0', '1', NULL ),
( '398', 'davidverstappen.eigenstart.nl', 'http://www.davidverstappen.eigenstart.nl', 'davidverstappen@gmail.com', '2015-09-02 10:50:39', '2015-09-02 10:50:39', '0', '1', NULL ),
( '399', 'yt de vries', 'http://ytdevries.eigenstart.nl', 'ytdevries@hotmail.com', '2015-09-02 11:44:52', '2015-09-02 11:44:52', '0', '1', NULL ),
( '400', 'cash', 'http://cash.eigenoverzicht.nl', 'victoreltoro@hotmail.com', '2015-09-02 11:52:50', '2015-09-02 11:52:50', '0', '1', NULL ),
( '401', 'wulms', 'http://wulms.eigenstart.nl', 'pfcwulms@ziggo.nl', '2015-09-02 16:47:21', '2015-09-02 16:47:21', '0', '1', NULL ),
( '402', 'http://iersesetter.eigenstart.nl', 'http://iersesetter.eigenstart.nl', 'wdewilde@zeelandnet.nl', '2015-09-02 17:46:52', '2015-09-02 17:46:52', '0', '1', NULL ),
( '403', 'The-best.eigenstart.nl', 'http://the-best.eigenstart.nl', 'b_zoer@hotmail.com', '2015-09-03 08:24:23', '2015-09-03 08:24:23', '0', '1', NULL ),
( '404', 'Energie acties vergelijken', 'http://energieacties.eigenstart.nl', 'sjoerdhendriks@outlook.com', '2015-09-03 12:51:15', '2015-09-03 12:51:15', '0', '1', NULL ),
( '405', 'Internet providers vergelijken', 'http://internet-page.eigenstart.nl', 'sjoerdhendriks@outlook.com', '2015-09-03 12:51:37', '2015-09-03 12:51:37', '0', '1', NULL ),
( '406', 'Sinterklaas', 'http://sinterklaas.eigenstart.nl/', 'mastveld@xs4all.nl', '2015-09-03 13:30:46', '2015-09-03 13:30:46', '0', '1', NULL ),
( '407', 'bianca1969', 'http://www.bianca1969.eigenstart.nl', 'bianca.m@planet.nl', '2015-09-03 14:16:59', '2015-09-03 14:16:59', '0', '1', NULL ),
( '408', 'Film De Cul', 'http://filmdecul.eigenstart.nl', 'brunodiscover@gmail.com', '2015-09-03 15:25:06', '2015-09-03 15:25:06', '0', '1', NULL ),
( '409', 'wonderepaarden', 'http://wonderepaarden.eigenstart.nl/', 'anja-zutven@live.nl', '2015-09-03 16:54:55', '2015-09-03 16:54:55', '0', '1', NULL ),
( '410', 'willie', 'http://willie.eigenoverzicht.nl', 'infonieuwemaan@yahoo.com', '2015-09-03 16:57:34', '2015-09-03 16:57:34', '0', '1', NULL ),
( '411', 'nieuwemaan', 'http://nieuwemaan.eigenstart.nl', 'infonieuwemaan@yahoo.com', '2015-09-03 17:11:28', '2015-09-03 17:11:28', '0', '1', NULL ),
( '412', 'jorien.eigenoverzicht', 'http://jorien.eigenoverzicht.nl', 'jorienbeltman@hotmail.com', '2015-09-03 18:34:11', '2015-09-03 18:34:11', '0', '1', NULL ),
( '413', 'Juf Gilla', 'http://jufgilla.eigenstart.be', 'gillaboudry@hotmail.com', '2015-09-03 18:34:20', '2015-09-03 18:34:20', '0', '1', NULL ),
( '414', 'Handige links, makkelijk, leuk en overal bereikbaar! dickydik, links, nieuwkoop, homeopaat, klassiek, saab, susanna, brasemstraat', 'http://www.dickydik.eigenstart.nl', 'dickydik@ziggo.nl', '2015-09-04 07:49:50', '2015-09-04 07:49:50', '0', '1', NULL ),
( '415', 'lockerbie', 'http://lockerbie.eigenstart.nl', 'lockerbie@hotmail.com', '2015-09-04 09:45:16', '2015-09-04 09:45:16', '0', '1', NULL ),
( '416', 'suriname-reizen', 'http://suriname-reizen.eigenstart.nl', 'pietersuriname@gmail.com', '2015-09-04 12:27:56', '2015-09-04 12:27:56', '0', '1', NULL ),
( '417', 'Nachtbraker-Startpagina', 'http://nachtbraker.eigenstart.nl', 'nachtbraker@casema.nl', '2015-09-04 23:07:07', '2015-09-04 23:07:07', '0', '1', NULL ),
( '418', 'ralfinho', 'http://ralfinho.eigenstart.nl', 'veerman_r@hotmail.com', '2015-09-05 07:02:44', '2015-09-05 07:02:44', '0', '1', NULL ),
( '419', 'http://piratenzenders.eigenstart.nl/', 'http://piratenzenders.eigenstart.nl/', 'piratenzenders@live.nl', '2015-09-05 21:34:38', '2015-09-05 21:34:38', '0', '1', NULL ),
( '420', 'omag', 'http://omag2.eigenstart.nl/', 'gjvissergaalen@ziggo.nl', '2015-09-06 12:49:33', '2015-09-06 12:49:33', '0', '1', NULL ),
( '421', 'Mariool', 'http://www.mariool.eigenstart.nl/', 'mario_elbers@hotmail.com', '2015-09-07 08:22:40', '2015-09-07 08:22:40', '0', '1', NULL ),
( '422', 'The-best.eigenstart.nl.', 'http://the-best.eigenstart.nl', 'b_zoer@hotmail.com', '2015-09-07 08:29:12', '2015-09-07 08:29:12', '0', '1', NULL ),
( '423', 'WebshopHHW', 'http://webshophhw.eigenstart.nl/', 'Sabrine.blauw@yandex.com', '2015-09-07 10:03:47', '2015-09-07 10:03:47', '0', '1', NULL ),
( '424', 'Labradors', 'http://martmanders.eigenstart.nl', 'martmanders@hotmail.com', '2015-09-07 11:49:40', '2015-09-07 11:49:40', '0', '1', NULL ),
( '425', 'corm.eigenstart.nl', 'http://htpp:www.corm.eigenstart.nl', 'calmvanmierlo@gmail.com', '2015-09-07 11:52:04', '2015-09-07 11:52:04', '0', '1', NULL ),
( '426', 'algemene startpagina torrentsites,labrador,hoesjes,tv', 'http://martmanders.eigenstart.nl', 'martmanders@hotmail.com', '2015-09-07 11:52:38', '2015-09-07 11:52:38', '0', '1', NULL ),
( '427', 'slaapkamers', 'http://slaapkamers.eigenstart.nl/', 'thomasdejong24@gmail.com', '2015-09-07 14:59:01', '2015-09-07 14:59:01', '0', '1', NULL ),
( '428', 'blababla van Kees', 'http://www.keesbuis.eigenstart.nl', 'kees_buis@hotmail.com', '2015-09-07 15:19:11', '2015-09-07 15:19:11', '0', '1', NULL ),
( '429', 'joseph.eigenstart.nl', 'http://www.joseph.eigenstart.nl', 'jdas@hetnet.nl', '2015-09-07 15:33:21', '2015-09-07 15:33:21', '0', '1', NULL ),
( '430', 'belgieonline', 'http://belgieonline.eigenstart.be', 'lightsprinkle@live.be', '2015-09-07 16:11:41', '2015-09-07 16:11:41', '0', '1', NULL ),
( '431', 'rickdekikker', 'http://rickdekikker.eigenstart.nl/', 'deopperkikker@hotmail.com', '2015-09-07 18:55:40', '2015-09-07 18:55:40', '0', '1', NULL ),
( '432', 'DDoS Protected Web Hosting', 'http://www.hyperfilter.com/', 'hyperfilter243@gmail.com', '2015-09-07 21:01:43', '2015-09-07 21:01:43', '0', '1', NULL ),
( '433', 'Bouw en wonen', 'http://bouwenwonen.eigenstart.be', 'info@sempris.be', '2015-09-08 10:50:21', '2015-09-08 10:50:21', '0', '1', NULL ),
( '434', 'Bram van Beurden', 'http://bramvanbeurden.eigenstart.nl', 'bramvanbeurden@msn.com', '2015-09-08 14:29:33', '2015-09-08 14:29:33', '0', '1', NULL ),
( '435', 'hannekevoordouw', 'https://hannekvoordouw.eigenstart.nl', 'hvoordouw@yahoo.com', '2015-09-08 21:23:54', '2015-09-08 21:23:54', '0', '1', NULL ),
( '436', 'hondentrimmers.eigenstart', 'http://hondentrimmers.eigenstart.nl#sthash.BCfSyXIC.dpuf', 'dspeerstra@hotmail.com', '2015-09-09 10:27:49', '2015-09-09 10:27:49', '0', '1', NULL ),
( '437', 'Juf Nickey', 'http://www.jufnickey.eigenstart.nl', 'nickey@denoordwijkseschool.nl', '2015-09-09 10:37:05', '2015-09-09 10:37:05', '0', '1', NULL ),
( '438', 'Diverse handige links van Wajang', 'http://www.wajang.eigenstart.nl', 'wajang100@gmail.com', '2015-09-09 12:06:27', '2015-09-09 12:06:27', '0', '1', NULL ),
( '439', 'Wolfertisk', 'http://wolfertisk.eigenstart.nl', 'msc@wolfert.nl', '2015-09-09 12:32:21', '2015-09-09 12:32:21', '0', '1', NULL ),
( '440', 'Juf Nickey', 'http://www.jufnickey.eigenstart.nl', 'nickey@denoordwijkseschool.nl', '2015-09-09 14:06:25', '2015-09-09 14:06:25', '0', '1', NULL ),
( '441', 'Juf Nickey', 'http://www.jufnickey.eigenstart.nl', 'nickey@denoordwijkseschool.nl', '2015-09-09 14:08:39', '2015-09-09 14:08:39', '0', '1', NULL ),
( '442', 'rocster', 'http://www.rocster.eigenstart.nl/', 'cybersales@home.nl', '2015-09-09 15:22:37', '2015-09-09 15:22:37', '0', '1', NULL ),
( '443', 'Gebr. van Enkhuizen', 'http://www.gebrvanenkhuizen.eigenstart.nl', 'info@gebrvanenkhuizen.nl', '2015-09-09 15:22:47', '2015-09-09 15:22:47', '0', '1', NULL ),
( '444', 'giganto', 'http://giganto.eigenstart.nl/', 'jaaphubert@hotmail.com', '2015-09-09 15:52:00', '2015-09-09 15:52:00', '0', '1', NULL ),
( '445', 'Startpagina voor de de reformatorische gezindte', 'http://refostart.eigenstart.nl', 'jls@solcon.nl', '2015-09-09 17:06:39', '2015-09-09 17:06:39', '0', '1', NULL ),
( '446', 'Startpagina voor de de Reformatorische gezindte', 'http://www.refostart.eigenstart.nl', 'jls@solcon.nl', '2015-09-09 17:09:10', '2015-09-09 17:09:10', '0', '1', NULL ),
( '447', 'Muurdecoratie', 'http://www.muurdecoratie.eigenstart.nl', 'dekogifts@live.nl', '2015-09-09 19:10:40', '2015-09-09 19:10:40', '0', '1', NULL ),
( '448', 'annette.eigenstart.nl', 'http://annette.eigenstart.nl/', 'annette1@casema.nl', '2015-09-09 19:40:16', '2015-09-09 19:40:16', '0', '1', NULL ),
( '449', 'annetjuh', 'http://annetjuh.eigenstart.nl', 'annettevandervoort@live.nl', '2015-09-09 19:51:28', '2015-09-09 19:51:28', '0', '1', NULL ),
( '450', 'oeteldonk.', 'http://www.lruti.nl/STsnp/', 'ajwsmits@ziggo.nl', '2015-09-10 11:33:46', '2015-09-10 11:33:46', '0', '1', NULL ),
( '451', 'oeteldonk.', 'http://www.lruti.nl/STsnp/', 'ajwsmits@ziggo.nl', '2015-09-10 11:34:35', '2015-09-10 11:34:35', '0', '1', NULL ),
( '452', 'freaky', 'https://freaky.eigenoverzicht.nl', 'fbendijk@gmail.com', '2015-09-10 15:58:41', '2015-09-10 15:58:41', '0', '1', NULL ),
( '453', 'bouwen en wonen, wmo, aannemers ....', 'http://www.mart.eigenstart.nl', 'eemem@live.nl', '2015-09-10 22:16:52', '2015-09-10 22:16:52', '0', '1', NULL ),
( '454', 'kloetjes', 'http://www.kloetjes.eigenstart.nl', 'kloetjes@zonnet.nl', '2015-09-11 07:24:29', '2015-09-11 07:24:29', '0', '1', NULL ),
( '455', 'wattox', 'http://www.wattox.eigenstart.nl', 'walter_king70@hotmail.com', '2015-09-11 10:02:45', '2015-09-11 10:02:45', '0', '1', NULL ),
( '456', 'linniebinnie', 'http://www.linniebinnie.eigenstart.nl', 'jolin78_93@hotmail.com', '2015-09-11 10:12:23', '2015-09-11 10:12:23', '0', '1', NULL ),
( '457', 'Tips voor ondernemers', 'http://ondernemers-tips.eigenstart.nl/', 'emma.zaanlander@gmail.com', '2015-09-11 15:47:17', '2015-09-11 15:47:17', '0', '1', NULL ),
( '458', 'modelspoor', 'http://modelspoor.eigenstart.nl', 'info@eigenstart.nl', '2015-09-11 17:55:39', '2015-09-11 17:55:39', '0', '1', NULL ),
( '459', 'Baltus1956 startpagina', 'htpp://www.baltus1956.eigenstart.nl', 'henkvandersangen1956@gmail.com', '2015-09-12 09:29:33', '2015-09-12 09:29:33', '0', '1', NULL ),
( '460', 'elsbethvanvelzen', 'http://elsbethvanvelzen.eigenstart.nl', 'elsbethparmentier@gmail.com', '2015-09-12 10:00:32', '2015-09-12 10:00:32', '0', '1', NULL ),
( '461', 'Wulms', 'http://www.wulms.eigenstart.nl', 'pfcwulms@ziggo.nl', '2015-09-12 10:45:01', '2015-09-12 10:45:01', '0', '1', NULL ),
( '462', 'Bart van Lier', 'http://bartvanlier.eigenstart.nl', 'bartvanlier@hotmail.com', '2015-09-12 11:14:42', '2015-09-12 11:14:42', '0', '1', NULL ),
( '463', 'Free Music from all over the world', 'http://jeanne.eigenstart.nl', 'j.goethals-strijker@online.nl', '2015-09-12 13:02:17', '2015-09-12 13:02:17', '0', '1', NULL ),
( '464', 'arrowmuziek-foto', 'http://arrowmuziek-foto.eigenstart.nl', 'luckypijl@gmail.com', '2015-09-12 21:24:54', '2015-09-12 21:24:54', '0', '1', NULL ),
( '465', 'boo.eigenstart', 'http://www.boo.eigenstart.nl', 'eoosterhof4@chello.nl', '2015-09-12 22:22:29', '2015-09-12 22:22:29', '0', '1', NULL ),
( '466', 'ikke', 'http://www.ikke.eigenstart.nl/', 'raymund_antoin@hotmail.com', '2015-09-12 22:34:26', '2015-09-12 22:34:26', '0', '1', NULL ),
( '467', 'ron beukers', 'http://www.ronbeukers.eigenstart.nl', 'ron_beukers_84@hotmail.com', '2015-09-13 11:36:18', '2015-09-13 11:36:18', '0', '1', NULL ),
( '468', 'Doven', 'http://doven.eigenstart.nl/', 'thstoter@gmail.com', '2015-09-13 14:14:31', '2015-09-13 14:14:31', '0', '1', NULL ),
( '469', 'Doven', 'http://doven.eigenstart.nl/', 'thstoter@gmail.com', '2015-09-13 14:19:43', '2015-09-13 14:19:43', '0', '1', NULL ),
( '470', 'boo.eigenstart', 'http://www.boo.eigenstart.nl', 'eoosterhof4@chello.nl', '2015-09-13 14:44:02', '2015-09-13 14:44:02', '0', '1', NULL ),
( '471', 'boo.eigenstart', 'http://www.boo.eigenstart.nl', 'eoosterhof4@chello.nl', '2015-09-13 14:44:06', '2015-09-13 14:44:06', '0', '1', NULL ),
( '472', 'boo.eigenstart', 'http://www.boo.eigenstart.nl', 'booster2956@gmail.com', '2015-09-13 14:47:16', '2015-09-13 14:47:16', '0', '1', NULL ),
( '473', 'the-best.eigenstart.nl/', 'http://www.the-best.eigenstart.nl/', 'b_zoer@hotmail.com', '2015-09-13 14:54:53', '2015-09-13 14:54:53', '0', '1', NULL ),
( '474', 'Debbierick', 'http://debbierick.eigenstart.nl', 'dschuurman@hotmail.com', '2015-09-13 18:44:18', '2015-09-13 18:44:18', '0', '1', NULL ),
( '475', 'vreeman.eigenstart', 'http://http:/www.vreeman.eigenstart.nl', 'cindyvreeman@yahoo.com', '2015-09-13 18:56:58', '2015-09-13 18:56:58', '0', '1', NULL ),
( '476', 'overkilll', 'http://overkilll.eigenstart.nl', 'jos.truyen@kpnmail.nl', '2015-09-14 08:45:58', '2015-09-14 08:45:58', '0', '1', NULL ),
( '477', 'vroomshoop', 'http://vroomshoop.eigenstart.nl/', 'jwgerrits@caiway.nl', '2015-09-14 11:16:55', '2015-09-14 11:16:55', '0', '1', NULL );
-- ---------------------------------------------------------


-- Dump data of "price_types" ------------------------------
INSERT INTO `price_types`(`id`,`title`) VALUES 
( '1', 'грн' ),
( '2', '$' ),
( '3', 'Є' );
-- ---------------------------------------------------------


-- Dump data of "product" ----------------------------------
INSERT INTO `product`(`id`,`name`,`title`,`description`,`price`,`created`,`updated`) VALUES 
( '1', 'Koop een link op deze pagina voor 30 dagen', 'default', 'Koop een link op deze pagina voor 30 dagen. Klik hier om verder te gaan.', '8', '2015-06-23 07:54:12', '2015-07-17 08:18:32' ),
( '2', 'Koop een link op deze pagina voor 30 dagen', 'homepage', 'Koop een link op deze pagina voor 30 dagen. Klik hier om verder te gaan.', '20', '2015-06-23 07:54:29', '2015-07-17 08:18:09' );
-- ---------------------------------------------------------


-- Dump data of "regions" ----------------------------------
INSERT INTO `regions`(`id`,`name`) VALUES 
( '1', 'Автономна Республіка Крим' ),
( '2', 'Вінницька область' ),
( '3', 'Волинська область' ),
( '4', 'Дніпропетровська область' ),
( '5', 'Донецька область' ),
( '6', 'Житомирська область' ),
( '7', 'Закарпатська область' ),
( '8', 'Запорізька область' ),
( '9', 'Івано-Франківська область' ),
( '10', 'Київська область' ),
( '11', 'Кіровоградська область' ),
( '12', 'Луганська область' ),
( '13', 'Львівська область' ),
( '14', 'Миколаївська область' ),
( '15', 'Одеська область' ),
( '16', 'Полтавська область' ),
( '17', 'Рівненська область' ),
( '18', 'Сумська область' ),
( '19', 'Тернопільська область' ),
( '20', 'Харківська область' ),
( '21', 'Херсонська область' ),
( '22', 'Черкаська область' ),
( '23', 'Чернівецька область' ),
( '24', 'Чернігівська область' );
-- ---------------------------------------------------------


-- Dump data of "roles" ------------------------------------
INSERT INTO `roles`(`id`,`name`) VALUES 
( '1', 'ROLE_ADMIN' ),
( '2', 'ROLE_USER' ),
( '3', 'ROLE_WEB_DEVELOPER' );
-- ---------------------------------------------------------


-- Dump data of "static_page" ------------------------------
INSERT INTO `static_page`(`id`,`title`,`slug`,`keywords`,`description`,`content`,`created`,`updated`) VALUES 
( '1', 'Uitleg', 'uitleg', NULL, NULL, 'Bouw je gratis eigen startpagina! Vul op de <a href="/">voorpagina</a> je gewenste URL in en je kunt direct aan de slag met de ontwikkeling van je eigen, gratis startpagina.<br>', '0000-00-00 00:00:00', '2015-07-16 12:52:06' ),
( '2', 'Contact opnemen', 'contact-opnemen-2', NULL, NULL, 'Heb je een vraag over onze website? Neem dan contact op via dit formulier!', '0000-00-00 00:00:00', '2015-07-29 10:59:33' ),
( '3', 'Algemene voorwaarden', 'algemene-voorwaarden-3', NULL, 'De algemene voorwaarden van Eigenstart.nl. De algemene voorwaarden van Eigenstart.nl. De algemene voorwaarden van Eigenstart.nl.', '<p><b>Samenvatting voorwaarden eigenstart.nl </b></p>
      <ul><li>Het is verboden informatie te publiceren middels onze service die in strijd is met het Nederlands Recht.</li><li>Het is verboden auteursrechten te schenden d.m.v het verspreiden en/of publiceren van beschermd foto-,video- of muziekmateriaal.</li><li>Het is verboden informatie te publiceren die niet in 
overeenstemming is met het u door u geselecteerde genre, onderwerp of 
doelgroepbenadering.</li><li> Het is verboden gebruik te maken van programma\'s die 
automatisch pagina\'s registeren en/of hits kunstmatig verhogen d.m.v 
popups of openstaande browsers.</li><li> Het is verboden te registeren en pagina\'s te beheren met ongeldige en/of verlopen emailadressen</li><li> Het is verboden dezelfde content meerdere malen te publiceren op verschillende dochterpagina\'s.</li><li> Het is verboden websites te publiceren die promotie 
verlenen aan "paid2surf", "paid2click" en soortgelijke diensten zonder 
deze aan te geven bij uw profiel. (zie inhoudsbepaling bij uw profiel)</li><li> Het is verboden gokgerelateerde websites en/of links te publiceren.</li><li> Het is verboden websites te publiceren die alleen geschikt 
zijn voor volwassen publiek en dit niet juist te kenmerken in het 
profiel.</li><li>Het is verboden producten en/of levensmiddelen aan te bieden
 die niet overeenkomstig zijn met het Nederlands Recht en 
respectievelijk de Keuringsdienst van Waren.<br>
		</li><li>Het is verboden erotisch gerelateerd en/of pornografisch materiaal te publiceren.<br>
          <br>
        </li></ul>
      <p> Het niet naleven van onderstaande voorwaarden betekent dat 
Eigenstart.nl gerechtigd is zonder kennisgeving de website te 
verwijderen en alle kosten te verhalen op de ingeschreven partij. 
Tijdens de inschrijving is uw IP-adres in onze database opgenomen. Deze 
zal worden vrijgegeven aan desbetreffende juridische instantie en worden
 gebruikt voor de aansprakelijkheid indien u de voorwaarden niet 
naleeft. <br>
          <br>
          <font color="#FF0000"><strong>U bent dus geheel 
verantwoordelijk voor de inhoud van de door u geregistreerde pagina\'s en
 zo zal u ook aangerekend worden indien u de voorwaarden niet naleeft.</strong></font><br>
  <br>
        Hieronder volgen de expliciete voorwaarden waaraan uw website dient te voldoen alvorens u deze publiceert. </p>
      <p><b> Voorwaarden:<br>
        </b>Hieronder kunt u lezen aan wat voor voorwaarden uw pagina moet voldoen. 
        Tevens wijzen wij u op andere belangrijke informatie
        omtrent het project eigenstart.nl. Lees deze voorwaarden aandachtig door 
        voordat u akkoord gaat met uw aanvraag.<b> </b>Eigenstart.nl is een project van Netoda. <br>
          <br>
        In deze voorwaarden 
        zal Netoda BV, eigenaar van Eigenstart.nl benoemd worden als 
        Eigenstart.nl. <b><br>
          </b> <br>
        Gebruik van enige informatie verkregen middels deze website gebeurt 
        voor risico van de gebruiker. Eigenstart.nl slaat geen financiële 
        gegevens op en tevens wordt uw emailadres niet aan derden verstrekt 
        zonder uw expliciete toestemming.<br>
            <br>
        Als u gebruik gaat maken van Eigenstart.nl, gaat u expliciet 
akkoord 
        met het ontvangen van aanbiedingen van Netoda. Eigenstart.nl spant zich in te waarborgen dat de te 
verkrijgen informatie 
        en het aanbod van relevante content waarnaar wordt verwezen en 
waarin 
        eigenstart.nl als portal fungeert volledig en juist is, 
daarentegen 
        kan eigenstart.nl niet verantwoordelijk worden gehouden voor 
enige onvolledige 
        of onjuiste informatie die middels deze website gevonden wordt. 
Eigenstart.nl 
        aanvaardt geen enkele aansprakelijkheid voor schade ontstaan uit
 het 
        bezoeken van deze site of voor enige schade ontstaan uit 
verleende diensten, 
        aangeboden of verwezen content. </p>
      <p>Eigenstart.nl geeft geen enkele garantie, met betrekking tot de geschiktheid 
        voor een specifiek gebruiksdoel, de functionaliteit, beschikbaarheid of bruikbaarheid 
        van haar diensten. Eigenstart.nl aanvaardt geen aansprakelijkheid voor 
        schade ontstaan door het downloaden, de installatie of het gebruik van 
        deze software, behoudens bepalingen van dwingend recht inzake aansprakelijkheid.</p>
      <p>Eigenstart.nl behoudt zich het recht voor pagina\'s te 
verwijderen die inhoudelijk 
        niet aan de door eigenstart gestelde eisen voldoen.
        De inhoud van de pagina\'s mogen geen rascistische of beledigende
 aanstootgevende 
        elementen bevatten. Tevens hanteert Eigenstart.nl een streng 
beleid voor erotische en gokgerelateerde pagina\'s. Erotische pagina\'s 
        behoren discreet te worden opgemaakt. (Afbeeldingen op
        de index van geslachtsdelen/penetratie en ander aanstootgevend 
materiaal 
        wordt niet getolereerd!) Indien de redactie van 
        Eigenstart.nl uw pagina om wat voor reden dan ook aanstootgevend
 beoordeeld 
        zal uw pagina zonder enige kennisgeving
        worden verwijderd. Gokrelateerde pagina\'s dienen alleen links te
 publiceren die in overeenkomst zijn met het Nederlands Recht. Wij 
controleren alle pagina\'s regelmatig op onjuistheden. 
        Algemene onjuistheden worden over het algemeen
        per email naar u toegestuurd.<br>
  <br>
        Eigenstart.nl is een iniatief dat wil bijdragen aan goede 
informatievoorziening voor mensen die deze portaal en/of dochter 
bezoeken.<br>
        Eigenstart.nl behoudt zich het recht voor pagina\'s te 
verwijderen of toe te eigenen die grotendeels uit commercieële links 
bestaan. </p>
      <p> Eigenstart.nl aanvaardt geen aansprakelijkheid voor 
        schade ontstaan door publicaties die auteursrechten van derden schenden.
        Dergelijke kosten zullen worden verhaald op de desbetreffende partij waaronder deze publicaties hebben plaatsgevonden.<br>
            <br>
        Eigenstart.nl is een project van Netoda. De 
domeinnaam eigenstart.nl en alle onderliggende .NL en .WS domeinen 
inclusief subdomeinen zijn in het bezit van Netoda. Het is niet toegestaan pagina\'s te verkopen 
of andere 
        commercieële activiteiten te ondernemen omtrent 
        deze domeinnaam zonder expliciete toestemming van de uitgever. </p>
      <p>Eigenstart 
        behoudt zich het recht voor ten aller tijden alle mogelijke subdomeinen 
        te gebruiken voor door ons gestelde doeleinden. Wanneer uw aangevraagde 
        Eigenstart subdomeinnaam zal 
        worden gebruikt voor verdere ontwikkeling door Eigenstart.nl zelf zal u 
        hiervanop de hoogte worden gesteld.<br>
            <br>
        De eigenstart.nl-site bevat verwijzingen of hyperlinks naar andere 
        sites die buiten het domein van Eigenstart.nl liggen. Deze zijn opgenomen 
        ter informatie van de gebruikers en te goeder trouw geselecteerd voor 
        de doelgroepen van eigenstart.nl. Eigenstart.nl is niet verantwoordelijk 
        voor de inhoud of beschikbaarheid van deze sites of bronnen. Eigenstart.nl 
        geeft geen garantie noch aanvaardt zij enigerlei aansprakelijkheid met 
        betrekking tot de inhoud, data, adviezen, verklaringen, software, producten 
        of ander materiaal op dergelijke sites of bronnen. Tevens maakt eigenstart.nl 
        gebruik van \'gesloten \' messaging systemen. Eigenstart.nl aanvaardt 
        geen enkele aansprakelijkheid voor schade ontstaan uit het bezoeken, 
        verbinden of gebruik maken van deze systemen. </p>
      <p>Het technisch functioneren van de verbindingen vallen onder 
        het risico van de exploitant van de verbinding. Eigenstart.nl 
        aanvaardt op geen enkele wijze aansprakelijkheid voor schade voortvloeiend 
        uit de verplichtingen van de leverancier. Eigenstart.nl vrijwaart 
        zich voor enige vorm van aansprakelijkheid vanwege een niet onbelemmerde 
        toegang tot de diensten van eigenstart.nl en Eigenstart.nl geeft geen 
        garantie met betrekking tot het functioneren van de site van eigenstart.nl. 
        Tevens is Eigenstart.nl niet aansprakelijk voor eventuele virussen op 
        de site of de server van eigenstart.nl die de informatie toegankelijk 
        maakt. Eigenstart.nl 
        is in geen enkel geval aansprakelijk voor winstderving of voor bijzondere, incidentele, 
        indirecte, bijkomende of enige andere schade die voortvloeit uit of 
        verband houdt met het functioneren van onze site of met onze diensten 
        ongeacht op welke wijze deze schade ontstaat. </p>
      <br><b>
        Copyright Eigenstart.nl 2001-2015 © </b>', '0000-00-00 00:00:00', '2015-08-12 23:24:51' ),
( '4', 'free-own-start-page', 'free-own-start-page', NULL, 'Je eigen gratis startpagina. Je eigen gratis startpagina. Je eigen gratis startpagina. Je eigen gratis startpagina.', '<ol><li><b>&nbsp;&nbsp;&nbsp; Gratis lid worden!</b></li><li><b>&nbsp;&nbsp;&nbsp; Ontvang bezoek vanuit netwerk</b></li><li><b>&nbsp;&nbsp;&nbsp; Gratis hosten van plaatjes</b></li><li><b>&nbsp;&nbsp;&nbsp; Gratis subdomein</b></li><li><b>&nbsp;&nbsp;&nbsp; RSS + vele tools! </b></li></ol>', '0000-00-00 00:00:00', '2015-07-06 12:24:07' ),
( '5', 'Registreer je nu!', 'registreer-je-nu-5', NULL, 'Registreer een gratis startpagina. Registreer een gratis startpagina.', '<i>Nieuws update 17-08-2015: </i><br><br><b>1) Om weer te kunnen inloggen dien je eenmalig je wachtwoord te resetten. Dit kunt u <a href="http://eigenstart.nl/resetting/request">hier</a> doen.</b><br><br>2) <b>Voer hier links op de vorpagina uw URL van uw Eigenstart pagina in, en wij zorgen ervoor dat hij het weer doet!<br><br><br>Welkom op de geheel vernieuwde website van Eigenstart.nl! De volledige website is opnieuw opgebouwd en zal binnenkort nog meer nieuwe features gaan bevatten, waardoor het opzetten van een startpagina nog veel fijner en eenvoudiger wordt!</b><br><br>Eigenstart.nl is een platform waarop je gratis een eigen startpagina kunt aanmaken. Je startpagina wordt dan jouwnaam.eigenstart.nl.<br>Wij zijn al actief sind 2001 en zijn daarmee een van de oudste startpagina\'s van Nederland! In 2015 hebben wij ons hele platform vernieuwd, waardoor je nu nog beter en eenvoudig een startpagina kunt maken.<br><br><b>Registreer hieronder je eigen nieuwe Eigenstart.nl pagina. Gratis!</b>', '0000-00-00 00:00:00', '2015-08-17 09:34:25' ),
( '6', 'Category', 'category', NULL, NULL, 'test', '0000-00-00 00:00:00', '2015-07-16 13:36:33' ),
( '7', 'Catalog', 'catalog', NULL, NULL, 'Hieronder vindt u een overzicht van alle dochterpagina\'s in het Eigenstart netwerk. Klik op een categorie om alle pagina\'s te zien.', '0000-00-00 00:00:00', '0000-00-00 00:00:00' ),
( '8', 'Over Eigenstart.nl', 'over-eigenstart', NULL, 'Eigenstart.nl - Wie zijn wij en waarom zijn wij de modernste startpagina van Nederland?', '<b>Welkom op Eigenstart.nl. </b>Eigenstart.nl is in Juli 2015 geheel vernieuwd, waardoor het nu een actueele website is die volkomen voldoet aan de huidige standaarden.<br><br>Eigenstart.nl is hiermee een stap verder dan vele andere startpagina\'s, waardoor het aanmaken van een startpagina op Eigenstart.nl extra aantrekkelijk is geworden.<br><br>Maak dus nu een gratis startpagina bij ons aan! Je kunt onder andere kleuren wijzigen, Youtube video\'s toevoegen en nog veel meer. Ook zullen er binnenkort nog vele nieuwe features toegevoegd worden.<br><br>Mocht je nog vragen of suggesties hebben, laat deze dan weten op onze contactpagina!<br><br>Succes!<br>Groeten,<br>Het Eigenstart.nl Team', '0000-00-00 00:00:00', '2015-07-29 08:23:43' );
-- ---------------------------------------------------------


-- Dump data of "themes" -----------------------------------
-- ---------------------------------------------------------


-- Dump data of "top_link_categories" ----------------------
INSERT INTO `top_link_categories`(`id`,`name`) VALUES 
( '1', 'Vakantie' ),
( '2', 'Email & Sociale Media' ),
( '3', 'Nieuws' ),
( '4', 'Weblogs' ),
( '5', 'Dating' ),
( '6', 'Internet & TV' ),
( '7', 'Verzekeren' ),
( '8', 'Acties' ),
( '9', 'Overig' ),
( '10', 'Online shoppen' );
-- ---------------------------------------------------------


-- Dump data of "top_links" --------------------------------
INSERT INTO `top_links`(`id`,`text`,`url`,`created`,`updated`,`category_id`) VALUES 
( '6', 'Arke.nl', 'http://arke.nl/', '2015-08-20 11:45:46', '2015-08-20 11:45:46', '1' ),
( '7', 'Corendon.nl', 'http://corendon.nl/', '2015-08-20 11:46:04', '2015-08-20 11:46:04', '1' ),
( '8', 'Centerparcs.nl', 'http://centerparcs.nl/', '2015-08-20 11:50:19', '2015-08-20 11:50:19', '1' ),
( '9', 'Suntip.nl', 'http://suntip.nl/', '2015-08-20 11:53:19', '2015-08-20 11:53:19', '1' ),
( '10', 'Outlook.com', 'http://outlook.com/', '2015-08-20 11:53:31', '2015-08-20 11:53:31', '2' ),
( '11', 'Mail.com', 'http://mail.com/', '2015-08-20 11:53:48', '2015-08-20 11:53:48', '2' ),
( '12', 'Gmail.com', 'http://gmail.com/', '2015-08-20 11:54:05', '2015-08-20 11:54:05', '2' ),
( '13', 'Hushmail.com', 'http://hushmail.com/', '2015-08-20 11:54:16', '2015-08-20 11:54:16', '2' ),
( '14', 'Facebook.com', 'http://facebook.com/', '2015-08-20 11:54:29', '2015-08-20 11:54:29', '2' ),
( '15', 'Twitter.com', 'http://twitter.com/', '2015-08-20 11:54:40', '2015-08-20 11:54:40', '2' ),
( '16', 'Youtube.com', 'http://youtube.com/', '2015-08-20 11:54:51', '2015-08-20 11:54:51', '2' ),
( '17', 'Nu.nl', 'http://nu.nl/', '2015-08-20 11:55:17', '2015-08-20 11:55:17', '3' ),
( '18', 'Telegraaf.nl', 'http://telegraaf.nl/', '2015-08-20 11:55:31', '2015-08-20 11:55:31', '3' ),
( '19', 'Volkskrant.nl', 'http://volkskrant.nl/', '2015-08-20 11:55:43', '2015-08-20 11:55:43', '3' ),
( '20', 'NOS.nl', 'http://nos.nl/', '2015-08-20 11:55:55', '2015-08-20 11:55:55', '3' ),
( '21', 'Rtl.nl', 'http://rtl.nl/', '2015-08-20 11:56:21', '2015-08-20 11:56:21', '3' ),
( '22', 'Nrc.nl', 'http://nrc.nl/', '2015-08-20 11:57:35', '2015-08-20 11:57:35', '3' ),
( '23', 'Trouw.nl', 'http://trouw.nl/', '2015-08-20 11:57:44', '2015-08-20 11:57:44', '3' ),
( '24', 'Geenstijl.nl', 'http://geenstijl.nl/', '2015-08-20 11:58:06', '2015-08-20 11:58:06', '4' ),
( '25', 'Sargasso.nl', 'http://sargasso.nl/', '2015-08-20 11:58:23', '2015-08-20 11:58:23', '4' ),
( '26', 'Fhm.nl', 'http://fhm.nl/', '2015-08-20 11:58:32', '2015-08-20 11:58:32', '4' ),
( '27', 'Gratisdatingsite.nl', 'http://gratisdatingsite.nl/', '2015-08-20 11:58:56', '2015-08-20 11:58:56', '5' ),
( '28', 'Parship.nl', 'http://parship.nl/', '2015-08-20 11:59:07', '2015-08-20 11:59:07', '5' ),
( '29', 'KPN', 'http://kpn.com/', '2015-08-20 11:59:20', '2015-08-20 11:59:20', '6' ),
( '30', 'Tele2', 'http://tele2.nl/', '2015-08-20 11:59:33', '2015-08-20 11:59:33', '6' ),
( '31', 'Telfort', 'http://telfort.nl/', '2015-08-20 11:59:42', '2015-08-20 11:59:42', '6' ),
( '32', 'Internet vergelijken', 'http://internetvergelijken.nl/', '2015-08-20 11:59:55', '2015-08-20 11:59:55', '6' ),
( '33', 'Independer', 'http://independer.nl/', '2015-08-20 12:00:06', '2015-08-20 12:00:06', '7' ),
( '34', 'WA Verzekeringen', 'http://aansprakelijkheidsverzekering.com/', '2015-08-20 12:00:16', '2015-08-20 12:00:16', '7' ),
( '35', 'Rechtsbijstandverzekeringen', 'http://rechtsbijstandverzekering.net/', '2015-08-20 12:01:50', '2015-08-20 12:01:50', '7' ),
( '36', 'Autoverzekeringen', 'http://allsecur.nl/', '2015-08-20 12:02:09', '2015-08-20 12:02:09', '7' ),
( '37', 'OHRA', 'http://ohra.nl/', '2015-08-20 12:02:18', '2015-08-20 12:02:18', '7' ),
( '38', 'Allianz', 'http://allianz.nl/', '2015-08-20 12:02:27', '2015-08-20 12:02:27', '7' ),
( '39', 'Unive', 'http://unive.nl/', '2015-08-20 12:02:35', '2015-08-20 12:02:35', '7' ),
( '40', 'Anwb', 'http://anwb.nl/', '2015-08-20 12:02:44', '2015-08-20 12:02:44', '7' ),
( '41', 'Mr Kortingscode', 'http://mrkortingscode.nl/', '2015-08-20 12:03:44', '2015-08-20 12:03:44', '8' ),
( '42', 'Mijnkortingscode.nl', 'http://mijnkortingscode.nl/', '2015-08-20 12:03:54', '2015-08-20 12:03:54', '8' ),
( '43', 'Couponcode.nu', 'http://couponcode.nu/', '2015-08-20 12:04:19', '2015-08-20 12:04:19', '8' ),
( '44', 'Vouchercodes', 'http://vouchercode.nl/', '2015-08-20 12:04:35', '2015-08-20 12:04:35', '8' ),
( '45', 'NHA', 'http://nha.nl/', '2015-08-20 12:04:48', '2015-08-20 12:04:48', '9' ),
( '46', 'NTI', 'http://nti.nl/', '2015-08-20 12:04:56', '2015-08-20 12:04:56', '9' ),
( '47', 'Auto', 'http://auto.nl/', '2015-08-20 12:05:05', '2015-08-20 12:05:05', '9' ),
( '48', 'Gratiz', 'http://gratiz.nl/', '2015-08-20 12:05:16', '2015-08-20 12:05:16', '9' ),
( '49', 'Spelletjes.nl', 'http://spelletjes.nl/', '2015-08-20 12:05:28', '2015-08-20 12:05:28', '9' ),
( '50', 'Weer', 'http://weer.nl/', '2015-08-20 12:05:36', '2015-08-20 12:05:36', '9' ),
( '51', 'BOL', 'http://bol.com/', '2015-08-20 12:05:47', '2015-08-20 12:05:47', '10' ),
( '52', 'Wehkamp', 'http://wehkamp.nl/', '2015-08-20 12:05:57', '2015-08-20 12:05:57', '10' ),
( '53', 'Zalando', 'http://zalando.nl/', '2015-08-20 12:06:08', '2015-08-20 12:06:08', '10' ),
( '54', 'Glasvezel vergelijken', 'http://glasvezelvergelijken.org/', '2015-08-20 14:20:03', '2015-08-20 14:20:03', '6' );
-- ---------------------------------------------------------


-- Dump data of "user_role" --------------------------------
INSERT INTO `user_role`(`user_id`,`role_id`) VALUES 
( '1', '2' ),
( '1', '3' ),
( '2', '2' ),
( '3', '2' ),
( '15', '2' ),
( '16', '2' ),
( '17', '2' ),
( '18', '2' ),
( '19', '2' ),
( '20', '2' ),
( '21', '2' );
-- ---------------------------------------------------------


-- Dump data of "user_settings" ----------------------------
INSERT INTO `user_settings`(`id`,`user_id`,`notifications_email`,`spam_email`,`notifications_sms`,`number_for_sms`) VALUES 
( '1', '1', '0', '0', '1', '+380978781424' ),
( '2', '2', '0', '0', '0', NULL ),
( '10', '3', '0', '0', '0', NULL ),
( '11', '15', NULL, NULL, NULL, NULL ),
( '12', '16', NULL, NULL, NULL, NULL ),
( '13', '17', NULL, NULL, NULL, NULL ),
( '14', '18', NULL, NULL, NULL, NULL ),
( '15', '19', NULL, NULL, NULL, NULL ),
( '16', '20', NULL, NULL, NULL, NULL ),
( '17', '21', NULL, NULL, NULL, NULL );
-- ---------------------------------------------------------


-- Dump data of "user_votes" -------------------------------
-- ---------------------------------------------------------


-- Dump data of "users" ------------------------------------
INSERT INTO `users`(`id`,`username`,`password`,`email`,`name`,`registered`,`lastactive`,`active`,`avatar`,`language_id`,`telephone_number`,`skype`,`city`,`region_id`,`deleted`,`rating`,`vk_id`,`fb_id`) VALUES 
( '1', 'riki34@spaces.ru', 'ef85bca36d0080aa5dd71bdff2a7a22e48e2c1ce96565e41b4e73aa26a52161a7ace7c83fc169afc441d729e1b656cd6fea9c6e85ff0ce1cf2bbb53b4b47ee79', 'riki34@spaces.ru', 'Vlad', '2015-04-04 05:31:24', '2015-04-04 05:31:24', '1', '/avatars/riki34@spaces.ru/riki34@spaces.ru562f8cbce1eb8.jpg', NULL, '+380978781424', 'vladislav.kosko', 'Uzhgorod', '7', '0', '10', NULL, NULL ),
( '2', 'lyashenkonik@gmail.com', '316605b7ad4c069dd8579973c9f1b4fec1e565d744d2a9230703166d23a4663251e1ebf05aad47e93100d8d5a2c3f6eeab596ce2b587dc80dde6a717b0c054d9', 'lyashenkonik@gmail.com', NULL, '2015-04-05 17:53:43', '2015-04-05 17:53:43', '0', 'default/user_default.png', NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL ),
( '3', 'vladislav.kosko@gmail.com', '2e6401531190d2c9ea5a91d4a16ed8ee026419d3703ee00f70defeae0416d2645b8bddb4d9a87fc8d6c5c812a0157bf59cab49b56b62aaed35a065637f509a6c', 'vladislav.kosko@gmail.com', NULL, '2015-04-12 21:17:57', '2015-04-12 21:17:57', '0', 'default/user_default.png', NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL ),
( '15', 'vla@vla.com', '329741c9824e8b0d237afdfa052d9ca7fdc93f43b58e7de0ed9fe45b748f7235778531b6d4aefc454d907e88458ebcbc3cdf1a896990ace1030e0df52221709b', 'vla@vla.com', 'Vlad', '2015-10-27 18:24:11', '2015-10-27 18:24:11', '0', '/css/img/icon-user-default.png', NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL ),
( '16', 'qwe@qwe.com', '2e6401531190d2c9ea5a91d4a16ed8ee026419d3703ee00f70defeae0416d2645b8bddb4d9a87fc8d6c5c812a0157bf59cab49b56b62aaed35a065637f509a6c', 'qwe@qwe.com', 'Vlad', '2015-10-27 18:28:38', '2015-10-27 18:28:38', '0', '/css/img/icon-user-default.png', NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL ),
( '17', 'qs@as.com', '2e6401531190d2c9ea5a91d4a16ed8ee026419d3703ee00f70defeae0416d2645b8bddb4d9a87fc8d6c5c812a0157bf59cab49b56b62aaed35a065637f509a6c', 'qs@as.com', 'Vla', '2015-10-27 18:29:27', '2015-10-27 18:29:27', '0', '/css/img/icon-user-default.png', NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL ),
( '18', 'ssd@ssd.com', '2e6401531190d2c9ea5a91d4a16ed8ee026419d3703ee00f70defeae0416d2645b8bddb4d9a87fc8d6c5c812a0157bf59cab49b56b62aaed35a065637f509a6c', 'ssd@ssd.com', 'Vla', '2015-10-27 18:32:33', '2015-10-27 18:32:33', '0', '/css/img/icon-user-default.png', NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL ),
( '19', 'awdawd', '67832d2c48e4ee33f8ac07e5a6ab80d1ab4401daaa0c687077148206fa5844d5829c0fe69855467f36a3cc2742bb14e327e30e53bc5a8b3e493191699ada8705', 'awdawd', 'dawdawd', '2015-10-28 00:19:19', '2015-10-28 00:19:19', '0', '/css/img/icon-user-default.png', NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL ),
( '20', 'ivan111@gmal.com', 'cce07c5fa918838c883849142d589b30d726c7f950ec1ea872ded13582bcc83456395cd972e2eb935be375c96adf2a26b1a1e4b4964e98f9601e36f1de31c1fe', 'ivan111@gmal.com', 'Ivan', '2015-10-28 05:16:03', '2015-10-28 05:16:03', '1', '/css/img/icon-user-default.png', NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL ),
( '21', 'vladsadaw@dwakwdj.com', '774830106a1bf3b85a99c3af652ba6340fa95c04b633ef8c985b2c98ab82fe191fc9c56d0fcef2619632dd9c3746e339cd23a48238f765b39ee1a53591686304', 'vladsadaw@dwakwdj.com', 'ekjhfd.lke', '2015-10-29 16:35:08', '2015-10-29 16:35:08', '0', '/css/img/icon-user-default.png', NULL, NULL, NULL, NULL, NULL, '0', '0', NULL, NULL );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_579D2BBEC54C8C93" ---------------------
CREATE INDEX `IDX_579D2BBEC54C8C93` USING BTREE ON `advertisment_categories`( `type_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_963FB19112469DE2" ---------------------
CREATE INDEX `IDX_963FB19112469DE2` USING BTREE ON `advertisment_subcategories`( `category_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_1E87895912469DE2" ---------------------
CREATE INDEX `IDX_1E87895912469DE2` USING BTREE ON `advertisments`( `category_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_1E87895998260155" ---------------------
CREATE INDEX `IDX_1E87895998260155` USING BTREE ON `advertisments`( `region_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_1E878959A76ED395" ---------------------
CREATE INDEX `IDX_1E878959A76ED395` USING BTREE ON `advertisments`( `user_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_1E878959AE6A44CF" ---------------------
CREATE INDEX `IDX_1E878959AE6A44CF` USING BTREE ON `advertisments`( `price_type_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_1E878959C54C8C93" ---------------------
CREATE INDEX `IDX_1E878959C54C8C93` USING BTREE ON `advertisments`( `type_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_1E878959F7BFE87C" ---------------------
CREATE INDEX `IDX_1E878959F7BFE87C` USING BTREE ON `advertisments`( `sub_category_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_47C4FAD671731BCA" ---------------------
CREATE INDEX `IDX_47C4FAD671731BCA` USING BTREE ON `attachments`( `advertisment_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_402D7ABC544B7DEE" ---------------------
CREATE INDEX `IDX_402D7ABC544B7DEE` USING BTREE ON `back_links`( `user_page_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_C2521BF1441B8B65" ---------------------
CREATE INDEX `IDX_C2521BF1441B8B65` USING BTREE ON `conversations`( `user2_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_C2521BF156AE248B" ---------------------
CREATE INDEX `IDX_C2521BF156AE248B` USING BTREE ON `conversations`( `user1_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_C2521BF171731BCA" ---------------------
CREATE INDEX `IDX_C2521BF171731BCA` USING BTREE ON `conversations`( `advertisment_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "log_class_lookup_idx" ---------------------
CREATE INDEX `log_class_lookup_idx` USING BTREE ON `ext_log_entries`( `object_class` );
-- ---------------------------------------------------------


-- CREATE INDEX "log_date_lookup_idx" ----------------------
CREATE INDEX `log_date_lookup_idx` USING BTREE ON `ext_log_entries`( `logged_at` );
-- ---------------------------------------------------------


-- CREATE INDEX "log_user_lookup_idx" ----------------------
CREATE INDEX `log_user_lookup_idx` USING BTREE ON `ext_log_entries`( `username` );
-- ---------------------------------------------------------


-- CREATE INDEX "log_version_lookup_idx" -------------------
CREATE INDEX `log_version_lookup_idx` USING BTREE ON `ext_log_entries`( `object_id`, `object_class`, `version` );
-- ---------------------------------------------------------


-- CREATE INDEX "translations_lookup_idx" ------------------
CREATE INDEX `translations_lookup_idx` USING BTREE ON `ext_translations`( `locale`, `object_class`, `foreign_key` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_E46960F571731BCA" ---------------------
CREATE INDEX `IDX_E46960F571731BCA` USING BTREE ON `favorites`( `advertisment_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_E46960F5A76ED395" ---------------------
CREATE INDEX `IDX_E46960F5A76ED395` USING BTREE ON `favorites`( `user_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_36AC99F112469DE2" ---------------------
CREATE INDEX `IDX_36AC99F112469DE2` USING BTREE ON `link`( `category_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_36AC99F1544B7DEE" ---------------------
CREATE INDEX `IDX_36AC99F1544B7DEE` USING BTREE ON `link`( `user_page_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_DB021E969AC0396" ----------------------
CREATE INDEX `IDX_DB021E969AC0396` USING BTREE ON `messages`( `conversation_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_DB021E96A76ED395" ---------------------
CREATE INDEX `IDX_DB021E96A76ED395` USING BTREE ON `messages`( `user_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_154232DE7E3C61F9" ---------------------
CREATE INDEX `IDX_154232DE7E3C61F9` USING BTREE ON `themes`( `owner_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_449D086C12469DE2" ---------------------
CREATE INDEX `IDX_449D086C12469DE2` USING BTREE ON `top_links`( `category_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_2DE8C6A3A76ED395" ---------------------
CREATE INDEX `IDX_2DE8C6A3A76ED395` USING BTREE ON `user_role`( `user_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_2DE8C6A3D60322AC" ---------------------
CREATE INDEX `IDX_2DE8C6A3D60322AC` USING BTREE ON `user_role`( `role_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_B3498197A76ED395" ---------------------
CREATE INDEX `IDX_B3498197A76ED395` USING BTREE ON `user_votes`( `user_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_1483A5E982F1BAF4" ---------------------
CREATE INDEX `IDX_1483A5E982F1BAF4` USING BTREE ON `users`( `language_id` );
-- ---------------------------------------------------------


-- CREATE INDEX "IDX_1483A5E998260155" ---------------------
CREATE INDEX `IDX_1483A5E998260155` USING BTREE ON `users`( `region_id` );
-- ---------------------------------------------------------


-- CREATE LINK "FK_A295BD91ADA40271" -----------------------
ALTER TABLE `Payment`
	ADD CONSTRAINT `FK_A295BD91ADA40271` FOREIGN KEY ( `link_id` )
	REFERENCES `link`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_ACF436DBADA40271" -----------------------
ALTER TABLE `PaymentDetails`
	ADD CONSTRAINT `FK_ACF436DBADA40271` FOREIGN KEY ( `link_id` )
	REFERENCES `link`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_579D2BBEC54C8C93" -----------------------
ALTER TABLE `advertisment_categories`
	ADD CONSTRAINT `FK_579D2BBEC54C8C93` FOREIGN KEY ( `type_id` )
	REFERENCES `advertisment_types`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_963FB19112469DE2" -----------------------
ALTER TABLE `advertisment_subcategories`
	ADD CONSTRAINT `FK_963FB19112469DE2` FOREIGN KEY ( `category_id` )
	REFERENCES `advertisment_categories`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_1E87895912469DE2" -----------------------
ALTER TABLE `advertisments`
	ADD CONSTRAINT `FK_1E87895912469DE2` FOREIGN KEY ( `category_id` )
	REFERENCES `advertisment_categories`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_1E87895998260155" -----------------------
ALTER TABLE `advertisments`
	ADD CONSTRAINT `FK_1E87895998260155` FOREIGN KEY ( `region_id` )
	REFERENCES `regions`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_1E878959A76ED395" -----------------------
ALTER TABLE `advertisments`
	ADD CONSTRAINT `FK_1E878959A76ED395` FOREIGN KEY ( `user_id` )
	REFERENCES `users`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_1E878959AE6A44CF" -----------------------
ALTER TABLE `advertisments`
	ADD CONSTRAINT `FK_1E878959AE6A44CF` FOREIGN KEY ( `price_type_id` )
	REFERENCES `price_types`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_1E878959C54C8C93" -----------------------
ALTER TABLE `advertisments`
	ADD CONSTRAINT `FK_1E878959C54C8C93` FOREIGN KEY ( `type_id` )
	REFERENCES `advertisment_types`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_1E878959F7BFE87C" -----------------------
ALTER TABLE `advertisments`
	ADD CONSTRAINT `FK_1E878959F7BFE87C` FOREIGN KEY ( `sub_category_id` )
	REFERENCES `advertisment_subcategories`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_47C4FAD671731BCA" -----------------------
ALTER TABLE `attachments`
	ADD CONSTRAINT `FK_47C4FAD671731BCA` FOREIGN KEY ( `advertisment_id` )
	REFERENCES `advertisments`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_C2521BF1441B8B65" -----------------------
ALTER TABLE `conversations`
	ADD CONSTRAINT `FK_C2521BF1441B8B65` FOREIGN KEY ( `user2_id` )
	REFERENCES `users`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_C2521BF156AE248B" -----------------------
ALTER TABLE `conversations`
	ADD CONSTRAINT `FK_C2521BF156AE248B` FOREIGN KEY ( `user1_id` )
	REFERENCES `users`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_C2521BF171731BCA" -----------------------
ALTER TABLE `conversations`
	ADD CONSTRAINT `FK_C2521BF171731BCA` FOREIGN KEY ( `advertisment_id` )
	REFERENCES `advertisments`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_E46960F571731BCA" -----------------------
ALTER TABLE `favorites`
	ADD CONSTRAINT `FK_E46960F571731BCA` FOREIGN KEY ( `advertisment_id` )
	REFERENCES `advertisments`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_E46960F5A76ED395" -----------------------
ALTER TABLE `favorites`
	ADD CONSTRAINT `FK_E46960F5A76ED395` FOREIGN KEY ( `user_id` )
	REFERENCES `users`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_36AC99F112469DE2" -----------------------
ALTER TABLE `link`
	ADD CONSTRAINT `FK_36AC99F112469DE2` FOREIGN KEY ( `category_id` )
	REFERENCES `top_link_categories`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_DB021E969AC0396" ------------------------
ALTER TABLE `messages`
	ADD CONSTRAINT `FK_DB021E969AC0396` FOREIGN KEY ( `conversation_id` )
	REFERENCES `conversations`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_DB021E96A76ED395" -----------------------
ALTER TABLE `messages`
	ADD CONSTRAINT `FK_DB021E96A76ED395` FOREIGN KEY ( `user_id` )
	REFERENCES `users`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_449D086C12469DE2" -----------------------
ALTER TABLE `top_links`
	ADD CONSTRAINT `FK_449D086C12469DE2` FOREIGN KEY ( `category_id` )
	REFERENCES `top_link_categories`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_2DE8C6A3A76ED395" -----------------------
ALTER TABLE `user_role`
	ADD CONSTRAINT `FK_2DE8C6A3A76ED395` FOREIGN KEY ( `user_id` )
	REFERENCES `users`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_2DE8C6A3D60322AC" -----------------------
ALTER TABLE `user_role`
	ADD CONSTRAINT `FK_2DE8C6A3D60322AC` FOREIGN KEY ( `role_id` )
	REFERENCES `roles`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_5C844C5A76ED395" ------------------------
ALTER TABLE `user_settings`
	ADD CONSTRAINT `FK_5C844C5A76ED395` FOREIGN KEY ( `user_id` )
	REFERENCES `users`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_B3498197A76ED395" -----------------------
ALTER TABLE `user_votes`
	ADD CONSTRAINT `FK_B3498197A76ED395` FOREIGN KEY ( `user_id` )
	REFERENCES `users`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_1483A5E982F1BAF4" -----------------------
ALTER TABLE `users`
	ADD CONSTRAINT `FK_1483A5E982F1BAF4` FOREIGN KEY ( `language_id` )
	REFERENCES `languages`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


-- CREATE LINK "FK_1483A5E998260155" -----------------------
ALTER TABLE `users`
	ADD CONSTRAINT `FK_1483A5E998260155` FOREIGN KEY ( `region_id` )
	REFERENCES `regions`( `id` )
	ON DELETE Restrict
	ON UPDATE Restrict;
-- ---------------------------------------------------------


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- ---------------------------------------------------------


