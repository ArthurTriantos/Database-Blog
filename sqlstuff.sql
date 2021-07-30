CREATE SCHEMA blog_artymctry;
USE blog_artymctry;

CREATE TABLE author (
	id INT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    _created TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (id)
);

CREATE TABLE blogs (
	id INT AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    authorid INT NOT NULL,
    _created TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (id),
    FOREIGN KEY (authorid) REFERENCES author (id)
);
    
CREATE TABLE tags (
		id INT AUTO_INCREMENT,
		name VARCHAR(20) NOT NULL UNIQUE,
        _created TIMESTAMP DEFAULT NOW(),
        PRIMARY KEY (id)
);

CREATE TABLE blogtags (
	blogid INT NOT NULL,
    tagid INT NOT NULL,
    PRIMARY KEY (blogid, tagid),
    FOREIGN KEY (blogid) REFERENCES blogs (id),
    FOREIGN KEY (tagid) REFERENCES tags (id)
);

INSERT INTO author (email, name) VALUE ('cry@more.com', 'Fart Doctor');
INSERT INTO blogs (title, content, authorid) VALUE ('Test Blog Title', 'Test Blog Content', 1);
INSERT INTO tags (name) VALUE ('Test Tag FardxD');
INSERT INTO blogtags (blogid, tagid) VALUE (1, 1);

DELIMITER &&
CREATE PROCEDURE spBLogTags (blog_id INT)
BEGIN
	SELECT tags.id, tags.name FROM blogtags
    JOIN tags ON tags.id = blogtags.tagid
    WHERE blogid =blog_id;
END &&
DELIMITER ;