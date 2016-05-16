/*
File: pagination.js
Purpose: Provides javascript structures for pagination.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
*/

$(function(){

  $(document).on( 'click', '.pagination a', function(){
    $.get( this.href, null, null, "script");
    return false;
  });

});
