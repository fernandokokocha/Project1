#// This is a manifest file that'll be compiled into application.js, which will include all the files
#// listed below.
#//
#// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
#// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#//
#// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
#// compiled file.
#//
#// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
#// about supported directives.
#//
#//= require jquery
#//= require jquery_ujs
#//= require turbolinks
#//= require_tree .

$(document).ready ->
  $('.preview-link').click (e) ->
    e.preventDefault()
    ann_id = this.name;
    current_row = $( this ).parent().parent()
    current_link = $( this )

    if current_link.text() is 'Hide'
      current_row.next().remove()
      current_link.text('Preview')
    else
      $.ajax
        url: '/announcements/' + ann_id
        type: 'GET'
        dataType: 'JSON'
      .success (c) ->
        newrow = "<tr ><td colspan='6' class='preview-row'>#{c.content}</td></tr>";
        current_row.after(newrow)
        current_link.text('Hide')