!function () {
  var i = "analytics", analytics = window[i] = window[i] || []; if (!analytics.initialize) if (analytics.invoked) window.console && console.error && console.error("Segment snippet included twice."); else {
    analytics.invoked = !0; analytics.methods = ["trackSubmit", "trackClick", "trackLink", "trackForm", "pageview", "identify", "reset", "group", "track", "ready", "alias", "debug", "page", "screen", "once", "off", "on", "addSourceMiddleware", "addIntegrationMiddleware", "setAnonymousId", "addDestinationMiddleware", "register"]; analytics.factory = function (e) { return function () { if (window[i].initialized) return window[i][e].apply(window[i], arguments); var n = Array.prototype.slice.call(arguments); if (["track", "screen", "alias", "group", "page", "identify"].indexOf(e) > -1) { var c = document.querySelector("link[rel='canonical']"); n.push({ __t: "bpc", c: c && c.getAttribute("href") || void 0, p: location.pathname, u: location.href, s: location.search, t: document.title, r: document.referrer }) } n.unshift(e); analytics.push(n); return analytics } }; for (var n = 0; n < analytics.methods.length; n++) { var key = analytics.methods[n]; analytics[key] = analytics.factory(key) } analytics.load = function (key, n) { var t = document.createElement("script"); t.type = "text/javascript"; t.async = !0; t.setAttribute("data-global-segment-analytics-key", i); t.src = "https://cdn.segment.com/analytics.js/v1/" + key + "/analytics.min.js"; var r = document.getElementsByTagName("script")[0]; r.parentNode.insertBefore(t, r); analytics._loadOptions = n }; analytics._writeKey = "rjo2ZXgRv6IaA4B8MKXd92cLlgopFVMM";; analytics.SNIPPET_VERSION = "5.2.0";
    analytics.load("rjo2ZXgRv6IaA4B8MKXd92cLlgopFVMM");
    console.log('analytics.js loaded');
    analytics.page();
  }
}();

const loginButtonId = 'loginButton';
const loginButtonElement = document.getElementById(loginButtonId);
if (loginButtonElement) {
  loginButtonElement.addEventListener('click', function () {
    console.log('keycloak login button clicked');
    analytics.track('keycloak-clicked-login');
  });
}

const urlParams = new URLSearchParams(window.location.search);
const redirectUri = urlParams.get('redirect_uri');
const redirectParams = redirectUri ? new URLSearchParams(redirectUri.split('?')[1]) : null;
console.log('redirectParams: redirectParams');
console.log({referrer: document.referrer});

const isNewSession =
  window.location.href.includes('openid-connect') ||
  document.referrer.includes('app.later.com') ||
  document.referrer.includes('staging.later.com') ||
  document.referrer.includes('localhost');
console.log({ isNewSession });

const utmSource = isNewSession ? redirectParams.get('utm_source') : localStorage.getItem('keycloak_utm_source');
const campaignId = isNewSession ? redirectParams.get('campaign_id') : localStorage.getItem('keycloak_campaign_id');
console.log({ utmSource });
console.log({ campaignId });

if (isNewSession) {
  localStorage.removeItem('keycloak_utm_source');
  localStorage.removeItem('keycloak_campaign_id');

  if (utmSource) {
    localStorage.setItem('keycloak_utm_source', utmSource);
  }
  if (campaignId) {
    localStorage.setItem('keycloak_campaign_id', campaignId);
  }
}

const utmToSelector = {
  mavrck: '.tLK--card--campaign',
  featured: '.tLK--card--featured',
  'linkin.bio': '.tLK--card--testimonial',
  'linkinbio': '.tLK--card--testimonial',
  contributor: '.tLK--card--invite',
  invite: '.tLK--card--invite'
};

const element = document.querySelector(utmToSelector[utmSource]);
if (element) {
  element.classList.remove('u--hide');
} else if (campaignId) {
  const loginHeader = document.querySelector('.tLK--card__title');
  if (loginHeader && loginHeader.innerText === 'Log In') {
    loginHeader.innerText = 'Log In with Later to Apply';
  }

  const campaignElement = document.querySelector('.tLK--card--campaign');
  if (campaignElement) {
    campaignElement.classList.remove('u--hide');
  }

  // Get the referrer URL
  var referrer = document.referrer;
  const campaignUrl = document.referrer.includes('app.later.com') ?
    `https://app.later.com/api/public_campaigns/${campaignId}` :
    `https://staging.later.com/api/public_campaigns/${campaignId}`;

  fetch(campaignUrl)
    .then(response => response.json())
    .then(data => {
      const insertDescriptionPart = (className, text) => {
        const part = document.createElement('p');
        part.setAttribute('class', className);
        part.innerText = text;
        const descriptionContainer = document.querySelector('#campaign__description');
        descriptionContainer.appendChild(part);
      };

      const campaign = data.campaign;
      console.log(campaign);
      insertDescriptionPart('tLK--card__title', campaign.name);
      insertDescriptionPart('u--text--light', `By ${campaign.brand_name}`);
      insertDescriptionPart('tLK--card--campaign__desc', campaign.about);

      const imageContainer = document.querySelector('.o--mediaContainer');
      const img = document.createElement('img');
      img.setAttribute('alt', 'Campaign image');
      img.setAttribute('class', 'o--media');
      img.src = campaign.campaign_image_url;
      imageContainer.appendChild(img);
    });

} else {
  const defaultElement = document.querySelector(utmToSelector['featured']);
  if (defaultElement) {
    defaultElement.classList.remove('u--hide');
  }
}

if (utmSource === 'campaign' || utmSource === 'mavrck') {
  const campaignElement = document.querySelector('#mavrck-welcome');
  if (campaignElement) {
    campaignElement.classList.remove('u--hide');
  }
}
