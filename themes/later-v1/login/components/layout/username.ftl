<#import "../icon/arrow-left-circle.ftl" as iconArrowLeftCircle>
<#import "../link/primary.ftl" as linkPrimary>

<#macro kw>
  <#nested "show-username">
  <h1 class="tLK--card__title u--m__b__xs u--ellipsis">
    Hi, ${auth.attemptedUsername}
    <div class="tLK--card__icon">
      <@linkPrimary.kw
        href="${url.loginRestartFlowUrl}"
        title="${msg('restartLoginTooltip')}"
      >
        <@iconArrowLeftCircle.kw />
      </@linkPrimary.kw>
    </div>
  </h1>
</#macro>
