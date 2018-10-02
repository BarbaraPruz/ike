
function addArticleIdtoFormValues (values) {
    values+=`&article_id=${$("#article_id").text()}`
    console.log ("updated values with", $("#article_id"));
    return values;
}

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
}

$(function() {
    console.log("Article Show - ready");
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
        console.log("Next!");
        console.log("id",$("#article_id").val());
        e.preventDefault();
        let id = $("#article_id").val();
        let idstring = $("#article_ids").val();
        let ids = idstring.split(',').map( id => parseInt(id,10) );
        id = parseInt(id,10);
        console.log("xids", ids, "max index", ids.length-1);
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
        console.log("Values",values);
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
            $("#content").val(''); // Comment form - content field 
        });        
     });
});
