clear all;

%赋值
R_1 = 20;
R_2 = 10;
R_3 = 25;
R_4 = 10;
R_5 = 30;
R_6 = 40;
V_1 = 0;
V_2 = 0;
V_3 = 200;

A = [R_6+R_1+R_2 -R_1 -R_2;
    -R_1 R_3+R_4+R_1 -R_4;
    -R_2 -R_4 R_5+R_4+R_2];
b = [V_1; V_2; V_3];

%问题(a)求解
x_1 = [];
iter_1 = 0;
for V_1 = 0:2:100
    b(1) = V_1;
    iter_1 = iter_1 + 1;
    x_temp = A\b;
    x_1(:,iter_1) = x_temp;
end

%%问题(b)求解
x_21 = [];
iter_21 = 0;
D = diag(diag(A));
T = A - D;
tol = 1e-6;
maxIter = 1e6;
x_temp(:,1) = [0; 0; 0];
iter_total1 = 0;
for V_1 = 0:2:100
    b(1) = V_1;
    iter_21 = iter_21 + 1;
    iter_in = 0;
    err = 2*tol;
    while (err > tol) && (iter_in < maxIter)
        iter_in = iter_in + 1;
        x_temp(:,iter_in + 1) = -(D\T)*x_temp(:,iter_in)+D\b;
        err = norm(x_temp(:,iter_in + 1) - x_temp(:,iter_in), Inf);
    end
    iter_total1 = iter_total1 + iter_in;
    x_21(:,iter_21) = x_temp(:,end);
end

S = tril(A);
T = A - S;
x_22 = [];
iter_22 = 0;
x_temp2(:,1) = [0; 0; 0];
iter_total2 = 0;
for V_1 = 0:2:100
    b(1) = V_1;
    iter_22 = iter_22 + 1;
    iter_in = 0;
    err = 2*tol;
    while (err > tol) && (iter_in < maxIter)
        iter_in = iter_in + 1;
        x_temp2(:,iter_in + 1) = -(S\T)*x_temp2(:,iter_in)+S\b;
        err = norm(x_temp2(:,iter_in + 1) - x_temp2(:,iter_in), Inf);
    end
    iter_total2 = iter_total2 + iter_in;
    x_22(:,iter_22) = x_temp2(:,end);
end

iter_mean = [iter_total1/51 iter_total2/51]


V1 = 0:2:100;
plot(V1,x_1(1,:),'-r*'),xlabel('x'),ylabel('iter'),legend('x1');
hold on;grid on;
plot(V1,x_1(2,:),'-b*'),legend('x2');
hold on;grid on;
plot(V1,x_1(3,:),'-g*'),legend('x3');
