<%--
  #%L
  aem-admin-extension-customize-sites
  %%
  Copyright (C) 2014 Adobe
  %%
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
       http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  #L%
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
