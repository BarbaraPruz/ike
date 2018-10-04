
function createArticleTable (articles) {
    console.log("Create Article Rows, count", articles.length);
     
    let template = Handlebars.compile(document.getElementById("article-index-template").innerHTML);
    let result = template(articles);
    $("#articles_table tbody")[0].innerHTML = result;
}

$(function() {
    console.log("Articles index - ready");
    let currentPage = $("#current_page")
    if ((currentPage.hasClass("articles")) && 
        (currentPage.hasClass("index")) ) {
        $.get("/articles/index_data", createArticleTable);
    } 
    $("#sort_button").on("click", function(e) {
        e.preventDefault();
        $.get("/articles/index_data", { sort: `${$("#sort").val()}` }, createArticleTable);          
    });
});

