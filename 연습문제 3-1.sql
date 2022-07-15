/*1. 도서번호가 1인 도서의 이름*/
SELECT 	bookname
FROM	book
WHERE	bookid = 1;
/*2. 가격이 20,000원 이상인 도서의 이름*/
SELECT	bookname
FROM	book
WHERE	price >= 20000;
/*3. 박지성의 총 구매액*/
SELECT	SUM(saleprice)
FROM 	orders
WHERE	custid = (
	SELECT 	custid
    FROM	customer
	WHERE	name = '박지성'
);
/*4. 박지성이 구매한 도서의 수*/
SELECT	COUNT(*)
FROM	orders
WHERE	custid = (
	SELECT 	custid
    FROM	customer
	WHERE	name = '박지성'
);
/*5. 박지성이 구매한 도서의 출판사 수*/
SELECT	COUNT(DISTINCT publisher) '출판사 수'
FROM	orders, book
WHERE	orders.bookid = book.bookid AND custid = 1;
/*6. 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이*/
SELECT	book.bookname, book.price AS 정가, book.price-orders.saleprice AS 가격차이
FROM	orders, book
WHERE	orders.bookid = book.bookid AND custid = 1;
/*7. 박지성이 구매하지 않은 도서의 이름*/
SELECT	bookname
FROM	book
WHERE	bookid NOT IN (
	SELECT	bookid
    FROM	orders
	WHERE	custid = 1
);