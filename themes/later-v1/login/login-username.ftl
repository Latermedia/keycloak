<#import "template.ftl" as layout>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/label/username.ftl" as labelUsername>
<#import "components/button/primary.ftl" as buttonPrimary>

<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username') displayInfo=(realm.password &&
  realm.registrationAllowed && !registrationDisabled??); section>
  <#if section="header">
    ${msg("loginAccountTitle")}
    <#elseif section="form">

      <#if realm.password>
        <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
          method="post">
          <#if !usernameHidden??>
            <div class="o--formWrapper--lg ${properties.kcFormGroupClass!}">
              <@inputPrimary.kw autocomplete="off" autofocus=true
                disabled=usernameEditDisabled?? invalid=["username", "password" ] name="username" type="email"
                value=(login.username)!''>
                <@labelUsername.kw />
              </@inputPrimary.kw>
            </div>
          </#if>

          <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
            <div id="kc-form-options">
              <#if realm.rememberMe && !usernameHidden??>
                <div class="o--form__checkbox u--m__t__md">
                  <label>
                    <#if login.rememberMe??>
                      <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked>
                      ${msg("rememberMe")}
                      
                      <#else>
                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox">
                        ${msg("rememberMe")}
                    </#if>
                  </label>
                </div>
              </#if>
            </div>
          </div>
          <div class="o--formSubmit">
            <@buttonPrimary.kw name="login" id="kc-login" type="submit">
              ${msg("Next")}
            </@buttonPrimary.kw>
          </div>
        </form>
      </#if>

      <#elseif section="info">
          <p class="u--text--center" id="kc-registration">
            ${msg("noAccount")} <a tabindex="6" href="${properties.registrationUrl}">${msg("doRegister")}</a>
          </p>
      <#elseif section="socialProviders">
        <#if realm.password && social.providers??>
          <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
            <hr />
            <h4>${msg("identity-provider-login-label")}</h4>
            <ul
              class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
              <#list social.providers as p>
                <a id="social-${p.alias}"
                  class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                  type="button" href="${p.loginUrl}">
                  <#if p.iconClasses?has_content>
                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                    <span
                      class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                    <#else>
                      <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                  </#if>
                </a>
              </#list>
            </ul>
          </div>
        </#if>
  </#if>

</@layout.registrationLayout>