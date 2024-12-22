$(document).ready(function(){
    // Координаты курсора относительно всего документа
    $(document).mousemove(function(event){
        var x = event.pageX;
        var y = event.pageY;
        $('#coords1').html( 'Координаты курсора: (' + x + '; ' + y + ')' );
    });
    // Координаты курсора относительно отдельного блока
    $('.hover').mousemove(function(event){
        var pos = $(this).offset();
        var elem_left = pos.left.toFixed(0);
        var elem_top = pos.top.toFixed(0);
        var x = event.pageX - elem_left;
        var y = event.pageY - elem_top;
        $('#coords2').html( 'Координаты курсора: (' + x + '; ' + y + ')' );
    });
});



// function getPosition(e){
//     var x = y = 0;
//
//     if (!e) {
//         var e = window.event;
//     }
//
//     if (e.pageX || e.pageY){
//         x = e.pageX;
//         y = e.pageY;
//     } else if (e.clientX || e.clientY){
//         x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
//         y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
//     }
//
//     return {x: x, y: y}
// }
//
// /* Координаты курсора */
// $("body").mousemove(function(e){
//     var coord = getPosition(e);
//     $('#coord-live').html(coord.x + "," + coord.y);
// });
//
// /* Координаты клика */
// $('body').click(function(e){
//     var coord = getPosition(e);
//     $('#coord-click').html(coord.x + "," + coord.y);
// });