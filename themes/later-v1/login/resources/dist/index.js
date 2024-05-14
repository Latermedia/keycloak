const appName = 'Later_Social';

!function () {
  var i = "analytics", analytics = window[i] = window[i] || []; if (!analytics.initialize) if (analytics.invoked) window.console && console.error && console.error("Segment snippet included twice."); else {
    analytics.invoked = !0; analytics.methods = ["trackSubmit", "trackClick", "trackLink", "trackForm", "pageview", "identify", "reset", "group", "track", "ready", "alias", "debug", "page", "screen", "once", "off", "on", "addSourceMiddleware", "addIntegrationMiddleware", "setAnonymousId", "addDestinationMiddleware", "register"]; analytics.factory = function (e) { return function () { if (window[i].initialized) return window[i][e].apply(window[i], arguments); var n = Array.prototype.slice.call(arguments); if (["track", "screen", "alias", "group", "page", "identify"].indexOf(e) > -1) { var c = document.querySelector("link[rel='canonical']"); n.push({ __t: "bpc", c: c && c.getAttribute("href") || void 0, p: location.pathname, u: location.href, s: location.search, t: document.title, r: document.referrer }) } n.unshift(e); analytics.push(n); return analytics } }; for (var n = 0; n < analytics.methods.length; n++) { var key = analytics.methods[n]; analytics[key] = analytics.factory(key) } analytics.load = function (key, n) { var t = document.createElement("script"); t.type = "text/javascript"; t.async = !0; t.setAttribute("data-global-segment-analytics-key", i); t.src = "https://cdn.segment.com/analytics.js/v1/" + key + "/analytics.min.js"; var r = document.getElementsByTagName("script")[0]; r.parentNode.insertBefore(t, r); analytics._loadOptions = n }; analytics._writeKey = "rjo2ZXgRv6IaA4B8MKXd92cLlgopFVMM";; analytics.SNIPPET_VERSION = "5.2.0";
    analytics.load("rjo2ZXgRv6IaA4B8MKXd92cLlgopFVMM");
    analytics.page();
    analytics.track('viewed-page', {page: 'login', later_app: appName})
  }
}();

function addPasswordIconListener() {
  const passwordIcon = document.querySelector('.tSU--card__inputButton');
  if (passwordIcon) {
    passwordIcon.addEventListener('click', function () {
      const passwordInput = document.getElementById('password');
      const showIcon = document.getElementById('showIcon'); // SVG for showing the password
      const hideIcon = document.getElementById('hideIcon'); // SVG for hiding the password


      // Toggle the input type between 'password' and 'text'
      if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        showIcon.style.display = 'none'; // Hide the 'show' icon
        hideIcon.style.display = 'block'; // Display the 'hide' icon
      } else {
        passwordInput.type = 'password';
        showIcon.style.display = 'block'; // Display the 'show' icon
        hideIcon.style.display = 'none'; // Hide the 'hide' icon
      }
    });
  } else {
    const forgotLink = document.querySelector('#forgotLink');
    if (forgotLink) {
      forgotLink.style.display = 'none';
    }
  }
}

function updateRegistrationUrls(oldUrl, newUrl) {
  // Get all anchor tags in the document
  const links = document.querySelectorAll('a');

  // Loop through all links
  links.forEach(link => {
      // Check if the href attribute matches the old URL
      if (link.href === oldUrl) {
          // Update the href attribute to the new URL
          link.href = newUrl;
      }
  });
}

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
const clientId = urlParams.get('client_id');
const isLaterProduction = window.location.pathname.includes('later-production');
const redirectParams = redirectUri ? new URLSearchParams(redirectUri.split('?')[1]) : undefined;

function getUTMValues() {
  const isNewSession = window.location.href.includes('openid-connect');
  const attributes = ['utm_source', 'utm_campaign', 'utm_medium', 'utm_term', 'utm_content', 'campaign_id'];
  const utmValues = {};
  attributes.forEach(attribute => {
    utmValues[attribute] = isNewSession ? redirectParams.get(attribute) : localStorage.getItem(`keycloak_${attribute}`);
  });
  console.log(utmValues);

  if (isNewSession) {
    attributes.forEach(attribute => {
      localStorage.removeItem(`keycloak_${attribute}`);
      if (utmValues[attribute]) {
        localStorage.setItem(`keycloak_${attribute}`, utmValues[attribute]);
      }
    });
  }
  return utmValues;
}
const utmValues = getUTMValues();
const queryParams = Object.entries(utmValues)
  .filter(([key, value]) => value)
  .map(([key, value]) => `${key}=${value}`)
  .join('&');
const registrationUrl  = isLaterProduction ? `https://app.later.com/user/signup?${queryParams}` : `https://staging.later.com/user/signup?${queryParams}`;
updateRegistrationUrls('https://staging.later.com/user/signup', registrationUrl);
updateFeaturedCard();

if (utmValues.utm_source === 'campaign') {
  const campaignElement = document.querySelector('#mavrck-welcome');
  if (campaignElement) {
    campaignElement.classList.remove('u--hide');
  }
}

addPasswordIconListener();

function renderCampaign() {
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
  const campaignUrl = isLaterProduction ?
    `https://app.later.com/api/public_campaigns/${utmValues['campaign_id']}` :
    `https://staging.later.com/api/public_campaigns/${utmValues['campaign_id']}`;


    
  fetch(campaignUrl)
    .then(response => response.json())
    .then(data => {
      const insertDescriptionPart = (className, text) => {
        const part = document.createElement('p');
        part.setAttribute('class', className);
        part.innerText = text;
        const descriptionContainer = document.querySelector('#campaign__description');
        if (descriptionContainer) {
          descriptionContainer.appendChild(part);
        }
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
      if (imageContainer) {
        imageContainer.appendChild(img);
      }
    }).catch(error => {
      console.log('Error:', error)
    });
}

function updateFeaturedCard() {
  const utmToSelector = {
    mavrck: '.tLK--card--mavrck',
    featured: '.tLK--card--featured',
    'linkin.bio': '.tLK--card--testimonial',
    'linkinbio': '.tLK--card--testimonial',
    contributor: '.tLK--card--invite',
    invite: '.tLK--card--invite'
  };

  const element = document.querySelector(utmToSelector[utmValues.utm_source]);
  if (element) {
    element.classList.remove('u--hide');
  } else if (utmValues['campaign_id']) {
    renderCampaign();

  } else {
    const defaultElement = document.querySelector(utmToSelector['featured']);
    if (defaultElement) {
      defaultElement.classList.remove('u--hide');
    }
  }
}

