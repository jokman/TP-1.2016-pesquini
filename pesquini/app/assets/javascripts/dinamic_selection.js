 $(document ).ready(function ( ) {

/*
File: dinamic_selection.js
Purpose: Script for dynamic selection in the application.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
*/

    var select_b = document.getElementById('select_button');
    if (select_b)
    {
      select_b.style.display = "none";
    }

    $('#select_tag').change(function() {
    $(this).closest('form').trigger('submit');
    });

});
