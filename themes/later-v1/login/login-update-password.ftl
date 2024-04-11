<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/input/primary.ftl" as inputPrimary>

<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("password", "password-confirm")
  ;
  section
>
  <#if section="header">
    ${msg("updatePasswordTitle")}
  <#elseif section="form">
    <form action="${url.loginAction}" class="m-0 space-y-4" method="post" >
      <div class="o--formWrapper--lg">
        <input
          autocomplete="username"
          name="username"
          type="hidden"
          value="${username}"
        >
      </div>  
      <div class="o--formWrapper--lg">
        <input autocomplete="current-password" name="password" type="hidden">
      </div>
      <div class="o--formWrapper--lg">
        <@inputPrimary.kw
          autocomplete="new-password"
          autofocus=true
          invalid=["password", "password-confirm"]
          message=false
          name="password-new"
          type="password"
        >
          ${msg("passwordNew")}
        </@inputPrimary.kw>
      </div>
      <div class="o--formWrapper--lg">
        <@inputPrimary.kw
          autocomplete="new-password"
          invalid=["password-confirm"]
          name="password-confirm"
          type="password"
        >
          ${msg("passwordConfirm")}
        </@inputPrimary.kw>
      </div>

      <#-- TODO isAppInitiatedAction -->

      <div class="o--formSubmit">
        <@buttonPrimary.kw type="submit">
          ${msg("doSubmit")}
        </@buttonPrimary.kw>
      </div>
    </form>
  </#if>
</@layout.registrationLayout>
