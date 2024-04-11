<#import "../link/primary.ftl" as linkPrimary>
<#import "../layout/another-way.ftl" as anotherWay>

<#macro kw auth showForgotPassword=true>
  <footer>
    <#nested>
      <div class="tLK--footer">
        <div class="tLK--footer__item u--text--left">
          <#if realm.resetPasswordAllowed && showForgotPassword>
            <@linkPrimary.kw href=url.loginResetCredentialsUrl>
              <span class="u--text--light u--text--underline u--text--sm">${msg("doForgotPassword")}</span>
            </@linkPrimary.kw>
          </#if>

        </div>
        <div class="tLK--footer__item u--text--right">
          <#if auth?has_content && auth.showTryAnotherWayLink()>
          <@anotherWay.kw />
          </#if>
        </div>
      </div>
  </footer>
  </#macro>