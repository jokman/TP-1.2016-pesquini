/*
File: main.js
Purpose: Provides javascript structures related to the main page.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
*/

//= require nav_bar_transparency.js
function main() {


(function () {
   'use strict';


    /*====================================
    Show Menu on Book
    ======================================*/

    $(document).ready(function() {
    /*var welcome = document.getElementById('tf-home');*/
    if (document.getElementById('tf-home')  == null)
    {
      $('.navbar-default').addClass('on');
    }
    else
    {
      $('.navbar-default').removeClass('on');


      $(window).bind('scroll', function() {
          var navHeight = $(window).height() - 100;
          if ($(window).scrollTop() > navHeight) {
              $('.navbar-default').addClass('on');
          } else {
              $('.navbar-default').removeClass('on');
          }
      });

      }
    });

    $('body').scrollspy({
        target: '.navbar-default',
        offset: 80
    })

  	$(document).ready(function() {
  	  $("#search").owlCarousel({

  	      navigation : false, // Show next and prev buttons
  	      slideSpeed : 300,
  	      paginationSpeed : 400,
  	      autoHeight : true,
  	      itemsCustom : [
				        [0, 1],
				        [450, 2],
				        [600, 2],
				        [700, 2],
				        [1000, 4],
				        [1200, 4],
				        [1400, 4],
				        [1600, 4]
				      ],
  	  });

  	  $("#clients").owlCarousel({

  	      navigation : false, // Show next and prev buttons
  	      slideSpeed : 300,
  	      paginationSpeed : 400,
  	      autoHeight : true,
  	      itemsCustom : [
				        [0, 1],
				        [450, 2],
				        [600, 2],
				        [700, 2],
				        [1000, 4],
				        [1200, 5],
				        [1400, 5],
				        [1600, 5]
				      ],
  	  });

  	});


}());

}
main();
