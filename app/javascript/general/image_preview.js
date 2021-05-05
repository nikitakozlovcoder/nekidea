function AppendPhoto(container, src) {
    var img = document.createElement('img');
    img.setAttribute('src', src);
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
      var elements = container.querySelectorAll('.img-wrapper img');
      elements.forEach((item) => {
          item.parentNode.removeChild(item);
      });
      //add images
      var images_container = container.querySelector('.img-wrapper');
      console.log(images_container);
      for(var i = 0; i<filesCount; i++){
          var reader = new FileReader();
          reader.onload = function(e) {
            AppendPhoto(images_container, e.target.result);
          }
          reader.readAsDataURL(input.files[i]);
      }
    }
}

export function start() {
    document.querySelectorAll("input[type = 'file']").forEach((el) => {
        el.addEventListener('change', () => {preview_image(el);});
    });
}