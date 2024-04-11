<#macro kw>
    <#if !realm.loginWithEmailAllowed>
      ${msg("username")}
    <#elseif !realm.registrationEmailAsUsername>
      ${msg("email")}
    </#if>
</#macro>
