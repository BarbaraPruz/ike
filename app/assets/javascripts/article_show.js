
function likeHandler (e) {
    let id = $("#article_id").val();
    let values = $(this).serialize();
    $.post("/articles/" + id + "/like", values, function (article) {
        $("#article_helpful_count").text(article.helpful_count);          
    }); 
    e.preventDefault();    
}

function nextHandler (e) {
    let id = parseInt ($("#article_id").val(), 10);
    let ids = $("#article_ids").val().split(',').map( id => parseInt(id,10) );
    let idx = ids.indexOf(id);          
    if ( idx == (ids.length-1) ) { 
        alert("Last Article in Topic!");
    }
    else {
        id = ids[++idx];
        $.get("/articles/" + id + ".json", function (article_json) {
            let article = new Article(article_json);
            article.show();
        });
    }
    e.preventDefault();    
}

function createBookmarkHandler (e) {
    let id = $("#article_id").val();
    let values = $(this).serialize();
    $.post("/articles/" + id + "/bookmarks.json", values, function (bookmark_json) {
        let bookmark = new Bookmark(bookmark_json);
        bookmark.notification();
        $("#bookmark_title").val('');        
    }); 
    e.preventDefault();         
}

function newCommentHandler (e) {
    let id = $("#article_id").val();
    let values = $(this).serialize();
    $.post("/articles/" + id + "/comments.json", values, function (comment_json) {
        let comment = new Comment(comment_json);
        let template = Handlebars.compile(document.getElementById("comments-template").innerHTML);
        comment.show(template);
        $("#content").val(' '); // Comment form - content field             
    });
    e.preventDefault();      
}

$(function() {
    //console.log("Article Show - ready");

    // AttachListeners
    $("#like").submit(likeHandler);
    $("#next").click(nextHandler); 
    $("#create_bookmark").submit (createBookmarkHandler);
    $("#new_comment").submit (newCommentHandler);

});
