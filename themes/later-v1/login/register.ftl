<#import "template.ftl" as layout>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/link/secondary.ftl" as linkSecondary>

<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("firstName", "lastName", "email", "username", "password", "password-confirm")
  ;
  section
>
  <#if section="header">
    ${msg("registerTitle")}
  <#elseif section="form">
    <form action="${url.registrationAction}" class="m-0 space-y-4" method="post" >
      <div class="o--formWrapper--lg">
        <@inputPrimary.kw
          autocomplete="given-name"
          autofocus=true
          invalid=["firstName"]
          name="firstName"
          type="text"
          value=(register.formData.firstName)!''
        >
          ${msg("firstName")}
        </@inputPrimary.kw>
      </div>
      <div class="o--formWrapper--lg">
        <@inputPrimary.kw
          autocomplete="family-name"
          invalid=["lastName"]
          name="lastName"
          type="text"
          value=(register.formData.lastName)!''
        >
          ${msg("lastName")}
        </@inputPrimary.kw>
      </div>
      <div class="o--formWrapper--lg">
        <@inputPrimary.kw
          autocomplete="email"
          invalid=["email"]
          name="email"
          type="email"
          value=(register.formData.email)!''
        >
          ${msg("email")}
        </@inputPrimary.kw>
      </div>
      <#if !realm.registrationEmailAsUsername>
        <div class="o--formWrapper--lg">
          <@inputPrimary.kw
            autocomplete="username"
            invalid=["username"]
            name="username"
            type="text"
            value=(register.formData.username)!''
          >
            ${msg("username")}
          </@inputPrimary.kw>
        </div>
      </#if>
      <#if passwordRequired??>
        <div class="o--formWrapper--lg">
          <@inputPrimary.kw
            autocomplete="new-password"
            invalid=["password", "password-confirm"]
            message=false
            name="password"
            type="password"
          >
            ${msg("password")}
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
      </#if>
      <#if recaptchaRequired??>
        <div>
          <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-size="compact"></div>
        </div>
      </#if>
      <@buttonPrimary.kw type="submit">
        ${msg("doRegister")}
      </@buttonPrimary.kw>
    </form>
    <footer class="u--m__t__lg">
      <p class="u--text--center u--m__b__lg" id="kc-registration">Already have an account? <a tabindex="6" href="/realms/later/login-actions/registration?client_id=later&amp;tab_id=y_vFzf3r1xM">Log In</a></p>
      <p class="u--text--light u--text--sm">By creating an account, you’re opting-in to receive marketing and product updates by email. You can always unsubscribe, any time.</p>
      <p class="u--text--light u--text--sm">By creating an account you agree to our Terms and Privacy Policy</p>
    </footer>
  <#elseif section="nav">
    <@linkSecondary.kw href=url.loginUrl>
      <span class="text-sm">${kcSanitize(msg("backToLogin"))?no_esc}</span>
    </@linkSecondary.kw>
  </#if>
</@layout.registrationLayout>
