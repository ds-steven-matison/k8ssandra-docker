CREATE KEYSPACE demo  WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE demo;

DROP TABLE IF EXISTS images;
CREATE TABLE IF NOT EXISTS images (
	id text,
	name text,
	url text,
	width int,
	height int,
	box_count smallint,
  	PRIMARY KEY (id)
);

INSERT INTO images(id,name,url,width,height,box_count) VALUES('87743020','Two Buttons','https://i.imgflip.com/1g8my4.jpg',600,908,2);

DROP TABLE IF EXISTS images_saved;
CREATE TABLE IF NOT EXISTS images_saved (
    uuid uuid,
	id text,
	sessionid uuid,
	name text,
	url text,
	toptext text,
	bottomtext text,
	memename text,
	width int,
	height int,
	box_count smallint,
	image_source text,
  	PRIMARY KEY (uuid)
);
CREATE INDEX images_saved_id_idx ON images_saved (id);
