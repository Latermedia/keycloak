<#macro kw>
  <#switch message.type>
    <#case "error">
      <#assign color="warning__container">
      <#break>
    <#case "info">
      <#assign color="bg-blue-100 text-blue-600">
      <#break>
    <#case "success">
      <#assign color="success__container">
      <#break>
    <#case "warning">
      <#assign color="bg-orange-100 text-orange-600">
      <#break>
    <#default>
      <#assign color="bg-blue-100 text-blue-600">
  </#switch>

  <div class="${color} p-4 rounded-lg text-sm" role="alert">
    <span>${kcSanitize(message.summary)?no_esc}</span>
  </div>
</#macro>
