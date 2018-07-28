CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL
);

CREATE TABLE user_activity (
	user_id INT,
	time TIMESTAMP,
	synonym_id INT,
	word_id INT,
	result BIT,
	FOREIGN KEY(user_id) REFERENCES users(id)
);
