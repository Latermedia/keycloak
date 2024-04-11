<#macro kw heading="Log In">
  <div class="o--wrapper">
    <header class="o--header">
      <div class="o--container tLK--headerContainer">
        <div class="o--logoWrapper">
          <a href="https://later.com" class="o--logo" target="_self" rel="" title="Later.com">
            <div class="o--logo__img"></div>    
          </a>
          <h3 class="o--logo__title">${heading}</h3>
        </div>
        <h3 class="o--header__action">
          New to Later? <a class="u--inline u--p__l__xs" href="${properties.registrationUrl}">Create&nbsp;an&nbsp;Account</a>
        </h3>
      </div>
    </header>
    <div class="o--content">
      <div class="o--container tLK--contentContainer">
        <div class="tLK--card">
          <#nested>
        </div>

        
        <#-- Default Feature Card -->
        <div class="tLK--card tLK--card--featured u--hide"></div>

        <#-- Testimonial Feature Card -->
        <div class="tLK--card tLK--card--testimonial u--hide">
          <p class="tLK--card__title--testimonial">
            Plan &amp; schedule posts. Drive traffic &amp; sales with Linkin.bio. Collab with creators &amp; brands.
          </p>
          <div class="tLK--card--testimonial__description u--text--center">
            <p class="u--text--italic">“We love using Later because not only does it allow us to visually see our images laid out on a calendar week by week, but it shows us the best time to post. We wouldn’t go anywhere else to schedule and curate our social media”</p>
            <p class="u--text--bold u--m__b__0">Megan White</p>
            <p class="u--text--bold">Artifact Uprising</p>
          </div>
        </div>

        <#-- Campaigns Feature Card -->
        <div class="tLK--card tLK--card--campaign u--hide">
          <div id="campaign__description" class="u--p__l__lg u--p__r__lg">
          </div>
          <div id="campaign__image" class="tLK--card--campaign__image">
            <figure class="o--mediaContainer">
              
            </figure>
          </div>
        </div>

        <#-- Contributor Feature Card -->
        <div class="tLK--card tLK--card--invite u--hide">
          <p class="tLK--card__title u--m__b__sm u--text--bold u--text--lg">Social Media Management<br>Made Easy</p>
          <p class="u--text--base">
            Later is your one-stop shop for social media management &amp; expert advice.
            <span style="color:#CF1C96;">Start wherever you are &amp; we’ll help you grow!</span>
          </p>
        </div>
        
      </div>
  </div>
</div>
</#macro>
