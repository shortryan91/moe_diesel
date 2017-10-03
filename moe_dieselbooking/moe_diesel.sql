
CREATE TABLE clients (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(400),
    email VARCHAR(800),
    phone_no VARCHAR(200),
    password_digest VARCHAR(400),
    cars_id INTEGER
);



CREATE TABLE cars (
  id SERIAL4 PRIMARY KEY,
  make VARCHAR(600),
  year VARCHAR(400),
  registration VARCHAR(800)
);
