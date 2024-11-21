//clc
//a=3
//b=4
//c=a+b
//disp('wynik: ',c)
//
//clc
//disp(%t)
//disp(%f)
//disp(%pi)
//disp(%e)
//disp(%i)  50+2*i, i*i=-1
//
//clc
//disp(%eps)
//disp(1 + (%eps / 2) == 1)
//disp(1 + (1+%eps) == 1)


// macierze i wektory
clc


disp("bleh")

A=[1 2 3; 4 5 6; 7 8 9]
disp('A: ',A)
B=[1 2 3; 4 5 6; 7 8 9]
disp('B: ' ,B)

C=A+B
disp('C: ',C)
disp(size(C))

D=A-B
disp('D: ',D)

E=A'
disp('macierz exp: ',E)


//mnozenie macierzowe macierzy

F=A*B
disp("F: ",F)
//mnozenie macierzowe macierzy
G=A .* B
disp("G: ",G)

//potegowanie macierzowe machierzy
H=A^3
disp("H: ",H)
//potegowanie tablicowe macierzy
H2=A.^3
disp("H2: ",H2)

clc

//macierz jednostkowa
I=eye(3,3)
disp("I: ",I)

J=zeros(5,15)
disp("J=", J)

clc

//dostep do macierzy za pomoca indexow
//indeksujemy od 1
disp(A(3,3))
clc

A1=A
disp(modulo(A,2)==0)

A1(modulo(A1,2)==0)=0
disp(A1)

//operator :

disp(1:4.5)//domyslny skok o 1
disp(1:0.1:4)
clc

disp(linspace(1,4,400))






