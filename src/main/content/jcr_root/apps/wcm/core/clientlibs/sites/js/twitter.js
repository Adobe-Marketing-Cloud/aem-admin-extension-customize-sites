/*
 * #%L
 * aem-admin-extension-customize-sites
 * %%
 * Copyright (C) 2014 Adobe
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * #L%
 */
 (function(window, document, Granite, $) {
    "use strict";

    var TWITTER_ACTIVATOR = ".cq-siteadmin-admin-actions-twitter-activator";

    $(document).on("click", TWITTER_ACTIVATOR, function(e) {
        var selection = $(".foundation-collection").first().find(".foundation-selections-item").first();
        var path = selection.data("foundationCollectionItemId") || selection.data("path");

        var ui = $(window).adaptTo("foundation-ui");
        var title = Granite.I18n.get("Publish to Twitter");
        var message = Granite.I18n.get("Do you want to publish a link to this page to Twitter?");

        ui.prompt(title, message, "notice", [
            {
                text: Granite.I18n.get("Yes"),
                primary: true,
                id: "yes"
            },
            {
                text: Granite.I18n.get("No"),
                id: "no"
            }
        ], function (btnId) {
            if (btnId === "yes") {
                var notificationSlider = new Granite.UI.NotificationSlider($(".endor-Page-content.endor-Panel.foundation-content"));
                notificationSlider.notify({
                    content: Granite.I18n.get("Page is being published to Twitter"),
                    type: "info",
                    closable: true,
                    className: "notification-alert--absolute admin-notification"
                });
            }
        });
    });

})(window, document, Granite, Granite.$);
