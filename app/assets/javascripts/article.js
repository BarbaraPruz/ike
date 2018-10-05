// Article class used by article show next
class Article {
    constructor(title, id, likes, content) {
      this.title = title;
      this.id = id;
      this.likes = likes;      
      this.content = content;
      this.comments = [];
    }
  
    addComment (comment, author, date) {  
      this.comments.push({content: comment, author:author, updated_at: date});
    }
  
    show (article) {
        $("#article_title").text(this.title);
        $("#article_helpful_count").text(this.likes);
        $("#article_content").html(this.content);  
        $("#article_id").val(this.id);
    
        $("#comments_detail").empty();   
        let template = Handlebars.compile(document.getElementById("comments-template").innerHTML);
        this.comments.forEach ( function (comment) {
            let result = template(comment);
            console.log("show comments",result);
            $("#comments_detail").append(result);
        });
    
        // NOTE: this code will update the URL so"next" URL looks correct.  But
        // it won't work 100% with back/forward browser buttons 
        // (browser will update URL but not reload). 
        // history.pushState({controller:"articles", id:`${article.id}` }, 
        //     "ike", `/articles/${article.id}`);
    }
    
};