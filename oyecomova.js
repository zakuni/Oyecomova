$(function() {
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
            $('h1').animate({
                fontSize: '200'
            }, 1000, function() {
                $('section').hide();
                $('section#current').show();
            });
            break;
        }
    });
});
