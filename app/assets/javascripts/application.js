// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .
// tinymce is for rich text editing
//= require tinymce
// moment for js formatting of times
//= require moment.min
// handlebars templating
//= require handlebars.js

Handlebars.registerHelper('updated_at_time', function() {
    return moment(this.updated_at).format("YYYY-MM-DD HH:mm");
});  

Handlebars.registerHelper('concat', function() {
    let outStr = '';
    for(var arg in arguments){
        if(typeof arguments[arg]!='object'){
            outStr += arguments[arg];
        }
    }
    return outStr;
});
