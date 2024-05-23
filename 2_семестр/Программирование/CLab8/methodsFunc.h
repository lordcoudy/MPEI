typedef double (*func)(double);     // Указатель на функцию типа double с принимаемым значением double

double func2(double x)  // Функция 2 варианта
{
    return (
            ((double)1/(double)10)*exp(-pow(cos(x),(double)2))+sqrt(x/(double)2)/log(x+(double)1)-x
    );
}

double func5(double x)  // Функция 5 варианта
{
    return (
            (double)1/(sqrt((double)5)+sin((double)0.1*x)+log((double)1+x))-x
    );
}

double FindRootDiv(double a, double b, double e, func f,int *n)     // Метод деления отрезка
{
    double xn,FB,FX;
    if (f(a)*f(b)>0)    // Проверка на наличие корня на отрезке (Разные знаки на концах отрецка)
        return -1;      // Если нет - возращаем -1
    else do             // Цикл с постусловием
    {
        xn = (b + a) / (double) 2;   // Середина отрезка
        FB = f(b);      // F(b) правый край
        FX = f(xn);     // F(X) левый сходящийся край
        if (FX * FB < 0) a = xn;    // Сравнение знаков F(x) и F(b)
        else b = xn;
        (*n)++;
    } while (fabs(a - b) >= e && FX != 0);  // Ищем, пока не пересечем Ox или пока отрезок не будет меньше точности(погрешности)
    return xn;
}

double FindRootNewt(double a, double b, double e, func f, int *n)   // Метод Ньютона
{
    double x0,xn, FX, dFX;
    if (f(a)*f(b)>0)    // Проверка на наличие корня на отрезке (Разные знаки на концах отрецка)
        return -1;      // Если нет - возращаем -1
    else {
        x0 = (a + b) / 2;   // Начальное приближение корня равно половине отрезка
        FX = f(x0);     // F(x0) - значение функции в точке x0
        dFX = (f(x0 + e/2) - f(x0 - e/2))/e;    // dF(x0) - производная функции F(x0)
        xn = x0 - FX / dFX;     // Считаем первое приближение
        (*n)++;
        do  //Цикл с постусловием
        {
            x0 = xn;    // Начальное приближение корня = первому приближению
            FX = f(x0);     // F(x0) - значение функции в точке x0
        dFX = (f(x0 + e/2) - f(x0 - e/2))/e;    // dF(x0) - производная функции F(x0)
            xn = x0 - FX / dFX;     // Непосредственно формула Ньютона
            (*n)++;
        } while (fabs(x0 - xn) > e);    // Ищем, пока отрезок не будет меньше точности(погрешности)
        return xn;
    }
}

void TableStart(int n,double a,double b) // Заголовок таблицы с результатами для удобного вывода
{
    printf("Line segment [%.5f, %.5f]\n",a,b);
    printf("|Function N%d |   Segment division    |Newton's method  |\n",n);
    printf("|Accuracy    |Root      |Iterations |Root      |Iterations |\n");
}

void TableCell(double e,double x1,int n1, double x2, int n2)    // Таблица с результатами для удобного вывода
{
    int z = ceil(fabs(log(e)/log(10)));
    char* r1 = new char[z+2];
    char* r2 = new char[z+2];
    if (x1==-1) r1 = (char*)"No root  ";
    else sprintf(r1,"%.*f",z,x1);
    if (x2==-1) r2 = (char*)"No root  ";
    else sprintf(r2,"%.*f",z,x2);
    printf("|%12.*f|%12s|%9d|%12s|%9d|\n",z,e,r1,n1,r2,n2);
    delete []r1; delete []r2;
}