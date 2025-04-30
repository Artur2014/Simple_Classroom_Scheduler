DROP DATABASE IF EXISTS simple_scheduler;
CREATE DATABASE simple_scheduler;

\connect simple_scheduler

CREATE TABLE classes (
    id SERIAL PRIMARY KEY,
    class_name VARCHAR(255),
    start_time TIME,
    end_time TIME
);

CREATE TABLE rooms (
    id SERIAL PRIMARY KEY,
    room_name VARCHAR(255),
    capacity INT
);

CREATE TABLE schedules (
    id SERIAL PRIMARY KEY,
    class_id INT REFERENCES classes(id),
    room_id INT REFERENCES rooms(id),
    schedule_time TIMESTAMP
);

INSERT INTO classes (class_name, start_time, end_time) VALUES
('Math 101', '09:00:00', '10:30:00'),
('Physics 101', '11:00:00', '12:30:00'),
('Chemistry 101', '13:00:00', '14:30:00');

INSERT INTO rooms (room_name, capacity) VALUES
('Room A', 30),
('Room B', 25),
('Room C', 40);

INSERT INTO schedules (class_id, room_id, schedule_time) VALUES
(1, 1, '2025-04-27 09:00:00'),
(2, 2, '2025-04-27 11:00:00'),
(3, 3, '2025-04-27 13:00:00');

