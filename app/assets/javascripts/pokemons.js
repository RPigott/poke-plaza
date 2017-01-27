/* Place all the behaviors and hooks related to the matching controller here. */
/* All this logic will automatically be available in application.js. */
/* global $ */

$(document).ready(function() {
    $('tr.pokemon').click(function() {
        document.location = $(this).data("link");
    });    
});
