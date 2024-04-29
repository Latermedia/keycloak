<#import "template.ftl" as layout>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/link/secondary.ftl" as linkSecondary>
<#import "components/layout/another-way.ftl" as anotherWay>

<@layout.registrationLayout displayInfo=false displayMessage=false; section>
  <#if section="title">
    ${msg("doLogIn")}
    <#elseif section="header">
      <div id="kc-username" class="${properties.kcFormGroupClass!}">
        <label id="kc-attempted-username">${auth.attemptedUsername}</label>
        <a id="reset-login" href="${url.loginRestartFlowUrl}" aria-label="${msg(" restartLoginTooltip")}">
          <div class="kc-login-tooltip">
            <i class="${properties.kcResetFlowIcon!}"></i>
            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
          </div>
        </a>
      </div>
      <#elseif section="form">
        <p class="u--m__b__lg">We’ve sent a verification code to your email.</p>
        <form id="kc-otp-login-form" action="${url.loginAction}" method="post">
          <div class="o--formWrapper--lg">
            <@inputPrimary.kw class="qa--signin_otp_input" invalid=["otp", "totp" ] message=true name="otp" type="text" maxlength="6" required=false placeholder="_ _ _ _ _ _">
              ${msg("loginOtpOneTime")}
            </@inputPrimary.kw>
          </div>
          <div class="${properties.kcFormGroupClass!}">
            <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
              <div class="${properties.kcFormOptionsWrapperClass!}">
              </div>
            </div>
            <div id="kc-form-buttons" class="u--row u--m__t__lg">
              <div class="u--row--column u--m__r__xs">
                <input class="o--btn--lg o--btn--outline qa--signin_resend_button" name="resend" id="kc-resend" type="submit" value="${msg("doResend")}" />
              </div>
              <div class="u--row--column u--m__l__xs">
                <input class="o--btn--lg o--btn--primary qa--signin_login_button" name="submit" id="kc-submit" type="submit" value="Log In" />
              </div>
            </div>

          </div>

        </form>
    <#elseif section="nav">
      <div class="tLK--footer">
        <div class="tLK--footer__item u--text--left">
          <@linkSecondary.kw href="https://help.later.com/hc/en-us/articles/1500001825902-Contacting-Customer-Support-Getting-Help" target="_blank">
          <span class="text-sm">Need help? Contact us</span>
          </@linkSecondary.kw>
        </div>

        <div class="tLK--footer__item u--text--right">
          <@anotherWay.kw />
        </div>
      </div>
    </#if>
</@layout.registrationLayout>