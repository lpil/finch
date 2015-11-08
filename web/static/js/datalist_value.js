'use strict';

if (window.datalistPage) {
  const input    = document.querySelector('#datalist-input');
  const list     = document.querySelectorAll('#datalist-data option');
  const reciever = document.querySelector('#datalist-reciever');

  input.addEventListener('input', function(e) {
    const inputValue = input.value;

    for(var i = 0; i < list.length; i++) {
      var option = list[i];
      if(option.value === inputValue) {
        reciever.value = option.innerText;
        return;
      }
    }
  });
}
