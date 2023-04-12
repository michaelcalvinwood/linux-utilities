CREATE DATABASE ai;
\c ai;
CREATE EXTENSION vector;
CREATE TABLE posts (id serial primary key, body text not null, embedding vector(1536));
