$(function() {
    $('html').keyup(function(e) {
        switch(e.which) {
        case 38: // up cursor key
            $('h1').animate({
                fontSize: '70'
            }, 1000, function() {
            });
            $('h1').show();
            break;
        case 40: // down cursor key
            $('h1').animate({
                fontSize: '200'
            }, 1000, function() {
                $('h1').hide();
                $('h1#current').show();
            });
            break;
        }
    });
});
