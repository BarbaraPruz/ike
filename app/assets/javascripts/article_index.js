//<script type="text/javascript" charset="utf-8">

function createArticleTable (articles) {
    console.log("Create Article Table");
    $("#articles_table tbody").empty();
    articles.forEach ( function (article) {
        let html = `<tr>`;
        let date = moment(`${article.updated_at}`).format("YYYY-MM-DD HH:mm");
        html += `<th scope="row">${article.topic.name}</th>`;
        html += `<td><a href="/articles/${article.id}">${article.title}</a></td>`;
        html += `<td>${article.helpful_count}</td>`;
        html += `<td>${date}</td>`;
        html += `</tr>`;
        $("#articles_table tbody").append(html);
    });
}

$(function() {
    console.log("Articles index - ready");
    $.get("/articles/index_data", createArticleTable);
    $("#sort_button").on("click", function(e) {
        e.preventDefault();
        $.get("/articles/index_data", { sort: `${$("#sort").val()}` }, createArticleTable);          
    });
});

//</script>

