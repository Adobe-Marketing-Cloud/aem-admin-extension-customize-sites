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
