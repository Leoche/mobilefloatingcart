<link rel="stylesheet" href="http://localhost:8080/style.css">
<div id="mfc-cart">
  <div class="mfc-header">
    <p class="mfc-title">Cart</p>
    <p class="mfc-subtitle">2 items in your cart</p>
  </div>
  <div class="mfc-empty" style="display: none;">
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M0 0h24v24H0z" fill="none"/><path d="M17.21 9l-4.38-6.56c-.19-.28-.51-.42-.83-.42-.32 0-.64.14-.83.43L6.79 9H2c-.55 0-1 .45-1 1 0 .09.01.18.04.27l2.54 9.27c.23.84 1 1.46 1.92 1.46h13c.92 0 1.69-.62 1.93-1.46l2.54-9.27L23 10c0-.55-.45-1-1-1h-4.79zM9 9l3-4.4L15 9H9zm3 8c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2z"/></svg>
    <p>Your card is empty!</p>
  </div>
  <ul class="mfc-products">
      <li class="mfc-active">
        <div class="mfc-item">
          <div class="mfc-line">
            <img src="http://i.pravatar.cc/48" alt="avatar">
            <span class="mfc-details">
              <span class="mfc-name"><span>Taie d'oreiller motif fleur</span></span>
              <span class="mfc-quantity">Quantity: 10</span>
            </span>
            <span class="mfc-price">25.05€ <small>HT</small></span>
          </div>
        </div>
        <div class="mfc-more">
          <p>Coupe classique, col rond, manches courtes. T-shirt en coton pima extra-fin à fibres longues.</p>
          <div class="mfc-controls">
            <div class="mfc-quantity-selector">
              <button class="mfc-button mfc-circle mfc-icon" disabled><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="white" d="M19 13H5v-2h14v2z"/><path d="M0 0h24v24H0z" fill="none"/></svg></button>
              <span>1</span>
              <button class="mfc-button mfc-circle mfc-icon"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="white" d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"/><path d="M0 0h24v24H0z" fill="none"/></svg></button>
            </div>
            <button class="mfc-button mfc-circle mfc-icon mfc-flat"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/><path d="M0 0h24v24H0z" fill="none"/></svg></button>
          </div>
        </div>
      </li>
  </ul>
  <div class="mfc-summary">
    <hr>
    <div class="mfc-total">
      <span>Total</span>
      <span class="mfc-value">41.24</span>
    </div>
    <div class="mfc-total-details">
      <span>Subtotal</span>
      <span class="mfc-value">36.00</span>
    </div>
    <div class="mfc-total-details">
      <span>Tax</span>
      <span class="mfc-value">3.24</span>
    </div>
  </div>
</div>
<div id="mfc-button" class="{if !$MFC_SHOWONDESKTOP}hidden-md-up{/if} {if $MFC_HIDDENONCARTEMPTY}hidden-on-empty{/if}" style="{if $MFC_COLOR}background:{$MFC_COLOR};{/if}{if $MFC_ZINDEX} z-index:{$MFC_ZINDEX};{/if}">
  {if $MFC_ICON}
    <img src="{$MFC_ICON}" alt="Shopping cart icon" />
  {else}
  <svg class="mfc-icon-cart" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="white" d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/><path d="M0 0h24v24H0z" fill="none"/></svg>
  {/if}
  <svg
    fill="white" class="mfc-icon-close" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
    <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z" />
    <path d="M0 0h24v24H0z" fill="none" />
    </svg>
</div>
<script src="http://localhost:8080/index.js"></script>