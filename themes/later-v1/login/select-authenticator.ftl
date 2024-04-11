<#import "components/icon/chevron-right.ftl" as iconChevronRight>
<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
  <#if section = "header" || section = "show-username">
    <#if section = "header">
      ${msg("loginChooseAuthenticator")}
    </#if>
  <#elseif section = "form">
    <form id="kc-select-credential-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
      <div class="tLK--listWrapper">
        <#list auth.authenticationSelections as authenticationSelection>
          <button class="tLK--list" type="submit" name="authenticationExecution" value="${authenticationSelection.authExecId}">
            <div class="tLK--list__item">
              <div class="tLK--list__title">${msg('${authenticationSelection.displayName}')}</div>
              <div class="tLK--list__text">${msg('${authenticationSelection.helpText}')}</div>
            </div>
            <div class="tLK--list__item"></div>
            <div class="tLK--list__item">
              <@iconChevronRight.kw />
            </div>
          </button>
        </#list>
      </div>
    </form>
  </#if>
</@layout.registrationLayout>