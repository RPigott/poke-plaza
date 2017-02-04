/* Place all the behaviors and hooks related to the matching controller here. */
/* All this logic will automatically be available in application.js. */
/* global $, PkSpr, Bloodhound */

function addPokemon() {
    
}

$(document).ready(function() {
    $('tr.pokemon').click(function() {
        document.location = $(this).data("link");
    });
    
    $('.selectpicker').selectpicker({tickIcon: ""})
    
    $('#select-ball .selectpicker').on('change', function() {
        PkSpr.process_container(this);
    });
    PkSpr.process_container($('#select-ball .dropdown-menu'));
    
    $('#select-species .typeahead').typeahead({
        hint: true,
        highlight: true,
        minLength: 1
    }, {
        name: "Species",
        source: new Bloodhound({
            datumTokenizer: Bloodhound.tokenizers.whitespace,
            queryTokenizer: Bloodhound.tokenizers.whitespace,
            local: species_typeahead
        })
    }).on('typeahead:selected', function(obj, datum, name) {
        $("#ability-selector").prop('disabled', false).selectpicker('refresh');
        $('#ability-selector').selectpicker('refresh');
    }).on('keyup', function(e) {
        if(e.which == 13) {
            $("#select-species .tt-suggestion:first-child").trigger('click');
        }
    });
});