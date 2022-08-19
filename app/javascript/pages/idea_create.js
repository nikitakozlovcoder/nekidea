
export function start() {
    console.log( document.querySelectorAll('.res-item'))
    document.querySelectorAll('.res-item').forEach((el)=>{
        el.querySelector('.del').addEventListener('click', ()=>{
            el.remove();
        })

    })
    console.log("Hi!");

    let id_res = 0;
    $('#add_res').on('click', (e) => {
        let container = $('#res-container');
        let res_num = ++id_res;
        let el = $(`
                    <div class = "res-item" data-id = "${res_num}">
                        <label class = "icon"><i class="fas fa-link"></i></label>
                        <label for="res_name${res_num}" class="inp number name">
                            <input id="res_name${res_num}" class = "res_name" placeholder=" " type="text" required>
                            <span class="label">Название</span>
                        </label>
                        <label for="res_link${res_num}" class="inp number link">
                            <input id="res_link${res_num}" class = "res_link" placeholder=" " type="text" required>
                            <span class="label">Ссылка</span>
                        </label>
                        <label class="del btn-simple-outline"><i class="fas fa-times"></i></label>
                    </div>
        `);
        container.append(el);
        el = container.find(`div[data-id = "${res_num}"]`);
        el.find('.del.btn-simple-outline').on('click', (e) => {
            el.remove();
        });
    });

    $('.ideaform').on('submit', (e) => {
        e.preventDefault();
        let json_array = [];
        let el = $('#res-container');
        el.find('.res-item').each((i, el) => {
            let obj = {name:null, link:null};
            obj.name = $(el).find('.res_name').val();
            obj.link = $(el).find('.res_link').val();

            json_array.push(obj);
        });

        let form = document.querySelector('.ideaform');
        $(form).find('#idea_res_array').val(JSON.stringify(json_array));
        form.submit();
    });
}
