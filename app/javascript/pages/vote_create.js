function AppendPhoto(container, src) {
    var img = document.createElement('div');
    img.className = 'img-wrapper';
    img.innerHTML = `<img src="${src}"/>`;
    container.appendChild(img);
}

function preview_image(input) {

    if (input.files) {
      //get images count
      var filesCount = input.files.length;
      //get outter_container
      var container = input.parentNode;
      //mark that images changed
      container.querySelector('input[type="text"]').value = "Yes";
      //delete old elements
      var elements = container.getElementsByClassName("img-wrapper");
      while (elements[0]) {
         elements[0].parentNode.removeChild(elements[0]);
      }
      //add images
      var images_container = container.querySelector('input[type="text"]');
      for(var i = 0; i<filesCount; i++){
          var reader = new FileReader();
          reader.onload = function(e) {
            AppendPhoto(container, e.target.result);
          }
          reader.readAsDataURL(input.files[i]);
      }
    }
}

document.querySelectorAll("input[type = 'file']").forEach((el) => {
    el.addEventListener('change', () => {preview_image(el);})
});

$("div[data-id = 'iter']").each((i, el) => {
    $(el).on('change', 'select', () => {
        let val = el.querySelector('select').value;
        if(val == 'other') {
            el.parentNode.querySelector("div[data-id = 'iter_additional']").classList.remove('fullhidden');
        } else {
            el.parentNode.querySelector("div[data-id = 'iter_additional']").classList.add('fullhidden');
        };
    });
});
