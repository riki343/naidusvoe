fos.Router.setData({"base_url":"","routes":{"naidusvoe_get_adv_info":{"tokens":[["text","\/get\/adv_info"]],"defaults":[],"requirements":[],"hosttokens":[]},"naidusvoe_add_adv":{"tokens":[["text","\/add\/adv"]],"defaults":[],"requirements":[],"hosttokens":[]},"get-adv":{"tokens":[["variable","\/","[^\/]++","adv_id"],["text","\/adv\/get"]],"defaults":[],"requirements":[],"hosttokens":[]},"get-advs":{"tokens":[["variable","\/","[^\/]++","filter"],["variable","\/","[^\/]++","type"],["text","\/get-advs"]],"defaults":{"type":null,"filter":null},"requirements":[],"hosttokens":[]},"add-to-fav":{"tokens":[["variable","\/","[^\/]++","adv_id"],["text","\/adv\/add-to-fav"]],"defaults":[],"requirements":[],"hosttokens":[]},"message-send":{"tokens":[["variable","-","[^\/]++","user_id"],["variable","\/","[^\/\\-]++","adv_id"],["text","\/message\/send"]],"defaults":[],"requirements":[],"hosttokens":[]},"user-get-conversations":{"tokens":[["text","\/user\/get-conversations"]],"defaults":[],"requirements":[],"hosttokens":[]},"user-get-conversation":{"tokens":[["variable","\/","[^\/]++","conv_id"],["text","\/user\/get-conversation"]],"defaults":[],"requirements":[],"hosttokens":[]},"naidusvoe_set_lang":{"tokens":[["text","\/setLang"]],"defaults":[],"requirements":[],"hosttokens":[]},"test-ctrl":{"tokens":[["text","\/test-ctrl"]],"defaults":[],"requirements":[],"hosttokens":[]},"user-get-info":{"tokens":[["text","\/user\/get-info"]],"defaults":[],"requirements":[],"hosttokens":[]},"user-change-contact-info":{"tokens":[["text","\/user\/change-contact-info"]],"defaults":[],"requirements":[],"hosttokens":[]},"user-change-pass":{"tokens":[["text","\/user\/change-pass"]],"defaults":[],"requirements":[],"hosttokens":[]},"user-change-email":{"tokens":[["text","\/user\/change-email"]],"defaults":[],"requirements":[],"hosttokens":[]},"user-change-email-settings":{"tokens":[["text","\/user\/change-email-settings"]],"defaults":[],"requirements":[],"hosttokens":[]},"user-change-sms-settings":{"tokens":[["text","\/user\/change-sms-settings"]],"defaults":[],"requirements":[],"hosttokens":[]},"user-delete-account":{"tokens":[["text","\/user\/delete-account"]],"defaults":[],"requirements":[],"hosttokens":[]},"get-user":{"tokens":[["text","\/user"]],"defaults":[],"requirements":[],"hosttokens":[]},"get-user-advs":{"tokens":[["text","\/user\/get-user-advs"]],"defaults":[],"requirements":[],"hosttokens":[]},"delete-user-adv":{"tokens":[["variable","\/","[^\/]++","adv_id"],["text","\/user\/delete-adv"]],"defaults":[],"requirements":[],"hosttokens":[]},"get-user-favs":{"tokens":[["text","\/user\/get-favs"]],"defaults":[],"requirements":[],"hosttokens":[]},"delete-user-fav":{"tokens":[["variable","\/","[^\/]++","fav_id"],["text","\/user\/delete-fav"]],"defaults":[],"requirements":[],"hosttokens":[]},"get-cabinet-profile":{"tokens":[["text","\/user\/get\/cabinet-profile"]],"defaults":[],"requirements":[],"hosttokens":[]},"change-avatar":{"tokens":[["text","\/user\/change-avatar"]],"defaults":[],"requirements":[],"hosttokens":[]}},"prefix":"","host":"localhost","scheme":"http"});