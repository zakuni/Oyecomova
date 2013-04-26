$(function() {
    var current = 0;
    
    $('html').keyup(function(e) {
        switch(e.which) {
        case 38: // up cursor key
            $('h1').animate({
                fontSize: '70'
            }, 1000, function() {
            });
            $('section').show();
            break;
        case 40: // down cursor key
            $('section#current').scrollTop();
            $('h1').animate({
                fontSize: '200'
            }, 1000, function() {
                showPage(index);
            });
            break;
        case 37: // left cursor key
            if (current > 0) current--;
            showPage(current);
            break;
        case 39: // right cursor key
            if (current < $('h1').size() -1) current++;
            showPage(current);
            break;
        }
    });
});

showPage = function(index) {
    $('section').hide();
    $('section:eq(' + index + ')').show();
};
