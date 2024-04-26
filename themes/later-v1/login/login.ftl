<#import "template.ftl" as layout>
<#import "components/provider.ftl" as provider>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/checkbox/primary.ftl" as checkboxPrimary>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/label/username.ftl" as labelUsername>
<#import "components/link/primary.ftl" as linkPrimary>

<@layout.registrationLayout
  displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??
  displayMessage=!messagesPerField.existsError("username", "password")
  ;
  section
>
  <#if section="header">
    ${msg("loginAccountTitle")}
  <#elseif section="form">
    <#if realm.password>
      <form
        action="${url.loginAction}"
        method="post"
        onsubmit="login.disabled = true; return true;"
      >
        <input
          name="credentialId"
          type="hidden"
          value="<#if auth.selectedCredential?has_content>${auth.selectedCredential}</#if>"
        >
        <div class="o--formWrapper--lg">
          <@inputPrimary.kw
            autocomplete=realm.loginWithEmailAllowed?string("email", "username")
            autofocus=true
            class="o--form__input"
            disabled=(login.username)?exists
            invalid=["username", "password"]
            name="username"
            type="text"
            value=(login.username)!''
            placeholder="Enter your email"
          >
            <@labelUsername.kw />
          </@inputPrimary.kw>
        </div>
        <div class="o--formWrapper--lg">
          <@inputPrimary.kw
            invalid=["username", "password"]
            message=false
            name="password"
            type="password"
            placeholder="Enter your password"
          >
            ${msg("password")}
          </@inputPrimary.kw>
        </div>

        <#if realm.rememberMe && !usernameEditDisabled??>
          <@checkboxPrimary.kw checked=login.rememberMe?? name="rememberMe">
            ${msg("rememberMe")}
          </@checkboxPrimary.kw>
        </#if>

        <div class="o--formSubmit" >
          <@buttonPrimary.kw name="login" type="submit" id="loginButton">
            ${msg("doLogIn")}
          </@buttonPrimary.kw>
        </div>
      </form>
    </#if>
    <#if realm.password && social.providers??>
      <@provider.kw />
    </#if>
  <#elseif section="info">
    <p class="u--text--center">
      ${msg("noAccount")}
      <@linkPrimary.kw href=properties.registrationUrl>
        ${msg("doRegister")}
      </@linkPrimary.kw>
    </p>
  </#if>
</@layout.registrationLayout>
