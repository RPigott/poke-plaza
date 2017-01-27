/* Place all the behaviors and hooks related to the matching controller here. */
/* All this logic will automatically be available in application.js. */
/* global $ */


$(document).ready(function() {
    $(".fc-segment").on("input", function() {
        if (this.value.length >= this.maxLength) {
            $(this).val($(this).val().slice(0, 4));
            return;
        }
    });
    
    $(".fc-1").on("keydown", function(event) {
        if (this.value.length >= this.maxLength)
            $(this).nextAll('.fc-2').focus();
    });
    $(".fc-2").on("keydown", function(event) {
        if (this.value.length >= this.maxLength)
            $(this).nextAll('.fc-3').focus();
    });
    
    $(".fc-2").on("keydown", function(event) {
        if (this.value.length == 0 && event.which == 8)
            $(this).prevAll('.fc-1').focus();
    });
    $(".fc-3").on("keydown", function(event) {
        if (this.value.length == 0 && event.which == 8)
            $(this).prevAll('.fc-2').focus();
    });
});