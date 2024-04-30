<#import "template.ftl" as layout>
<#import "components/provider.ftl" as provider>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/checkbox/primary.ftl" as checkboxPrimary>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/label/username.ftl" as labelUsername>
<#import "components/link/primary.ftl" as linkPrimary>

<@layout.registrationLayout
  displayInfo=true
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
            class="qa--signin_email_input"
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
        <div class="o--formWrapper--lg u--relative">
          <@inputPrimary.kw
            class="qa--signin_password_input"
            invalid=["username", "password"]
            message=false
            name="password"
            type="password"
            placeholder="Enter your password"
          >
            ${msg("password")}
          </@inputPrimary.kw>
          <button class="o--btn--lg tSU--card__inputButton" type="button">
            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 28 28" class="o--icon--md tSU--card__inputIcon" id="showIcon">
              <path fill-rule="evenodd" d="M24.294 2.688c.459-.301 1.003-.24 1.426.183.495.495.495 1.155 0 1.65L23 7.241c3.333 3.017 5 6.767 5 6.767s-4.667 10.5-14 10.5c-2.476 0-4.623-.739-6.442-1.824l-2.462 2.461c-.495.495-1.155.495-1.65 0-.495-.495-.495-1.155 0-1.65l.21-.208c.076-.05.149-.11.219-.18zm-2.957 6.217l-2.253 2.252c.477.844.75 1.818.75 2.851 0 3.208-2.626 5.833-5.834 5.833a5.783 5.783 0 01-2.851-.749l-1.854 1.854c1.385.745 2.958 1.229 4.705 1.229 6.183 0 10.033-5.834 11.317-8.167-.66-1.199-1.997-3.322-3.98-5.103zM14 3.508c1.879 0 3.569.426 5.07 1.105L17.272 6.41A9.705 9.705 0 0014 5.841c-6.183 0-10.033 5.834-11.317 8.167.533.969 1.528 2.54 2.944 4.048L3.942 19.74C1.314 16.964 0 14.008 0 14.008l.012-.027C.282 13.39 4.945 3.508 14 3.508zm3.325 9.41l-4.415 4.415c.343.114.71.175 1.09.175a3.51 3.51 0 003.5-3.5c0-.38-.061-.747-.175-1.09zM14 8.175c.464 0 .915.055 1.349.158l-2.31 2.31a3.526 3.526 0 00-2.404 2.403l-2.31 2.31a5.796 5.796 0 01-.158-1.348c0-3.208 2.625-5.833 5.833-5.833z"></path>
            </svg>

            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 28 28" class="o--icon--md tSU--card__inputIcon" id="hideIcon">
              <path fill-rule="evenodd" d="M14 3.508c9.333 0 14 10.5 14 10.5s-4.667 10.5-14 10.5-14-10.5-14-10.5l.012-.027C.282 13.39 4.945 3.508 14 3.508zm0 2.333c-6.183 0-10.033 5.834-11.317 8.167 1.284 2.333 5.25 8.167 11.317 8.167 6.183 0 10.033-5.834 11.317-8.167C24.033 11.675 20.183 5.841 14 5.841zm0 2.334c3.208 0 5.833 2.625 5.833 5.833S17.208 19.841 14 19.841s-5.833-2.625-5.833-5.833S10.792 8.175 14 8.175zm0 2.333a3.51 3.51 0 00-3.5 3.5 3.51 3.51 0 003.5 3.5 3.51 3.51 0 003.5-3.5 3.51 3.51 0 00-3.5-3.5z"></path>
            </svg>
          </button>
        </div>

        <#if realm.rememberMe && !usernameEditDisabled??>
          <@checkboxPrimary.kw checked=login.rememberMe?? name="rememberMe">
            ${msg("rememberMe")}
          </@checkboxPrimary.kw>
        </#if>

        <div class="o--formSubmit" >
          <@buttonPrimary.kw class="qa--signin_login_button" name="login" type="submit" id="loginButton">
            ${msg("doLogIn")}
          </@buttonPrimary.kw>
        </div>
      </form>
    </#if>
    <#if realm.password && social.providers??>
      <@provider.kw />
    </#if>
  <#elseif section="info">
    <p class="u--text--center" id="kc-registration">
      ${msg("noAccount")}
      <@linkPrimary.kw href=properties.registrationUrl>
        ${msg("doRegister")}
      </@linkPrimary.kw>
    </p>
  </#if>
</@layout.registrationLayout>
