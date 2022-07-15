/*1. 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름*/
SELECT		name
FROM		customer
WHERE		custid IN (
	SELECT		DISTINCT custid
	FROM		book, orders
	WHERE		orders.bookid = book.bookid AND book.publisher IN (
		SELECT		DISTINCT publisher
		FROM		orders, book
		WHERE		orders.bookid = book.bookid AND orders.custid = 1
	)
);
/*2. 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름*/
SELECT		name
FROM		customer
WHERE		custid IN (
	SELECT 		custid
	FROM		orders, book
	WHERE		orders.bookid = book.bookid
	GROUP BY	custid
	HAVING		COUNT(DISTINCT publisher) >= 2
);
/*3. 전체 고객의 30% 이상이 구매한 도서*/
SELECT		bookname
FROM		book
WHERE		bookid IN (
	SELECT		bookid
	FROM		ORDERS
	GROUP BY	bookid
	HAVING		COUNT(DISTINCT custid) >= (SELECT COUNT(*) FROM CUSTOMER) * 0.3
);



