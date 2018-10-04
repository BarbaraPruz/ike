
function buildComment (comment) {
    let date = moment(`${comment.updated_at}`).format("YYYY-MM-DD HH:mm");
    let html = `<div class="indent">`;
    html += `<div class="mb-0">${comment.content}</div>`;
    html += `<h5 class="mt-0">${comment.author_name} on ${date}</h5>`;
    html += `</div>`;
    return html;
}

function showArticle (article) {
    console.log("Show Article!", article);
    $("#article_title").text(article.title);
    $("#article_helpful_count").text(article.helpful_count);
    $("#article_content").html(article.content);  
    $("#article_id").val(article.id);

    $("#comments_detail").empty();   
    article.comments.forEach ( function (comment) {
        $("#comments_detail").append(buildComment(comment));
    });

    // NOTE: this code will update the URL so"next" URL looks correct.  But
    // it won't work 100% with back/forward browser buttons 
    // (browser will update URL but not reload). 
    // history.pushState({controller:"articles", id:`${article.id}` }, 
    //     "ike", `/articles/${article.id}`);
}

function attachListeners() {

    $("#like").submit(function(e) {
        console.log("Like!",this);
        e.preventDefault();
        let id = $("#article_id").val();
        var values = $(this).serialize();
        $.post("/articles/" + id + "/like", values, function (article) {
            console.log("Likes Response", article);
            $("#article_helpful_count").text(article.helpful_count);          
        }); 
    });

    $("#next").on("click", function(e) {
        console.log("Next! id",$("#article_id").val());
        e.preventDefault();
        let id = parseInt ($("#article_id").val(), 10);
        let ids = $("#article_ids").val().split(',').map( id => parseInt(id,10) );
        let idx = ids.indexOf(id);          
        if ( idx == (ids.length-1) ) { 
            alert("Last Article in Topic!");
        }
        else {
            id = ids[++idx];
            console.log ("going to get",`"/articles/${id}"`);
            $.get("/articles/" + id + ".json", showArticle);
        }    
     });

     $("#create_bookmark").submit (function(e) {
        e.preventDefault();
        console.log("Create Bookmark!");
        let id = $("#article_id").val();
        var values = $(this).serialize();
        $.post("/articles/" + id + "/bookmarks.json", values, function (bookmark) {
            console.log("Bookmark Response", bookmark);
            alert(`Bookmark "${bookmark.bookmark_title}" Created!`);
            $("#bookmark_title").val('');        
        });        
     });

     $("#new_comment").submit (function(e) {
        e.preventDefault();
        console.log("New Comment!");
        let id = $("#article_id").val();
        var values = $(this).serialize();
        $.post("/articles/" + id + "/comments.json", values, function (comment) {
            console.log("Comment Response", comment); 
            $("#comments_detail").append(buildComment(comment));     
            $("#content").val(' '); // Comment form - content field            
        });        
     });
}

$(function() {
    console.log("Article Show - ready");
    attachListeners();

});
