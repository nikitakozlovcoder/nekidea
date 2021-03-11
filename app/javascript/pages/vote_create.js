function AppendPhoto(container, src) {
    var img = document.createElement('img');
    img.setAttribute('src', src);
    // img.className = 'img-wrapper';
    // img.innerHTML = `<img src="${src}"/>`;
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

document.querySelectorAll("input[type = 'file']").forEach((el) => {
    el.addEventListener('change', () => {preview_image(el);})
});

// $("div#iter").each((i, el) => {
//     $(el).on('change', 'select', () => {
//         let val = el.querySelector('select').value;
//         if(val == 'other') {
//             el.parentNode.querySelector("div[data-id = 'iter_additional']").classList.remove('fullhidden');
//         } else {
//             el.parentNode.querySelector("div[data-id = 'iter_additional']").classList.add('fullhidden');
//         };
//     });
// });

$("div#vote_type").each((i, el) => {
    $(el).on('change', 'select', () => {
        let val = el.querySelector('select').value;
        let btn = el.parentNode.parentNode.querySelector("div#add_iter");
        if(val == '2') {
            btn.classList.remove('fullhidden');
        } else {
            //and remove or hide
            btn.classList.add('fullhidden');
        };
    });
});

$('div#add_iter button').on('click', (e) => {
    e.preventDefault();
    console.log("Hi!!!")
})