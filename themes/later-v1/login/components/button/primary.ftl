<#macro kw component="button" rest...>
  <${component}
    class="o--btn--primary o--btn--lg o--btn--block"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
