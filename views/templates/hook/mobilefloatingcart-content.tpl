{**
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author Léo DESIGAUX <leodesigaux@gmail.com>
*  @copyright  Léo DESIGAUX
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
**}
<div class="mfc-header">
  <p class="mfc-title">Cart</p>
  <p class="mfc-subtitle js-subtotal">{$cart.summary_string|escape:'htmlall':'UTF-8'}</p>
</div>
<div class="mfc-empty" {if count($cart.products) != 0}style="display: none;"{/if}>
  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M0 0h24v24H0z" fill="none"/><path d="M17.21 9l-4.38-6.56c-.19-.28-.51-.42-.83-.42-.32 0-.64.14-.83.43L6.79 9H2c-.55 0-1 .45-1 1 0 .09.01.18.04.27l2.54 9.27c.23.84 1 1.46 1.92 1.46h13c.92 0 1.69-.62 1.93-1.46l2.54-9.27L23 10c0-.55-.45-1-1-1h-4.79zM9 9l3-4.4L15 9H9zm3 8c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2z"/></svg>
  <p>{l s='Your card is empty!' mod='mobilefloatingcart'}</p>
</div>
  <ul class="mfc-products" {if count($cart.products) == 0}style="display: none;"{/if}>
    {foreach $cart.products as $product}
        <li class="mfc-product mfc-material-ripple" data-idproduct="{$product.id_product|escape:'htmlall':'UTF-8'}" data-idshop="{$product.id_shop|escape:'htmlall':'UTF-8'}">
          <div class="mfc-item">
            <div class="mfc-line">
              <img src="{$product.images[0].small.url|escape:'htmlall':'UTF-8'}" alt="{$product.name|escape:'htmlall':'UTF-8'}">
              <span class="mfc-details">
                <span class="mfc-name"><span>{$product.name|escape:'htmlall':'UTF-8'}</span></span>
                <span class="mfc-quantity">Quantity: <span class="value">{$product.cart_quantity|escape:'htmlall':'UTF-8'}</span></span>
              </span>
              <span class="mfc-price"><span class="value">{$product.total|escape:'htmlall':'UTF-8'}</span> <small>{$product.labels.tax_short|escape:'htmlall':'UTF-8'}</small></span>
            </div>
          </div>
          <div class="mfc-more">
            <p>{strip_tags($product.description_short)|escape:'htmlall':'UTF-8'}</p>
            <div class="mfc-controls">
              <div class="mfc-quantity-selector">
                <button {if $product.cart_quantity == 1}disabled{/if} data-uri="{$product.down_quantity_url|escape:'htmlall':'UTF-8'}" style="{if $MFC_COLOR}background:{$MFC_COLOR|escape:'htmlall':'UTF-8'};{/if}" class="mfc-material-ripple js-decrease-product-quantity mfc-action mfc-button mfc-circle mfc-icon"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="white" d="M19 13H5v-2h14v2z"/><path d="M0 0h24v24H0z" fill="none"/></svg></button>
                <span>{$product.cart_quantity|escape:'htmlall':'UTF-8'}</span>
                <button {if $product.cart_quantity == $product.stock_quantity}disabled{/if} data-uri="{$product.up_quantity_url|escape:'htmlall':'UTF-8'}" style="{if $MFC_COLOR}background:{$MFC_COLOR|escape:'htmlall':'UTF-8'};{/if}" class="mfc-material-ripple js-increase-product-quantity mfc-action mfc-button mfc-circle mfc-icon"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="white" d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"/><path d="M0 0h24v24H0z" fill="none"/></svg></button>
              </div>
              <button data-uri="{$product.remove_from_cart_url|escape:'htmlall':'UTF-8'}" title="{l s='Remove' mod='mobilefloatingcart'}" class="mfc-material-ripple mfc-action mfc-button mfc-circle mfc-icon mfc-flat"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/><path d="M0 0h24v24H0z" fill="none"/></svg></button>
            </div>
          </div>
        </li>
    {/foreach}
</ul>
<div class="mfc-summary" {if count($cart.products) == 0}style="display: none;"{/if}>
  <hr>
  {if $cart.totals.total != null}
  <div class="mfc-total">
    <span>{$cart.totals.total.label|escape:'htmlall':'UTF-8'}</span>
    <span class="mfc-value">{$cart.totals.total.value|escape:'htmlall':'UTF-8'}</span>
  </div>
  {/if}
  {if $cart.subtotals.products != null}
  <div class="mfc-total-details mfc-total-products">
    <span>{$cart.subtotals.products.label|escape:'htmlall':'UTF-8'}</span>
    <span class="mfc-value">{$cart.subtotals.products.value|escape:'htmlall':'UTF-8'}</span>
  </div>
  {/if}
  {if $cart.subtotals.shipping != null}
  <div class="mfc-total-details mfc-total-shipping">
    <span>{$cart.subtotals.shipping.label|escape:'htmlall':'UTF-8'}</span>
    <span class="mfc-value">{ucfirst($cart.subtotals.shipping.value)|escape:'htmlall':'UTF-8'}</span>
  </div>
  {/if}
  {if $cart.subtotals.tax != null}
  <div class="mfc-total-details mfc-total-taxes">
    <span>{$cart.subtotals.tax.label|escape:'htmlall':'UTF-8'}</span>
    <span class="mfc-value">{$cart.subtotals.tax.label|escape:'htmlall':'UTF-8'}</span>
  </div>
  {/if}
</div>
