-- 테이블 생성
CREATE TABLE course (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    teacher_id INT NOT NULL
);

-- 데이터 삽입
INSERT INTO course (id, name, teacher_id) 
VALUES 
(1, 'database design', 1),
(2, 'English literature', 2),
(3, 'Python programming', 1);

-- 테이블 생성
CREATE TABLE teacher (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);

-- 데이터 삽입
INSERT INTO teacher (id, first_name, last_name)
VALUES 
(1, 'Taylah', 'Booker'),
(2, 'Sarah-Louise', 'Blake');

-- 테이블 생성
CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL
);

-- 데이터 삽입
INSERT INTO student (id, first_name, last_name)
VALUES 
(1, 'Shreya', 'Bain'),
(2, 'Rianna', 'Foster'),
(3, 'Yosef', 'Naylor');

-- 테이블 생성
CREATE TABLE student_course (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);

-- 데이터 삽입
INSERT INTO student_course (student_id, course_id)
VALUES 
(1, 2),
(1, 3),
(2, 1),
(2, 2),
(2, 3),
(3, 1);

SELECT 
    student.id AS student_id,
    student.first_name,
    student.last_name,
    student_course.course_id
FROM 
    student
JOIN 
    student_course ON student.id = student_course.student_id;


SELECT 
    course.id AS course_id,
    course.name AS course_name,
    teacher.first_name AS teacher_first_name,
    teacher.last_name AS teacher_last_name
FROM 
    course
JOIN 
    teacher ON course.teacher_id = teacher.id;


SELECT 
    student_course.student_id,
    course.id AS course_id,
    course.name AS course_name
FROM 
    student_course
JOIN 
    course ON student_course.course_id = course.id;


SELECT 
    student.first_name, 
    student.last_name
FROM 
    student
JOIN 
    student_course ON student.id = student_course.student_id
JOIN 
    course ON student_course.course_id = course.id
WHERE 
    course.name = 'database design';


SELECT 
    course.name AS course_name
FROM 
    course
JOIN 
    teacher ON course.teacher_id = teacher.id
WHERE 
    teacher.first_name = 'Taylah'
    AND teacher.last_name = 'Booker';


-- 성이 "B"로 시작하는 학생 검색
SELECT 
    'Student' AS role,
    student.first_name, 
    student.last_name
FROM 
    student
WHERE 
    student.last_name LIKE 'B%'

UNION


-- 성이 "B"로 시작하는 교사 검색
SELECT 
    'Teacher' AS role,
    teacher.first_name, 
    teacher.last_name
FROM 
    teacher
WHERE 
    teacher.last_name LIKE 'B%';
