

    export function start() {
        $('.like').on('click', function(e) {
            e.preventDefault();
            if ($(this)[0].classList.contains('disabled'))
                return;
            let like = $(this);

            let el = $(this).parent();
            let idea_id = el[0].dataset.idea_id;
            let dislike = el.find('.dislike');
            let val_input = el.find('.value');
            let val = parseInt(val_input.val());
    
            if(dislike.hasClass('active')) {
                val++;
                dislike.removeClass('active');
            }
    
            if(like.hasClass('active')) {
                //unvote_up
                fetch('/ideas/'+idea_id + '/unvote_up');
                val--;
                like.removeClass('active');
            } else {
                //upvote
                fetch('/ideas/'+idea_id + '/upvote');
                val++;
                like.addClass('active');
            }
            
            val_input.val(val);
        });
    
        $('.dislike').on('click', function(e) {
            e.preventDefault();
            if ($(this)[0].classList.contains('disabled'))
                return;
            let dislike = $(this);
            let el = $(this).parent();
            let like = el.find('.like');
            let idea_id = el[0].dataset.idea_id;
            let val_input = el.find('.value');
            let val = parseInt(val_input.val());
    
            if(like.hasClass('active')) {
                val--;
                like.removeClass('active');
            }
    
            if(dislike.hasClass('active')) {
                fetch('/ideas/'+idea_id + '/unvote_down');
                val++;
                dislike.removeClass('active');
            } else {
                fetch('/ideas/'+idea_id + '/downvote');
                val--;
                dislike.addClass('active');
            }
            
            val_input.val(val);
        });
    }

