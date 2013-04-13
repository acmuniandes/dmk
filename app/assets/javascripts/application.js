// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

function fbLogin() {
    FB.login(onLogin,{scope: 'email'});
}

function onLogin(response) {


    if (response.authResponse) {
        FB.api('/me', function(resp) {
            $('#modallogin').modal('show');
            var uid = resp.id;
            var name = resp.first_name;
            var email = resp.email;
            if (resp!=null){
                $.post('/client_auth',{uid: uid, name: name, email: email}, function(){

                }).done(function() {  window.location.href = '/me'; });
            }
        });
    } else {
        alert("Login failed");
    }
}
