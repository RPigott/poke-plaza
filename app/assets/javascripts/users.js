/* Place all the behaviors and hooks related to the matching controller here. */
/* All this logic will automatically be available in application.js. */
/* global $ */

$(document).ready(function() {
    var queryStatus = -1; // -1 none, 0 query requested, 1 query in progress
    var validUsername = false;
    
    function validateFriendCode(nums) {
        var output = [nums.slice(0, 4)];
        if (nums.length >= 4) {
            output.push('-', nums.slice(4, 8));
        }
        if (nums.length >= 8) {
            output.push('-', nums.slice(8, 12));
        }
        return output.join('');
    }
    
    function validateRegistration() {
        var success = true;
        if (!validUsername) {
            $("#sign-up-error-username").show();
            $("#sign-up-error-username-success").hide();
            success = false;
        } else {
            $("#sign-up-error-username").hide();
            $("#sign-up-error-username-success").show();
        }
        if ($("#user_friend_code").val().replace(/\D/g, '').length < 12) {
            $("#sign-up-error-friend-code").show();
            $("#sign-up-error-friend-code-success").hide();
            success = false;
        } else {
            $("#sign-up-error-friend-code").hide();
            $("#sign-up-error-friend-code-success").show();
        }
        if ($("#user_password").val() != $("#user_confirm_password").val()) {
            $("#sign-up-error-match").show();
            success = false;
        } else {
            $("#sign-up-error-match").hide();
        }
        if ($("#user_password").val().length < $("#user_password").data("min-length")) {
            $("#sign-up-error-length").show();
            success = false;
        } else {
            $("#sign-up-error-length").hide();
        }
        
        if (success) {
            $("#sign-up-submit").prop('disabled', false);
        } else {
            $("#sign-up-submit").prop('disabled', true);
        }
    }
    
    function queryUsername() {
        if (queryStatus == -1) {
            $("#sign-up-error-username-availability").show();
            queryStatus = 1;
            $.ajax({
                type: "GET",
                url: "/pokemons/username_availability",
                data: {username: $("#user_username").val()},
                complete: function() {
                    queryStatus = -1;
                }
            }).done(function(data) {
                validUsername = data == 'true';
                validateRegistration();
                if (queryStatus == 0) {
                    queryStatus = -1;
                    return queryUsername();
                }
                if ($("#user_username").val().length == 0) {
                    validUsername = false;
                    validateRegistration();
                }
                $("#sign-up-error-username-availability").hide();
                queryStatus = -1;
            });
        }
    }
    
    $("#user_username").on("input", function() {
        var valid = $(this).val().replace(/\W/g, '');
        if ($(this).val() != valid) {
            $("#sign-up-error-username-invalid").stop(true, true).show().delay("slow").fadeOut();
            $(this).val(valid);
        } else {
            if ($(this).val().length == 0) {
                validUsername = false;
                validateRegistration();
                $("#sign-up-error-username").hide();
            } else if (queryStatus == -1) {
                queryUsername();
            } else {
                queryStatus = 0;
            }
        }
    });
    
    $("#user_ign").on("input", function() {
        var valid = $(this).val().replace(/\W/g, '');
        $(this).val(valid);
    });
    
    $("#user_friend_code").on("input", function() {
        var nums = $(this).val().replace(/\D/g, '');
        $(this).val(validateFriendCode(nums));
        validateRegistration();
    });
    $("#user_friend_code").on("keydown", function(event) {
        var nums = $(this).val().replace(/\D/g, '');
        if (event.which == 8 && nums.length % 4 == 0) {
            $(this).val(validateFriendCode(nums.slice(0, -1)));
            validateRegistration();
            return false;
        }
    });
    
    $("#user_password, #user_confirm_password").on("input", function() {
        validateRegistration();
    });
    
    $("#sign-up-submit").on("click", function() {
       console.log($("#user_friend_code").val());
    });
});