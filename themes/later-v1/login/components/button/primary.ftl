<#macro kw component="button" class="" rest...>
  <${component}
    class="o--btn--primary o--btn--lg o--btn--block<#if class?has_content> ${class}</#if>"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>