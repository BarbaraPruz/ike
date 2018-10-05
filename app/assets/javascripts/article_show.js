
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
        $.get("/articles/" + id + ".json", function (a) {
            let article = new Article(a.title, a.id, a.helpful_count, a.content);
            a.comments.forEach ( function (comment) {
               article.addComment(comment.content, comment.author_name, comment.updated_at);
            });
            article.show();
        });
    }
    e.preventDefault();    
}

function createBookmarkHandler (e) {
    let id = $("#article_id").val();
    let values = $(this).serialize();
    $.post("/articles/" + id + "/bookmarks.json", values, function (bookmark) {
        alert(`Bookmark "${bookmark.bookmark_title}" Created!`);
        $("#bookmark_title").val('');        
    }); 
    e.preventDefault();         
}

function newCommentHandler (e) {
    let id = $("#article_id").val();
    let values = $(this).serialize();
    $.post("/articles/" + id + "/comments.json", values, function (comment) {
        let template = Handlebars.compile(document.getElementById("comments-template").innerHTML);
        let result = template(comment);
        $("#comments_detail").append(result);
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
