/*0. 극장 테이블을 만드시오*/
CREATE TABLE cinema (
	cinid	INT		PRIMARY KEY,
    name	VARCHAR(2),
    loc		VARCHAR(2)
);
INSERT INTO cinema VALUES (1, '롯데', '잠실');
INSERT INTO cinema VALUES (2, '메가', '강남');
INSERT INTO cinema VALUES (3, '대한', '잠실');

CREATE TABLE theater (
	cinid	INT,
    theaid	INT  	CHECK(1 <= theaid AND theaid <= 10),
    title	VARCHAR(20),
    price	INT		CHECK(price <= 20000),
    seats 	INT,
    PRIMARY KEY		(cinid, theaid)
);
INSERT INTO theater VALUES (1, 1, '어려운 영화', 15000, 48);
INSERT INTO theater VALUES (3, 1, '멋진 영화', 7500, 120);
INSERT INTO theater VALUES (3, 2, '재밌는 영화', 8000, 110);

CREATE TABLE reservation (
	cinid	INT,
    theaid	INT  	CHECK(1 <= theaid AND theaid <= 10),
    custid  INT,
    seats 	INT		UNIQUE,
	ondate 	DATE,
    PRIMARY KEY		(cinid, theaid, custid)
);
INSERT INTO reservation VALUES (3,2,3,15,'2014-09-01');
INSERT INTO reservation VALUES (3,1,4,16,'2014-09-01');
INSERT INTO reservation VALUES (1,1,9,48,'2014-09-01');

CREATE TABLE theacustomer (
	custid	INT,
    name	VARCHAR(4),
    addr	VARCHAR(4)
);
INSERT INTO theacustomer VALUES (3, '홍길동', '강남');
INSERT INTO theacustomer VALUES (4, '김철수', '잠실');
INSERT INTO theacustomer VALUES (9, '박영희', '강남');

/*1. 극장의 수는 몇개인가?*/
SELECT	COUNT(*)
FROM	CINEMA;
/*2. 상영되는 영화의 평균 가격은 얼마인가?*/
SELECT	AVG(PRICE)
FROM	THEATER;
/*3. 2014년 9월 1일에 영화를 관람한 고객의 수는 얼마인가?*/
SELECT	COUNT(*)
FROM	RESERVATION
WHERE	ondate = '2014-09-01';
/*4. 대한 극장에서 상영된 영화제목을 보이시오*/
SELECT	title
FROM	theater
WHERE	cinid = 3;
/*5. 대한 극장에서 영화를 본 고객의 이름을 보이시오*/
SELECT	name
FROM	RESERVATION, THEACUSTOMER
WHERE	reservation.custid = theacustomer.custid AND cinid = 1;
/*6. 대한 극장의 전체 수입을 보이시오*/
SELECT	SUM(price)
FROM	reservation LEFT OUTER JOIN theater ON theater.theaid = reservation.theaid AND theater.cinid = reservation.cinid
WHERE	reservation.cinid = 1;
/*7. 극장별 상영관 수를 보이시오*/
SELECT		cinema.name, count(*)
FROM		cinema RIGHT OUTER JOIN theater ON cinema.cinid = theater.cinid
GROUP BY	name;
/*8. 잠실에 있는 극장의 상영관을 보이시오.*/
SELECT		name, loc, cinema.cinid, theaid
FROM		cinema RIGHT OUTER JOIN theater ON cinema.cinid = theater.cinid
WHERE		loc = '잠실';
/*9. 2014년 9월 1일의 극장별 평균 관람 고객 수를 보이시오*/
SELECT		count(*) AS cnt
FROM		cinema RIGHT OUTER JOIN reservation ON cinema.cinid = reservation.cinid
WHERE 		ondate = '2014-09-01'
GROUP BY	cinema.name;
/*10. 2014년 9월 1일에 가장 많은 고객이 관람한 영화를 보이시오 --> 불가(MySQL에서는 집계함수 중첩사용 불가)*/
SELECT		title, count(*) as cnt
FROM		theater RIGHT OUTER JOIN reservation ON theater.cinid = reservation.cinid AND theater.theaid = reservation.theaid
WHERE		ondate = '2014-09-01'
GROUP BY	title
HAVING 		cnt = (
	SELECT		MAX(count(*))
    FROM		theater RIGHT OUTER JOIN reservation ON theater.cinid = reservation.cinid AND theater.theaid = reservation.theaid
	WHERE		ondate = '2014-09-01'
	GROUP BY	theater.cinid, reservation.theaid	
);






