import "./style/mfc.scss";
import "./style/mfc-configurator.scss";
const saySomething = something => {
  console.log(something); // eslint-disable-line no-console
};

saySomething("Something! (index.js)");
document.querySelector('#mfc-button').addEventListener('click', function (e) {
  document.querySelector('#mfc-button').classList.toggle('mfc-active')
  document.querySelector('#mfc-cart').classList.toggle('mfc-active')
})
document.querySelectorAll('.mfc-line').forEach(function (item) {
  item.addEventListener('click', function (e) {
    e.target.closest('li').classList.toggle('mfc-active')
  })
})
