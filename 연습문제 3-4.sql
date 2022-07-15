/*1. 새로운 도서('스포츠 세게', '대한미디어', 10000원)이 마당서점에 입고되었다.*/
INSERT INTO BOOK(bookname, publisher, price) VALUES ('스포츠 세계', '대한미디어', 10000);
/*기본키를 지정하지 않았기에, 데이터가 안 들어간다.*/
/*2. '삼성당'에서 출판한 도서를 삭제하시오*/
DELETE	FROM	book
		WHERE	publisher = '삼성당';
/*3. '이상미디어'에서 출판한 도서를 삭제하시오.*/
DELETE	FROM	book
		WHERE	publisher = '이상미디어';
/*orders의 외래키가 참조하는 기본키이기에 삭제가 거부되었다.*/
/*4. 출판사 '대한미디어'를 '대한출판사'로 이름을 바꾸시오.*/
UPDATE	book
SET		publisher = '대한출판사'
WHERE	publisher = '대한미디어';
/*5. 출판사에 대한 정보를 저장하는 테이블 Bookcompany(name, address, begin)을 생성하시오*/
CREATE TABLE Bookcompany(
	name 	VARCHAR(20)		PRIMARY KEY,
    address	VARCHAR(20),
    begin	DATE
);
/*6. Bookcompany 테이블에 인터넷 주소를 저장하는 webaddress 속성을 varchar(30)으로 추가하시오.*/
ALTER TABLE Bookcompany
	ADD		webaddress	VARCHAR(30);
/*7. Bookcompany 테이블에 임의의 투플을 삽입하시오*/
INSERT Bookcompany VALUES ('신재현', '인천광역시 연수구 송도3동', '1998-03-05', 'www.sogang.ac.kr');