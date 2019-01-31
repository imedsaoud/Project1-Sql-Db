



CREATE TABLE subj (
	id INT UNSIGNED AUTO_INCREMENT,
	title VARCHAR(100) NOT NULL,
	content TEXT NOT NULL,
	auteur_id INT UNSIGNED NOT NULL,
	date_publication DATETIME NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE User (
	id INT UNSIGNED AUTO_INCREMENT,
	pseudo VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	password CHAR(40) NOT NULL,  
	PRIMARY KEY(id)
);

CREATE TABLE Category (
	id INT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(150) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE Category_subj (
	category_id INT UNSIGNED,
	subj_id INT UNSIGNED,
	PRIMARY KEY (category_id, subj_id)
);

CREATE TABLE Comment (
	id INT UNSIGNED AUTO_INCREMENT,
	subj_id INT UNSIGNED NOT NULL,
	auteur_id INT UNSIGNED,
	content TEXT NOT NULL,
	date_comment DATETIME NOT NULL,
	PRIMARY KEY(id)
);

-- Clés étrangères
ALTER TABLE subj 
ADD CONSTRAINT fk_auteur_subj FOREIGN KEY (auteur_id) REFERENCES User(id);

ALTER TABLE Categorie_article 
ADD CONSTRAINT fk_article_cat FOREIGN KEY (subj_id) REFERENCES subj(id),
ADD CONSTRAINT fk_category_cat FOREIGN KEY (category_id) REFERENCES Category(id);

ALTER TABLE Comment  
ADD CONSTRAINT fk_subj_com FOREIGN KEY (subj_id) REFERENCES subj(id),
ADD CONSTRAINT fk_auteur_com FOREIGN KEY (auteur_id) REFERENCES User(id);

-- Index
CREATE UNIQUE INDEX index_email
ON User(email);

CREATE UNIQUE INDEX index_pseudo
ON User(pseudo);

CREATE INDEX index_date_subj 
ON subj(date_publication);

CREATE INDEX index_date_comment
ON Comment(date_comment);