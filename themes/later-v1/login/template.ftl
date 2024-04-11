<#import "components/document.ftl" as document>
<#import "components/layout/alerts.ftl" as alerts>
<#import "components/layout/another-way.ftl" as anotherWay>
<#import "components/layout/card.ftl" as card>
<#import "components/layout/card-footer.ftl" as cardFooter>
<#import "components/layout/card-header.ftl" as cardHeader>
<#import "components/layout/card-main.ftl" as cardMain>
<#import "components/layout/container.ftl" as container>
<#import "components/layout/locales.ftl" as locales>
<#import "components/layout/nav.ftl" as nav>
<#import "components/layout/required-fields.ftl" as requiredFields>
<#import "components/layout/title.ftl" as title>
<#import "components/layout/username.ftl" as username>

<#macro
  registrationLayout
  displayInfo=false
  displayMessage=true
  displayRequiredFields=false
  heading=msg("loginAccountTitle")
  showAnotherWayIfPresent=true
  showForgotPassword=true
>
  <html>
    <head>
      <@document.kw/>
    </head>
    <body>
      <@container.kw heading=heading>
        <@card.kw>
          <@cardHeader.kw>
            <@title.kw />
            <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
              <h1 class="tLK--card__title">
                <#nested "header">
              </h1>
              <p id="mavrck-welcome" class="u--hide u--text--light u--m__t__0 u--m__b__lg">
                Mavrck teamed up with Later! Apply to this campaign through Later to access our all-in-one creator experience.
                <a href="https://www.later.com/" target="_blank" rel="noopener">Learn More</a>
              </p>
            <#else>
              <@username.kw />
            </#if>
          </@cardHeader.kw>
          <@cardMain.kw>
            <#if displayMessage && message?has_content && (message.type != "warning" || !isAppInitiatedAction??)>
              <@alerts.kw />
            </#if>
            <#nested "form">
            <#if displayRequiredFields>
              <@requiredFields.kw />
            </#if>
          </@cardMain.kw>
          <#if displayInfo>
            <@cardFooter.kw auth=auth showForgotPassword=showForgotPassword>
              <#nested "info">
            </@cardFooter.kw>
          </#if>
        </@card.kw>
        <@nav.kw>
          <#nested "nav">
          <#if realm.internationalizationEnabled && locale.supported?size gt 1>
            <@locales.kw />
          </#if>
        </@nav.kw>
      </@container.kw>
    </body>
  </html>
</#macro>
