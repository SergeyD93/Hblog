// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function get_parent_id(id)
{
    var pattern = '_parent-';
    var start = id.indexOf(pattern);
    var length_for_remove = start + pattern.length;

    return id.substr(length_for_remove);
}

function get_comment_id(id)
{
    var pattern = '_parent-';
    var start = id.indexOf(pattern);
    return id.substr(0,start);
}

function build_tree(comments)
{
    if(comments.length > 0)
    {
        for (var i = 0; i < comments.length; i++)
        {
            for (var j = 0; j < comments.length; j++)
            {
                if(get_parent_id(comments[i].id) == get_comment_id(comments[j].id))
                {
                    comments[i].style.marginLeft = '30px';
                    comments[j].appendChild(comments[i]);
                }
            }
        }
    }
    else
    {
        $(document.getElementById("comments")).append('<p id = "no_comments_info">There is no comments yet</p>');
    }
}