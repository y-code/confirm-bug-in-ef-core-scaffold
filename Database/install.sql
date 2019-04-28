CREATE DATABASE :db WITH TEMPLATE template0;

\c sampledb

CREATE SCHEMA sample;

CREATE TABLE sample.message (
  id serial /*int GENERATED ALWAYS AS IDENTITY*/ PRIMARY KEY,
  message text
);

INSERT INTO sample.message ( message ) VALUES ( 'Hello, world!' );
INSERT INTO sample.message ( message ) VALUES ( 'How are you?');
INSERT INTO sample.message ( message ) VALUES ( 'Not bad.' );
