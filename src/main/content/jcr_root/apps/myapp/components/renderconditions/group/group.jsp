<%--
  ADOBE CONFIDENTIAL

  Copyright 2014 Adobe Systems Incorporated
  All Rights Reserved.

  NOTICE:  All information contained herein is, and remains
  the property of Adobe Systems Incorporated and its suppliers,
  if any.  The intellectual and technical concepts contained
  herein are proprietary to Adobe Systems Incorporated and its
  suppliers and may be covered by U.S. and Foreign Patents,
  patents in process, and are protected by trade secret or copyright law.
  Dissemination of this information or reproduction of this material
  is strictly forbidden unless prior written permission is obtained
  from Adobe Systems Incorporated.
--%><%@include file="/libs/granite/ui/global.jsp" %><%
%><%@page session="false"
          import="java.util.Arrays,
                  java.util.Iterator,
                  java.util.List,
                  org.apache.jackrabbit.api.security.user.Authorizable,
                  org.apache.jackrabbit.api.security.user.Group,
                  com.adobe.granite.ui.components.Config,
                  com.adobe.granite.ui.components.rendercondition.RenderCondition" %><%!

    /**
     * Class declared in JSP for demo purpose
     */
    private static class GroupRenderCondition implements RenderCondition {
        private final Authorizable authorizable;
        private final List<String> allowedGroups;

        public GroupRenderCondition(Authorizable authorizable, List<String> allowedGroups) {
            this.authorizable = authorizable;
            this.allowedGroups = allowedGroups;
        }

        public boolean check() {
            try {
                Iterator<Group> groupIt = authorizable.memberOf();
                while (groupIt.hasNext()) {
                    Group group = groupIt.next();
                    if (allowedGroups.contains(group.getPrincipal().getName())) {
                        return true;
                    }
                }
            } catch (Exception e) {
                // catching generic exception and ignoring it for demo
            }

            return false;
        }
    }

%><%

/**
A condition that decides based on group membership.

@name Privilege
@location /apps/myapp/components/renderconditions/group

@property {String[]} [groups] The group names

@example
+ mybutton
  - sling:resourceType = "granite/ui/components/foundation/button"
  + rendercondition
    - sling:resourceType = "myapp/components/renderconditions/group"
    - groups = ["administrators"]
*/

    Config cfg = cmp.getConfig();

    List<String> groups = Arrays.asList(cfg.get("groups", new String[0]));
    if (groups.isEmpty()) {
        return;
    }

    Authorizable authorizable = resourceResolver.adaptTo(Authorizable.class);
    if (authorizable != null) {
        request.setAttribute(RenderCondition.class.getName(), new GroupRenderCondition(authorizable, groups));
    }
%>