class Bookmark {
    constructor (bookmark_json) {
        this.title = bookmark_json.bookmark_title;
    }

    notification() {
        alert(`Bookmark "${this.title}" Created!`);
    }

};