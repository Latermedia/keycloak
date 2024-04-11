<#import "../button/primary.ftl" as buttonPrimary>
<#macro kw>
  <div class="tLK--footer__item u--text--right">
    <form action="${url.loginAction}" class="flex justify-center" method="post">
      <input name="tryAnotherWay" type="hidden" value="on"/>
      <button type="submit" class="o--btn--unstyled u--text--light u--text--underline u--text--sm">
        ${msg("doTryAnotherWay")}
      </button>
    </form>
  </div>
</#macro>


