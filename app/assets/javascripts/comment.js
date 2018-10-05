// Comment class used by article show - next and new comment
class Comment {
    constructor(comment_json) {
      this.content = comment_json.content;
      this.author = comment_json.author_name;      
      this.updated_at = comment_json.updated_at;
    }
   
    show (hbtemplate) {
        let result = hbtemplate(this);
        $("#comments_detail").append(result);
    }
};