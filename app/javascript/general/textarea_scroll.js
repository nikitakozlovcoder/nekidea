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
        var minRows = this.getAttribute('data-min-rows')|0,
            rows;
        this.rows = minRows;
        rows = Math.ceil((this.scrollHeight - this.baseScrollHeight) / 24);
        this.rows = minRows + rows;
    });

    updateTextbox("");
}

