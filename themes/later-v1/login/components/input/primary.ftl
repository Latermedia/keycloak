<#import "./error.ftl" as inputError>

<#macro kw invalid name autofocus=false disabled=false message=true required=true placeholder="" class="" rest...>
  <label class="sr-only" for="${name}">
    <#nested>
  </label>
  <input
    <#if autofocus>autofocus</#if>
    <#if disabled>disabled</#if>
    <#if required>required</#if>
    aria-invalid="${messagesPerField.existsError(invalid)?c}"
    class="o--form__input<#if messagesPerField.existsError(invalid)> hasError</#if><#if class?has_content> ${class}</#if>"
    id="${name}"
    name="${name}"
    <#if placeholder?has_content>
    placeholder="${placeholder}"
    <#else>
    placeholder="<#compress><#nested></#compress>"
    </#if>
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
  <#if message && messagesPerField.existsError(invalid)>
    <@inputError.kw id="error" class="o--form__helpText u--text--danger">
      ${kcSanitize(messagesPerField.getFirstError(invalid))?no_esc}
    </@inputError.kw>
  </#if>
</#macro>
