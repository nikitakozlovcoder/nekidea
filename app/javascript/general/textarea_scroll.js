function h(e) {
    console.log(e.scrollHeight);
    $(e).css({'height':'40','overflow-y':'hidden'}).height(e.scrollHeight);
}

function updateTextbox(text) {
	$('#cagetextbox').val(text);
	//$('#cagetextbox').attr("rows", Math.max.apply(null, text.split("\n").map(function(a){alert(a.length);return a.length;})));
};

export function start() {
    $(document).one('focus.textarea', '.autoExpand', function(){
        var savedValue = this.value;
        this.value = '';
        this.baseScrollHeight = this.scrollHeight;
        this.value = savedValue;
    }).on('input.textarea', '.autoExpand', function(){
        console.log('there');
        var minRows = this.getAttribute('data-min-rows')|0,
            rows;
        this.rows = minRows;
        console.log('scroll:', this.scrollHeight);
        console.log('base scroll:', this.baseScrollHeight);
        rows = Math.ceil((this.scrollHeight - this.baseScrollHeight) / 24);
        console.log('rows:', rows);
        this.rows = minRows + rows;
    });

    updateTextbox("");
}

