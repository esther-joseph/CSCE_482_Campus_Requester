﻿// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
function redirectPost(url, data) {
    var form = document.createElement('form');
    document.body.appendChild(form);
    form.method = 'post';
    form.action = url;
    for (var name in data) {
        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = name;
        input.value = data[name];
        form.appendChild(input);
    }
    form.submit();
}

function onSignIn(googleUser) {
    var idToken = googleUser.getAuthResponse().id_token;
    console.log(idToken);
    document.getElementById("idParagraph").innerHTML = idToken;
    var ele = $("idParagraph");
    ele.text(idToken);
    $('idParagraph').text(idToken);
}

/*
function onLoad() {
    gapi.load('auth2', function () {
        gapi.auth2.init();
    });
}
*/

function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
        console.log('User signed out.');
    });
}