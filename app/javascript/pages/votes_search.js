export function start() {
    var search_input = $('.search-section .search-bar input')[0];
    var container = $('.list-container');
    var message = $('.list-container .message-item');
    $(search_input).on('keyup', (e) => {
        var val = search_input.value.trim().toLowerCase();
        var records = container.find('.list-item:not(.filtered)');
        
        message.addClass('hide');

        records.each((i, el) => {
            $(el).removeClass('hide');
            var name = $(el).find('.info .name').text();
            if(name.toLowerCase().indexOf(val) == -1) {
                $(el).addClass('hide');
            }
        })
        
        if(container.find('.list-item:not(.hide, .filtered)').length == 0) {
            message.removeClass('hide');
        }
    })

    var cur_select = $('.filters select')[0];
    $(cur_select).on('change', (e) => {
        container.find('.list-item').each((i, el) => {
            $(el).removeClass('filtered');
            if(
                (cur_select.value == 'archived')&&!$(el).hasClass('archived')||
                (cur_select.value == 'active')&&$(el).hasClass('archived')
              )
            {
                $(el).addClass('filtered');
            }
        })
    })
}