import './style/mfc.scss';

document.querySelector('#mfc-button').addEventListener('click', () => {
  document.querySelector('#mfc-button').classList.toggle('mfc-active');
  document.querySelector('#mfc-cart').classList.toggle('mfc-active');
});
document.querySelectorAll('.mfc-line').forEach((item) => {
  item.addEventListener('click', (e) => {
    e.target.closest('li').classList.toggle('mfc-active');
  });
});
