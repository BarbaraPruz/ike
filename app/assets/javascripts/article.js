// Article class used by article show next
class Article {
    constructor(article_json) {
      this.title = article_json.title;
      this.id = article_json.id;
      this.likes = article_json.helpful_count;      
      this.content = article_json.content;
      this.comments = [];
      article_json.comments.forEach ( comment => this.comments.push(new Comment(comment)));
    //       comment => this.comments.push({content: comment.content, 
    //                                      author:comment.author_name, 
    //                                      updated_at: comment.updated_at})
    //   );
    }

    show () {
        $("#article_title").text(this.title);
        $("#article_helpful_count").text(this.likes);
        $("#article_content").html(this.content);  
        $("#article_id").val(this.id);
    
        $("#comments_detail").empty();   
        let template = Handlebars.compile(document.getElementById("comments-template").innerHTML);
        this.comments.forEach ( comment => comment.show(template) );
    
        // NOTE: this code will update the URL so"next" URL looks correct.  But
        // it won't work 100% with back/forward browser buttons 
        // (browser will update URL but not reload). 
        // history.pushState({controller:"articles", id:`${article.id}` }, 
        //     "ike", `/articles/${article.id}`);
    }
       
};