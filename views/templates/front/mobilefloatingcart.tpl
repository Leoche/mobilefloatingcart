<!--
* 2018 Léo DESIGAUX
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author Léo DESIGAUX <leodesigaux@gmail.com>
*  @copyright  2018 Léo DESIGAUX
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
* -->
<script>
var MFC_REFRESH_URI = "{$link->getModuleLink('mobilefloatingcart', 'ajax', array())}";
</script>
<div id="mfc-cart" class="mfc-active" style="{if $MFC_ZINDEX} z-index:{$MFC_ZINDEX};{/if}">
  <div class="mfc-cart-container">
    {include 'module:mobilefloatingcart/templates/front/mobilefloatingcart-content.tpl'}
  </div>
  <div class="mfc-cart-loader">
    <div class="mfc-loader">
      <svg class="mfc-circular" viewBox="25 25 50 50">
        <circle class="mfc-path" cx="50" cy="50" r="20" fill="none" stroke="{if $MFC_COLOR}{$MFC_COLOR}{/if}" stroke-width="2" stroke-miterlimit="10"/>
      </svg>
    </div>
  </div>
</div>
<div id="mfc-button" class="{if !$MFC_SHOWONDESKTOP}hidden-md-up{/if} {if $MFC_HIDDENONCARTEMPTY}hidden-on-empty{/if}" style="{if $MFC_COLOR}background:{$MFC_COLOR};{/if}{if $MFC_ZINDEX} z-index:{$MFC_ZINDEX};{/if}">
  {if $MFC_ICON != null}
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
