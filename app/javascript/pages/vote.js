

    export function start() {
        $('.like').on('click', function(e) {
            e.preventDefault();
            let like = $(this);
            let el = $(this).parent();
            let dislike = el.find('.dislike');
            let val_input = el.find('.value');
            let val = parseInt(val_input.val());
    
            if(dislike.hasClass('active')) {
                val++;
                dislike.removeClass('active');
            }
    
            if(like.hasClass('active')) {
                val--;
                like.removeClass('active');
            } else {
                val++;
                like.addClass('active');
            }
            
            val_input.val(val);
        });
    
        $('.dislike').on('click', function(e) {
            e.preventDefault();
            let dislike = $(this);
            let el = $(this).parent();
            let like = el.find('.like');
            let val_input = el.find('.value');
            let val = parseInt(val_input.val());
    
            if(like.hasClass('active')) {
                val--;
                like.removeClass('active');
            }
    
            if(dislike.hasClass('active')) {
                val++;
                dislike.removeClass('active');
            } else {
                val--;
                dislike.addClass('active');
            }
            
            val_input.val(val);
        });
    }

