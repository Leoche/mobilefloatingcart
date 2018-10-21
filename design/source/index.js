import './style/mfc.scss';



jQuery(document).ready(($) => { // eslint-disable-line no-undef

  $('body').on('click', '.mfc-line', (event) => {
    event.currentTarget.closest('li').classList.toggle('mfc-active');
  });
  $('#mfc-button').on('click', (event) => {
    event.stopPropagation();
    $('#mfc-button, #mfc-cart').toggleClass('mfc-active');
  });
  $('body').on('click', '.mfc-action', (event) => {
    $('.mfc-cart-loader').addClass("mfc-active");
    const URI = event.currentTarget.closest('.mfc-action').dataset.uri;
    $.post(URI, {ajax: '1', action: 'update'}, (res) => {
      $.post(prestashop.urls.base_url + "index.php?controller=cart&ajax=1&action=refresh", {controller: 'cart', ajax: '1', action: 'refresh'}, (resp) => {
        $('.cart-detailed-totals').replaceWith(resp.cart_detailed_totals);
        $('.cart-summary-items-subtotal').replaceWith(resp.cart_summary_items_subtotal);
        $('.cart-summary-totals').replaceWith(resp.cart_summary_totals);
        $('.cart-detailed-actions').replaceWith(resp.cart_detailed_actions);
        $('.cart-voucher').replaceWith(resp.cart_voucher);
        $('.cart-overview').replaceWith(resp.cart_detailed);

        $('#product_customization_id').val(0);

        $('.js-cart-line-product-quantity').each((index, input) => {
          var $input = $(input);
          $input.attr('value', $input.val());
        });

        prestashop.emit('updatedCart', {eventType: 'updateCart', resp: resp});

      }, 'json');
      $.post(MFC_REFRESH_URI.replace(/&amp;/g, '&'), {}, (resp) => {
        $('.mfc-cart-container').html(resp['mfc-content']);
        $('.mfc-cart-loader').removeClass("mfc-active");
      }, 'json');
    }, 'json');
  });
  prestashop.on('updatedCart', function (event) {
    console.log();
    $.post(MFC_REFRESH_URI.replace(/&amp;/g, '&'), {}, (resp) => {
      $('.mfc-cart-container').html(resp['mfc-content']);
      $('.mfc-cart-loader').removeClass("mfc-active");
    }, 'json');
  });
});
