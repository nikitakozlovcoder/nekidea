export function start() {
    let el1, el2;
    (el1 = document.querySelector('.btn-edit'))?.addEventListener('click', ()=>{
        el1.classList.toggle('btn-simple-active');
        document.querySelector('.profile-info').classList.toggle('hide');
        document.querySelector('.profile-form').classList.toggle('hide');
    });


    (el2 = document.querySelector('.btn-edit-password'))?.addEventListener('click', ()=>{
        el2.classList.toggle('btn-simple-active');
        document.querySelector('.password-change_form').classList.toggle('hide');

    });

}
