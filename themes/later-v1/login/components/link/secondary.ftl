<#macro kw component="a" rest...>
  <${component}
    class="u--text--light u--text--underline u--text--sm"
    <#list rest as attrName, attrValue>
      ${attrName}="${attrValue}"
    </#list>
  >
    <#nested>
  </${component}>
</#macro>
