<div class="mfc-header">
  <p class="mfc-title">Cart</p>
  <p class="mfc-subtitle js-subtotal">{$cart.summary_string}</p>
</div>
<div class="mfc-empty" {if count($cart.products) != 0}style="display: none;"{/if}>
  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M0 0h24v24H0z" fill="none"/><path d="M17.21 9l-4.38-6.56c-.19-.28-.51-.42-.83-.42-.32 0-.64.14-.83.43L6.79 9H2c-.55 0-1 .45-1 1 0 .09.01.18.04.27l2.54 9.27c.23.84 1 1.46 1.92 1.46h13c.92 0 1.69-.62 1.93-1.46l2.54-9.27L23 10c0-.55-.45-1-1-1h-4.79zM9 9l3-4.4L15 9H9zm3 8c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2z"/></svg>
  <p>{l s="Your card is empty!" mod="mobilefloatingcart"}</p>
</div>
<ul class="mfc-products" {if count($cart.products) == 0}style="display: none;"{/if}>
    {foreach $cart.products as $product}
        <li class="mfc-product" data-idproduct="{$product.id_product}" data-idshop="{$product.id_shop}">
          <div class="mfc-item">
            <div class="mfc-line">
              <img src="{$product.images[0].small.url}" alt="{$product.name}">
              <span class="mfc-details">
                <span class="mfc-name"><span>{$product.name}</span></span>
                <span class="mfc-quantity">Quantity: {$product.cart_quantity}</span>
              </span>
              <span class="mfc-price">{$product.total} <small>{$product.labels.tax_short}</small></span>
            </div>
          </div>
          <div class="mfc-more">
            <p>{strip_tags($product.description_short)}</p>
            <div class="mfc-controls">
              <div class="mfc-quantity-selector">
                <button {if $product.cart_quantity == 1}disabled{/if} data-uri="{$product.down_quantity_url}" style="{if $MFC_COLOR}background:{$MFC_COLOR};{/if}" class="js-increase-product-quantity mfc-action mfc-button mfc-circle mfc-icon"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="white" d="M19 13H5v-2h14v2z"/><path d="M0 0h24v24H0z" fill="none"/></svg></button>
                <span>{$product.cart_quantity}</span>
                <button {if $product.cart_quantity == $product.stock_quantity}disabled{/if} data-uri="{$product.up_quantity_url}" style="{if $MFC_COLOR}background:{$MFC_COLOR};{/if}" class="js-decrease-product-quantity mfc-action mfc-button mfc-circle mfc-icon"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="white" d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"/><path d="M0 0h24v24H0z" fill="none"/></svg></button>
              </div>
              <button data-uri="{$product.remove_from_cart_url}" title="{l s="Remove" d="Shop.Theme.Actions"}" class="mfc-action mfc-button mfc-circle mfc-icon mfc-flat"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/><path d="M0 0h24v24H0z" fill="none"/></svg></button>
            </div>
          </div>
        </li>
    {/foreach}
</ul>
<div class="mfc-summary" {if count($cart.products) == 0}style="display: none;"{/if}>
  <hr>
  {if $cart.totals.total != null}
  <div class="mfc-total">
    <span>{$cart.totals.total.label}</span>
    <span class="mfc-value">{$cart.totals.total.amount}</span>
  </div>
  {/if}
  {if $cart.subtotals.products != null}
  <div class="mfc-total-details">
    <span>{$cart.subtotals.products.label}</span>
    <span class="mfc-value">{$cart.subtotals.products.amount}</span>
  </div>
  {/if}
  {if $cart.subtotals.shipping != null}
  <div class="mfc-total-details">
    <span>{$cart.subtotals.shipping.label}</span>
    <span class="mfc-value">{$cart.subtotals.shipping.amount}</span>
  </div>
  {/if}
  {if $cart.subtotals.tax != null}
  <div class="mfc-total-details">
    <span>{$cart.subtotals.tax.label}</span>
    <span class="mfc-value">{$cart.subtotals.tax.label}</span>
  </div>
  {/if}
</div>
