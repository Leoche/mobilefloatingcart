import './style/mfc.scss';

jQuery(document).ready(($) => { // eslint-disable-line no-undef
  $(document).on('click', '.mfc-material-ripple', function(event) {
    var surface = $(this);
    console.log("de");
    if (surface.find(".material-ink").length == 0) {
      surface.prepend("<div class='material-ink'></div>");
    }
    var ink = surface.find(".material-ink");
    ink.removeClass("animate");
    if (!ink.height() && !ink.width()) {
      var d = Math.max(surface.outerWidth(), surface.outerHeight());
      ink.css({height: d, width: d});
    }
    var x = event.pageX - surface.offset().left - (ink.width() / 2);
    var y = event.pageY - surface.offset().top - (ink.height() / 2);

    var rippleColor = surface.data("ripple-color");
    ink.css({
      top: y + 'px',
      left: x + 'px',
      background: rippleColor
    }).addClass("animate");
  });
  $('body').on('click', '.mfc-line', (event) => {
    event.currentTarget.closest('li').classList.toggle('mfc-active');
  });
  $('#mfc-button').on('click', (event) => {
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
        updateMFC(resp['mfc-json'], resp['mfc-content']);
      }, 'json');
    }, 'json');
  });
  prestashop.on('updatedCart', function (event) {
    $.post(MFC_REFRESH_URI.replace(/&amp;/g, '&'), {}, (resp) => {
        updateMFC(resp['mfc-json'], resp['mfc-content']);
    }, 'json');
  });
});

function updateMFC(json, resp) {
  console.log(resp);
  prestashop.cart = json;
  // Update totals and miscs
  $('.js-subtotal').html(json.summary_string)
  $('.cart-total .value').html(json.totals.total.value)
  $('.mfc-total .mfc-value').html(json.totals.total.value)
  $('.mfc-total-details.mfc-total-products .mfc-value').html(prestashop.cart.subtotals.products.value)
  $('.mfc-total-details.mfc-total-shipping .mfc-value').html(
    prestashop.cart.subtotals.shipping.value.charAt(0).toUpperCase() + prestashop.cart.subtotals.shipping.value.slice(1)
  )
  $('.mfc-cart-loader').removeClass("mfc-active");

  if (!$('#mfc-cart').hasClass('mfc-active')) {
    $('.mfc-cart-container').html(resp);
  } else {
    console.log("deeeeeeeeeeeeeeee")
    //Removing deleted products
    $('.mfc-products li').each((index, item) => {
      let id_product = item.dataset.idproduct;
      let id_shop = item.dataset.idshop;
      let exist = false;
      for (var i = prestashop.cart.products.length - 1; i >= 0; i--) {
        if (prestashop.cart.products[i].id_product == id_product &&
            prestashop.cart.products[i].id_shop == id_shop)
          exist = true;
      }
      if (!exist) item.remove();
    });
    $('.mfc-products li').each((index, item) => {
      let id_product = item.dataset.idproduct;
      let id_shop = item.dataset.idshop;
      for (var i = prestashop.cart.products.length - 1; i >= 0; i--) {
        if (prestashop.cart.products[i].id_product == id_product &&
            prestashop.cart.products[i].id_shop == id_shop) {
            let dataProduct = prestashop.cart.products[i];
            $(item).find('.mfc-quantity .value, .mfc-quantity-selector span').html(dataProduct.cart_quantity);

            if (dataProduct.cart_quantity == dataProduct.stock_quantity) {
              $(item).find('.js-increase-product-quantity').attr('disabled', 'disabled');
            } else {
              $(item).find('.js-increase-product-quantity').removeAttr('disabled');
            }

            if (dataProduct.cart_quantity == 1) {
              $(item).find('.js-decrease-product-quantity').attr('disabled', 'disabled');
            } else {
              $(item).find('.js-decrease-product-quantity').removeAttr('disabled');
            }
            
            $(item).find('.mfc-price .value').html(dataProduct.total);
        }
      }
    });
  }
}