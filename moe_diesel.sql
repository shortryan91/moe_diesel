
CREATE TABLE clients (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(400),
    email VARCHAR(800),
    phone_no VARCHAR(200),
    password_digest VARCHAR(400)
);



CREATE TABLE cars (
  id SERIAL4 PRIMARY KEY,
  make VARCHAR(600),
  year VARCHAR(400),
  registration VARCHAR(800),
  client_id INTEGER
);

CREATE TABLE bookings (
  id SERIAL4 PRIMARY KEY,
  date_booked DATE,
  client_id INTEGER,
  car_id INTEGER,
  issue VARCHAR(800)
);
