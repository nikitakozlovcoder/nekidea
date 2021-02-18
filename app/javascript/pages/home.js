import '../vendor/jquery.nice-select.min.js'

export class Animal{
    
}
function sayhi(){
    console.log("hi!!");
}
export function start() {
    sayhi();
    $(document).ready(function() {
        $('select').niceSelect();
    });
}
