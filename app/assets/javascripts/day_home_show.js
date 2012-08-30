$(document).ready(function() {

        $("#contact_name").keyup(function() {
                delay(function() {
                        var name = $("#contact_name").val();
                        validate_field('name', name, $("#contact_name") );
                }, 600);
        });
        
        $("#contact_email").keyup(function() {
                delay(function() {
                        var email = $("#contact_email").val();
                        validate_field('email', email, $("#contact_email") );
                }, 600);
        });
        
});