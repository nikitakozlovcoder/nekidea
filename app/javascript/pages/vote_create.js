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

// $("div#vote_type").each((i, el) => {
//     $(el).on('change', 'select', () => {
//         let val = el.querySelector('select').value;
//         let btn = el.parentNode.parentNode.querySelector("div#add_iter");
//         if(val == '2') {
//             btn.classList.remove('fullhidden');
//         } else {
//             //and remove or hide
//             btn.classList.add('fullhidden');
//         };
//     });
// });
let id_iter = 0;
$('#add_iter').on('click', (e) => {
    let container = $('div#iters');
    let iter_num = ++id_iter;
    let el = $(`<div data-id = "${iter_num}"></div>`).append(`
    <div class = "form-group">
        <label class="del btn-simple-outline right"><i class="fas fa-times"></i></label>
    </div>
    <div class="form-group">
        <label for="vote_name${iter_num}" class="inp">
            <input id="vote_name${iter_num}" placeholder=" " type="text" name="vote[title]">
            <span class="label">Название этапа</span>
        </label>
    </div>
    <div class="form-group">
        <label for="vote_description${iter_num}" class="inp textarea">
            <textarea id="vote_description${iter_num}" placeholder=" " class="autoExpand" rows="1" data-min-rows="1" name="vote[body]"></textarea>
            <span class="label">Описание этапа</span>
        </label>
  </div>
  <div class="form-group">
        <p class = "title">Продолжительность фазы предложения идей</p>
        <label for="vote_collecting${iter_num}" class="inp number">
            <input id="vote_collecting${iter_num}" placeholder=" " type="text" name="vote[days_collecting]">
            <span class="label">Количество дней</span>
        </label>
  </div>
  <div class="form-group">
        <p class = "title">Продолжительность фазы оценивания идей</p>
        <label for="vote_voting${iter_num}" class="inp number">
            <input id="vote_voting${iter_num}" placeholder=" " type="text" name="vote[days_voting]">
            <span class="label">Количество дней</span>
        </label>
  </div>`);
  container.append(el);
  el = container.find(`div[data-id = "${iter_num}"]`);
  el.find('.del.btn-simple-outline').on('click', (e) => {
     el.remove();
     console.log(iter_num);
 });
})